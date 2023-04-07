import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pv239_qwiz/common/util/shared_ui_constants.dart';
import 'package:pv239_qwiz/common/widget/page_template.dart';
import 'package:pv239_qwiz/game/model/game.dart';
import 'package:pv239_qwiz/game/service/game_cubit.dart';
import 'package:pv239_qwiz/game/widget/button.dart';

class LobbyPage extends StatelessWidget {
  const LobbyPage({super.key});

  static const routeName = '/lobby';

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Lobby',
      child: Column(
        children: [
          BlocBuilder<GameCubit, Game?>(
            builder: (context, state) => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Game code: ', style: Theme.of(context).textTheme.titleLarge),
                Text(state!.id, style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.blue)),
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