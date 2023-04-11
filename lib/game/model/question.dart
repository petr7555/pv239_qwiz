import 'package:json_annotation/json_annotation.dart';
import 'package:pv239_qwiz/game/model/interaction.dart';

part 'question.g.dart';

@JsonSerializable(explicitToJson: true)
class Question {
  final String id;
  final String question;
  final int correctAnswerIdx;
  final List<String> allAnswers;
  final Map<String, Interaction> interactions;
  Question({
    required this.id,
    required this.question,
    required this.correctAnswerIdx,
    required this.allAnswers,
    required this.interactions,
  });

  Question copyWith({
    String? id,
    String? question,
    int? correctAnswerIdx,
    List<String>? allAnswers,
    Map<String, Interaction>? interactions,
  }) {
    return Question(
      id: id ?? this.id,
      question: question ?? this.question,
      correctAnswerIdx: correctAnswerIdx ?? this.correctAnswerIdx,
      allAnswers: allAnswers ?? this.allAnswers,
      interactions: interactions ?? this.interactions,
    );
  }

  factory Question.fromApiJson(Map<String, dynamic> json) {
    final correctAnswer = json['correctAnswer'] as String;
    final incorrectAnswers = (json['incorrectAnswers'] as List<dynamic>).map((e) => e as String).toList();
    final allAnswers = [correctAnswer, ...incorrectAnswers];
    allAnswers.shuffle();
    final correctAnswerIdx = allAnswers.indexOf(correctAnswer);

    return Question(
      id: json['id'] as String,
      question: json['question'] as String,
      correctAnswerIdx: correctAnswerIdx,
      allAnswers: allAnswers,
      interactions: {},
    );
  }

  factory Question.fromJson(Map<String, dynamic> json) => _$QuestionFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionToJson(this);
}
