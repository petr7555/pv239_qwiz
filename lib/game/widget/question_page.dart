import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linear_timer/linear_timer.dart';
import 'package:pv239_qwiz/auth/service/auth_cubit.dart';
import 'package:pv239_qwiz/common/util/shared_logic_constants.dart';
import 'package:pv239_qwiz/common/util/shared_ui_constants.dart';
import 'package:pv239_qwiz/common/widget/page_template.dart';
import 'package:pv239_qwiz/game/model/game.dart';
import 'package:pv239_qwiz/game/service/game_cubit.dart';
import 'package:pv239_qwiz/game/widget/players_points_display.dart';
import 'package:pv239_qwiz/game/widget/question_timer.dart';
import 'package:pv239_qwiz/game/widget/quit_game_button.dart';

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
      actions: [QuitGameButton()],
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

            if (stateOfQuestion == StateOfQuestion.answering && (game.allPlayersAnswered || game.answerTimersEnded)) {
              answerTimerController.stop();

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
          final opponent = game.opponent(userId);

          return Center(
            child: Column(
              children: [
                PlayersPointsDisplay(stateOfQuestion: stateOfQuestion, game: game),
                SizedBox(height: standardGap),
                QuestionTimer(timerController: answerTimerController),
                SizedBox(height: standardGap),
                Text(question.question, style: Theme.of(context).textTheme.titleLarge),
                SizedBox(height: standardGap),
                Column(
                  children: question.allAnswers.mapIndexed((index, answer) {
                    final isYourAnswer = question.interactions[userId]!.answerIdx == index;
                    final isOpponentsAnswer = question.interactions[opponent.id]!.answerIdx == index;
                    final isCorrect = question.correctAnswerIdx == index;

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
}
