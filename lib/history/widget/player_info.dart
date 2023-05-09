import 'package:flutter/material.dart';

class PlayerInfo extends StatelessWidget {
  final player;
  final defaultValue;
  PlayerInfo({super.key, required this.player, this.defaultValue});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: player.photoURL != null ? NetworkImage(player.photoURL!) : null,
          child: player.photoURL == null ? Icon(Icons.person, size: 40, color: Colors.white) : null,
        ),
        Text(player.displayName != null ? player.displayName! : defaultValue),
        Text('${player.points} points'),
      ],
    );
  }
}
