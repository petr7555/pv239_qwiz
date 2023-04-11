// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Question _$QuestionFromJson(Map<String, dynamic> json) => Question(
      id: json['id'] as String,
      question: json['question'] as String,
      correctAnswerIdx: json['correctAnswerIdx'] as int,
      allAnswers: (json['allAnswers'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      interactions: (json['interactions'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, Interaction.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
      'id': instance.id,
      'question': instance.question,
      'correctAnswerIdx': instance.correctAnswerIdx,
      'allAnswers': instance.allAnswers,
      'interactions':
          instance.interactions.map((k, e) => MapEntry(k, e.toJson())),
    };
