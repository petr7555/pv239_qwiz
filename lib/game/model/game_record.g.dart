// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameRecord _$GameRecordFromJson(Map<String, dynamic> json) => GameRecord(
      date: DateTime.parse(json['date'] as String),
      winnerId: json['winnerId'] as String,
      player1: PlayerRecord.fromJson(json['player1'] as Map<String, dynamic>),
      player2: PlayerRecord.fromJson(json['player2'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GameRecordToJson(GameRecord instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'winnerId': instance.winnerId,
      'player1': instance.player1.toJson(),
      'player2': instance.player2.toJson(),
    };
