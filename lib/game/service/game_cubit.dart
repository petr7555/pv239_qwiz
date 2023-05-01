import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pv239_qwiz/common/service/ioc_container.dart';
import 'package:pv239_qwiz/game/model/game.dart';
import 'package:pv239_qwiz/game/model/player.dart';
import 'package:pv239_qwiz/game/service/game_service.dart';
import 'package:pv239_qwiz/game/widget/lobby_page.dart';
import 'package:random_string_generator/random_string_generator.dart';

class GameCubit extends Cubit<Game?> {
  final _gameService = get<GameService>();

  GameCubit() : super(null);

  void startListening(String userId) {
    _gameService.currentGameStream(userId).listen((game) => emit(game));
  }

  String? get gameId => state?.id;

  Future<void> createGame(int pointsToWin, String userId, String? userName, String? photoURL) async {
    final game = Game(
      id: get<RandomStringGenerator>().generate(),
      pointsToWin: pointsToWin,
      players: {
        userId: Player(id: userId, displayName: userName, photoURL: photoURL, route: LobbyPage.routeName),
      },
      createdAt: DateTime.now(),
    );
    return _gameService.createGame(game);
  }

  Future<void> joinGame(String gameId, String userId, String? userName, String? photoURL) {
    return _gameService.joinGame(gameId, userId, userName, photoURL);
  }

  Future<void> deleteGame() {
    return _gameService.deleteGame(gameId!);
  }

  Future<void> abortGame(String userId) {
    return _gameService.abortGame(gameId!, userId);
  }

  Future<void> startGame() {
    return _gameService.startGame(gameId!);
  }

  Future<void> resetGame(String userId) {
    return _gameService.resetGame(gameId!, userId);
  }

  Future<void> answerCurrentQuestion(String userId, int answerIdx, double secondsToAnswer) {
    return _gameService.answerCurrentQuestion(gameId!, userId, answerIdx, secondsToAnswer);
  }

  Future<void> setAnswerTimerEnded(String userId, {required bool ended}) {
    return _gameService.setAnswerTimerEnded(gameId!, userId, ended);
  }

  Future<void> setResultTimerEnded(String userId, {required bool ended}) {
    return _gameService.setResultTimerEnded(gameId!, userId, ended);
  }
}
