import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pv239_qwiz/auth/service/auth_cubit.dart';
import 'package:pv239_qwiz/common/util/shared_ui_constants.dart';
import 'package:pv239_qwiz/game/model/game.dart';
import 'package:pv239_qwiz/game/widget/question_page.dart';

class QuestionOptions extends StatelessWidget {
  final StateOfQuestion stateOfQuestion;
  final Game game;
  final Function(int) onPressed;

  const QuestionOptions({
    super.key,
    required this.stateOfQuestion,
    required this.game,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final userId = context.read<AuthCubit>().userId;
    final question = game.currentQuestion;

    return Column(
      children: question.allAnswers.mapIndexed((answerIdx, answer) {
        final isYourAnswer = question.interactions[userId]?.answerIdx == answerIdx;
        final isOpponentsAnswer = question.interactions[game.opponentId(userId)]?.answerIdx == answerIdx;

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
                      backgroundColor: _getAnswerColor(
                        stateOfQuestion: stateOfQuestion,
                        isCorrect: question.correctAnswerIdx == answerIdx,
                      ),
                      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    ),
                    child: Text(answer),
                    onPressed: () => onPressed(answerIdx),
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Color? _getAnswerColor({
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
        return "Opponent's answer";
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
