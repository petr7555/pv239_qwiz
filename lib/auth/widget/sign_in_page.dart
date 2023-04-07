import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:go_router/go_router.dart';
import 'package:pv239_qwiz/auth/service/auth_cubit.dart';
import 'package:pv239_qwiz/common/widget/page_template.dart';
import 'package:pv239_qwiz/game/widget/menu_page.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  static const routeName = '/signin';

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Sign in',
      child: Center(
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: SignInButton(Buttons.Google,
              onPressed: () =>
                  context.read<AuthCubit>().signInWithGoogle().then((_) => context.go(MenuPage.routeName))),
        ),
      ),
    );
  }
}
