import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pv239_qwiz/auth/model/auth_user.dart';
import 'package:pv239_qwiz/auth/service/auth_cubit.dart';
import 'package:pv239_qwiz/common/util/combine_any_latest_stream.dart';
import 'package:pv239_qwiz/common/util/dark_theme.dart';
import 'package:pv239_qwiz/common/util/get_router_config.dart';
import 'package:pv239_qwiz/common/util/light_theme.dart';
import 'package:pv239_qwiz/common/widget/app_loader_overlay.dart';
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
      child: AppLoaderOverlay(
        child: BlocListener<AuthCubit, AuthUser?>(
          listener: (BuildContext context, state) {
            if (state != null) {
              context.read<GameCubit>().startListening(state.uid);
            }
          },
          child: Builder(
            builder: (context) {
              final authCubit = context.read<AuthCubit>();
              final gameCubit = context.read<GameCubit>();
              final combinedStream = CombineAnyLatestStream([authCubit.stream, gameCubit.stream], (v) => v);

              return MaterialApp.router(
                title: 'Qwiz',
                theme: lightTheme,
                darkTheme: darkTheme,
                routerConfig: getRouterConfig(combinedStream),
              );
            },
          ),
        ),
      ),
    );
  }
}
