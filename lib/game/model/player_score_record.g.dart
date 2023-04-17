// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_score_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayerScoreRecord _$PlayerScoreRecordFromJson(Map<String, dynamic> json) =>
    PlayerScoreRecord(
      playerId: json['playerId'] as String,
      playerName: json['playerName'] as String,
      totalScore: json['totalScore'] as int,
    );

Map<String, dynamic> _$PlayerScoreRecordToJson(PlayerScoreRecord instance) =>
    <String, dynamic>{
      'playerId': instance.playerId,
      'playerName': instance.playerName,
      'totalScore': instance.totalScore,
    };
