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
import 'package:pv239_qwiz/game/widget/question_options.dart';
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
            if (game.winnerId != null) return;

            if (game.resultTimersEnded && stateOfQuestion == StateOfQuestion.showingResult) {
              print('LISTENER: Result timers ended, StateOfQuestion was showingResult, will be answering');
              setState(() {
                print('LISTENER: Starting answer timer');
                stateOfQuestion = StateOfQuestion.answering;
                answerTimerController.start(restart: true);
              });
            }

            if (stateOfQuestion == StateOfQuestion.answering && (game.allPlayersAnswered || game.answerTimersEnded)) {
              answerTimerController.stop();

              print('LISTENER: Answer timers ended, StateOfQuestion was answering, will be showingResult');
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

          final userId = context.read<AuthCubit>().userId;
          final opponentId = game.opponent(userId).id;

          return Center(
            child: Column(
              children: [
                PlayersPointsDisplay(stateOfQuestion: stateOfQuestion, game: game),
                SizedBox(height: standardGap),
                QuestionTimer(timerController: answerTimerController),
                SizedBox(height: standardGap),
                Text(game.currentQuestion.question, style: Theme.of(context).textTheme.titleLarge),
                SizedBox(height: standardGap),
                QuestionOptions(
                  stateOfQuestion: stateOfQuestion,
                  question: game.currentQuestion,
                  userId: userId,
                  opponentId: opponentId,
                  onPressed: (answerIdx) {
                    final userId = context.read<AuthCubit>().userId;
                    final secondsToAnswer = answerTimerController.value * secondsForQuestion;
                    context.read<GameCubit>().answerCurrentQuestion(userId, answerIdx, secondsToAnswer);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
