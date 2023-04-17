
import 'package:json_annotation/json_annotation.dart';

part 'player_record.g.dart';

@JsonSerializable(explicitToJson: true)
class PlayerRecord {
  final String id;
  final String name;
  final int score;

  const PlayerRecord({
    required this.id,
    required this.name,
    required this.score,
  });

  factory PlayerRecord.fromJson(Map<String, dynamic> json) => _$PlayerRecordFromJson(json);

  Map<String, dynamic> toJson() => _$PlayerRecordToJson(this);
}