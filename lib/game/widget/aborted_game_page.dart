import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pv239_qwiz/common/util/shared_ui_constants.dart';
import 'package:pv239_qwiz/common/widget/button.dart';
import 'package:pv239_qwiz/common/widget/page_template.dart';
import 'package:pv239_qwiz/game/widget/menu_page.dart';

class AbortedGamePage extends StatelessWidget {
  const AbortedGamePage({super.key});

  static const routeName = '/abortedGame';

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Aborted game',
      child: Center(
        child: Column(
          children: [
            Text('Game was aborted because one of the players left.', style: Theme.of(context).textTheme.titleLarge),
            SizedBox(height: standardGap),
            Button(
              label: 'Back to menu',
              onPressed: () => context.go(MenuPage.routeName),
            )
          ],
        ),
      ),
    );
  }
}
