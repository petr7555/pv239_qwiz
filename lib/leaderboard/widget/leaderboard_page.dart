import 'package:flutter/material.dart';
import 'package:pv239_qwiz/common/service/ioc_container.dart';
import 'package:pv239_qwiz/common/widget/handling_stream_builder.dart';
import 'package:pv239_qwiz/common/widget/page_template.dart';
import 'package:pv239_qwiz/game/model/player.dart';
import 'package:pv239_qwiz/leaderboard/service/leaderboard_service.dart';
import 'package:pv239_qwiz/leaderboard/widget/players_list.dart';

class LeaderboardPage extends StatelessWidget {
  const LeaderboardPage({super.key});

  static const routeName = '/leaderboard';

  @override
  Widget build(BuildContext context) {
    final leaderboardService = get<LeaderboardService>();

    return PageTemplate(
      title: 'Leaderboard',
      scrollable: false,
      child: HandlingStreamBuilder<List<Player>>(
        stream: leaderboardService.rankedPlayers,
        builder: (context, players) {
          if (players.isEmpty) {
            // TODO Can be empty?
            return const Center(child: Text('No players yet.'));
          }
          return PlayersList(players: players);
        },
      ),
    );
  }
}
