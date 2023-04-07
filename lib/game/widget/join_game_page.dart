import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pv239_qwiz/common/service/ioc_container.dart';
import 'package:pv239_qwiz/common/util/shared_logic_constants.dart';
import 'package:pv239_qwiz/common/util/shared_ui_constants.dart';
import 'package:pv239_qwiz/common/widget/page_template.dart';
import 'package:pv239_qwiz/game/service/game_service.dart';
import 'package:pv239_qwiz/game/widget/button.dart';
import 'package:pv239_qwiz/game/widget/get_ready_page.dart';

class JoinGamePage extends StatefulWidget {
  const JoinGamePage({super.key});

  static const routeName = '/joinGame';

  @override
  State<JoinGamePage> createState() => _JoinGamePageState();
}

class _JoinGamePageState extends State<JoinGamePage> {
  final _gameCodeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Join game',
      child: Column(
        children: [
          Form(
            key: _formKey,
            child: TextFormField(
              decoration: InputDecoration(
                hintText: 'Enter game code',
              ),
              controller: _gameCodeController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter game code';
                }
                if (value.length != gameCodeLength) {
                  return 'Game code must be $gameCodeLength characters long';
                }
                // if (get<GameService>().getGame(value) == null) {
                //   return 'Game with code $value does not exist';
                // }
                return null;
              },
            ),
          ),
          SizedBox(height: standardGap),
          Button(label: 'Join game', onPressed: () => _joinGame(context: context))
        ],
      ),
    );
  }

  Future<void> _joinGame({
    required BuildContext context,
  }) async {
    if (_formKey.currentState?.validate() == false) {
      return;
    }
    final game = await get<GameService>().getGame(_gameCodeController.text);
    if (game == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Game with code ${_gameCodeController.text} does not exist')));
      return;
    }

    context.push(GetReadyPage.routeName);
  }
}
