import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pv239_qwiz/auth/service/auth_cubit.dart';
import 'package:pv239_qwiz/common/widget/page_template.dart';

import '../../game/model/game.dart';
import '../../game/service/game_service.dart';
import 'game_result_page.dart';



class GameHistoryPage extends StatelessWidget {
  static const routeName = '/history';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final userId = context.read<AuthCubit>().userId;
    final gameService = GameService();

    return PageTemplate(
      title: 'Game History',
      child: StreamBuilder<List<Game>>(
        stream: gameService.finishedGameStream(userId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final games = snapshot.data!;
          if (games.isEmpty) {
            return Center(
              child: Text('No games played on this account yet'),
            );
          }

          return ListView.builder(
            itemCount: games.length,
            itemBuilder: (context, index) {
              final game = games[index];
              final opponent = game.players.values.where((element) => element.id != userId).first;

              return ListTile(
                title: Text('Game with ${opponent.name}', style: theme.textTheme.titleLarge),
                subtitle: Text(game.date.toString(), style: theme.textTheme.bodyMedium),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    GameResultPage.routeName,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
