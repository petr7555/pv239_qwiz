import 'package:flutter/material.dart';
import 'package:pv239_qwiz/common/util/shared_ui_constants.dart';
import 'package:pv239_qwiz/common/widget/page_template.dart';
import 'package:pv239_qwiz/game/widget/menu_button.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Menu',
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MenuButton(
              label: 'Create game',
              route: '/createGame',
            ),
            SizedBox(height: smallGap),
            MenuButton(
              label: 'Join game',
              route: '/joinGame',
            ),
            SizedBox(height: smallGap),
            MenuButton(
              label: 'History',
              route: '/history',
            ),
            SizedBox(height: smallGap),
            MenuButton(
              label: 'Leaderboard',
              route: '/leaderboard',
            ),
          ],
        ),
      ),
    );
  }
}
