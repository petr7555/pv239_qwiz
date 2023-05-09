import 'package:cloud_firestore/cloud_firestore.dart';
import '../../game/model/game.dart';

class LeaderboardService {
  static Stream<List<Game>> getLeaderboardStream() {
    return FirebaseFirestore.instance
        .collection('games')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => Game.fromJson(doc.data())).toList());
  }
}
