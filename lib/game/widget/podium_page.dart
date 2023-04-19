import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:pv239_qwiz/auth/service/auth_cubit.dart';
import 'package:pv239_qwiz/common/util/shared_ui_constants.dart';
import 'package:pv239_qwiz/common/widget/button.dart';
import 'package:pv239_qwiz/common/widget/page_template.dart';
import 'package:pv239_qwiz/game/model/game.dart';
import 'package:pv239_qwiz/game/service/game_cubit.dart';
import 'package:pv239_qwiz/leaderboard/model/player_score_record.dart';
import 'package:pv239_qwiz/leaderboard/service/leaderboard_service.dart';

class PodiumPage extends StatelessWidget {
  const PodiumPage({super.key});

  static const routeName = '/podium';

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Podium',
      child: BlocBuilder<GameCubit, Game?>(builder: (context, game) {
        if (game == null) {
          return SizedBox.shrink();
        }

        for (final player in game.players.values) {
          final record = PlayerScoreRecord(playerId: player.id, playerName: player.name, totalScore: player.points);
          LeaderboardService.updatePlayerScore(record);
        }

        final theme = Theme.of(context);
        final userId = context.read<AuthCubit>().userId;
        final isWinner = game.winnerId == userId;
        final thisPlayer = game.thisPlayer(userId);
        final opponent = game.opponent(userId);

        return Column(
          children: [
            SizedBox(height: standardGap),
            Text(isWinner ? 'You won!' : 'You lost.', style: theme.textTheme.headlineLarge),
            SizedBox(height: largeGap),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildBar(theme: theme, playerName: 'You', points: thisPlayer.points, isWinner: isWinner),
                _buildBar(theme: theme, playerName: 'Opponent', points: opponent.points, isWinner: !isWinner),
              ],
            ),
            SizedBox(height: largeGap),
            Button(
              label: 'Back to menu',
              onPressed: () {
                final userId = context.read<AuthCubit>().userId;
                context.read<GameCubit>().resetGame(userId);
              },
            ),
          ],
        );
      }),
    );
  }

  Widget _buildBar({
    required ThemeData theme,
    required String playerName,
    required int points,
    required bool isWinner,
  }) {
    const winnerHeight = 200.0;
    final height = isWinner ? winnerHeight : (winnerHeight * points / 100);
    final color = isWinner ? goldColor : silverColor;

    return Column(
      children: [
        Text(points.toString(), style: theme.textTheme.titleLarge),
        SizedBox(height: smallGap),
        Container(
          width: 50,
          height: height,
          color: color,
        ),
        SizedBox(height: smallGap),
        Text(playerName, style: theme.textTheme.titleLarge),
      ],
    );
  }
}
