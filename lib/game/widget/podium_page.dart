import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pv239_qwiz/auth/service/auth_cubit.dart';
import 'package:pv239_qwiz/common/util/shared_ui_constants.dart';
import 'package:pv239_qwiz/common/widget/button.dart';
import 'package:pv239_qwiz/common/widget/page_template.dart';
import 'package:pv239_qwiz/game/model/game.dart';
import 'package:pv239_qwiz/game/service/game_cubit.dart';

class PodiumPage extends StatelessWidget {
  const PodiumPage({super.key});

  static const routeName = '/podium';

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Podium',
      child: BlocBuilder<GameCubit, Game?>(
        builder: (context, game) {
          if (game == null) {
            return SizedBox.shrink();
          }

          final theme = Theme.of(context);

          final userId = context.read<AuthCubit>().userId;
          final you = game.you(userId);
          final opponent = game.opponent(userId);
          final isWinner = game.winnerId == userId;
          final winnerPoints = isWinner ? you.points : opponent.points;

          final iconSource = isWinner ? 'assets/icons/trophy.png' : 'assets/icons/crying_face.png';
          final text = isWinner ? 'You won!' : 'You lost...';

          return Column(
            children: [
              SizedBox(height: standardGap),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(iconSource, width: 40, height: 40),
                  SizedBox(width: smallGap),
                  Text(text, style: theme.textTheme.headlineLarge),
                ],
              ),
              SizedBox(height: largeGap),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildBar(
                    theme: theme,
                    playerName: 'You',
                    points: you.points,
                    winnerPoints: winnerPoints,
                    isWinner: isWinner,
                  ),
                  _buildBar(
                    theme: theme,
                    playerName: 'Opponent',
                    points: opponent.points,
                    winnerPoints: winnerPoints,
                    isWinner: !isWinner,
                  ),
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
        },
      ),
    );
  }

  Widget _buildBar({
    required ThemeData theme,
    required String playerName,
    required int points,
    required int winnerPoints,
    required bool isWinner,
  }) {
    const winnerHeight = 200.0;
    final height = isWinner ? winnerHeight : (winnerHeight * points / winnerPoints);
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
