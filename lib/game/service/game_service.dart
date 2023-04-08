import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pv239_qwiz/game/model/game.dart';
import 'package:pv239_qwiz/game/model/player.dart';

class GameService {
  final gamesCollection = FirebaseFirestore.instance.collection('games').withConverter(
        fromFirestore: (snapshot, _) => Game.fromJson(snapshot.data()!),
        toFirestore: (model, _) => model.toJson(),
      );

  Future<void> createGame(Game game) {
    return gamesCollection.doc(game.id).set(game);
  }

  Stream<Game?> gameStream(String id) {
    return gamesCollection.doc(id).snapshots().map((event) => event.data());
  }

  Future<Game?> getGame(String id) {
    return gamesCollection.doc(id).get().then((value) => value.data());
  }

  Future<void> joinGame(String id, String userId) async {
    final game = (await getGame(id))!;
    final updatedGame = game.copyWith(players: game.players + [Player(id: userId)]);
    return gamesCollection.doc(id).set(updatedGame);
  }

  Future<void> leaveGame(String id, String userId) async {
    final game = (await getGame(id))!;
    final newPlayers = game.players.where((element) => element.id != userId).toList();
    if (newPlayers.isEmpty) {
      return _deleteGame(id);
    }
    final updatedGame = game.copyWith(players: newPlayers);
    return gamesCollection.doc(id).set(updatedGame);
  }

  Future<void> _deleteGame(String id) {
    return gamesCollection.doc(id).delete();
  }
}
