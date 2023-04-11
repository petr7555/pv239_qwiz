import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:pv239_qwiz/auth/model/auth_user.dart';
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
      child: BlocBuilder<AuthCubit, AuthUser?>(builder: (context, authUser) {
        return BlocBuilder<GameCubit, Game?>(builder: (context, game) {
          if (game == null) {
            return SizedBox.shrink();
          }
          final userId = authUser!.uid;
          final isWinner = game.winnerId == userId;
          final thisPlayer = game.thisPlayer(userId);
          final opponent = game.opponent(userId);

          return Column(
            children: [
              SizedBox(height: standardGap),
              Text(isWinner ? 'You won!' : 'You lost.', style: Theme.of(context).textTheme.headlineLarge),
              SizedBox(height: largeGap),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildBar(context, 'You', thisPlayer.points, isWinner),
                  _buildBar(context, 'Opponent', opponent.points, !isWinner),
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
        });
      }),
    );
  }

  Widget _buildBar(BuildContext context, String playerName, int score, bool isWinner) {
    const winnerHeight = 200.0;
    final height = isWinner ? winnerHeight : (winnerHeight * score / 100);
    final color = isWinner ? goldColor : silverColor;
    return Column(
      children: [
        Text(score.toString(), style: Theme.of(context).textTheme.titleLarge),
        SizedBox(height: smallGap),
        Container(
          width: 50,
          height: height,
          color: color,
        ),
        SizedBox(height: smallGap),
        Text(playerName, style: Theme.of(context).textTheme.titleLarge),
      ],
    );
  }
}
