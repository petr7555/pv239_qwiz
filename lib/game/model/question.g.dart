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
      firstPlayerAnswerIdx: json['firstPlayerAnswerIdx'] as int?,
      secondPlayerAnswerIdx: json['secondPlayerAnswerIdx'] as int?,
    );

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
      'id': instance.id,
      'question': instance.question,
      'correctAnswerIdx': instance.correctAnswerIdx,
      'allAnswers': instance.allAnswers,
      'firstPlayerAnswerIdx': instance.firstPlayerAnswerIdx,
      'secondPlayerAnswerIdx': instance.secondPlayerAnswerIdx,
    };
