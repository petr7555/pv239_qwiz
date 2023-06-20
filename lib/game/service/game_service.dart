import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pv239_qwiz/common/service/ioc_container.dart';
import 'package:pv239_qwiz/common/util/shared_logic_constants.dart';
import 'package:pv239_qwiz/game/model/game.dart';
import 'package:pv239_qwiz/game/model/interaction.dart';
import 'package:pv239_qwiz/game/model/player.dart';
import 'package:pv239_qwiz/game/service/question_api_service.dart';
import 'package:pv239_qwiz/game/widget/aborted_game_page.dart';
import 'package:pv239_qwiz/game/widget/get_ready_page.dart';
import 'package:pv239_qwiz/game/widget/menu_page.dart';
import 'package:pv239_qwiz/game/widget/podium_page.dart';
import 'package:pv239_qwiz/game/widget/question_page.dart';

class GameService {
  final _db = FirebaseFirestore.instance;

  final _gamesCollection = FirebaseFirestore.instance.collection('games').withConverter(
        fromFirestore: (snapshot, _) => Game.fromJson(snapshot.data()!),
        toFirestore: (model, _) => model.toJson(),
      );

  Stream<List<Game>> _getIncompleteGamesOfUser(String userId) {
    return _gamesCollection
        .where('players.$userId.complete', isEqualTo: false)
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs.map((docSnapshot) => docSnapshot.data()).toList());
  }

  Stream<Game?> currentGameStream(String userId) {
    final incompleteGamesOfUser = _getIncompleteGamesOfUser(userId);

    return incompleteGamesOfUser.map((games) {
      if (games.isEmpty) {
        return null;
      }
      return games.first;
    });
  }

  Future<bool> gameExists(String gameId) {
    return _gameDocRef(gameId).get().then((value) => value.exists);
  }

  Future<bool> gameIsFull(String gameId) async {
    final game = await _getGame(gameId);
    return game.players.length == maxPlayers;
  }

  Future<void> createGame(Game game) {
    return _gameDocRef(game.id).set(game);
  }

  Future<void> joinGame(String gameId, String userId, String? userName, String? photoURL) {
    return _withTransactGame(gameId, (game) async {
      var updatedGame = game.copyWith(
        players: ({...game.players}..[userId] = Player(id: userId, displayName: userName, photoURL: photoURL))
            .map((key, value) => MapEntry(key, value.copyWith(route: GetReadyPage.routeName))),
      );
      updatedGame = await _addNextQuestion(updatedGame, userId);
      return updatedGame;
    });
  }

  Future<void> deleteGame(String gameId) {
    return _gameDocRef(gameId).delete();
  }

  Future<void> startGame(String gameId) {
    return _withTransactGame(gameId, (game) async {
      final updatedGame = game.copyWith(
        players: game.players.map((key, value) => MapEntry(key, value.copyWith(route: QuestionPage.routeName))),
      );
      return updatedGame;
    });
  }

  Future<void> abortGame(String gameId, String userId) {
    return _withTransactGame(gameId, (game) async {
      final updatedGame = game.copyWith(
        players: game.players.map((key, value) {
          if (key == userId) {
            return MapEntry(key, value.copyWith(route: MenuPage.routeName, complete: true));
          } else {
            return MapEntry(key, value.copyWith(route: AbortedGamePage.routeName));
          }
        }),
      );
      return updatedGame;
    });
  }

  Future<void> resetGame(String gameId, String userId) {
    return _withTransactGame(gameId, (game) async {
      final updatedGame = game.copyWith(
        players: {...game.players}..[userId] = game.you(userId).copyWith(route: MenuPage.routeName, complete: true),
      );
      return updatedGame;
    });
  }

  Future<void> answerCurrentQuestion(String gameId, String userId, int answerIdx, double secondsToAnswer) {
    return _withTransactGame(gameId, (game) async {
      final yourInteraction = game.yourCurrentInteraction(userId);
      if (yourInteraction.answerIdx != null || game.you(userId).answerTimerEnded) {
        return null;
      }

      var updatedGame = game.copyWith(
        questions: [...game.questions]..[game.questions.length - 1] = game.currentQuestion.copyWith(
            interactions: {...game.currentQuestion.interactions}..[userId] =
                yourInteraction.copyWith(answerIdx: answerIdx, secondsToAnswer: secondsToAnswer),
          ),
      );

      if (updatedGame.allPlayersAnswered) {
        updatedGame = _addPoints(updatedGame, userId);
      }

      return updatedGame;
    });
  }

  Future<void> setAnswerTimerEnded(String gameId, String userId, bool ended) {
    return _withTransactGame(gameId, (game) async {
      var updatedGame = game.copyWith(
        players: {...game.players}..[userId] = game.you(userId).copyWith(answerTimerEnded: ended),
      );

      if (updatedGame.answerTimersEnded) {
        updatedGame = _addPoints(updatedGame, userId);
      }

      return updatedGame;
    });
  }

  Future<void> setResultTimerEnded(String gameId, String userId, bool ended) {
    return _withTransactGame(gameId, (game) async {
      var updatedGame = game.copyWith(
        players: {...game.players}..[userId] = game.you(userId).copyWith(resultTimerEnded: ended),
      );
      if (updatedGame.resultTimersEnded) {
        updatedGame = _checkWinner(updatedGame, userId);

        if (updatedGame.winnerId == null) {
          updatedGame = await _addNextQuestion(updatedGame, userId);
          updatedGame = updatedGame.copyWith(
            players: updatedGame.players.map((key, value) => MapEntry(key, value.copyWith(answerTimerEnded: false))),
          );
        }
      }
      return updatedGame;
    });
  }

  DocumentReference<Game> _gameDocRef(String gameId) => _gamesCollection.doc(gameId);

  Future<Game> _getGame(String gameId, [Transaction? transaction]) {
    if (transaction != null) {
      return transaction.get(_gameDocRef(gameId)).then((value) => value.data()!);
    }
    return _gameDocRef(gameId).get().then((value) => value.data()!);
  }

  Future<void> _withTransactGame(String gameId, Future<Game?> Function(Game) gameModifier) {
    return _db.runTransaction((transaction) async {
      final game = await _getGame(gameId, transaction);
      final updatedGame = await gameModifier(game);
      if (updatedGame == null) {
        return;
      }
      transaction.set(_gameDocRef(gameId), updatedGame);
    });
  }

  Future<Game> _addNextQuestion(Game game, String userId) async {
    final question = await get<QuestionApiService>().getQuestion();
    final questionWithInteractions = question.copyWith(
      interactions: game.players.map((key, value) => MapEntry(key, Interaction())),
      isShootout: _shouldNextQuestionBeShootoutQuestion(game, userId),
    );
    final updatedGame = game.copyWith(
      questions: [...game.questions, questionWithInteractions],
    );
    return updatedGame;
  }

  Game _addPoints(Game game, String userId) {
    final correctAnswer = game.currentQuestion.correctAnswerIdx;
    final yourInteraction = game.yourCurrentInteraction(userId);
    final opponentsInteraction = game.opponentsCurrentInteraction(userId);
    final youAreCorrect = yourInteraction.answerIdx == correctAnswer;
    final opponentIsCorrect = opponentsInteraction.answerIdx == correctAnswer;

    var yourDeltaPoints = 0;
    var opponentsDeltaPoints = 0;

    if (!game.currentQuestion.isShootout) {
      if (youAreCorrect && opponentIsCorrect) {
        final yourTime = yourInteraction.secondsToAnswer!;
        final opponentsTime = opponentsInteraction.secondsToAnswer!;

        if (yourTime < opponentsTime) {
          yourDeltaPoints = bigPoints;
          opponentsDeltaPoints = mediumPoints;
        } else if (yourTime > opponentsTime) {
          opponentsDeltaPoints = bigPoints;
          yourDeltaPoints = mediumPoints;
        } else {
          yourDeltaPoints = mediumPoints;
          opponentsDeltaPoints = mediumPoints;
        }
      } else if (youAreCorrect) {
        yourDeltaPoints = bigPoints;
      } else if (opponentIsCorrect) {
        opponentsDeltaPoints = bigPoints;
      }
    } else {
      if (youAreCorrect && opponentIsCorrect) {
        final yourTime = yourInteraction.secondsToAnswer!;
        final opponentsTime = opponentsInteraction.secondsToAnswer!;

        if (yourTime < opponentsTime) {
          opponentsDeltaPoints = shootoutPenaltyPoints;
        } else if (yourTime > opponentsTime) {
          yourDeltaPoints = shootoutPenaltyPoints;
        }
      } else if (youAreCorrect && !opponentIsCorrect) {
        opponentsDeltaPoints = shootoutPenaltyPoints;
      } else if (!youAreCorrect && opponentIsCorrect) {
        yourDeltaPoints = shootoutPenaltyPoints;
      }
    }

    var updatedGame = game.copyWith(
      players: game.players.map((key, value) {
        if (key == userId) {
          return MapEntry(key, value.copyWith(points: value.points + yourDeltaPoints));
        } else {
          return MapEntry(key, value.copyWith(points: value.points + opponentsDeltaPoints));
        }
      }),
    );

    updatedGame = updatedGame.copyWith(
      questions: [...updatedGame.questions]..[updatedGame.questions.length - 1] = updatedGame.currentQuestion.copyWith(
          interactions: updatedGame.currentQuestion.interactions.map((key, value) {
            if (key == userId) {
              return MapEntry(key, value.copyWith(deltaPoints: yourDeltaPoints));
            } else {
              return MapEntry(key, value.copyWith(deltaPoints: opponentsDeltaPoints));
            }
          }),
        ),
    );

    return updatedGame;
  }

  Game _checkWinner(Game game, String userId) {
    final yourPoints = game.you(userId).points;
    final opponent = game.opponent(userId);
    final opponentsPoints = opponent.points;

    String? winnerId;
    if (yourPoints > opponentsPoints && yourPoints >= game.pointsToWin) {
      winnerId = userId;
    }
    if (opponentsPoints > yourPoints && opponentsPoints >= game.pointsToWin) {
      winnerId = opponent.id;
    }

    if (winnerId != null) {
      return game.copyWith(
        winnerId: winnerId,
        players: game.players.map((key, value) => MapEntry(key, value.copyWith(route: PodiumPage.routeName))),
      );
    }

    return game;
  }

  bool _shouldNextQuestionBeShootoutQuestion(Game game, String userId) {
    final yourPoints = game.you(userId).points;
    final opponentsPoints = game.opponent(userId).points;

    return yourPoints == opponentsPoints && yourPoints != 0;
  }
}
