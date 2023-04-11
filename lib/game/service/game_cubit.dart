import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:pv239_qwiz/common/service/ioc_container.dart';
import 'package:pv239_qwiz/game/model/game.dart';
import 'package:pv239_qwiz/game/model/player.dart';
import 'package:pv239_qwiz/game/service/game_service.dart';
import 'package:pv239_qwiz/game/widget/lobby_page.dart';
import 'package:random_string_generator/random_string_generator.dart';

const mockGame = false;
const mockedGame = Game(
  id: 'game123',
  pointsToWin: 100,
  players: {
    'user123': Player(id: 'user123', points: 100),
    '2': Player(id: '2', points: 65),
  },
  winnerId: 'user123',
);

class GameCubit extends Cubit<Game?> {
  final _gameService = get<GameService>();

  GameCubit() : super(mockGame ? mockedGame : null);

  void startListening(String userId) {
    _gameService.currentGameStream(userId).listen((game) => emit(game));
  }

  String? get gameId => state?.id;

  Future<void> createGame(int pointsToWin, String userId) async {
    final game = Game(
      id: get<RandomStringGenerator>().generate(),
      pointsToWin: pointsToWin,
      players: {
        userId: Player(id: userId, route: LobbyPage.routeName),
      },
    );
    return _gameService.createGame(game);
  }

  Future<void> joinGame(String gameId, String userId) {
    return _gameService.joinGame(gameId, userId);
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

  Future<void> answerQuestion(String userId, String questionId, int answerIdx) {
    return _gameService.answerQuestion(gameId!, userId, questionId, answerIdx);
  }

  Future<void> setAnswerTimerEnded(String userId) {
    return _gameService.setAnswerTimerEnded(gameId!, userId);
  }

  Future<void> setResultTimerEnded(String userId) {
    return _gameService.setResultTimerEnded(gameId!, userId);
  }
}
