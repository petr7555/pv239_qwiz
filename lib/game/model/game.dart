import 'package:json_annotation/json_annotation.dart';
import 'package:pv239_qwiz/game/model/player.dart';

part 'game.g.dart';

@JsonSerializable(explicitToJson: true)
class Game {
  final String id;
  final int pointsToWin;
  final Player firstPlayer;
  final Player? secondPlayer;
  final String? winnerId;

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
  });

  Game copyWith({
    String? id,
    int? pointsToWin,
    Player? firstPlayer,
    Player? secondPlayer,
    String? winnerId,
  }) {
    return Game(
      id: id ?? this.id,
      pointsToWin: pointsToWin ?? this.pointsToWin,
      firstPlayer: firstPlayer ?? this.firstPlayer,
      secondPlayer: secondPlayer ?? this.secondPlayer,
      winnerId: winnerId ?? this.winnerId,
    );
  }

  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);

  Map<String, dynamic> toJson() => _$GameToJson(this);
}
