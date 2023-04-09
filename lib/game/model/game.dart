import 'package:json_annotation/json_annotation.dart';
import 'package:pv239_qwiz/game/model/player.dart';
import 'package:pv239_qwiz/game/model/question.dart';

part 'game.g.dart';

@JsonSerializable(explicitToJson: true)
class Game {
  final String id;
  final int pointsToWin;
  final Map<String, Player> players;
  final String? winnerId;
  final List<Question> questions;
  final int currentQuestionIdx;

  Question get currentQuestion => questions[currentQuestionIdx];

  String opponentId(String userId) => players.values.firstWhere((element) => element.id != userId).id;

  Player thisPlayer(String userId) {
    return players[userId]!;
  }

  Player opponent(String userId) {
    return players[opponentId(userId)]!;
  }

  const Game({
    required this.id,
    required this.pointsToWin,
    required this.players,
    this.winnerId,
    this.questions = const [],
    this.currentQuestionIdx = 0,
  });

  Game copyWith({
    String? id,
    int? pointsToWin,
    Map<String, Player>? players,
    String? winnerId,
    List<Question>? questions,
    int? currentQuestionIdx,
  }) {
    return Game(
      id: id ?? this.id,
      pointsToWin: pointsToWin ?? this.pointsToWin,
      players: players ?? this.players,
      winnerId: winnerId ?? this.winnerId,
      questions: questions ?? this.questions,
      currentQuestionIdx: currentQuestionIdx ?? this.currentQuestionIdx,
    );
  }

  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);

  Map<String, dynamic> toJson() => _$GameToJson(this);
}
