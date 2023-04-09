import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pv239_qwiz/common/util/shared_logic_constants.dart';
import 'package:pv239_qwiz/game/model/game.dart';
import 'package:pv239_qwiz/game/model/player.dart';
import 'package:pv239_qwiz/game/widget/aborted_game_page.dart';
import 'package:pv239_qwiz/game/widget/get_ready_page.dart';
import 'package:pv239_qwiz/game/widget/menu_page.dart';
import 'package:pv239_qwiz/game/widget/question_page.dart';

class GameService {
  final gamesCollection = FirebaseFirestore.instance.collection('games').withConverter(
        fromFirestore: (snapshot, _) => Game.fromJson(snapshot.data()!),
        toFirestore: (model, _) => model.toJson(),
      );

  Stream<Game?> currentGameStream(String userId) {
    // TODO filter in Firebase
    final gamesUserIsPartOf = gamesCollection
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

  Future<bool> gameExists(String gameId) {
    return gamesCollection.doc(gameId).get().then((value) => value.exists);
  }

  Future<bool> gameIsFull(String gameId) async {
    final game = await _getGame(gameId);
    return game.players.length == maxPlayers;
  }

  Future<Game> _getGame(String gameId) {
    return gamesCollection.doc(gameId).get().then((value) => value.data()!);
  }

  Future<void> createGame(Game game) {
    return gamesCollection.doc(game.id).set(game);
  }

  Future<void> joinGame(String gameId, String userId) async {
    final game = await _getGame(gameId);
    game.players[userId] = Player(id: userId);
    final updatedGame = game.copyWith(
      players: game.players.map((key, value) => MapEntry(key, value.copyWith(route: GetReadyPage.routeName))),
    );
    return gamesCollection.doc(gameId).set(updatedGame);
  }

  Future<void> deleteGame(String gameId) {
    return gamesCollection.doc(gameId).delete();
  }

  Future<void> startGame(String gameId) async {
    final game = await _getGame(gameId);
    final updatedGame = game.copyWith(
      players: game.players.map((key, value) => MapEntry(key, value.copyWith(route: QuestionPage.routeName))),
    );
    return gamesCollection.doc(gameId).set(updatedGame);
  }

  Future<void> abortGame(String gameId, String userId) async {
    final game = await _getGame(gameId);
    game.players[userId] = game.players[userId]!.copyWith(route: MenuPage.routeName, complete: true);
    final opponentId = game.opponentId(userId);
    game.players[opponentId] = game.players[opponentId]!.copyWith(route: AbortedGamePage.routeName);
    final updatedGame = game.copyWith(
      players: game.players,
    );
    return gamesCollection.doc(gameId).set(updatedGame);
  }

  Future<void> resetGame(String gameId, String userId) async {
    final game = await _getGame(gameId);
    game.players[userId] = game.players[userId]!.copyWith(route: MenuPage.routeName, complete: true);
    final updatedGame = game.copyWith(
      players: game.players,
    );
    return gamesCollection.doc(gameId).set(updatedGame);
  }

  Future<void> answerQuestion(String gameId, String userId, String questionId, int answerIdx) async {
    final game = await _getGame(gameId);

    final questionIdx = game.questions.indexWhere((question) => question.id == questionId);
    final question = game.questions[questionIdx];
    question.playerAnswers[userId] = answerIdx;
    final updatedQuestion = question.copyWith(
      playerAnswers: question.playerAnswers,
    );
    game.questions[questionIdx] = updatedQuestion;
    final updatedGame = game.copyWith(questions: game.questions);
    return gamesCollection.doc(gameId).set(updatedGame);
  }
}
