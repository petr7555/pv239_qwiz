// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Game _$GameFromJson(Map<String, dynamic> json) => Game(
      id: json['id'] as String,
      pointsToWin: json['pointsToWin'] as int,
      firstPlayer: Player.fromJson(json['firstPlayer'] as Map<String, dynamic>),
      secondPlayer: json['secondPlayer'] == null
          ? null
          : Player.fromJson(json['secondPlayer'] as Map<String, dynamic>),
      winnerId: json['winnerId'] as String?,
    );

Map<String, dynamic> _$GameToJson(Game instance) => <String, dynamic>{
      'id': instance.id,
      'pointsToWin': instance.pointsToWin,
      'firstPlayer': instance.firstPlayer.toJson(),
      'secondPlayer': instance.secondPlayer?.toJson(),
      'winnerId': instance.winnerId,
    };
