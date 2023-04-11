// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Interaction _$InteractionFromJson(Map<String, dynamic> json) => Interaction(
      answerIdx: json['answerIdx'] as int?,
      answerTimerEnded: json['answerTimerEnded'] as bool? ?? false,
      resultTimerEnded: json['resultTimerEnded'] as bool? ?? false,
    );

Map<String, dynamic> _$InteractionToJson(Interaction instance) =>
    <String, dynamic>{
      'answerIdx': instance.answerIdx,
      'answerTimerEnded': instance.answerTimerEnded,
      'resultTimerEnded': instance.resultTimerEnded,
    };
