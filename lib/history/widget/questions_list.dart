import 'package:flutter/material.dart';
import 'package:pv239_qwiz/game/model/question.dart';

class QuestionsList extends StatelessWidget {
  final List<Question> questions;

  const QuestionsList({
    super.key,
    required this.questions,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: questions.length,
      itemBuilder: (context, index) {
        final question = questions[index];

        return Text(question.question);
      },
      separatorBuilder: (BuildContext context, int index) => Divider(thickness: 1),
    );
  }
}
