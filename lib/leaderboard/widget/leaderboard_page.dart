import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import '../../common/widget/page_template.dart';
import '../../game/model/game.dart';
import '../../game/model/player.dart';
import '../service/leaderboard_service.dart';

class LeaderboardPage extends StatelessWidget {
  static const routeName = '/leaderboard';

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: "Leaderboard",
      child: StreamBuilder<List<Game>>(
        stream: LeaderboardService.getLeaderboardStream(),
        builder: (BuildContext context, AsyncSnapshot<List<Game>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final games = snapshot.data!;
          List<Player> players = [];
          for (final game in games) {
            for (final player in game.players.values.where((element) => element.complete)) {
              players.add(player);
            }
          }
          Map<String, Player> playerTotalScores = {};

          for (final player in players) {
            playerTotalScores[player.id] = playerTotalScores[player.id] == null ? player : playerTotalScores[player.id]!.copyWith(
                points : playerTotalScores[player.id]!.points + player.points);
          }
          final playerRankList = playerTotalScores.values.sorted(((a,b) => b.points.compareTo(a.points))).toList();



          return ListView.builder(
            itemCount: playerTotalScores.length,
            itemBuilder: (context, index) {

              return ListTile(
                leading: CircleAvatar(
                  radius: 50,
                  backgroundImage: playerRankList[index].photoURL != null ? NetworkImage(playerRankList[index].photoURL!) : null,
                  child: playerRankList[index].photoURL == null ? Icon(Icons.person, size: 40, color: Colors.white) : null,
                ),
                title: Text(
                  '${index + 1}. ${playerRankList[index].displayName}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                subtitle: Text("${playerRankList[index].points} points", style: Theme.of(context).textTheme.bodyMedium),
              );
            },
          );
        },
      ),
    );
  }
}
