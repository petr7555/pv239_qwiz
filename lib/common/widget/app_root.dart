import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jumping_dot/jumping_dot.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:pv239_qwiz/auth/model/auth_user.dart';
import 'package:pv239_qwiz/auth/service/auth_cubit.dart';
import 'package:pv239_qwiz/auth/widget/sign_in_page.dart';
import 'package:pv239_qwiz/common/util/combine_any_latest_stream.dart';
import 'package:pv239_qwiz/common/util/go_router_refresh_stream.dart';
import 'package:pv239_qwiz/common/util/shared_ui_constants.dart';
import 'package:pv239_qwiz/game/model/game_status.dart';
import 'package:pv239_qwiz/game/service/game_cubit.dart';
import 'package:pv239_qwiz/game/widget/aborted_game_page.dart';
import 'package:pv239_qwiz/game/widget/create_game_page.dart';
import 'package:pv239_qwiz/game/widget/get_ready_page.dart';
import 'package:pv239_qwiz/game/widget/join_game_page.dart';
import 'package:pv239_qwiz/game/widget/lobby_page.dart';
import 'package:pv239_qwiz/game/widget/menu_page.dart';
import 'package:pv239_qwiz/game/widget/podium_page.dart';
import 'package:pv239_qwiz/game/widget/question_page.dart';

String? redirectIfNotThere(GoRouterState state, String routeName) {
  if (state.subloc != routeName) {
    return routeName;
  }
  return null;
}

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(lazy: false, create: (context) => AuthCubit()),
        BlocProvider(lazy: false, create: (context) => GameCubit()),
      ],
      child: GlobalLoaderOverlay(
        useDefaultLoading: false,
        overlayWidget: Center(
          child: JumpingDots(
            color: primaryColor,
            radius: 10,
            numberOfDots: 3,
            animationDuration: Duration(milliseconds: 200),
          ),
        ),
        child: BlocListener<AuthCubit, AuthUser?>(
          listener: (BuildContext context, state) {
            if (state != null) {
              context.read<GameCubit>().startListening(state.uid);
            }
          },
          child: Builder(builder: (context) {
            final authCubit = context.read<AuthCubit>();
            final gameCubit = context.read<GameCubit>();
            final combinedStream = CombineAnyLatestStream([authCubit.stream, gameCubit.stream], (values) => values);

            return MaterialApp.router(
              title: 'Qwiz',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSwatch(
                  brightness: Brightness.light,
                  primarySwatch: primaryColor,
                  accentColor: secondaryColor,
                ),
              ),
              darkTheme: ThemeData(
                colorScheme: ColorScheme.fromSwatch(
                  brightness: Brightness.dark,
                  primarySwatch: primaryColor,
                  accentColor: secondaryColor,
                ),
              ),
              routerConfig: GoRouter(
                redirect: (context, state) {
                  final signedIn = authCubit.isSignedIn();
                  if (!signedIn) {
                    return redirectIfNotThere(state, SignInPage.routeName);
                  }
                  if (state.subloc == SignInPage.routeName) {
                    return MenuPage.routeName;
                  }

                  final gameActive = gameCubit.state != null;
                  if (gameActive) {
                    final userId = authCubit.state!.uid;
                    final game = gameCubit.state!;
                    final thisPlayer = game.thisPlayer(userId)!;
                    return redirectIfNotThere(state, thisPlayer.route);
                  }

                  if (!gameActive && state.subloc == LobbyPage.routeName) {
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
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
