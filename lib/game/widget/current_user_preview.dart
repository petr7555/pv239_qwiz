import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pv239_qwiz/auth/service/auth_cubit.dart';
import 'package:pv239_qwiz/common/util/shared_ui_constants.dart';
import 'package:pv239_qwiz/common/widget/user_avatar.dart';

class CurrentUserPreview extends StatelessWidget {
  const CurrentUserPreview({super.key});

  @override
  Widget build(BuildContext context) {
    final photoUrl = context.read<AuthCubit>().state?.photoURL;
    final displayName = context.read<AuthCubit>().state?.displayName;
    final theme = Theme.of(context);

    return Column(
      children: [
        UserAvatar(size: 50, photoUrl: photoUrl),
        SizedBox(height: standardGap),
        if (displayName != null) Text(displayName, style: theme.textTheme.titleLarge),
      ],
    );
  }
}
