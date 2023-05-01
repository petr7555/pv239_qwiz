// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Player _$$_PlayerFromJson(Map<String, dynamic> json) => _$_Player(
      id: json['id'] as String,
      displayName: json['displayName'] as String?,
      photoURL: json['photoURL'] as String?,
      route: json['route'] as String? ?? MenuPage.routeName,
      points: json['points'] as int? ?? 0,
      complete: json['complete'] as bool? ?? false,
      answerTimerEnded: json['answerTimerEnded'] as bool? ?? false,
      resultTimerEnded: json['resultTimerEnded'] as bool? ?? false,
    );

Map<String, dynamic> _$$_PlayerToJson(_$_Player instance) => <String, dynamic>{
      'id': instance.id,
      'displayName': instance.displayName,
      'photoURL': instance.photoURL,
      'route': instance.route,
      'points': instance.points,
      'complete': instance.complete,
      'answerTimerEnded': instance.answerTimerEnded,
      'resultTimerEnded': instance.resultTimerEnded,
    };
