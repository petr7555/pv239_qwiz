
import 'package:json_annotation/json_annotation.dart';
import 'package:pv239_qwiz/game/model/player_record.dart';

part 'game_record.g.dart';

@JsonSerializable(explicitToJson: true)
class GameRecord {
  final DateTime date;
  final String winnerId;
  final PlayerRecord player1;
  final PlayerRecord player2;

  const GameRecord({
    required this.date,
    required this.winnerId,
    required this.player1,
    required this.player2,
  });

  factory GameRecord.fromJson(Map<String, dynamic> json) => _$GameRecordFromJson(json);

  Map<String, dynamic> toJson() => _$GameRecordToJson(this);
}