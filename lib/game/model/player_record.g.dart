// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayerRecord _$PlayerRecordFromJson(Map<String, dynamic> json) => PlayerRecord(
      id: json['id'] as String,
      name: json['name'] as String,
      score: json['score'] as int,
    );

Map<String, dynamic> _$PlayerRecordToJson(PlayerRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'score': instance.score,
    };
