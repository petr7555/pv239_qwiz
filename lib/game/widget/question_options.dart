import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:pv239_qwiz/common/util/shared_ui_constants.dart';
import 'package:pv239_qwiz/game/model/question.dart';
import 'package:pv239_qwiz/game/widget/question_page.dart';
import 'package:tuple/tuple.dart';

class QuestionOptions extends StatelessWidget {
  final StateOfQuestion stateOfQuestion;
  final Question question;
  final String userId;
  final String opponentId;
  final Function(int)? onPressed;

  const QuestionOptions({
    super.key,
    required this.stateOfQuestion,
    required this.question,
    required this.userId,
    required this.opponentId,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: question.allAnswers.mapIndexed((answerIdx, answer) {
        final isYourAnswer = question.interactions[userId]?.answerIdx == answerIdx;
        final isOpponentsAnswer = question.interactions[opponentId]?.answerIdx == answerIdx;

        final borderTextAndColor = _getBorderTextAndColor(
          stateOfQuestion: stateOfQuestion,
          isYourAnswer: isYourAnswer,
          isOpponentsAnswer: isOpponentsAnswer,
        );

        final backgroundColor =
            stateOfQuestion == StateOfQuestion.showingResult && question.correctAnswerIdx == answerIdx
                ? correctColor
                : Theme.of(context).colorScheme.primary;

        return Padding(
          padding: EdgeInsets.only(bottom: smallGap),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(borderTextAndColor.item1),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  border: Border.all(
                    color: borderTextAndColor.item2,
                    width: 5,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(4),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: backgroundColor,
                      disabledBackgroundColor: backgroundColor,
                      disabledForegroundColor: Theme.of(context).colorScheme.onPrimary,
                      minimumSize: Size.fromHeight(buttonHeight),
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    ),
                    onPressed: onPressed != null ? () => onPressed!(answerIdx) : null,
                    child: Text(answer),
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Tuple2<String, Color> _getBorderTextAndColor({
    required StateOfQuestion stateOfQuestion,
    required bool isYourAnswer,
    required bool isOpponentsAnswer,
  }) {
    if (stateOfQuestion == StateOfQuestion.showingResult) {
      if (isYourAnswer && isOpponentsAnswer) {
        return Tuple2('Both answered', bothColor);
      }
      if (isOpponentsAnswer) {
        return Tuple2("Opponent's answer", opponentsColor);
      }
    }
    if (isYourAnswer) {
      return Tuple2('Your answer', yourColor);
    }
    return Tuple2('', Colors.transparent);
  }
}
