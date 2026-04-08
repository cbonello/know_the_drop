import '../entities/question.dart';

abstract class QuestionRepository {
  Future<List<Question>> getQuestions({
    required String locale,
    Category? category,
    Difficulty? difficulty,
  });
}
