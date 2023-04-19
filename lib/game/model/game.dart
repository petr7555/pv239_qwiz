import 'package:json_annotation/json_annotation.dart';
import 'package:pv239_qwiz/game/model/player.dart';
import 'package:pv239_qwiz/game/model/question.dart';


part 'game.g.dart';

@JsonSerializable(explicitToJson: true)
class Game {
  final String id;
  final int pointsToWin;
  final Map<String, Player> players;
  final DateTime createdAt;
  final String? winnerId;
  final List<Question> questions;
  DateTime? date;

  @JsonKey(includeFromJson: false, includeToJson: false)
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

  Game({
    required this.id,
    required this.pointsToWin,
    required this.players,
    required this.createdAt,
    this.winnerId,
    this.questions = const [],
    this.date,
  });

  Game copyWith({
    String? id,
    int? pointsToWin,
    Map<String, Player>? players,
    DateTime? createdAt,
    String? winnerId,
    List<Question>? questions,
    DateTime? date,
  }) {
    return Game(
      id: id ?? this.id,
      pointsToWin: pointsToWin ?? this.pointsToWin,
      players: players ?? this.players,
      createdAt: createdAt ?? this.createdAt,
      winnerId: winnerId ?? this.winnerId,
      questions: questions ?? this.questions,
      date: date ?? this.date,
    );
  }

  void setDate(DateTime date) {
    this.date = date;
  }

  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);

  Map<String, dynamic> toJson() => _$GameToJson(this);
}
