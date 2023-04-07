import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pv239_qwiz/common/widget/page_template.dart';
import 'package:pv239_qwiz/game/widget/button.dart';

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

  Widget _createMenuButton({
    required BuildContext context,
    required String label,
    required String route,
  }) {
    return Button(
      label: label,
      onPressed: () => context.push(route),
    );
  }
}
