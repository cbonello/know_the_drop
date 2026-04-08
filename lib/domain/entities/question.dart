enum Category { discography, biography, edmCulture }

enum Difficulty { casualFan, trueFan, scholar }

class Question {
  const Question({
    required this.id,
    required this.category,
    required this.difficulty,
    required this.text,
    required this.options,
    required this.correctIndex,
    this.explanation,
  });

  final String id;
  final Category category;
  final Difficulty difficulty;
  final String text;
  final List<String> options;
  final int correctIndex;
  final String? explanation;

  String get correctAnswer => options[correctIndex];
}
