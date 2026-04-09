import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/responsive/breakpoints.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../providers/quiz_provider.dart';
import '../../providers/score_provider.dart';

class ResultsScreen extends ConsumerStatefulWidget {
  const ResultsScreen({super.key});

  @override
  ConsumerState<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends ConsumerState<ResultsScreen> {
  bool _scoreSaved = false;

  void _saveScore(int score, int accuracy) {
    if (_scoreSaved) return;
    _scoreSaved = true;
    ref.read(scoreRepositoryProvider).saveScore(
      score: score,
      accuracy: accuracy,
    );
    ref.invalidate(bestScoreProvider);
  }

  @override
  Widget build(BuildContext context) {
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
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (context.mounted) context.go(AppRoutes.home);
              });
              return const SizedBox.shrink();
            }

            _saveScore(quizState.correctCount, quizState.accuracyPercent);

            final content = Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenSize.isPhone ? 24 : 48,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 48),
                  const Icon(
                    Icons.emoji_events,
                    color: AppColors.brightPurple,
                    size: 80,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    l10n.quizComplete,
                    style: Theme.of(context).textTheme.headlineLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            l10n.yourScore,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            l10n.scoreValue(
                              quizState.correctCount,
                              quizState.questions.length,
                            ),
                            style: Theme.of(context).textTheme.headlineMedium
                                ?.copyWith(color: AppColors.white),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            l10n.accuracy,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            l10n.accuracyPercent(quizState.accuracyPercent),
                            style: Theme.of(context).textTheme.headlineMedium
                                ?.copyWith(color: AppColors.neonGreen),
                          ),
                        ],
                      ),
                    ],
                  ),
                  if (quizState.bestStreak >= 2) ...[
                    const SizedBox(height: 24),
                    Column(
                      children: [
                        Text(
                          l10n.bestStreak,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          l10n.streakCount(quizState.bestStreak),
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(color: AppColors.neonGreen),
                        ),
                      ],
                    ),
                  ],
                  const SizedBox(height: 48),
                  ElevatedButton(
                    onPressed: () {
                      ref.read(quizProvider.notifier).reset();
                      context.go(AppRoutes.home);
                    },
                    child: Text(l10n.playAgain),
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () {
                      ref.read(quizProvider.notifier).reset();
                      context.go(AppRoutes.home);
                    },
                    child: Text(
                      l10n.goHome,
                      style: const TextStyle(color: AppColors.mutedGray),
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
