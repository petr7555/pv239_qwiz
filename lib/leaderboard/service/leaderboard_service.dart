import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/player_score_record.dart';

class LeaderboardService {
  static Stream<List<PlayerScoreRecord>> getLeaderboardStream() {
    return FirebaseFirestore.instance
        .collection('player_scores')
        .orderBy('score', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => PlayerScoreRecord.fromJson(doc.data())).toList());
  }

  static Future<void> updatePlayerScore(PlayerScoreRecord playerScoreRecord) async {
    final playerId = playerScoreRecord.playerId;
    final playerName = playerScoreRecord.playerName;
    final score = playerScoreRecord.totalScore;

    final playerScoreRef = FirebaseFirestore.instance.collection('player_scores').doc(playerId);
    final playerScoreDoc = await playerScoreRef.get();

    if (playerScoreDoc.exists) {
      final currentScore = playerScoreDoc.get('score') as int;
      await playerScoreRef.update({'score': currentScore + score});
    } else {
      await playerScoreRef.set({'name': playerName, 'score': score});
    }
  }
}
