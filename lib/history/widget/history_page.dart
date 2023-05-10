import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pv239_qwiz/auth/service/auth_cubit.dart';
import 'package:pv239_qwiz/common/widget/page_template.dart';
import 'package:pv239_qwiz/game/model/game.dart';
import 'package:pv239_qwiz/history/service/history_service.dart';
import 'package:pv239_qwiz/history/widget/game_info_page.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  static const routeName = '/history';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final userId = context.read<AuthCubit>().userId;

    return PageTemplate(
      title: 'History',
      child: StreamBuilder<List<Game>>(
        stream: HistoryService.getGamesByPlayer(userId),
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
          games.sort((a, b) => b.createdAt.compareTo(a.createdAt));
          return ListView.builder(
            itemCount: games.length,
            itemBuilder: (context, index) {
              final game = games[index];
              final opponent = game.opponent(userId);

              return ListTile(
                title: Text('Game with ${opponent.displayName}', style: theme.textTheme.titleLarge),
                subtitle: Text(game.createdAt.toString(), style: theme.textTheme.bodyMedium),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () => context.push(GameInfoPage.routeName, extra: game),
              );
            },
          );
        },
      ),
    );
  }
}
