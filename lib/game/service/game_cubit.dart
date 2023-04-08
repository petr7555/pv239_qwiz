import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:pv239_qwiz/common/service/ioc_container.dart';
import 'package:pv239_qwiz/game/model/game.dart';
import 'package:pv239_qwiz/game/model/player.dart';
import 'package:pv239_qwiz/game/service/game_service.dart';
import 'package:random_string_generator/random_string_generator.dart';

class GameCubit extends Cubit<Game?> {
  GameCubit() : super(null);

  Future<void> createGame(int pointsToWin, String userId) async {
    final game = Game(
      id: get<RandomStringGenerator>().generate(),
      pointsToWin: pointsToWin,
      players: [Player(id: userId)],
    );
    await get<GameService>().createGame(game);
    emit(game);
    get<GameService>().gameStream(game.id).listen((game) => emit(game));
  }

  Future<void> joinGame(String gameCode, String userId) async {
    await get<GameService>().joinGame(gameCode, userId);
  }
}
