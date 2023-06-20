import 'package:flutter/material.dart';
import 'package:pv239_qwiz/game/model/player.dart';
import 'package:pv239_qwiz/leaderboard/widget/leaderboard_tile.dart';

class PlayersList extends StatelessWidget {
  final List<Player> players;

  const PlayersList({
    super.key,
    required this.players,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: players.length,
      itemBuilder: (context, index) {
        final player = players[index];
        final rank = index + 1;

        return LeaderboardTile(rank: rank, player: player);
      },
      separatorBuilder: (BuildContext context, int index) => Divider(thickness: 1),
    );
  }
}
