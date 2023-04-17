import 'package:json_annotation/json_annotation.dart';
import 'package:pv239_qwiz/game/model/player.dart';
import 'package:pv239_qwiz/game/model/player_record.dart';
import 'package:pv239_qwiz/game/model/question.dart';

import 'game_record.dart';

part 'game.g.dart';

@JsonSerializable(explicitToJson: true)
class Game {
  final String id;
  final int pointsToWin;
  final Map<String, Player> players;
  final String? winnerId;
  final List<Question> questions;

  Question get currentQuestion => questions.last;
  set currentQuestion(Question question) => questions[questions.length - 1] = question;

  String opponentId(String userId) => players.values.firstWhere((element) => element.id != userId).id;

  Player thisPlayer(String userId) {
    return players[userId]!;
  }

  Player opponent(String userId) {
    return players[opponentId(userId)]!;
  }

  bool get answerTimersEnded => players.values.every((player) => player.answerTimerEnded);
  bool get resultTimersEnded => players.values.every((player) => player.resultTimerEnded);

  const Game({
    required this.id,
    required this.pointsToWin,
    required this.players,
    this.winnerId,
    this.questions = const [],
  });

  Game copyWith({
    String? id,
    int? pointsToWin,
    Map<String, Player>? players,
    String? winnerId,
    List<Question>? questions,
  }) {
    return Game(
      id: id ?? this.id,
      pointsToWin: pointsToWin ?? this.pointsToWin,
      players: players ?? this.players,
      winnerId: winnerId ?? this.winnerId,
      questions: questions ?? this.questions,
    );
  }

  GameRecord toRecord() {
    final playerIds = players.keys.toList();
    final player1 = players[playerIds[0]]!;
    final player2 = players[playerIds[1]]!;

    final winnerId = this.winnerId ?? '';

    final player1Record = PlayerRecord(
      id: player1.id,
      name: player1.route,
      score: player1.points,
    );

    final player2Record = PlayerRecord(
      id: player2.id,
      name: player2.route,
      score: player2.points,
    );

    return GameRecord(
      date: DateTime.now(),
      winnerId: winnerId,
      player1: player1Record,
      player2: player2Record,
    );
  }

  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);

  Map<String, dynamic> toJson() => _$GameToJson(this);
}
