import 'package:cloud_firestore/cloud_firestore.dart';
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
        .map((games) => games
            .where((game) =>
                (game.firstPlayer.id == userId && game.firstPlayer.complete == false) ||
                (game.secondPlayer?.id == userId && game.secondPlayer?.complete == false))
            .toList());

    return gamesUserIsPartOf.map((games) {
      if (games.isEmpty) {
        return null;
      }
      return games.first;
    });
  }

  Future<Game?> getGame(String gameId) {
    return gamesCollection.doc(gameId).get().then((value) => value.data());
  }

  Future<void> createGame(Game game) {
    return gamesCollection.doc(game.id).set(game);
  }

  Future<void> joinGame(String gameId, String userId) async {
    final game = await getGame(gameId);
    if (game == null) {
      throw Exception('Cannot join game $gameId because it does not exist');
    }
    final firstPlayer = game.firstPlayer.copyWith(route: GetReadyPage.routeName);
    final secondPlayer = Player(id: userId, route: GetReadyPage.routeName);
    final updatedGame = game.copyWith(
      firstPlayer: firstPlayer,
      secondPlayer: secondPlayer,
    );
    return gamesCollection.doc(gameId).set(updatedGame);
  }

  Future<void> deleteGame(String gameId) {
    return gamesCollection.doc(gameId).delete();
  }

  Future<void> startGame(String gameId) async {
    final game = await getGame(gameId);
    if (game == null) {
      throw Exception('Cannot start game $gameId because it does not exist');
    }
    final updatedGame = game.copyWith(
      firstPlayer: game.firstPlayer.copyWith(route: QuestionPage.routeName),
      secondPlayer: game.secondPlayer?.copyWith(route: QuestionPage.routeName),
    );
    return gamesCollection.doc(gameId).set(updatedGame);
  }

  Future<void> abortGame(String gameId, String userId) async {
    final game = await getGame(gameId);
    if (game == null) {
      throw Exception('Cannot abort game $gameId because it does not exist');
    }
    final isFirstPlayer = game.firstPlayer.id == userId;
    final updatedGame = game.copyWith(
      firstPlayer: isFirstPlayer
          ? game.firstPlayer.copyWith(route: MenuPage.routeName, complete: true)
          : game.firstPlayer.copyWith(route: AbortedGamePage.routeName),
      secondPlayer: isFirstPlayer
          ? game.secondPlayer?.copyWith(route: AbortedGamePage.routeName)
          : game.secondPlayer?.copyWith(route: MenuPage.routeName, complete: true),
    );
    return gamesCollection.doc(gameId).set(updatedGame);
  }

  Future<void> resetGame(String gameId, String userId) async {
    final game = await getGame(gameId);
    if (game == null) {
      throw Exception('Cannot reset game $gameId because it does not exist');
    }
    final isFirstPlayer = game.firstPlayer.id == userId;
    final updatedGame = game.copyWith(
      firstPlayer:
          isFirstPlayer ? game.firstPlayer.copyWith(route: MenuPage.routeName, complete: true) : game.firstPlayer,
      secondPlayer:
          isFirstPlayer ? game.secondPlayer : game.secondPlayer?.copyWith(route: MenuPage.routeName, complete: true),
    );
    return gamesCollection.doc(gameId).set(updatedGame);
  }
}
