import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pv239_qwiz/game/model/interaction.dart';
import 'package:pv239_qwiz/game/model/player.dart';
import 'package:pv239_qwiz/game/model/question.dart';

part 'game.freezed.dart';
part 'game.g.dart';

@freezed
class Game with _$Game {
  const Game._();

  const factory Game({
    required String id,
    required int pointsToWin,
    required Map<String, Player> players,
    required DateTime createdAt,
    String? winnerId,
    @Default([]) List<Question> questions,
  }) = _Game;

  Question get currentQuestion => questions.last;

  Interaction yourCurrentInteraction(String userId) {
    return currentQuestion.interactions[userId]!;
  }

  Interaction opponentsCurrentInteraction(String userId) {
    return currentQuestion.interactions[opponent(userId).id]!;
  }

  Player you(String userId) {
    return players[userId]!;
  }

  Player opponent(String userId) {
    return players.values.firstWhere((element) => element.id != userId);
  }

  bool get answerTimersEnded => players.values.every((player) => player.answerTimerEnded);

  bool get resultTimersEnded => players.values.every((player) => player.resultTimerEnded);

  bool get allPlayersAnswered =>
      currentQuestion.interactions.values.every((interaction) => interaction.answerIdx != null);

  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);
}
