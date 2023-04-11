import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:pv239_qwiz/auth/service/auth_cubit.dart';
import 'package:pv239_qwiz/common/util/shared_logic_constants.dart';
import 'package:pv239_qwiz/common/util/shared_ui_constants.dart';
import 'package:pv239_qwiz/common/widget/button.dart';
import 'package:pv239_qwiz/common/widget/page_template.dart';
import 'package:pv239_qwiz/game/service/form_bloc/create_game_form_bloc.dart';
import 'package:pv239_qwiz/game/service/game_cubit.dart';

class CreateGamePage extends StatelessWidget {
  const CreateGamePage({super.key});

  static const routeName = '/createGame';

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Create game',
      child: BlocProvider(
        create: (context) => CreateGameFormBloc(),
        child: Builder(
          builder: (context) {
            final formBloc = context.read<CreateGameFormBloc>();
            return FormBlocListener<CreateGameFormBloc, String, String>(
              onSuccess: (context, state) {
                context.loaderOverlay.show();
                final pointsToWin = int.parse(formBloc.pointsToWinField.value);
                final userId = context.read<AuthCubit>().userId;
                context.read<GameCubit>().createGame(pointsToWin, userId).whenComplete(context.loaderOverlay.hide);
              },
              child: Column(
                children: [
                  SingleChildScrollView(
                    child: TextFieldBlocBuilder(
                      textFieldBloc: formBloc.pointsToWinField,
                      decoration: InputDecoration(
                        label: Text('Number of points to win (min: $pointsToWinMin, max: $pointsToWinMax)'),
                      ),
                      autofocus: true,
                      onSubmitted: (_) => formBloc.submit(),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                  ),
                  SizedBox(height: standardGap),
                  Button(label: 'Create game', onPressed: formBloc.submit)
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
