import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pv239_qwiz/common/util/shared_logic_constants.dart';
import 'package:pv239_qwiz/common/util/shared_ui_constants.dart';
import 'package:pv239_qwiz/common/widget/page_template.dart';
import 'package:pv239_qwiz/game/model/game.dart';
import 'package:pv239_qwiz/game/service/game_cubit.dart';
import 'package:pv239_qwiz/game/widget/button.dart';
import 'package:pv239_qwiz/game/widget/get_ready_page.dart';

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
            listener: (context, state) {
              if (state?.players.length == maxPlayers) {
                context.push(GetReadyPage.routeName);
              }
            },
            builder: (context, state) => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Game code: ', style: Theme.of(context).textTheme.titleLarge),
                if (state != null)
                  Text(state.id, style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.blue)),
              ],
            ),
          ),
          SizedBox(height: standardGap),
          Text('Waiting for other player to join...', style: Theme.of(context).textTheme.titleLarge),
          SizedBox(height: standardGap),
          Button(label: 'Cancel', onPressed: () {})
        ],
      ),
    );
  }
}
