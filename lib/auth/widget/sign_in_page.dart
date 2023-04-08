import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:pv239_qwiz/auth/service/auth_cubit.dart';
import 'package:pv239_qwiz/auth/widget/logo.dart';
import 'package:pv239_qwiz/common/util/shared_ui_constants.dart';
import 'package:pv239_qwiz/common/widget/page_template.dart';
import 'package:pv239_qwiz/game/service/game_cubit.dart';
import 'package:pv239_qwiz/game/widget/menu_page.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  static const routeName = '/signIn';

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Sign in',
      child: Center(
        child: Column(
          children: [
            Logo(),
            SizedBox(height: largeGap),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: SignInButton(
                Buttons.Google,
                onPressed: () {
                  context.loaderOverlay.show();
                  context
                      .read<AuthCubit>()
                      .signInWithGoogle()
                      .then((userCredential) => context.read<GameCubit>().startListening(userCredential.user!.uid))
                      .catchError((_) {})
                      .then((_) => context.go(MenuPage.routeName))
                      .whenComplete(context.loaderOverlay.hide);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
