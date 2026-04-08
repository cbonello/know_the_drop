import 'package:go_router/go_router.dart';

import '../../presentation/screens/answer_revealed/answer_revealed_screen.dart';
import '../../presentation/screens/home/home_screen.dart';
import '../../presentation/screens/question/question_screen.dart';
import '../../presentation/screens/results/results_screen.dart';

abstract final class AppRoutes {
  static const home = '/';
  static const question = '/question';
  static const answerRevealed = '/answer-revealed';
  static const results = '/results';
}

final appRouter = GoRouter(
  initialLocation: AppRoutes.home,
  routes: [
    GoRoute(
      path: AppRoutes.home,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: AppRoutes.question,
      builder: (context, state) => const QuestionScreen(),
    ),
    GoRoute(
      path: AppRoutes.answerRevealed,
      builder: (context, state) => const AnswerRevealedScreen(),
    ),
    GoRoute(
      path: AppRoutes.results,
      builder: (context, state) => const ResultsScreen(),
    ),
  ],
);
