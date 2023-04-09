import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pv239_qwiz/common/util/shared_logic_constants.dart';
import 'package:pv239_qwiz/common/util/shared_ui_constants.dart';
import 'package:pv239_qwiz/common/widget/page_template.dart';
import 'package:pv239_qwiz/game/service/game_cubit.dart';
import 'package:timer_count_down/timer_count_down.dart';

class GetReadyPage extends StatelessWidget {
  const GetReadyPage({super.key});

  static const routeName = '/getReady';

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Get ready',
      child: Center(
        child: Column(
          children: [
            Text('The game will start in', style: Theme.of(context).textTheme.titleLarge),
            SizedBox(height: standardGap),
            Countdown(
              seconds: secondsToStartGame,
              build: (BuildContext context, double time) {
                int seconds = time.toInt();
                final text = seconds == 0 ? 'Go!' : seconds.toString();
                return Text(text, style: Theme.of(context).textTheme.titleLarge);
              },
              interval: Duration(seconds: 1),
              onFinished: () => context.read<GameCubit>().startGame(),
            ),
          ],
        ),
      ),
    );
  }
}
