import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pv239_qwiz/auth/service/auth_cubit.dart';
import 'package:pv239_qwiz/common/util/shared_ui_constants.dart';
import 'package:pv239_qwiz/common/widget/user_avatar.dart';
import 'package:pv239_qwiz/game/model/player.dart';

const _paddingHorizontal = 16.0;

class LeaderboardTile extends StatelessWidget {
  final int rank;
  final Player player;

  const LeaderboardTile({
    super.key,
    required this.rank,
    required this.player,
  });

  @override
  Widget build(BuildContext context) {
    final displayName = player.displayName;
    final theme = Theme.of(context);

    const rankColors = [goldColor, silverColor, bronzeColor];
    final trophy = rank <= rankColors.length ? Icon(Icons.emoji_events, color: rankColors[rank - 1]) : null;

    final userId = context.read<AuthCubit>().userId;
    final isCurrentUser = player.id == userId;

    return ListTile(
      contentPadding: EdgeInsets.only(
        left: _paddingHorizontal,
        right: _paddingHorizontal,
        top: smallGap,
        bottom: smallGap,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(smallGap)),
      tileColor: isCurrentUser ? theme.colorScheme.secondary : null,
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('$rank.', style: theme.textTheme.titleLarge),
          if (trophy != null) trophy,
          SizedBox(width: smallGap),
          UserAvatar(size: 30, photoUrl: player.photoURL),
        ],
      ),
      title: displayName != null ? Text(displayName, style: theme.textTheme.titleMedium) : null,
      trailing: Text(player.points.toString(), style: theme.textTheme.titleMedium),
    );
  }
}
