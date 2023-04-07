import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:pv239_qwiz/common/service/ioc_container.dart';
import 'package:pv239_qwiz/common/util/shared_logic_constants.dart';
import 'package:pv239_qwiz/game/model/game.dart';
import 'package:pv239_qwiz/game/model/player.dart';
import 'package:pv239_qwiz/game/service/game_service.dart';
import 'package:random_string_generator/random_string_generator.dart';

class CreateGameFormBloc extends FormBloc<String, String> {
  final pointsToWinField = TextFieldBloc(
    initialValue: pointsToWinDefault.toString(),
    validators: [
      FieldBlocValidators.required,
      _checkPointsToWin,
    ],
  );

  CreateGameFormBloc() {
    addFieldBlocs(fieldBlocs: [pointsToWinField]);
  }

  static String? _checkPointsToWin(String value) {
    final val = int.tryParse(value);
    if (val == null) {
      return 'Please enter a valid number';
    }
    if (val < pointsToWinMin) {
      return 'Number of points to win must be at least $pointsToWinMin';
    }
    if (val > pointsToWinMax) {
      return 'Number of points to win must be at most $pointsToWinMax';
    }
    return null;
  }

  @override
  void onSubmitting() async {
    try {
      final pointsToWin = int.parse(pointsToWinField.value);
      final gameCode = get<RandomStringGenerator>().generate();
      final game = Game(
        id: gameCode,
        pointsToWin: pointsToWin,
        players: [Player(id: 'player1')],
      );
      await get<GameService>().createGame(game);
      emitSuccess();
    } catch (e) {
      emitFailure();
    }
  }
}
