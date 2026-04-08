import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/responsive/breakpoints.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../providers/quiz_provider.dart';

class AnswerRevealedScreen extends ConsumerWidget {
  const AnswerRevealedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final screenSize = Breakpoints.of(context);
    final quizAsync = ref.watch(quizProvider);

    return Scaffold(
      body: SafeArea(
        child: quizAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Error: $e')),
          data: (quizState) {
            if (quizState == null) {
              return const Center(child: Text('No quiz in progress'));
            }

            final question = quizState.currentQuestion;
            final lastAnswer = quizState.answers.last;
            final isCorrect = lastAnswer == question.correctIndex;

            final content = Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenSize.isPhone ? 24 : 48,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 48),
                  Icon(
                    isCorrect ? Icons.check_circle : Icons.cancel,
                    color: isCorrect ? AppColors.neonGreen : AppColors.errorRed,
                    size: 72,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    isCorrect ? l10n.correctAnswer : l10n.wrongAnswer,
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: isCorrect
                          ? AppColors.neonGreen
                          : AppColors.errorRed,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  if (!isCorrect) ...[
                    const SizedBox(height: 16),
                    Text(
                      l10n.theAnswerWas,
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      question.correctAnswer,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppColors.neonGreen,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                  if (question.explanation != null) ...[
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.darkPurple,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.mediumPurple),
                      ),
                      child: Text(
                        question.explanation!,
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                  const SizedBox(height: 36),
                  ElevatedButton(
                    onPressed: () {
                      if (quizState.isLastQuestion) {
                        context.go(AppRoutes.results);
                      } else {
                        ref.read(quizProvider.notifier).nextQuestion();
                        context.go(AppRoutes.question);
                      }
                    },
                    child: Text(
                      quizState.isLastQuestion
                          ? l10n.quizComplete
                          : l10n.nextQuestion,
                    ),
                  ),
                ],
              ),
            );

            return screenSize.isPhone
                ? SingleChildScrollView(child: content)
                : Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 600),
                      child: SingleChildScrollView(child: content),
                    ),
                  );
          },
        ),
      ),
    );
  }
}
