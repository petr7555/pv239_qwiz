import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pv239_qwiz/game/model/game.dart';

class HistoryService {
  final _gamesCollection = FirebaseFirestore.instance.collection('games').withConverter(
        fromFirestore: (snapshot, _) => Game.fromJson(snapshot.data()!),
        toFirestore: (model, _) => model.toJson(),
      );

  Stream<List<Game>> getFinishedGamesOfUser(String userId) {
    final finishedGamesOfUser = _gamesCollection
        .where('winnerId', isNull: false)
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs.map((docSnapshot) => docSnapshot.data()))
        .map((games) => games.where((game) => game.players.containsKey(userId)).toList());

    final sortedFinishedGamesOfUser =
        finishedGamesOfUser.map((games) => games..sort((a, b) => b.createdAt.compareTo(a.createdAt)));
    return sortedFinishedGamesOfUser;
  }

  Stream<Game> getGameById(String gameId) {
    return _gamesCollection.doc(gameId).snapshots().map((snapshot) => snapshot.data()!);
  }
}
