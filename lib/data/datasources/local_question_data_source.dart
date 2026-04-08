import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/question_model.dart';

class LocalQuestionDataSource {
  Future<List<QuestionModel>> loadQuestions() async {
    final jsonString = await rootBundle.loadString(
      'assets/questions/triesto_trivia_questions.json',
    );
    final jsonMap = json.decode(jsonString) as Map<String, dynamic>;
    final jsonList = jsonMap['questions'] as List<dynamic>;

    return jsonList
        .map((e) => QuestionModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
