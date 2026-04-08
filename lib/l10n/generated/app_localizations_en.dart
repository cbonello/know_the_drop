// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Tiësto Trivia';

  @override
  String get homeSubtitle => 'How well do you know the legend?';

  @override
  String get categoriesLabel => 'CATEGORIES';

  @override
  String get categoryDiscography => 'Discography';

  @override
  String get categoryBiography => 'Biography';

  @override
  String get categoryEdmCulture => 'EDM culture';

  @override
  String get difficultyLabel => 'DIFFICULTY';

  @override
  String get difficultyCasualFan => 'Casual fan';

  @override
  String get difficultyTrueFan => 'True fan';

  @override
  String get difficultyScholar => 'Scholar';

  @override
  String get yourBestScore => 'Your best score';

  @override
  String get accuracy => 'Accuracy';

  @override
  String get startQuiz => 'Start quiz';

  @override
  String questionOf(int current, int total) {
    return 'Question $current of $total';
  }

  @override
  String get correctAnswer => 'Correct!';

  @override
  String get wrongAnswer => 'Wrong!';

  @override
  String get theAnswerWas => 'The answer was:';

  @override
  String get nextQuestion => 'Next question';

  @override
  String get quizComplete => 'Quiz complete!';

  @override
  String get yourScore => 'Your score';

  @override
  String scoreValue(int score, int total) {
    return '$score / $total';
  }

  @override
  String accuracyPercent(int percent) {
    return '$percent%';
  }

  @override
  String get quitQuiz => 'Quit';

  @override
  String get quitConfirmTitle => 'Quit quiz?';

  @override
  String get quitConfirmBody => 'Your progress will be lost.';

  @override
  String get quitConfirmYes => 'Quit';

  @override
  String get quitConfirmNo => 'Continue';

  @override
  String get playAgain => 'Play again';

  @override
  String get goHome => 'Go home';

  @override
  String get photoCredit => 'Photo: Takeaway / CC BY 4.0';
}
