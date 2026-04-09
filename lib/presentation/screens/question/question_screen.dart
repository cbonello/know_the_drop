import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/responsive/breakpoints.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../providers/quiz_provider.dart';

class QuestionScreen extends ConsumerWidget {
  const QuestionScreen({super.key});

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
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      l10n.noQuestionsAvailable,
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () => context.go(AppRoutes.home),
                      child: Text(l10n.goHome),
                    ),
                  ],
                ),
              );
            }

            final question = quizState.currentQuestion;

            final content = Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenSize.isPhone ? 24 : 48,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      if (quizState.currentStreak >= 2)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.neonGreen.withAlpha(30),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: AppColors.neonGreen.withAlpha(100),
                            ),
                          ),
                          child: Text(
                            l10n.streakCount(quizState.currentStreak),
                            style: const TextStyle(
                              color: AppColors.neonGreen,
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      const Spacer(),
                      TextButton(
                        onPressed: () => _showQuitDialog(context, ref),
                        child: Text(
                          l10n.quitQuiz,
                          style: const TextStyle(color: AppColors.mutedGray),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    l10n.questionOf(
                      quizState.currentIndex + 1,
                      quizState.questions.length,
                    ),
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  const SizedBox(height: 16),
                  LinearProgressIndicator(
                    value:
                        (quizState.currentIndex + 1) /
                        quizState.questions.length,
                    backgroundColor: AppColors.mediumPurple,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      AppColors.accentPurple,
                    ),
                    minHeight: 4,
                    borderRadius: BorderRadius.circular(2),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    question.text,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 32),
                  ...List.generate(question.options.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _OptionButton(
                        text: question.options[index],
                        index: index,
                        isSelected: quizState.selectedAnswer == index,
                        isCorrect: index == question.correctIndex,
                        isRevealed: quizState.isAnswerRevealed,
                        onTap: quizState.isAnswerRevealed
                            ? null
                            : () {
                                ref
                                    .read(quizProvider.notifier)
                                    .selectAnswer(index);
                                Future.delayed(
                                  const Duration(milliseconds: 800),
                                  () {
                                    if (context.mounted) {
                                      context.go(AppRoutes.answerRevealed);
                                    }
                                  },
                                );
                              },
                      ),
                    );
                  }),
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

  void _showQuitDialog(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.darkPurple,
        title: Text(l10n.quitConfirmTitle),
        content: Text(l10n.quitConfirmBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(l10n.quitConfirmNo),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              ref.read(quizProvider.notifier).reset();
              context.go(AppRoutes.home);
            },
            child: Text(
              l10n.quitConfirmYes,
              style: const TextStyle(color: AppColors.errorRed),
            ),
          ),
        ],
      ),
    );
  }
}

class _OptionButton extends StatelessWidget {
  const _OptionButton({
    required this.text,
    required this.index,
    required this.isSelected,
    required this.isCorrect,
    required this.isRevealed,
    this.onTap,
  });

  final String text;
  final int index;
  final bool isSelected;
  final bool isCorrect;
  final bool isRevealed;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    Color borderColor = AppColors.mediumPurple;
    Color bgColor = AppColors.darkPurple;

    if (isRevealed) {
      if (isCorrect) {
        borderColor = AppColors.neonGreen;
        bgColor = AppColors.neonGreen.withAlpha(30);
      } else if (isSelected) {
        borderColor = AppColors.errorRed;
        bgColor = AppColors.errorRed.withAlpha(30);
      }
    } else if (isSelected) {
      borderColor = AppColors.accentPurple;
    }

    return Material(
      color: bgColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: borderColor, width: 1.5),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Text(text, style: Theme.of(context).textTheme.bodyLarge),
        ),
      ),
    );
  }
}
