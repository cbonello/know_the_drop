import '../../domain/entities/question.dart';

class QuestionModel {
  const QuestionModel({
    required this.id,
    required this.category,
    required this.difficulty,
    required this.question,
    required this.answers,
    required this.correct,
    this.fact,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['id'] as String,
      category: _parseCategory(json['category'] as String),
      difficulty: _parseDifficulty(json['difficulty'] as String),
      question: Map<String, String>.from(json['question'] as Map),
      answers: (json['answers'] as Map<String, dynamic>).map(
        (key, value) => MapEntry(
          key,
          (value as List<dynamic>).map((e) => e as String).toList(),
        ),
      ),
      correct: json['correct'] as int,
      fact: json['fact'] != null
          ? Map<String, String>.from(json['fact'] as Map)
          : null,
    );
  }

  final String id;
  final Category category;
  final Difficulty difficulty;
  final Map<String, String> question;
  final Map<String, List<String>> answers;
  final int correct;
  final Map<String, String>? fact;

  Question toEntity(String locale) {
    final lang = locale.substring(0, 2);
    final options = List<String>.of(answers[lang] ?? answers['en']!);
    final correctAnswer = options[correct];
    options.shuffle();

    return Question(
      id: id,
      category: category,
      difficulty: difficulty,
      text: question[lang] ?? question['en']!,
      options: options,
      correctIndex: options.indexOf(correctAnswer),
      explanation: fact?[lang] ?? fact?['en'],
    );
  }

  static Category _parseCategory(String value) => switch (value) {
    'discography' => Category.discography,
    'biography' => Category.biography,
    'edm_culture' => Category.edmCulture,
    _ => Category.discography,
  };

  static Difficulty _parseDifficulty(String value) => switch (value) {
    'casual' => Difficulty.casualFan,
    'true' => Difficulty.trueFan,
    'scholar' => Difficulty.scholar,
    _ => Difficulty.casualFan,
  };
}
