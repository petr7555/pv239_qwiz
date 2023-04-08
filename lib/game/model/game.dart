import 'package:json_annotation/json_annotation.dart';
import 'package:pv239_qwiz/game/model/player.dart';

part 'game.g.dart';

@JsonSerializable(explicitToJson: true)
class Game {
  final String id;
  final int pointsToWin;
  final List<Player> players;
  // TODO add game state

  const Game({
    required this.id,
    required this.pointsToWin,
    required this.players,
  });

  Game copyWith({
    String? id,
    int? pointsToWin,
    List<Player>? players,
  }) {
    return Game(
      id: id ?? this.id,
      pointsToWin: pointsToWin ?? this.pointsToWin,
      players: players ?? this.players,
    );
  }

  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);

  Map<String, dynamic> toJson() => _$GameToJson(this);
}
