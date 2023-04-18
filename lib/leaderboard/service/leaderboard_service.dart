import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/player_score_record.dart';

class LeaderboardService {
  static Stream<List<PlayerScoreRecord>> getLeaderboardStream() {
    return FirebaseFirestore.instance
        .collection('player_scores')
        .orderBy('score', descending: true)
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map((doc) => PlayerScoreRecord.fromJson(doc.data())).toList());
  }
}
