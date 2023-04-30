// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Interaction _$InteractionFromJson(Map<String, dynamic> json) => Interaction(
      answerIdx: json['answerIdx'] as int?,
      secondsToAnswer: (json['secondsToAnswer'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$InteractionToJson(Interaction instance) => <String, dynamic>{
      'answerIdx': instance.answerIdx,
      'secondsToAnswer': instance.secondsToAnswer,
    };
