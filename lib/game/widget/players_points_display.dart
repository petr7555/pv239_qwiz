import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pv239_qwiz/auth/service/auth_cubit.dart';
import 'package:pv239_qwiz/game/model/game.dart';
import 'package:pv239_qwiz/game/widget/question_page.dart';

class PlayersPointsDisplay extends StatelessWidget {
  final StateOfQuestion stateOfQuestion;
  final Game game;

  const PlayersPointsDisplay({
    super.key,
    required this.stateOfQuestion,
    required this.game,
  });

  @override
  Widget build(BuildContext context) {
    final question = game.currentQuestion;
    final userId = context.read<AuthCubit>().userId;
    final you = game.you(userId);
    final opponent = game.opponent(userId);
    final youInteraction = question.interactions[userId];
    final opponentInteraction = question.interactions[opponent.id];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildPlayerPointsDisplay(
          context: context,
          playerName: 'You',
          points: you.points,
          deltaPoints: youInteraction?.deltaPoints,
          time: youInteraction?.secondsToAnswer,
        ),
        _buildPlayerPointsDisplay(
          context: context,
          playerName: 'Opponent',
          points: opponent.points,
          deltaPoints: opponentInteraction?.deltaPoints,
          time: opponentInteraction?.secondsToAnswer,
        ),
      ],
    );
  }

  Widget _buildPlayerPointsDisplay({
    required BuildContext context,
    required String playerName,
    required int points,
    int? deltaPoints,
    double? time,
  }) {
    final textStyle = Theme.of(context).textTheme.titleMedium;

    final showDeltaPoints = stateOfQuestion == StateOfQuestion.showingResult && deltaPoints != null;
    final showTime = stateOfQuestion == StateOfQuestion.showingResult && time != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('$playerName: $points', style: textStyle),
            if (showDeltaPoints)
              Text(
                ' (${deltaPoints > 0 ? '+' : ''}$deltaPoints)',
                style: textStyle?.copyWith(color: deltaPoints > 0 ? Colors.green : Colors.red),
              ),
          ],
        ),
        SizedBox(height: 4),
        Row(
          children: [
            if (showTime) Icon(Icons.timer_outlined, size: 16),
            SizedBox(width: 2),
            Text(showTime ? '${time.toStringAsFixed(1)} sec' : '', style: textStyle),
          ],
        )
      ],
    );
  }
}
