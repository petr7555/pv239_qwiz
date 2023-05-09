import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pv239_qwiz/auth/service/auth_cubit.dart';

class QuestionInfo extends StatelessWidget {
  final question;
  const QuestionInfo({Key? key, required this.question}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      title: Text(question.question),
      subtitle: Column(
        children: <Widget>[
          Text('Correct answer was: ' + question.allAnswers[question.correctAnswerIdx]),
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
