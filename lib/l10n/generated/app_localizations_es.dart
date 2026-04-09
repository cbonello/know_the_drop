// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Trivia de Tiësto';

  @override
  String get homeSubtitle => '¿Qué tan bien conoces a la leyenda?';

  @override
  String get categoriesLabel => 'CATEGORÍAS';

  @override
  String get categoryDiscography => 'Discografía';

  @override
  String get categoryBiography => 'Biografía';

  @override
  String get categoryEdmCulture => 'Cultura EDM';

  @override
  String get difficultyLabel => 'DIFICULTAD';

  @override
  String get difficultyCasualFan => 'Fan casual';

  @override
  String get difficultyTrueFan => 'Verdadero fan';

  @override
  String get difficultyScholar => 'Erudito';

  @override
  String get yourBestScore => 'Tu mejor puntuación';

  @override
  String get accuracy => 'Precisión';

  @override
  String get startQuiz => 'Comenzar';

  @override
  String questionOf(int current, int total) {
    return 'Pregunta $current de $total';
  }

  @override
  String get correctAnswer => '¡Correcto!';

  @override
  String get wrongAnswer => '¡Incorrecto!';

  @override
  String get theAnswerWas => 'La respuesta era:';

  @override
  String get nextQuestion => 'Siguiente pregunta';

  @override
  String get quizComplete => '¡Quiz completo!';

  @override
  String get yourScore => 'Tu puntuación';

  @override
  String scoreValue(int score, int total) {
    return '$score / $total';
  }

  @override
  String accuracyPercent(int percent) {
    return '$percent%';
  }

  @override
  String streakCount(int count) {
    return '$count seguidas';
  }

  @override
  String get bestStreak => 'Mejor racha';

  @override
  String get noQuestionsAvailable =>
      'No hay preguntas disponibles para esta selección.';

  @override
  String get quitQuiz => 'Salir';

  @override
  String get quitConfirmTitle => '¿Salir del quiz?';

  @override
  String get quitConfirmBody => 'Tu progreso se perderá.';

  @override
  String get quitConfirmYes => 'Salir';

  @override
  String get quitConfirmNo => 'Continuar';

  @override
  String get playAgain => 'Jugar de nuevo';

  @override
  String get goHome => 'Ir al inicio';

  @override
  String get onboardingWelcome => 'Bienvenido a';

  @override
  String get onboardingLine1 => '150 preguntas sobre el legendario DJ Tiësto';

  @override
  String get onboardingLine2 => 'Elige tu categoría y dificultad';

  @override
  String get onboardingLine3 => 'Sigue tus rachas y supera tu mejor puntuación';

  @override
  String get onboardingStart => 'Vamos';

  @override
  String get languageLabel => 'Idioma';

  @override
  String get photoCredit => 'Foto: Takeaway / CC BY 4.0';
}
