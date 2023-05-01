// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Interaction _$$_InteractionFromJson(Map<String, dynamic> json) =>
    _$_Interaction(
      answerIdx: json['answerIdx'] as int?,
      secondsToAnswer: (json['secondsToAnswer'] as num?)?.toDouble(),
      deltaPoints: json['deltaPoints'] as int? ?? 0,
    );

Map<String, dynamic> _$$_InteractionToJson(_$_Interaction instance) =>
    <String, dynamic>{
      'answerIdx': instance.answerIdx,
      'secondsToAnswer': instance.secondsToAnswer,
      'deltaPoints': instance.deltaPoints,
    };
