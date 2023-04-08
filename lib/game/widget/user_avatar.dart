import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:pv239_qwiz/auth/service/auth_cubit.dart';
import 'package:pv239_qwiz/common/util/shared_ui_constants.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    final photoUrl = context.read<AuthCubit>().state!.photoURL;
    final displayName = context.read<AuthCubit>().state!.displayName;
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: photoUrl != null ? NetworkImage(photoUrl) : null,
          child: photoUrl == null ? Icon(Icons.person, size: 40) : null,
        ),
        SizedBox(height: standardGap),
        if (displayName != null) Text(displayName, style: Theme.of(context).textTheme.titleLarge),
      ],
    );
  }
}
