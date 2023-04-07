import 'package:flutter/material.dart';
import 'package:pv239_qwiz/common/widget/page_template.dart';

class QuestionPage extends StatelessWidget {
  const QuestionPage({super.key});

  static const routeName = '/question';

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Question',
      child: Center(
        child: Text('Question', style: Theme.of(context).textTheme.titleLarge),
      ),
    );
  }
}
