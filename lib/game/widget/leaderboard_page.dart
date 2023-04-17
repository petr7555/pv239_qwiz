import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../common/widget/page_template.dart';
import '../model/player_score_record.dart';

class LeaderboardPage extends StatelessWidget {

  static const routeName = '/leaderboard';

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: "Leaderboard",
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('player_scores')
            .orderBy('score', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final playerScores = snapshot.data!.docs.map((doc) => PlayerScoreRecord.fromJson(doc.data() as Map<String, dynamic>)).toList();

          return ListView.builder(
            itemCount: playerScores.length,
            itemBuilder: (context, index) {
              final playerScore = playerScores[index];

              return ListTile(
                title: Text(
                  '${index + 1}. ${playerScore.playerName}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                subtitle: Text(playerScore.totalScore.toString(), style: Theme.of(context).textTheme.bodyMedium),
              );
            },
          );
        },
      ),
      );
  }
}
