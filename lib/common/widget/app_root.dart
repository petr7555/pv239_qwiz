import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jumping_dot/jumping_dot.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:pv239_qwiz/auth/service/auth_cubit.dart';
import 'package:pv239_qwiz/auth/widget/sign_in_page.dart';
import 'package:pv239_qwiz/common/util/go_router_refresh_stream.dart';
import 'package:pv239_qwiz/common/util/shared_ui_constants.dart';
import 'package:pv239_qwiz/game/service/game_cubit.dart';
import 'package:pv239_qwiz/game/widget/create_game_page.dart';
import 'package:pv239_qwiz/game/widget/get_ready_page.dart';
import 'package:pv239_qwiz/game/widget/join_game_page.dart';
import 'package:pv239_qwiz/game/widget/lobby_page.dart';
import 'package:pv239_qwiz/game/widget/menu_page.dart';
import 'package:pv239_qwiz/game/widget/question_page.dart';

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
        child: Builder(builder: (context) {
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
                if (!context.read<AuthCubit>().isSignedIn()) {
                  return SignInPage.routeName;
                }
                if (context.read<GameCubit>().state != null) {
                  // TODO later redirect to the correct page based on game state
                  return LobbyPage.routeName;
                }
                return null;
              },
              refreshListenable: GoRouterRefreshStream(context.read<GameCubit>().stream),
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
            ),
          );
        }),
      ),
    );
  }
}
