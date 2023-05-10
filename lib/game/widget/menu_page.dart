import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pv239_qwiz/auth/service/auth_cubit.dart';
import 'package:pv239_qwiz/common/util/shared_ui_constants.dart';
import 'package:pv239_qwiz/common/widget/button.dart';
import 'package:pv239_qwiz/common/widget/page_template.dart';
import 'package:pv239_qwiz/game/widget/create_game_page.dart';
import 'package:pv239_qwiz/game/widget/join_game_page.dart';
import 'package:pv239_qwiz/game/widget/user_avatar.dart';
import 'package:pv239_qwiz/history/widget/history_page.dart';
import 'package:pv239_qwiz/leaderboard/widget/leaderboard_page.dart';

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
            UserAvatar(),
            SizedBox(height: largeGap),
            _buildMenuButton(context: context, label: 'Create game', route: CreateGamePage.routeName),
            SizedBox(height: smallGap),
            _buildMenuButton(context: context, label: 'Join game', route: JoinGamePage.routeName),
            SizedBox(height: smallGap),
            _buildMenuButton(context: context, label: 'History', route: HistoryPage.routeName),
            SizedBox(height: smallGap),
            _buildMenuButton(context: context, label: 'Leaderboard', route: LeaderboardPage.routeName),
            SizedBox(height: smallGap),
            Button(label: 'Sign out', onPressed: () => context.read<AuthCubit>().signOut()),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuButton({
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
