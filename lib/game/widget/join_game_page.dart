import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pv239_qwiz/auth/service/auth_cubit.dart';
import 'package:pv239_qwiz/common/util/shared_ui_constants.dart';
import 'package:pv239_qwiz/common/widget/page_template.dart';
import 'package:pv239_qwiz/game/bloc/join_game_form_bloc.dart';
import 'package:pv239_qwiz/game/service/game_cubit.dart';
import 'package:pv239_qwiz/game/widget/button.dart';
import 'package:pv239_qwiz/game/widget/get_ready_page.dart';

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
                final userId = context.read<AuthCubit>().userId;
                context.read<GameCubit>().joinGame(formBloc.gameCodeField.value, userId).then((_) {
                  context.push(GetReadyPage.routeName);
                });
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
