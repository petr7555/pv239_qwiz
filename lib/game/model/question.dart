class Question {
  final String id;
  final String question;
  final int correctAnswerIdx;
  final List<String> allAnswers;

  const Question({
    required this.id,
    required this.question,
    required this.correctAnswerIdx,
    required this.allAnswers,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
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
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'correctAnswerIdx': correctAnswerIdx,
      'allAnswers': allAnswers,
    };
  }
}
