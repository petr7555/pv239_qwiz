import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pv239_qwiz/auth/service/auth_cubit.dart';
import 'package:pv239_qwiz/auth/widget/sign_in_page.dart';
import 'package:pv239_qwiz/common/util/combine_any_latest_stream.dart';
import 'package:pv239_qwiz/common/util/go_router_refresh_stream.dart';
import 'package:pv239_qwiz/game/service/game_cubit.dart';
import 'package:pv239_qwiz/game/widget/aborted_game_page.dart';
import 'package:pv239_qwiz/game/widget/create_game_page.dart';
import 'package:pv239_qwiz/game/widget/get_ready_page.dart';
import 'package:pv239_qwiz/game/widget/join_game_page.dart';
import 'package:pv239_qwiz/leaderboard/widget/leaderboard_page.dart';
import 'package:pv239_qwiz/game/widget/lobby_page.dart';
import 'package:pv239_qwiz/game/widget/menu_page.dart';
import 'package:pv239_qwiz/game/widget/podium_page.dart';
import 'package:pv239_qwiz/game/widget/question_page.dart';

RouterConfig<Object> getRouterConfig(CombineAnyLatestStream<Object?, List<Object?>> combinedStream) {
  return GoRouter(
    redirect: (context, state) {
      final authCubit = context.read<AuthCubit>();
      final gameCubit = context.read<GameCubit>();

      final signedIn = authCubit.isSignedIn();
      if (!signedIn) {
        return _redirectIfNotThere(state, SignInPage.routeName);
      }
      if (state.subloc == SignInPage.routeName) {
        return MenuPage.routeName;
      }

      final gameActive = gameCubit.state != null;
      if (gameActive) {
        final userId = authCubit.state!.uid;
        final game = gameCubit.state!;
        final thisPlayer = game.thisPlayer(userId);
        return _redirectIfNotThere(state, thisPlayer.route);
      }

      if (!gameActive &&
          (state.subloc == LobbyPage.routeName ||
              state.subloc == QuestionPage.routeName ||
              state.subloc == PodiumPage.routeName ||
              state.subloc == AbortedGamePage.routeName)) {
        return MenuPage.routeName;
      }

      return null;
    },
    refreshListenable: GoRouterRefreshStream(combinedStream),
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
      GoRoute(
        path: PodiumPage.routeName,
        builder: (context, state) => PodiumPage(),
      ),
      GoRoute(
        path: AbortedGamePage.routeName,
        builder: (context, state) => AbortedGamePage(),
      ),
      GoRoute(
        path: LeaderboardPage.routeName,
        builder: (context, state) => LeaderboardPage(),
      ),
    ],
  );
}

String? _redirectIfNotThere(GoRouterState state, String routeName) {
  if (state.subloc != routeName) {
    return routeName;
  }
  return null;
}
