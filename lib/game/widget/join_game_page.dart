import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:pv239_qwiz/auth/service/auth_cubit.dart';
import 'package:pv239_qwiz/common/util/shared_ui_constants.dart';
import 'package:pv239_qwiz/common/widget/button.dart';
import 'package:pv239_qwiz/common/widget/page_template.dart';
import 'package:pv239_qwiz/game/service/form_bloc/join_game_form_bloc.dart';
import 'package:pv239_qwiz/game/service/game_cubit.dart';

class JoinGamePage extends StatelessWidget {
  const JoinGamePage({super.key});

  static const routeName = '/joinGame';

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Join game',
      child: BlocProvider(
        create: (context) => JoinGameFormBloc(),
        child: Builder(
          builder: (context) {
            final formBloc = context.read<JoinGameFormBloc>();
            return FormBlocListener<JoinGameFormBloc, String, String>(
              onSuccess: (context, state) {
                context.loaderOverlay.show();
                final userId = context.read<AuthCubit>().userId;
                final userName = context.read<AuthCubit>().state?.displayName;
                final photoURL = context.read<AuthCubit>().state?.photoURL;
                context
                    .read<GameCubit>()
                    .joinGame(formBloc.gameCodeField.value, userId, userName, photoURL)
                    .whenComplete(context.loaderOverlay.hide);
              },
              child: Column(
                children: [
                  SingleChildScrollView(
                    child: TextFieldBlocBuilder(
                      textFieldBloc: formBloc.gameCodeField,
                      suffixButton: SuffixButton.asyncValidating,
                      decoration: InputDecoration(
                        labelText: 'Game code',
                        hintText: 'Enter game code',
                      ),
                      autofocus: true,
                      onSubmitted: (_) => formBloc.submit(),
                    ),
                  ),
                  SizedBox(height: standardGap),
                  Button(label: 'Join game', onPressed: formBloc.submit)
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
