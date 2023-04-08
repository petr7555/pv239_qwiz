import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pv239_qwiz/game/model/game.dart';
import 'package:pv239_qwiz/game/model/game_status.dart';
import 'package:pv239_qwiz/game/model/player.dart';

class GameService {
  final gamesCollection = FirebaseFirestore.instance.collection('games').withConverter(
        fromFirestore: (snapshot, _) => Game.fromJson(snapshot.data()!),
        toFirestore: (model, _) => model.toJson(),
      );

  Stream<Game?> currentGameStream(String userId) {
    final gamesUserIsPartOf = gamesCollection
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs.map((docSnapshot) => docSnapshot.data()).toList())
        .map((games) => games.where((game) => game.players.any((player) => player.id == userId)).toList());

    return gamesUserIsPartOf.map((games) {
      if (games.isEmpty) {
        return null;
      }
      return games.first;
    });
  }

  Future<void> createGame(Game game) {
    return gamesCollection.doc(game.id).set(game);
  }

  Future<Game?> getGame(String gameId) {
    return gamesCollection.doc(gameId).get().then((value) => value.data());
  }

  Future<void> joinGame(String gameId, String userId) async {
    final game = await getGame(gameId);
    if (game == null) {
      throw Exception('Cannot join game $gameId because it does not exist');
    }
    final updatedGame = game.copyWith(players: game.players + [Player(id: userId)], gameStatus: GameStatus.inProgress);
    return gamesCollection.doc(gameId).set(updatedGame);
  }

  Future<void> leaveGame(String gameId, String userId) async {
    final game = await getGame(gameId);
    if (game == null) {
      throw Exception('Cannot leave game $gameId because it does not exist');
    }
    final newPlayers = game.players.where((element) => element.id != userId).toList();
    if (newPlayers.isEmpty) {
      return _deleteGame(gameId);
    }
    final updatedGame = game.copyWith(players: newPlayers);
    return gamesCollection.doc(gameId).set(updatedGame);
  }

  Future<void> _deleteGame(String gameId) {
    return gamesCollection.doc(gameId).delete();
  }
}
