import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:linear_timer/linear_timer.dart';
import 'package:pv239_qwiz/auth/service/auth_cubit.dart';
import 'package:pv239_qwiz/common/service/ioc_container.dart';
import 'package:pv239_qwiz/common/util/shared_logic_constants.dart';
import 'package:pv239_qwiz/common/util/shared_ui_constants.dart';
import 'package:pv239_qwiz/common/widget/button.dart';
import 'package:pv239_qwiz/common/widget/handling_future_builder.dart';
import 'package:pv239_qwiz/common/widget/page_template.dart';
import 'package:pv239_qwiz/game/model/question.dart';
import 'package:pv239_qwiz/game/service/game_cubit.dart';
import 'package:pv239_qwiz/game/service/question_api_service.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({super.key});

  static const routeName = '/question';

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  late Future<Question> futureQuestion;

  @override
  void initState() {
    super.initState();
    futureQuestion = get<QuestionApiService>().getQuestion();
  }

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
                    child: Text('Yes'),
                    onPressed: () {
                      final userId = context.read<AuthCubit>().userId;
                      final gameId = context.read<GameCubit>().state!.id;
                      context.read<GameCubit>().leaveGame(gameId, userId);
                      // context.pop();
                      // context.go(MenuPage.routeName);
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ],
      child: HandlingFutureBuilder<Question>(
        future: futureQuestion,
        builder: (context, question) {
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
                    for (final answer in question.allAnswers)
                      Button(
                        label: answer,
                        onPressed: () {},
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
