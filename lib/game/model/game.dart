import 'package:json_annotation/json_annotation.dart';
import 'package:pv239_qwiz/game/model/game_status.dart';
import 'package:pv239_qwiz/game/model/player.dart';

part 'game.g.dart';

@JsonSerializable(explicitToJson: true)
class Game {
  final String id;
  final int pointsToWin;
  final List<Player> players;
  final GameStatus gameStatus;
  final String? winnerId;

  const Game({
    required this.id,
    required this.pointsToWin,
    required this.players,
    this.gameStatus = GameStatus.waitingForPlayers,
    this.winnerId,
  });

  Game copyWith({
    String? id,
    int? pointsToWin,
    List<Player>? players,
    GameStatus? gameStatus,
    String? winnerId,
  }) {
    return Game(
      id: id ?? this.id,
      pointsToWin: pointsToWin ?? this.pointsToWin,
      players: players ?? this.players,
      gameStatus: gameStatus ?? this.gameStatus,
      winnerId: winnerId ?? this.winnerId,
    );
  }

  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);

  Map<String, dynamic> toJson() => _$GameToJson(this);
}
