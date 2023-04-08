import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jumping_dot/jumping_dot.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:pv239_qwiz/auth/service/auth_cubit.dart';
import 'package:pv239_qwiz/common/util/router.dart';
import 'package:pv239_qwiz/common/util/shared_ui_constants.dart';
import 'package:pv239_qwiz/game/service/game_cubit.dart';

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
        child: MaterialApp.router(
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
          routerConfig: router,
        ),
      ),
    );
  }
}
