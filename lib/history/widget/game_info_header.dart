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
        _buildPlayerScore(context: context, text: '${isWinner ? '🏆 ' : ''}You: ${you.points}'),
        SizedBox(height: smallGap),
        _buildPlayerScore(context: context, text: '${isWinner ? '' : '🏆 '}Opponent: ${opponent.points}'),
      ],
    );
  }
}

Widget _buildPlayerScore({
  required BuildContext context,
  required String text,
}) {
  return Text(text, style: Theme.of(context).textTheme.titleLarge);
}
