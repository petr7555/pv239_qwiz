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

  Stream<List<Game>> _getGamesOfUser(String userId, {required bool complete}) {
    // TODO filter in Firebase
    return _gamesCollection
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs.map((docSnapshot) => docSnapshot.data()).toList())
        .map((games) => games.where((game) {
              final player = game.players[userId];
              return player != null && player.complete == complete;
            }).toList());
  }

  Stream<Game?> currentGameStream(String userId) {
    final incompleteGamesOfUser = _getGamesOfUser(userId, complete: false);

    return incompleteGamesOfUser.map((games) {
      if (games.isEmpty) {
        return null;
      }
      return games.first;
    });
  }

  Stream<List<Game>> finishedGamesStream(String userId) => _getGamesOfUser(userId, complete: true);

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
      game.players[userId] = Player(id: userId, displayName: userName, photoURL: photoURL);
      var updatedGame = game.copyWith(
        players: game.players.map((key, value) => MapEntry(key, value.copyWith(route: GetReadyPage.routeName))),
      );
      updatedGame = await _addNextQuestion(updatedGame);
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
      game.players[userId] = game.players[userId]!.copyWith(route: MenuPage.routeName, complete: true);
      final opponentId = game.opponentId(userId);
      game.players[opponentId] = game.players[opponentId]!.copyWith(route: AbortedGamePage.routeName);
      final updatedGame = game.copyWith(
        players: game.players,
      );
      return updatedGame;
    });
  }

  Future<void> resetGame(String gameId, String userId) {
    return _withTransactGame(gameId, (game) async {
      game.players[userId] = game.players[userId]!.copyWith(route: MenuPage.routeName, complete: true);
      final updatedGame = game.copyWith(
        players: game.players,
      );
      return updatedGame;
    });
  }

  Future<void> answerCurrentQuestion(String gameId, String userId, int answerIdx, double secondsToAnswer) {
    return _withTransactGame(gameId, (game) async {
      final question = game.currentQuestion;
      final interaction = question.interactions[userId]!;
      if (interaction.answerIdx != null || game.players[userId]!.answerTimerEnded) {
        return null;
      }
      final updatedInteraction = interaction.copyWith(answerIdx: answerIdx, secondsToAnswer: secondsToAnswer);
      question.interactions[userId] = updatedInteraction;
      game.currentQuestion = question;
      return game;
    });
  }

  Future<void> setAnswerTimerEnded(String gameId, String userId) {
    return _withTransactGame(gameId, (game) async {
      game.players[userId] = game.players[userId]!.copyWith(answerTimerEnded: true, resultTimerEnded: false);
      var updatedGame = game.copyWith(players: game.players);
      if (updatedGame.answerTimersEnded) {
        print('SERVICE: Both answer timers ended, getting results');
        final correctAnswer = updatedGame.currentQuestion.correctAnswerIdx;
        final youCorrect = updatedGame.currentQuestion.interactions[userId]!.answerIdx == correctAnswer;
        final opponentId = updatedGame.opponentId(userId);
        final opponentCorrect = updatedGame.currentQuestion.interactions[opponentId]!.answerIdx == correctAnswer;

        var youDeltaPoints = 0;
        var opponentDeltaPoints = 0;

        if (youCorrect && opponentCorrect) {
          final yourTime = updatedGame.currentQuestion.interactions[userId]!.secondsToAnswer!;
          final opponentsTime = updatedGame.currentQuestion.interactions[opponentId]!.secondsToAnswer!;
          if (yourTime < opponentsTime) {
            youDeltaPoints = bigPoints;
            opponentDeltaPoints = mediumPoints;
          } else if (yourTime > opponentsTime) {
            opponentDeltaPoints = bigPoints;
            youDeltaPoints = mediumPoints;
          } else {
            youDeltaPoints = mediumPoints;
            opponentDeltaPoints = mediumPoints;
          }
        } else if (youCorrect) {
          youDeltaPoints = bigPoints;
        } else if (opponentCorrect) {
          opponentDeltaPoints = bigPoints;
        }

        updatedGame.players[userId] = updatedGame.players[userId]!.copyWith(
          points: updatedGame.players[userId]!.points + youDeltaPoints,
        );
        updatedGame.players[opponentId] = updatedGame.players[opponentId]!.copyWith(
          points: updatedGame.players[opponentId]!.points + opponentDeltaPoints,
        );
        updatedGame.currentQuestion.interactions[userId] =
            updatedGame.currentQuestion.interactions[userId]!.copyWith(deltaPoints: youDeltaPoints);
        updatedGame.currentQuestion.interactions[opponentId] =
            updatedGame.currentQuestion.interactions[opponentId]!.copyWith(deltaPoints: opponentDeltaPoints);
      }
      return updatedGame;
    });
  }

  Future<void> setResultTimerEnded(String gameId, String userId) {
    return _withTransactGame(gameId, (game) async {
      game.players[userId] = game.players[userId]!.copyWith(answerTimerEnded: false, resultTimerEnded: true);
      var updatedGame = game.copyWith(players: game.players);
      if (updatedGame.resultTimersEnded) {
        print('SERVICE: Both result timers ended, checking winner');

        final opponentId = updatedGame.opponentId(userId);
        final youPoints = updatedGame.players[userId]!.points;
        final opponentPoints = updatedGame.players[opponentId]!.points;

        String winnerId = '';
        // TODO handle tie
        if (youPoints >= updatedGame.pointsToWin) {
          winnerId = userId;
        } else if (opponentPoints >= updatedGame.pointsToWin) {
          winnerId = opponentId;
        }
        if (winnerId != '') {
          updatedGame = updatedGame.copyWith(
            winnerId: winnerId,
            players: game.players.map((key, value) => MapEntry(key, value.copyWith(route: PodiumPage.routeName))),
          );
        } else {
          print('SERVICE: Both result timers ended, getting next question');
          updatedGame = await _addNextQuestion(updatedGame);
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

  Future<Game> _addNextQuestion(Game game) async {
    final newQuestion = await get<QuestionApiService>().getQuestion();
    for (final key in game.players.keys) {
      newQuestion.interactions[key] = Interaction();
    }
    final updatedGame = game.copyWith(
      questions: [...game.questions, newQuestion],
    );
    return updatedGame;
  }
}
