import 'dart:async';

import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:pv239_qwiz/common/service/ioc_container.dart';
import 'package:pv239_qwiz/common/util/shared_logic_constants.dart';
import 'package:pv239_qwiz/game/service/game_service.dart';

class JoinGameFormBloc extends FormBloc<String, String> {
  final gameCodeField = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
      _checkGameCodeLength,
    ],
    asyncValidatorDebounceTime: Duration(milliseconds: 500),
  );

  JoinGameFormBloc() {
    addFieldBlocs(fieldBlocs: [gameCodeField]);

    gameCodeField.addAsyncValidators(
      [_checkGameExistsAndNotFull],
    );
  }

  static String? _checkGameCodeLength(String gameCode) {
    if (gameCode.length != gameCodeLength) {
      return 'Game code must be $gameCodeLength characters long';
    }
    return null;
  }

  Future<String?> _checkGameExistsAndNotFull(String gameCode) async {
    final game = await get<GameService>().getGame(gameCode);
    if (game == null) {
      return 'Game with code $gameCode does not exist';
    }
    if (game.players.length >= maxPlayers) {
      return 'Game with code $gameCode is full';
    }
    return null;
  }

  @override
  void onSubmitting() async {
    try {
      await get<GameService>().joinGame(gameCodeField.value);
      emitSuccess();
    } catch (e) {
      emitFailure();
    }
  }
}
