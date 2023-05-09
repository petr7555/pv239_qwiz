import 'package:cloud_firestore/cloud_firestore.dart';

import '../../game/model/game.dart';

class HistoryService {
  static Stream<List<Game>> getGamesByPlayer(String id) {
    return FirebaseFirestore.instance.collection('games').snapshots().map((snapshot) => snapshot.docs
        .map((doc) => Game.fromJson(doc.data()))
        .where((element) => element.players.keys.contains(id))
        .toList());
  }
}