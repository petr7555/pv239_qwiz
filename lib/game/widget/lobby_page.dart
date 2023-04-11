import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pv239_qwiz/common/util/shared_ui_constants.dart';
import 'package:pv239_qwiz/common/widget/button.dart';
import 'package:pv239_qwiz/common/widget/page_template.dart';
import 'package:pv239_qwiz/game/model/game.dart';
import 'package:pv239_qwiz/game/service/game_cubit.dart';

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
            builder: (context, game) {
              if (game == null) {
                return SizedBox.shrink();
              }

              final theme = Theme.of(context);
              final gameCodeStyle = theme.textTheme.headlineMedium?.copyWith(
                color: theme.colorScheme.secondary,
                fontWeight: FontWeight.bold,
              );
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Game code: ', style: theme.textTheme.titleLarge),
                      Text(game.id, style: gameCodeStyle),
                    ],
                  ),
                  SizedBox(height: standardGap),
                  Text('Waiting for the second player to join...', style: theme.textTheme.titleLarge),
                  SizedBox(height: standardGap),
                  Button(label: 'Cancel', onPressed: context.read<GameCubit>().deleteGame),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
