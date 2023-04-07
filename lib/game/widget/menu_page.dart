import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pv239_qwiz/auth/service/auth_cubit.dart';
import 'package:pv239_qwiz/auth/widget/sign_in_page.dart';
import 'package:pv239_qwiz/common/util/shared_ui_constants.dart';
import 'package:pv239_qwiz/common/widget/page_template.dart';
import 'package:pv239_qwiz/game/widget/button.dart';
import 'package:pv239_qwiz/game/widget/create_game_page.dart';
import 'package:pv239_qwiz/game/widget/join_game_page.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Menu',
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _createMenuButton(context: context, label: 'Create game', route: CreateGamePage.routeName),
            SizedBox(height: smallGap),
            _createMenuButton(context: context, label: 'Join game', route: JoinGamePage.routeName),
            SizedBox(height: smallGap),
            _createMenuButton(context: context, label: 'History', route: '/history'),
            SizedBox(height: smallGap),
            _createMenuButton(context: context, label: 'Leaderboard', route: '/leaderboard'),
            SizedBox(height: smallGap),
            Button(
                label: 'Sign out',
                onPressed: () => context.read<AuthCubit>().signOut().then((_) => context.go(SignInPage.routeName))),
          ],
        ),
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
