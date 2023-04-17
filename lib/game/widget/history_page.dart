import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pv239_qwiz/auth/service/auth_cubit.dart';
import 'package:pv239_qwiz/common/widget/page_template.dart';
import 'package:pv239_qwiz/game/model/game_record.dart';

import 'game_result_page.dart';

class GameHistoryPage extends StatelessWidget {
  static const routeName = '/history';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final userId = context.read<AuthCubit>().userId;

    return PageTemplate(
      title: 'Game History',
      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('game_records')
            .where('players', arrayContains: userId)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final gameRecords = snapshot.data!.docs.map((doc) => GameRecord.fromJson(doc.data())).toList();
          final thisPlayerGameRecords = gameRecords.where((record) => record.player1.id == userId || record.player2.id == userId).toList();

          if (gameRecords.isEmpty) {
            return Center(
                child: Text('No games played on this account yet'));
          }

          return ListView.builder(
            itemCount: thisPlayerGameRecords.length,
            itemBuilder: (context, index) {
              final gameRecord = thisPlayerGameRecords[index];
              final opponent = gameRecord.player1.id == userId ? gameRecord.player2 : gameRecord.player1;

              return ListTile(
                title: Text('Game with ${opponent.name}', style: theme.textTheme.titleLarge),
                subtitle: Text(gameRecord.date.toString(), style: theme.textTheme.bodyMedium),
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
