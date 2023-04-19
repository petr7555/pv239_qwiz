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
import 'package:pv239_qwiz/game/widget/question_page.dart';

class GameService {
  final _db = FirebaseFirestore.instance;

  final _gamesCollection = FirebaseFirestore.instance.collection('games').withConverter(
        fromFirestore: (snapshot, _) => Game.fromJson(snapshot.data()!),
        toFirestore: (model, _) => model.toJson(),
      );

  Stream<Game?> currentGameStream(String userId) {
    // TODO filter in Firebase
    final gamesUserIsPartOf = _gamesCollection
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs.map((docSnapshot) => docSnapshot.data()).toList())
        .map((games) => games.where((game) {
              final player = game.players[userId];
              return player != null && player.complete == false;
            }).toList());

    return gamesUserIsPartOf.map((games) {
      if (games.isEmpty) {
        return null;
      }
      return games.first;
    });
  }

  Stream<List<Game>>? finishedGameStream(String userId) {
    // TODO filter in Firebase
    return _gamesCollection
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs.map((docSnapshot) => docSnapshot.data()).toList())
        .map((games) => games.where((game) {
              final player = game.players[userId];
              return player != null && player.complete == true;
            }).toList())
        .map((games) {
      return games;
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

  Future<void> answerCurrentQuestion(String gameId, String userId, int answerIdx) {
    return _withTransactGame(gameId, (game) async {
      final question = game.currentQuestion;
      final interaction = question.interactions[userId]!;
      if (interaction.answerIdx != null || game.players[userId]!.answerTimerEnded) {
        return null;
      }
      final updatedInteraction = interaction.copyWith(answerIdx: answerIdx);
      question.interactions[userId] = updatedInteraction;
      game.currentQuestion = question;
      return game;
    });
  }

  Future<void> setAnswerTimerEnded(String gameId, String userId) {
    return _withTransactGame(gameId, (game) async {
      game.players[userId] = game.players[userId]!.copyWith(answerTimerEnded: true, resultTimerEnded: false);
      return game.copyWith(players: game.players);
    });
  }

  Future<void> setResultTimerEnded(String gameId, String userId) {
    return _withTransactGame(gameId, (game) async {
      game.players[userId] = game.players[userId]!.copyWith(answerTimerEnded: false, resultTimerEnded: true);
      var updatedGame = game.copyWith(players: game.players);
      if (game.resultTimersEnded) {
        print('SERVICE: Both result timers ended, getting next question');
        updatedGame = await _addNextQuestion(updatedGame);
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
