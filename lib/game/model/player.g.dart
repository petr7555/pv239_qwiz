// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Player _$PlayerFromJson(Map<String, dynamic> json) => Player(
      id: json['id'] as String,
      route: json['route'] as String? ?? MenuPage.routeName,
      points: json['points'] as int? ?? 0,
      complete: json['complete'] as bool? ?? false,
      answerTimerEnded: json['answerTimerEnded'] as bool? ?? false,
      resultTimerEnded: json['resultTimerEnded'] as bool? ?? false,
    );

Map<String, dynamic> _$PlayerToJson(Player instance) => <String, dynamic>{
      'id': instance.id,
      'route': instance.route,
      'points': instance.points,
      'complete': instance.complete,
      'answerTimerEnded': instance.answerTimerEnded,
      'resultTimerEnded': instance.resultTimerEnded,
    };
