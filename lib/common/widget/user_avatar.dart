import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final double size;
  final String? photoUrl;

  const UserAvatar({
    super.key,
    required this.size,
    required this.photoUrl,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: size,
      foregroundImage: photoUrl != null ? NetworkImage(photoUrl!) : null,
      backgroundColor: Theme.of(context).colorScheme.secondary,
      child: photoUrl == null ? Icon(Icons.person, size: size, color: Colors.white) : null,
    );
  }
}
