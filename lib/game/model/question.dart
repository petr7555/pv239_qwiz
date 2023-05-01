import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pv239_qwiz/game/model/interaction.dart';

part 'question.freezed.dart';
part 'question.g.dart';

@freezed
class Question with _$Question {
  const factory Question({
    required String id,
    required String question,
    required int correctAnswerIdx,
    required List<String> allAnswers,
    required Map<String, Interaction> interactions,
    @Default(false) bool isShootout,
  }) = _Question;

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
}
