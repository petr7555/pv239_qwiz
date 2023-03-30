import 'package:flutter/material.dart';
import 'package:pv239_qwiz/common/widget/page_template.dart';

class CreateGamePage extends StatelessWidget {
  const CreateGamePage({super.key});

  static const routeName = '/createGame';

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Create game',
      child: Placeholder(),
    );
  }
}
