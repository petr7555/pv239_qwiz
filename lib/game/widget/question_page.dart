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
  late final LinearTimerController _answerTimerController = LinearTimerController(this);
  var _stateOfQuestion = StateOfQuestion.initial;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_stateOfQuestion == StateOfQuestion.initial) {
        setState(() {
          _stateOfQuestion = StateOfQuestion.answering;
        });
        _answerTimerController.start(restart: true);
      }
    });
  }

  @override
  void dispose() {
    _answerTimerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GameCubit, Game?>(
      listener: (context, game) async {
        if (game != null) {
          if (game.winnerId != null) {
            return;
          }

          final userId = context.read<AuthCubit>().userId;

          if (game.resultTimersEnded && _stateOfQuestion == StateOfQuestion.showingResult) {
            context.read<GameCubit>().setResultTimerEnded(userId, ended: false);

            setState(() {
              _stateOfQuestion = StateOfQuestion.answering;
            });

            WidgetsBinding.instance.addPostFrameCallback((_) {
              _answerTimerController.start(restart: true);
            });
          }

          if (_stateOfQuestion == StateOfQuestion.answering && (game.allPlayersAnswered || game.answerTimersEnded)) {
            _answerTimerController.stop();

            setState(() {
              _stateOfQuestion = StateOfQuestion.showingResult;
            });
            Future.delayed(Duration(seconds: secondsForResults), () {
              context.read<GameCubit>().setResultTimerEnded(userId, ended: true);
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
        final question = game.currentQuestion;
        final secondsForQuestion = question.secondsForQuestion;

        return PageTemplate(
          title: question.isShootout ? 'Shootout question' : 'Question',
          actions: [QuitGameButton()],
          child: Center(
            child: Column(
              children: [
                PlayersPointsDisplay(stateOfQuestion: _stateOfQuestion, game: game),
                SizedBox(height: standardGap),
                QuestionTimer(
                  timerController: _answerTimerController,
                  secondsForQuestion: secondsForQuestion,
                  questionId: question.id,
                ),
                SizedBox(height: standardGap),
                Text(question.question, style: Theme.of(context).textTheme.titleLarge),
                SizedBox(height: standardGap),
                QuestionOptions(
                  stateOfQuestion: _stateOfQuestion,
                  question: question,
                  userId: userId,
                  opponentId: opponentId,
                  onPressed: (answerIdx) {
                    final userId = context.read<AuthCubit>().userId;
                    final secondsToAnswer = _answerTimerController.value * secondsForQuestion;
                    context.read<GameCubit>().answerCurrentQuestion(userId, answerIdx, secondsToAnswer);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
