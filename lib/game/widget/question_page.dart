import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:linear_timer/linear_timer.dart';
import 'package:pv239_qwiz/auth/service/auth_cubit.dart';
import 'package:pv239_qwiz/common/util/shared_logic_constants.dart';
import 'package:pv239_qwiz/common/util/shared_ui_constants.dart';
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

    WidgetsBinding.instance.addPostFrameCallback((_) {
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
            return SizedBox.shrink();
          }

          final question = game.currentQuestion;
          final userId = context.read<AuthCubit>().userId;
          final you = game.you(userId);
          final opponent = game.opponent(userId);

          final youDeltaPoints = question.interactions[userId]!.deltaPoints;
          final opponentDeltaPoints = question.interactions[opponent.id]!.deltaPoints;

          final youTime = question.interactions[userId]!.secondsToAnswer;
          final opponentTime = question.interactions[opponent.id]!.secondsToAnswer;

          final isWinner = youDeltaPoints > opponentDeltaPoints;

          return Center(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _getPointsDisplay(
                      stateOfQuestion: stateOfQuestion,
                      label: 'You',
                      points: you.points,
                      deltaPoints: youDeltaPoints,
                      time: youTime,
                    ),
                    _getPointsDisplay(
                      stateOfQuestion: stateOfQuestion,
                      label: 'Opponent',
                      points: opponent.points,
                      deltaPoints: opponentDeltaPoints,
                      time: opponentTime,
                    ),
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
                    final isYourAnswer = question.interactions[userId]!.answerIdx == index;
                    final isOpponentsAnswer = question.interactions[opponent.id]!.answerIdx == index;
                    final isCorrect = question.correctAnswerIdx == index;

                    // final isYourAnswer = true;
                    // final isOpponentsAnswer = true;
                    // final isCorrect = question.correctAnswerIdx == index;

                    final borderText = _getBorderText(
                      stateOfQuestion: stateOfQuestion,
                      isYourAnswer: isYourAnswer,
                      isOpponentsAnswer: isOpponentsAnswer,
                    );

                    return Padding(
                      padding: EdgeInsets.only(bottom: smallGap),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(borderText),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(4.0)),
                              border: Border.all(
                                color: _getBorderColor(
                                  stateOfQuestion: stateOfQuestion,
                                  isYourAnswer: isYourAnswer,
                                  isOpponentsAnswer: isOpponentsAnswer,
                                ),
                                width: 5,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(4.0),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size.fromHeight(buttonHeight),
                                  backgroundColor: _getQuestionColor(
                                    stateOfQuestion: stateOfQuestion,
                                    isCorrect: isCorrect,
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                                ),
                                child: Text(answer),
                                onPressed: () {
                                  final userId = context.read<AuthCubit>().userId;
                                  final secondsToAnswer = answerTimerController.value * secondsForQuestion;
                                  context.read<GameCubit>().answerCurrentQuestion(userId, index, secondsToAnswer);
                                },
                              ),
                            ),
                          ),
                        ],
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

  Color? _getQuestionColor({
    required StateOfQuestion stateOfQuestion,
    required bool isCorrect,
  }) {
    if (stateOfQuestion == StateOfQuestion.showingResult) {
      if (isCorrect) {
        return correctColor;
      }
    }
    return null;
  }

  String _getBorderText({
    required StateOfQuestion stateOfQuestion,
    required bool isYourAnswer,
    required bool isOpponentsAnswer,
  }) {
    if (stateOfQuestion == StateOfQuestion.showingResult) {
      if (isYourAnswer && isOpponentsAnswer) {
        return 'Both answered';
      }
      if (isOpponentsAnswer) {
        return 'Opponent\'s answer';
      }
    }
    if (isYourAnswer) {
      return 'Your answer';
    }
    return '';
  }

  Color _getBorderColor({
    required StateOfQuestion stateOfQuestion,
    required bool isYourAnswer,
    required bool isOpponentsAnswer,
  }) {
    if (stateOfQuestion == StateOfQuestion.showingResult) {
      if (isYourAnswer && isOpponentsAnswer) {
        return bothColor;
      }
      if (isOpponentsAnswer) {
        return opponentColor;
      }
    }
    if (isYourAnswer) {
      return youColor;
    }
    return Colors.transparent;
  }

  Widget _getPointsDisplay({
    required StateOfQuestion stateOfQuestion,
    required String label,
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
            Text('$label: $points', style: textStyle),
            if (showDeltaPoints)
              Text(
                ' (${deltaPoints > 0 ? '+' : ''}$deltaPoints)',
                style: textStyle?.copyWith(color: deltaPoints > 0 ? Colors.green : Colors.red),
              ),
          ],
        ),
        SizedBox(height: 4.0),
        Row(
          children: [
            if (showTime) Icon(Icons.timer_outlined, size: 16.0),
            SizedBox(width: 2.0),
            Text(showTime ? '${time.toStringAsFixed(1)} sec' : '', style: textStyle),
          ],
        )
      ],
    );
  }
}
