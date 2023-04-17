import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pv239_qwiz/auth/service/auth_cubit.dart';
import 'package:pv239_qwiz/common/widget/page_template.dart';
import 'package:pv239_qwiz/game/model/game.dart';
import 'package:pv239_qwiz/game/service/game_cubit.dart';

import 'game_result_page.dart';

class GameHistoryPage extends StatelessWidget {
  static const routeName = '/history';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final userId = context.read<AuthCubit>().userId;

    return PageTemplate(
      title: 'Game History',
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('games')
            .where('players', arrayContains: userId)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final games = snapshot.data!.docs.map((doc) => Game.fromJson(doc)).toList();
          final thisPlayerGames = games.where((game) => game.players.contains(userId)).toList();

          return ListView.builder(
            itemCount: thisPlayerGames.length,
            itemBuilder: (context, index) {
              final game = thisPlayerGames[index];
              final opponent = game.opponent(userId);

              return ListTile(
                title: Text('Game with ${opponent.name}', style: theme.textTheme.titleLarge),
                subtitle: Text(game.dateTime.toString(), style: theme.textTheme.bodyMedium),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    GameResultPage.routeName,
                    arguments: GameResultPageArgs(game: game),
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