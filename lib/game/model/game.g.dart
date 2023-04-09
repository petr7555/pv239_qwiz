// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Game _$GameFromJson(Map<String, dynamic> json) => Game(
      id: json['id'] as String,
      pointsToWin: json['pointsToWin'] as int,
      players: (json['players'] as List<dynamic>)
          .map((e) => Player.fromJson(e as Map<String, dynamic>))
          .toList(),
      gameStatus:
          $enumDecodeNullable(_$GameStatusEnumMap, json['gameStatus']) ??
              GameStatus.notStarted,
      winnerId: json['winnerId'] as String?,
    );

Map<String, dynamic> _$GameToJson(Game instance) => <String, dynamic>{
      'id': instance.id,
      'pointsToWin': instance.pointsToWin,
      'players': instance.players.map((e) => e.toJson()).toList(),
      'gameStatus': _$GameStatusEnumMap[instance.gameStatus]!,
      'winnerId': instance.winnerId,
    };

const _$GameStatusEnumMap = {
  GameStatus.notStarted: 'notStarted',
  GameStatus.inProgress: 'inProgress',
  GameStatus.finished: 'finished',
};
