import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:pv239_qwiz/common/service/ioc_container.dart';
import 'package:pv239_qwiz/common/util/shared_ui_constants.dart';
import 'package:pv239_qwiz/common/widget/page_template.dart';
import 'package:pv239_qwiz/game/model/game.dart';
import 'package:pv239_qwiz/game/service/game_service.dart';
import 'package:pv239_qwiz/game/widget/button.dart';
import 'package:pv239_qwiz/game/widget/lobby_page.dart';
import 'package:random_string_generator/random_string_generator.dart';

const _pointsToWinMin = 10;
const _pointsToWinMax = 100;
const _pointsToWinDefault = 50;

class CreateGamePage extends StatefulWidget {
  const CreateGamePage({super.key});

  static const routeName = '/createGame';

  @override
  State<CreateGamePage> createState() => _CreateGamePageState();
}

class _CreateGamePageState extends State<CreateGamePage> {
  final _pointsToWinController = TextEditingController(text: '$_pointsToWinDefault');
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Create game',
      child: Column(
        children: [
          Form(
            key: _formKey,
            child: TextFormField(
              decoration: InputDecoration(
                label: Text('Number of points to win (min: $_pointsToWinMin, max: $_pointsToWinMax)'),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              controller: _pointsToWinController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter number of points to win';
                }
                final val = int.tryParse(value);
                if (val == null) {
                  return 'Please enter a valid number';
                }
                if (val < _pointsToWinMin) {
                  return 'Number of points to win must be at least $_pointsToWinMin';
                }
                if (val > _pointsToWinMax) {
                  return 'Number of points to win must be at most $_pointsToWinMax';
                }

                return null;
              },
            ),
          ),
          SizedBox(height: standardGap),
          Button(
            label: 'Start game',
            onPressed: () => _startGame(context: context, pointsToWinStr: _pointsToWinController.text),
          )
        ],
      ),
    );
  }

  void _startGame({required BuildContext context, required String pointsToWinStr}) {
    if (_formKey.currentState?.validate() == false) {
      return;
    }
    final pointsToWin = int.parse(pointsToWinStr);
    final gameCode = get<RandomStringGenerator>().generate();
    final game = Game(
      id: gameCode,
      pointsToWin: pointsToWin,
      // players: [Player(name: 'Player 1', points: 0)],
    );
    get<GameService>().createGame(game);
    context.pushNamed(LobbyPage.routeName, params: {'gameCode': gameCode});
  }
}
