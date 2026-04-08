import 'question.dart';

class QuizState {
  const QuizState({
    required this.questions,
    this.currentIndex = 0,
    this.answers = const [],
    this.selectedAnswer,
    this.isAnswerRevealed = false,
  });

  final List<Question> questions;
  final int currentIndex;
  final List<int> answers;
  final int? selectedAnswer;
  final bool isAnswerRevealed;

  Question get currentQuestion => questions[currentIndex];
  bool get isLastQuestion => currentIndex >= questions.length - 1;
  bool get isComplete => answers.length == questions.length;

  int get correctCount {
    var count = 0;
    for (var i = 0; i < answers.length; i++) {
      if (answers[i] == questions[i].correctIndex) count++;
    }

    return count;
  }

  int get accuracyPercent =>
      questions.isEmpty ? 0 : (correctCount * 100) ~/ questions.length;

  QuizState copyWith({
    List<Question>? questions,
    int? currentIndex,
    List<int>? answers,
    int? Function()? selectedAnswer,
    bool? isAnswerRevealed,
  }) {
    return QuizState(
      questions: questions ?? this.questions,
      currentIndex: currentIndex ?? this.currentIndex,
      answers: answers ?? this.answers,
      selectedAnswer: selectedAnswer != null
          ? selectedAnswer()
          : this.selectedAnswer,
      isAnswerRevealed: isAnswerRevealed ?? this.isAnswerRevealed,
    );
  }
}
