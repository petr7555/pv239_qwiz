import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pv239_qwiz/auth/service/auth_cubit.dart';
import 'package:pv239_qwiz/game/service/game_cubit.dart';

class QuitGameButton extends StatelessWidget {
  const QuitGameButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.close),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Are you sure you want to quit?'),
            actions: [
              TextButton(
                style: TextButton.styleFrom(foregroundColor: Colors.red),
                child: Text('No'),
                onPressed: () {
                  context.pop();
                },
              ),
              TextButton(
                style: TextButton.styleFrom(foregroundColor: Colors.green),
                onPressed: () {
                  final userId = context.read<AuthCubit>().userId;
                  context.read<GameCubit>().abortGame(userId);
                },
                child: Text('Yes'),
              ),
            ],
          ),
        );
      },
    );
  }
}
