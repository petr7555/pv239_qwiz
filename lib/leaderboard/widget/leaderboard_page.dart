import 'package:flutter/material.dart';
import '../../common/widget/page_template.dart';
import '../model/player_score_record.dart';
import '../service/leaderboard_service.dart';

class LeaderboardPage extends StatelessWidget {
  static const routeName = '/leaderboard';

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: "Leaderboard",
      child: StreamBuilder<List<PlayerScoreRecord>>(
        stream: LeaderboardService.getLeaderboardStream(),
        builder: (BuildContext context,
            AsyncSnapshot<List<PlayerScoreRecord>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final playerScores = snapshot.data!;

          return ListView.builder(
            itemCount: playerScores.length,
            itemBuilder: (context, index) {
              final playerScore = playerScores[index];

              return ListTile(
                title: Text(
                  '${index + 1}. ${playerScore.playerName}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                subtitle:
                Text(playerScore.totalScore.toString(), style: Theme.of(context).textTheme.bodyMedium),
              );
            },
          );
        },
      ),
    );
  }
}
