import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pv239_qwiz/common/util/shared_logic_constants.dart';
import 'package:pv239_qwiz/game/model/question.dart';

const shouldMockQuestion = true;
final mockQuestion = Question(
  id: '1',
  question: 'What is the capital of the Czech Republic?',
  correctAnswerIdx: 0,
  allAnswers: ['Prague', 'Brno', 'Ostrava', 'Plzen'],
  interactions: {},
);

class QuestionApiService {
  Future<Question> getQuestion() async {
    if (shouldMockQuestion) {
      return mockQuestion;
    }
    final response = await http.get(Uri.parse(questionsApiEndpoint));

    if (response.statusCode == 200) {
      return Question.fromApiJson(jsonDecode(response.body)[0]);
    } else {
      throw Exception('Failed to get question');
    }
  }
}
