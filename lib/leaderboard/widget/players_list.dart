import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pv239_qwiz/auth/service/auth_cubit.dart';
import 'package:pv239_qwiz/game/model/player.dart';
import 'package:pv239_qwiz/leaderboard/widget/leaderboard_tile.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

const _scrollDurationMilliseconds = 300;

class PlayersList extends StatefulWidget {
  final List<Player> players;

  const PlayersList({
    super.key,
    required this.players,
  });

  @override
  State<PlayersList> createState() => _PlayersListState();
}

class _PlayersListState extends State<PlayersList> {
  final ItemScrollController itemScrollController = ItemScrollController();
  final ScrollOffsetController scrollOffsetController = ScrollOffsetController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userId = context.read<AuthCubit>().userId;
      final index = widget.players.indexWhere((player) => player.id == userId);
      if (index == -1) {
        return;
      }
      itemScrollController.scrollTo(
        index: index,
        duration: const Duration(milliseconds: _scrollDurationMilliseconds),
        curve: Curves.easeInOutCubic,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScrollablePositionedList.separated(
      itemCount: widget.players.length,
      itemScrollController: itemScrollController,
      itemBuilder: (context, index) {
        final player = widget.players[index];
        final rank = index + 1;

        return LeaderboardTile(rank: rank, player: player);
      },
      separatorBuilder: (BuildContext context, int index) => Divider(thickness: 1),
    );
  }
}
