import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linear_timer/linear_timer.dart';
import 'package:pv239_qwiz/auth/service/auth_cubit.dart';
import 'package:pv239_qwiz/common/util/shared_ui_constants.dart';
import 'package:pv239_qwiz/game/service/game_cubit.dart';

class QuestionTimer extends StatelessWidget {
  final LinearTimerController timerController;
  final int secondsForQuestion;
  final String questionId;

  const QuestionTimer({
    super.key,
    required this.timerController,
    required this.secondsForQuestion,
    required this.questionId,
  });

  @override
  Widget build(BuildContext context) {
    final userId = context.read<AuthCubit>().userId;

    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(16)),
      child: LinearTimer(
        controller: timerController,
        key: ValueKey(questionId),
        duration: Duration(seconds: secondsForQuestion),
        forward: false,
        minHeight: 20,
        color: secondaryColor,
        onTimerEnd: () {
          context.read<GameCubit>().setAnswerTimerEnded(userId, ended: true);
        },
      ),
    );
  }
}
