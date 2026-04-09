import 'package:go_router/go_router.dart';

import '../../presentation/screens/answer_revealed/answer_revealed_screen.dart';
import '../../presentation/screens/home/home_screen.dart';
import '../../presentation/screens/onboarding/onboarding_screen.dart';
import '../../presentation/screens/question/question_screen.dart';
import '../../presentation/screens/results/results_screen.dart';

abstract final class AppRoutes {
  static const onboarding = '/onboarding';
  static const home = '/';
  static const question = '/question';
  static const answerRevealed = '/answer-revealed';
  static const results = '/results';
}

GoRouter buildRouter({required bool showOnboarding}) {
  return GoRouter(
    initialLocation:
        showOnboarding ? AppRoutes.onboarding : AppRoutes.home,
    routes: [
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
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
}
