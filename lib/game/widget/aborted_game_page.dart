import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:pv239_qwiz/auth/service/auth_cubit.dart';
import 'package:pv239_qwiz/common/util/shared_ui_constants.dart';
import 'package:pv239_qwiz/common/widget/button.dart';
import 'package:pv239_qwiz/common/widget/page_template.dart';
import 'package:pv239_qwiz/game/service/game_cubit.dart';

class AbortedGamePage extends StatelessWidget {
  const AbortedGamePage({super.key});

  static const routeName = '/abortedGame';

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Aborted game',
      child: Center(
        child: Column(
          children: [
            Text('Game was aborted because the second player left.', style: Theme.of(context).textTheme.titleLarge),
            SizedBox(height: standardGap),
            Button(
              label: 'Back to menu',
              onPressed: () {
                final userId = context.read<AuthCubit>().userId;
                context.read<GameCubit>().resetGame(userId);
              },
            )
          ],
        ),
      ),
    );
  }
}
