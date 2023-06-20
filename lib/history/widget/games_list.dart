import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pv239_qwiz/auth/service/auth_cubit.dart';
import 'package:pv239_qwiz/game/model/game.dart';
import 'package:pv239_qwiz/history/widget/game_tile.dart';

class GamesList extends StatelessWidget {
  final List<Game> games;

  const GamesList({
    super.key,
    required this.games,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: games.length,
      itemBuilder: (context, index) {
        final game = games[index];
        final userId = context.read<AuthCubit>().userId;
        final opponent = game.opponent(userId);

        return GameTile(
          gameId: game.id,
          createdAt: game.createdAt,
          opponent: opponent,
        );
      },
      separatorBuilder: (BuildContext context, int index) => Divider(thickness: 1),
    );
  }
}
