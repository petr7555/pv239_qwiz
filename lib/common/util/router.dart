import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pv239_qwiz/auth/service/auth_cubit.dart';
import 'package:pv239_qwiz/auth/widget/sign_in_page.dart';
import 'package:pv239_qwiz/game/widget/create_game_page.dart';
import 'package:pv239_qwiz/game/widget/get_ready_page.dart';
import 'package:pv239_qwiz/game/widget/join_game_page.dart';
import 'package:pv239_qwiz/game/widget/lobby_page.dart';
import 'package:pv239_qwiz/game/widget/menu_page.dart';
import 'package:pv239_qwiz/game/widget/question_page.dart';

final router = GoRouter(
  redirect: (context, state) {
    if (context.read<AuthCubit>().isSignedIn()) {
      return null;
    }
    return SignInPage.routeName;
  },
  initialLocation: MenuPage.routeName,
  routes: [
    GoRoute(
      path: SignInPage.routeName,
      builder: (context, state) => SignInPage(),
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
      path: LobbyPage.routeName,
      builder: (context, state) => LobbyPage(),
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
