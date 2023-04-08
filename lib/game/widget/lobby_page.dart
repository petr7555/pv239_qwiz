import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pv239_qwiz/auth/service/auth_cubit.dart';
import 'package:pv239_qwiz/common/util/shared_logic_constants.dart';
import 'package:pv239_qwiz/common/util/shared_ui_constants.dart';
import 'package:pv239_qwiz/common/widget/button.dart';
import 'package:pv239_qwiz/common/widget/page_template.dart';
import 'package:pv239_qwiz/game/model/game.dart';
import 'package:pv239_qwiz/game/service/game_cubit.dart';
import 'package:pv239_qwiz/game/widget/get_ready_page.dart';
import 'package:pv239_qwiz/game/widget/menu_page.dart';

class LobbyPage extends StatelessWidget {
  const LobbyPage({super.key});

  static const routeName = '/lobby';

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Lobby',
      child: Column(
        children: [
          BlocConsumer<GameCubit, Game?>(
            listener: (context, game) {
              if (game?.players.length == maxPlayers) {
                context.push(GetReadyPage.routeName);
              }
            },
            builder: (context, game) => Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Game code: ', style: Theme.of(context).textTheme.titleLarge),
                    if (game != null)
                      Text(
                        game.id,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(color: Theme.of(context).colorScheme.secondary, fontWeight: FontWeight.bold),
                      ),
                  ],
                ),
                SizedBox(height: standardGap),
                Text('Waiting for the second player to join...', style: Theme.of(context).textTheme.titleLarge),
                SizedBox(height: standardGap),
                Button(
                  label: 'Cancel',
                  onPressed: () async {
                    final userId = context.read<AuthCubit>().userId;
                    final game = context.read<GameCubit>().state;
                    if (game != null) {
                      context
                          .read<GameCubit>()
                          .leaveGame(game.id, userId)
                          .then((value) => context.go(MenuPage.routeName));
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
