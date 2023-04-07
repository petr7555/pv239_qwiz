import 'package:json_annotation/json_annotation.dart';
import 'package:pv239_qwiz/game/model/player.dart';

part 'game.g.dart';

@JsonSerializable()
class Game {
  final String id;
  final int pointsToWin;
  final List<Player> players = const [];

  const Game({
    required this.id,
    required this.pointsToWin,
  });

  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);

  Map<String, dynamic> toJson() => _$GameToJson(this);
}
