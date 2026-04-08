import '../../domain/entities/question.dart';
import '../../domain/repositories/question_repository.dart';
import '../datasources/local_question_data_source.dart';
import '../models/question_model.dart';

class QuestionRepositoryImpl implements QuestionRepository {
  QuestionRepositoryImpl({required this.dataSource});

  final LocalQuestionDataSource dataSource;

  List<QuestionModel>? _cachedModels;

  @override
  Future<List<Question>> getQuestions({
    required String locale,
    Category? category,
    Difficulty? difficulty,
  }) async {
    _cachedModels ??= await dataSource.loadQuestions();

    var filtered = _cachedModels!;

    if (category != null) {
      filtered = filtered.where((m) => m.category == category).toList();
    }
    if (difficulty != null) {
      filtered = filtered.where((m) => m.difficulty == difficulty).toList();
    }

    final questions = filtered.map((m) => m.toEntity(locale)).toList();
    questions.shuffle();

    return questions.take(10).toList();
  }
}
