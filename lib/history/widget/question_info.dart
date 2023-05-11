import 'package:flutter/material.dart';
import 'package:pv239_qwiz/game/model/question.dart';

class QuestionInfo extends StatelessWidget {
  final Question question;

  const QuestionInfo({
    super.key,
    required this.question,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
                  style: theme.textTheme.bodyMedium,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
