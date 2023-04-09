import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:linear_timer/linear_timer.dart';
import 'package:pv239_qwiz/auth/service/auth_cubit.dart';
import 'package:pv239_qwiz/common/util/shared_logic_constants.dart';
import 'package:pv239_qwiz/common/util/shared_ui_constants.dart';
import 'package:pv239_qwiz/common/widget/button.dart';
import 'package:pv239_qwiz/common/widget/page_template.dart';
import 'package:pv239_qwiz/game/model/game.dart';
import 'package:pv239_qwiz/game/service/game_cubit.dart';

class QuestionPage extends StatelessWidget {
  const QuestionPage({super.key});

  static const routeName = '/question';

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Question',
      actions: [
        IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Are you sure you want to quit?'),
                actions: [
                  TextButton(
                    style: TextButton.styleFrom(foregroundColor: Colors.red),
                    child: Text('No'),
                    onPressed: () {
                      context.pop();
                    },
                  ),
                  TextButton(
                    style: TextButton.styleFrom(foregroundColor: Colors.green),
                    onPressed: () {
                      final userId = context.read<AuthCubit>().userId;
                      context.read<GameCubit>().abortGame(userId);
                    },
                    child: Text('Yes'),
                  ),
                ],
              ),
            );
          },
        ),
      ],
      child: BlocBuilder<GameCubit, Game?>(
        builder: (context, game) {
          if (game == null) {
            return Center(child: Text('No game in progress'));
          }
          final question = game.currentQuestion;

          return Center(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('You: 12', style: Theme.of(context).textTheme.titleMedium),
                    Text('Opponent: 15', style: Theme.of(context).textTheme.titleMedium),
                  ],
                ),
                SizedBox(height: standardGap),
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                  child: LinearTimer(
                    duration: const Duration(seconds: secondsForQuestion),
                    forward: false,
                    minHeight: 20,
                    color: secondaryColor,
                    onTimerEnd: () {},
                  ),
                ),
                SizedBox(height: standardGap),
                Text(question.question, style: Theme.of(context).textTheme.titleLarge),
                SizedBox(height: standardGap),
                Column(
                  children: [
                    for (var i = 0; i < question.allAnswers.length; i++)
                      Button(
                        label: question.allAnswers[i],
                        onPressed: () {
                          final userId = context.read<AuthCubit>().userId;
                          context.read<GameCubit>().answerQuestion(userId, question.id, i);
                        },
                      ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
