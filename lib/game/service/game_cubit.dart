import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:pv239_qwiz/common/service/ioc_container.dart';
import 'package:pv239_qwiz/game/model/game.dart';
import 'package:pv239_qwiz/game/model/player.dart';
import 'package:pv239_qwiz/game/service/game_service.dart';
import 'package:random_string_generator/random_string_generator.dart';

class GameCubit extends Cubit<Game?> {
  final _gameService = get<GameService>();

  GameCubit() : super(null);

  void startListening(String userId) {
    _gameService.currentGameStream(userId).listen((game) {
      print('GameCubit: game updated: $game');
      emit(game);
    });
  }

  String? get gameId => state?.id;

  Future<void> createGame(int pointsToWin, String userId) {
    final game = Game(
      id: get<RandomStringGenerator>().generate(),
      pointsToWin: pointsToWin,
      players: [Player(id: userId)],
    );
    return _gameService.createGame(game);
  }

  Future<void> joinGame(String gameCode, String userId) {
    return _gameService.joinGame(gameCode, userId);
  }

  Future<void> leaveGame(String gameCode, String userId) {
    return _gameService.leaveGame(gameCode, userId);
  }
}
