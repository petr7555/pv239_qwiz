// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Game _$GameFromJson(Map<String, dynamic> json) => Game(
      id: json['id'] as String,
      pointsToWin: json['pointsToWin'] as int,
      players: (json['players'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, Player.fromJson(e as Map<String, dynamic>)),
      ),
      createdAt: DateTime.parse(json['createdAt'] as String),
      winnerId: json['winnerId'] as String?,
      questions: (json['questions'] as List<dynamic>?)
              ?.map((e) => Question.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$GameToJson(Game instance) => <String, dynamic>{
      'id': instance.id,
      'pointsToWin': instance.pointsToWin,
      'players': instance.players.map((k, e) => MapEntry(k, e.toJson())),
      'createdAt': instance.createdAt.toIso8601String(),
      'winnerId': instance.winnerId,
      'questions': instance.questions.map((e) => e.toJson()).toList(),
    };
