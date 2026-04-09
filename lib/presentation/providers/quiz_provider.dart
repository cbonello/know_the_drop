import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/local_question_data_source.dart';
import '../../data/repositories/question_repository_impl.dart';
import '../../domain/entities/question.dart';
import '../../domain/entities/quiz_state.dart';
import '../../domain/repositories/question_repository.dart';

final questionRepositoryProvider = Provider<QuestionRepository>(
  (_) => QuestionRepositoryImpl(dataSource: LocalQuestionDataSource()),
);

final selectedCategoryProvider = StateProvider<Category?>((_) => null);

final selectedDifficultyProvider = StateProvider<Difficulty?>(
  (ref) => Difficulty.trueFan,
);

final quizProvider =
    StateNotifierProvider<QuizNotifier, AsyncValue<QuizState?>>(
      (ref) => QuizNotifier(ref),
    );

class QuizNotifier extends StateNotifier<AsyncValue<QuizState?>> {
  QuizNotifier(this.ref) : super(const AsyncData(null));

  final Ref ref;

  Future<void> startQuiz({required String locale}) async {
    state = const AsyncLoading();
    try {
      final repo = ref.read(questionRepositoryProvider);
      final category = ref.read(selectedCategoryProvider);
      final difficulty = ref.read(selectedDifficultyProvider);

      final questions = await repo.getQuestions(
        locale: locale,
        category: category,
        difficulty: difficulty,
      );

      if (questions.isEmpty) {
        state = const AsyncData(null);
        return;
      }

      state = AsyncData(QuizState(questions: questions));
    } on Exception catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  void selectAnswer(int answerIndex) {
    final current = state.valueOrNull;
    if (current == null || current.isAnswerRevealed) {
      return;
    }

    final isCorrect = answerIndex == current.currentQuestion.correctIndex;
    final newStreak = isCorrect ? current.currentStreak + 1 : 0;
    final newBest = newStreak > current.bestStreak
        ? newStreak
        : current.bestStreak;

    state = AsyncData(
      current.copyWith(
        selectedAnswer: () => answerIndex,
        isAnswerRevealed: true,
        answers: [...current.answers, answerIndex],
        currentStreak: newStreak,
        bestStreak: newBest,
      ),
    );
  }

  void nextQuestion() {
    final current = state.valueOrNull;
    if (current == null) {
      return;
    }

    state = AsyncData(
      current.copyWith(
        currentIndex: current.currentIndex + 1,
        selectedAnswer: () => null,
        isAnswerRevealed: false,
      ),
    );
  }

  void reset() {
    state = const AsyncData(null);
  }
}
