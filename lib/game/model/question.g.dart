// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Question _$$_QuestionFromJson(Map<String, dynamic> json) => _$_Question(
      id: json['id'] as String,
      question: json['question'] as String,
      correctAnswerIdx: json['correctAnswerIdx'] as int,
      allAnswers: (json['allAnswers'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      interactions: (json['interactions'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, Interaction.fromJson(e as Map<String, dynamic>)),
      ),
      isShootout: json['isShootout'] as bool? ?? false,
    );

Map<String, dynamic> _$$_QuestionToJson(_$_Question instance) =>
    <String, dynamic>{
      'id': instance.id,
      'question': instance.question,
      'correctAnswerIdx': instance.correctAnswerIdx,
      'allAnswers': instance.allAnswers,
      'interactions':
          instance.interactions.map((k, e) => MapEntry(k, e.toJson())),
      'isShootout': instance.isShootout,
    };
