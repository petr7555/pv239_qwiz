import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:pv239_qwiz/common/service/ioc_container.dart';
import 'package:pv239_qwiz/game/model/game.dart';
import 'package:pv239_qwiz/game/model/player.dart';
import 'package:pv239_qwiz/game/service/game_service.dart';
import 'package:random_string_generator/random_string_generator.dart';

class GameCubit extends Cubit<Game?> {
  GameCubit() : super(null) {
    get<GameService>().currentGameStream().listen((game) => emit(game));
  }

  String? get gameId => state?.id;

  Future<void> createGame(int pointsToWin, String userId) {
    final game = Game(
      id: get<RandomStringGenerator>().generate(),
      pointsToWin: pointsToWin,
      players: [Player(id: userId)],
    );
    return get<GameService>().createGame(game);
    // TODO remove?
    // emit(game);
    // TODO remove?
    // get<GameService>().gameStream(game.id).listen((game) => emit(game));
  }

  Future<void> joinGame(String gameCode, String userId) {
    return get<GameService>().joinGame(gameCode, userId);
    // TODO remove?
    // emit(await get<GameService>().getGame(gameCode));
  }

  Future<void> leaveGame(String gameCode, String userId) {
    return get<GameService>().leaveGame(gameCode, userId);
    // TODO remove?
    // emit(null);
  }
}
