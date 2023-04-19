import 'package:json_annotation/json_annotation.dart';
part 'player_score_record.g.dart';

@JsonSerializable()
class PlayerScoreRecord {
  final String playerId;
  final String playerName;
  final int totalScore;

  const PlayerScoreRecord({
    required this.playerId,
    required this.playerName,
    required this.totalScore,
  });

  factory PlayerScoreRecord.fromJson(Map<String, dynamic> json) => _$PlayerScoreRecordFromJson(json);

  Map<String, dynamic> toJson() => _$PlayerScoreRecordToJson(this);
}
