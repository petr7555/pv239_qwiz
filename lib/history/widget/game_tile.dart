import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:pv239_qwiz/common/util/shared_ui_constants.dart';
import 'package:pv239_qwiz/common/widget/user_avatar.dart';
import 'package:pv239_qwiz/game/model/player.dart';
import 'package:pv239_qwiz/history/widget/game_info_page.dart';

const _paddingHorizontal = 16.0;

class GameTile extends StatelessWidget {
  final String gameId;
  final DateTime createdAt;
  final Player opponent;

  const GameTile({
    super.key,
    required this.gameId,
    required this.createdAt,
    required this.opponent,
  });

  @override
  Widget build(BuildContext context) {
    final opponentDisplayName = opponent.displayName;
    final theme = Theme.of(context);
    final date = DateFormat('d. M. yyyy').format(createdAt);

    return ListTile(
      contentPadding: EdgeInsets.only(
        left: _paddingHorizontal,
        right: _paddingHorizontal,
        top: smallGap,
        bottom: smallGap,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(smallGap)),
      title: Padding(
        padding: EdgeInsets.only(bottom: smallGap),
        child: Row(
          children: [
            UserAvatar(size: 20, photoUrl: opponent.photoURL),
            SizedBox(width: smallGap),
            if (opponentDisplayName != null)
              Flexible(child: Text(opponentDisplayName, style: theme.textTheme.titleLarge)),
          ],
        ),
      ),
      subtitle: Text(date, style: theme.textTheme.titleMedium),
      onTap: () => context.push('${GameInfoPage.routeName}/$gameId'),
    );
  }
}
