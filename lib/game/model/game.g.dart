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
      winnerId: json['winnerId'] as String?,
      date: json['date'] as DateTime?,
      questions:
          (json['questions'] as List<dynamic>?)?.map((e) => Question.fromJson(e as Map<String, dynamic>)).toList() ??
              const [],
    )..currentQuestion = Question.fromJson(json['currentQuestion'] as Map<String, dynamic>);

Map<String, dynamic> _$GameToJson(Game instance) => <String, dynamic>{
      'id': instance.id,
      'pointsToWin': instance.pointsToWin,
      'players': instance.players.map((k, e) => MapEntry(k, e.toJson())),
      'winnerId': instance.winnerId,
      'questions': instance.questions.map((e) => e.toJson()).toList(),
      'currentQuestion': instance.currentQuestion.toJson(),
      'date': instance.date,
    };
