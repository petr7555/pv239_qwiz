import 'package:json_annotation/json_annotation.dart';
import 'package:pv239_qwiz/game/model/player.dart';
import 'package:pv239_qwiz/game/model/question.dart';

part 'game.g.dart';

@JsonSerializable(explicitToJson: true)
class Game {
  final String id;
  final int pointsToWin;
  final Player firstPlayer;
  final Player? secondPlayer;
  final String? winnerId;
  final List<Question> questions;

  Question get currentQuestion => questions.last;

  Player? thisPlayer(String userId) {
    if (firstPlayer.id == userId) {
      return firstPlayer;
    }
    return secondPlayer;
  }

  Player? otherPlayer(String userId) {
    if (firstPlayer.id == userId) {
      return secondPlayer;
    }
    return firstPlayer;
  }

  const Game({
    required this.id,
    required this.pointsToWin,
    required this.firstPlayer,
    this.secondPlayer,
    this.winnerId,
    this.questions = const [],
  });

  Game copyWith({
    String? id,
    int? pointsToWin,
    Player? firstPlayer,
    Player? secondPlayer,
    String? winnerId,
    List<Question>? questions,
  }) {
    return Game(
      id: id ?? this.id,
      pointsToWin: pointsToWin ?? this.pointsToWin,
      firstPlayer: firstPlayer ?? this.firstPlayer,
      secondPlayer: secondPlayer ?? this.secondPlayer,
      winnerId: winnerId ?? this.winnerId,
      questions: questions ?? this.questions,
    );
  }

  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);

  Map<String, dynamic> toJson() => _$GameToJson(this);
}
