import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pv239_qwiz/common/util/shared_logic_constants.dart';
import 'package:pv239_qwiz/game/model/question.dart';

class QuestionApiService {
  Future<Question> getQuestion() async {
    final response = await http.get(Uri.parse(questionsApiEndpoint));

    if (response.statusCode == 200) {
      return Question.fromApiJson(jsonDecode(response.body)[0]);
    } else {
      throw Exception('Failed to get question');
    }
  }
}
