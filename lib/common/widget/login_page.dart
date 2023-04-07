import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pv239_qwiz/common/widget/page_template.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static const routeName = '/login';

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Login',
      child: Center(
        child: ElevatedButton(
          child: Text('Login'),
          onPressed: () => context.push('/'),
        ),
      ),
    );
  }
}
