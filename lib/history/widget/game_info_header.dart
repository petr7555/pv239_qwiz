import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pv239_qwiz/auth/service/auth_cubit.dart';
import 'package:pv239_qwiz/common/util/shared_ui_constants.dart';
import 'package:pv239_qwiz/game/model/game.dart';

class GameInfoHeader extends StatelessWidget {
  final Game game;

  const GameInfoHeader({
    super.key,
    required this.game,
  });

  @override
  Widget build(BuildContext context) {
    final userId = context.read<AuthCubit>().userId;
    final you = game.you(userId);
    final opponent = game.opponent(userId);
    final isWinner = game.winnerId == userId;

    return Column(
      children: [
        _buildPlayerPoints(context: context, text: 'You: ${you.points}', isWinner: isWinner),
        SizedBox(height: smallGap),
        _buildPlayerPoints(context: context, text: 'Opponent: ${opponent.points}', isWinner: !isWinner),
      ],
    );
  }
}

Widget _buildPlayerPoints({
  required BuildContext context,
  required String text,
  required bool isWinner,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      if (isWinner)
        Row(
          children: [
            Icon(Icons.emoji_events, color: goldColor),
            SizedBox(width: smallGap),
          ],
        ),
      Text(text, style: Theme.of(context).textTheme.titleLarge),
    ],
  );
}
