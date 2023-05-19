import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:pv239_qwiz/game/model/game.dart';
import 'package:pv239_qwiz/game/service/game_service.dart';

class HistoryService {
  static Stream<List<Game>> getGamesByPlayer(String id) {
    final gameService = GameService();
    return FirebaseFirestore.instance.collection('games').snapshots().map((snapshot) => snapshot.docs
        .map((doc) => Game.fromJson(doc.data()))
        .where((element) => element.players.keys.contains(id))
        .sorted((a, b) => b.createdAt.compareTo(a.createdAt))
        .toList());
  }
}
