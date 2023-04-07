import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pv239_qwiz/common/widget/login_page.dart';
import 'package:pv239_qwiz/game/widget/create_game_page.dart';
import 'package:pv239_qwiz/game/widget/get_ready_page.dart';
import 'package:pv239_qwiz/game/widget/join_game_page.dart';
import 'package:pv239_qwiz/game/widget/lobby_page.dart';
import 'package:pv239_qwiz/game/widget/menu_page.dart';
import 'package:pv239_qwiz/game/widget/question_page.dart';

final _router = GoRouter(
  routes: [
    GoRoute(
      path: LoginPage.routeName,
      builder: (context, state) => LoginPage(),
    ),
    GoRoute(
      path: MenuPage.routeName,
      builder: (context, state) => MenuPage(),
    ),
    GoRoute(
      path: CreateGamePage.routeName,
      builder: (context, state) => CreateGamePage(),
    ),
    GoRoute(
      path: JoinGamePage.routeName,
      builder: (context, state) => JoinGamePage(),
    ),
    GoRoute(
      path: '${LobbyPage.routeName}/:gameCode',
      name: LobbyPage.routeName,
      builder: (context, state) => LobbyPage(gameCode: state.params['gameCode']!),
    ),
    GoRoute(
      path: GetReadyPage.routeName,
      builder: (context, state) => GetReadyPage(),
    ),
    GoRoute(
      path: QuestionPage.routeName,
      builder: (context, state) => QuestionPage(),
    ),
  ],
);

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Qwiz',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: _router,
    );
  }
}
