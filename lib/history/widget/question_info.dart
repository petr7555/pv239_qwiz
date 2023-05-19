import 'package:flutter/material.dart';
import 'package:pv239_qwiz/game/model/question.dart';

class QuestionInfo extends StatelessWidget {
  final Question question;
  final String userId;
  final String opponentId;

  const QuestionInfo({
    super.key,
    required this.userId,
    required this.opponentId,
    required this.question,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final yourAnswer = (question.interactions[userId] != null && question.interactions[userId]!.answerIdx != null)
        ? question.interactions[userId]!.answerIdx!
        : null;
    final opponentAnswer =
        (question.interactions[opponentId] != null && question.interactions[opponentId]!.answerIdx != null)
            ? question.interactions[opponentId]!.answerIdx!
            : null;
    return ListTile(
      title: Text(question.question),
      subtitle: Column(
        children: <Widget>[
          Text('Correct answer was: ${question.allAnswers[question.correctAnswerIdx]}'),
          Column(
            children: question.allAnswers.map<Widget>((answer) {
              return ListTile(
                title: Text(
                  answer,
                  style: theme.textTheme.bodyMedium != null
                      ? theme.textTheme.bodyMedium!
                          .copyWith(color: getQuestionColor(answer, yourAnswer, opponentAnswer))
                      : theme.textTheme.bodyMedium,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Color? getQuestionColor(String answer, int? userAnswer, int? opponentAnswer) {
    if (userAnswer != null &&
        opponentAnswer != null &&
        userAnswer == opponentAnswer &&
        question.allAnswers[userAnswer] == answer) {
      return Colors.orange;
    }
    if (userAnswer != null && question.allAnswers[userAnswer] == answer) {
      return Colors.blue;
    }
    if (opponentAnswer != null && question.allAnswers[opponentAnswer] == answer) {
      return Colors.red;
    }
    return null;
  }
}
