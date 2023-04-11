import 'package:collection/collection.dart';
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

class QuestionPage extends StatefulWidget {
  const QuestionPage({super.key});

  static const routeName = '/question';

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

enum StateOfQuestion { initial, answering, showingResult }

class _QuestionPageState extends State<QuestionPage> with TickerProviderStateMixin {
  late LinearTimerController answerTimerController = LinearTimerController(this);
  var stateOfQuestion = StateOfQuestion.initial;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      if (stateOfQuestion == StateOfQuestion.initial) {
        setState(() {
          print('INIT: Starting answer timer');
          stateOfQuestion = StateOfQuestion.answering;
          answerTimerController.start(restart: true);
        });
      }
    });
  }

  @override
  void dispose() {
    answerTimerController.dispose();
    super.dispose();
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
      child: BlocConsumer<GameCubit, Game?>(
        listener: (context, game) async {
          final userId = context.read<AuthCubit>().userId;

          if (game != null) {
            if (game.resultTimersEnded && stateOfQuestion == StateOfQuestion.showingResult) {
              print('LISTENER: Result timers ended, StateOfQuestion.showingResult');
              setState(() {
                print('LISTENER: Starting answer timer');
                stateOfQuestion = StateOfQuestion.answering;
                answerTimerController.start(restart: true);
              });
            }

            if (game.answerTimersEnded && stateOfQuestion == StateOfQuestion.answering) {
              print('LISTENER: Answer timers ended, StateOfQuestion.answering');
              setState(() {
                stateOfQuestion = StateOfQuestion.showingResult;
              });
              print('LISTENER: Starting result timer');
              Future.delayed(Duration(seconds: secondsForResults), () {
                print('LISTENER: Result timer ended');
                context.read<GameCubit>().setResultTimerEnded(userId);
              });
            }
          }
        },
        builder: (context, game) {
          if (game == null) {
            return Center(child: Text('No game in progress'));
          }
          final question = game.currentQuestion;
          final userId = context.read<AuthCubit>().userId;
          final thisPlayer = game.thisPlayer(userId);
          final opponent = game.opponent(userId);
          final answerTimersEnded = game.answerTimersEnded;

          return Center(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('You: ${thisPlayer.points}', style: Theme.of(context).textTheme.titleMedium),
                    Text('Opponent: ${opponent.points}', style: Theme.of(context).textTheme.titleMedium),
                  ],
                ),
                SizedBox(height: standardGap),
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                  child: LinearTimer(
                    controller: answerTimerController,
                    duration: Duration(seconds: secondsForQuestion),
                    forward: false,
                    minHeight: 20,
                    color: secondaryColor,
                    onTimerEnd: () {
                      print('BUILDER: Answer timer ended');
                      context.read<GameCubit>().setAnswerTimerEnded(userId);
                    },
                  ),
                ),
                SizedBox(height: standardGap),
                Text(question.question, style: Theme.of(context).textTheme.titleLarge),
                SizedBox(height: standardGap),
                Column(
                  children: question.allAnswers.mapIndexed((index, answer) {
                    final isSelected = question.interactions[userId]!.answerIdx == index;
                    final isCorrect = question.correctAnswerIdx == index;

                    return Padding(
                      padding: EdgeInsets.only(bottom: standardGap),
                      child: Button(
                        color: _getQuestionColor(
                            isSelected: isSelected, isCorrect: isCorrect, answerTimersEnded: answerTimersEnded),
                        label: answer,
                        onPressed: () {
                          final userId = context.read<AuthCubit>().userId;
                          context.read<GameCubit>().answerQuestion(userId, question.id, index);
                        },
                      ),
                    );
                  }).toList(),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Color? _getQuestionColor({required bool isSelected, required bool isCorrect, required bool answerTimersEnded}) {
    if (answerTimersEnded) {
      if (isCorrect) {
        return Colors.green;
      }
    }
    if (isSelected) {
      return Colors.orange;
    }
    return null;
  }
}
