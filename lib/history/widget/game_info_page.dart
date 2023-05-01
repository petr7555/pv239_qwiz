import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pv239_qwiz/auth/service/auth_cubit.dart';
import 'package:pv239_qwiz/common/util/shared_ui_constants.dart';
import 'package:pv239_qwiz/common/widget/page_template.dart';

class GameInfoPage extends StatelessWidget {
  const GameInfoPage({super.key});

  static const routeName = '/gameInfo';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final userId = context.read<AuthCubit>().userId;
    final gamesRef = FirebaseFirestore.instance.collection('games');

    return PageTemplate(
      title: 'Game info',
      child: StreamBuilder<QuerySnapshot>(
        stream: gamesRef.where('players', arrayContains: userId).orderBy('createdAt', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final docs = snapshot.data?.docs ?? [];

          if (docs.isEmpty) {
            return Center(
              child: Text('No game history found.'),
            );
          }

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final game = docs[index];
              final players = List<String>.from(game['players']);
              final opponent = players.firstWhere((id) => id != userId);
              final gameResult = game['result'];
              final didWin = gameResult['winnerId'] == userId;
              const opponentsName = 'Opponent'; // Replace with actual opponent's name

              return ListTile(
                title: Text('Game ${index + 1}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      didWin ? 'You won!' : 'You lost.',
                      style: theme.textTheme.headlineLarge,
                    ),
                    SizedBox(height: smallGap),
                    Text('$opponentsName: ${gameResult[opponent]} points'),
                    SizedBox(height: smallGap),
                    Text('You: ${gameResult[userId]} points'),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(Icons.arrow_forward),
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/history/${game.id}',
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
