import 'package:flutter/material.dart';
import 'package:pv239_qwiz/common/widget/page_template.dart';
import 'package:pv239_qwiz/game/model/player.dart';
import 'package:pv239_qwiz/leaderboard/service/leaderboard_service.dart';

class LeaderboardPage extends StatelessWidget {
  static const routeName = '/leaderboard';

  const LeaderboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Leaderboard',
      scrollable: false,
      child: StreamBuilder<List<Player>>(
        stream: LeaderboardService.getLeaderboardStream(),
        builder: (BuildContext context, AsyncSnapshot<List<Player>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final playerRankList = snapshot.data ?? [];

          return _buildPlayerList(playerRankList);
        },
      ),
    );
  }

  Widget _buildPlayerList(List<Player> playerRankList) {
    return ListView.builder(
      itemCount: playerRankList.length,
      itemBuilder: (context, index) {
        final player = playerRankList[index];

        return ListTile(
          leading: CircleAvatar(
            radius: 50,
            backgroundImage: player.photoURL != null ? NetworkImage(player.photoURL!) : null,
            child: player.photoURL == null ? Icon(Icons.person, size: 40, color: Colors.white) : null,
          ),
          title: Text(
            '${index + 1}. ${player.displayName}',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          subtitle: Text(
            '${player.points} points',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        );
      },
    );
  }
}
