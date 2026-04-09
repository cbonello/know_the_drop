import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/responsive/breakpoints.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../domain/entities/question.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../providers/locale_provider.dart';
import '../../providers/quiz_provider.dart';
import '../../providers/score_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final screenSize = Breakpoints.of(context);
    final selectedCategory = ref.watch(selectedCategoryProvider);
    final selectedDifficulty = ref.watch(selectedDifficultyProvider);

    final content = Padding(
      padding: EdgeInsets.symmetric(horizontal: screenSize.isPhone ? 24 : 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: _MenuButton(),
          ),
          const SizedBox(height: 8),
          Text(l10n.appTitle, style: Theme.of(context).textTheme.headlineLarge),
          const SizedBox(height: 8),
          Text(
            l10n.homeSubtitle,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 32),

          // Categories
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              l10n.categoriesLabel,
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _CategoryChip(
                label: l10n.categoryDiscography,
                value: Category.discography,
                selected: selectedCategory == Category.discography,
              ),
              _CategoryChip(
                label: l10n.categoryBiography,
                value: Category.biography,
                selected: selectedCategory == Category.biography,
              ),
              _CategoryChip(
                label: l10n.categoryEdmCulture,
                value: Category.edmCulture,
                selected: selectedCategory == Category.edmCulture,
              ),
            ],
          ),
          const SizedBox(height: 28),

          // Difficulty
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              l10n.difficultyLabel,
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _DifficultyChip(
                label: l10n.difficultyCasualFan,
                value: Difficulty.casualFan,
                selected: selectedDifficulty == Difficulty.casualFan,
              ),
              _DifficultyChip(
                label: l10n.difficultyTrueFan,
                value: Difficulty.trueFan,
                selected: selectedDifficulty == Difficulty.trueFan,
              ),
              _DifficultyChip(
                label: l10n.difficultyScholar,
                value: Difficulty.scholar,
                selected: selectedDifficulty == Difficulty.scholar,
              ),
            ],
          ),
          const SizedBox(height: 28),

          // Stats row
          Consumer(
            builder: (context, ref, _) {
              final scoreAsync = ref.watch(bestScoreProvider);
              return scoreAsync.when(
                loading: () => const SizedBox(height: 60),
                error: (_, _) => const SizedBox(height: 60),
                data: (record) => Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.yourBestScore,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            record.hasData
                                ? l10n.scoreValue(record.bestScore, 10)
                                : '—',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(color: AppColors.white),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.accuracy,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            record.hasData
                                ? l10n.accuracyPercent(record.bestAccuracy)
                                : '—',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(color: AppColors.neonGreen),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 36),

          // Start button
          ElevatedButton(
            onPressed: () async {
              final locale = Localizations.localeOf(context).toString();
              await ref.read(quizProvider.notifier).startQuiz(locale: locale);
              if (context.mounted) {
                context.go(AppRoutes.question);
              }
            },
            child: Text(l10n.startQuiz),
          ),
          const SizedBox(height: 16),
          Text(
            l10n.photoCredit,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontSize: 12),
          ),
        ],
      ),
    );

    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.jpg'),
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.deepPurple.withAlpha(180),
                AppColors.deepPurple.withAlpha(230),
                AppColors.deepPurple,
              ],
              stops: const [0.0, 0.4, 0.7],
            ),
          ),
          child: SafeArea(
            child: screenSize.isPhone
                ? SingleChildScrollView(child: content)
                : Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 600),
                      child: SingleChildScrollView(child: content),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

class _CategoryChip extends ConsumerWidget {
  const _CategoryChip({
    required this.label,
    required this.value,
    required this.selected,
  });

  final String label;
  final Category value;
  final bool selected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (isSelected) {
        ref.read(selectedCategoryProvider.notifier).state = isSelected
            ? value
            : null;
      },
    );
  }
}

class _DifficultyChip extends ConsumerWidget {
  const _DifficultyChip({
    required this.label,
    required this.value,
    required this.selected,
  });

  final String label;
  final Difficulty value;
  final bool selected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (isSelected) {
        ref.read(selectedDifficultyProvider.notifier).state = isSelected
            ? value
            : null;
      },
    );
  }
}

class _MenuButton extends ConsumerWidget {
  const _MenuButton();

  static const _locales = [
    (locale: Locale('en'), label: 'English'),
    (locale: Locale('es'), label: 'Español'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final current = ref.watch(localeProvider) ?? Localizations.localeOf(context);

    return PopupMenuButton<String>(
      icon: const Icon(Icons.menu, color: AppColors.lightGray),
      color: AppColors.darkPurple,
      itemBuilder: (context) => [
        PopupMenuItem(
          enabled: false,
          child: Text(
            l10n.languageLabel,
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
        for (final entry in _locales)
          PopupMenuItem(
            value: entry.locale.languageCode,
            child: Row(
              children: [
                if (current.languageCode == entry.locale.languageCode)
                  const Icon(Icons.check, size: 18, color: AppColors.neonGreen)
                else
                  const SizedBox(width: 18),
                const SizedBox(width: 12),
                Text(entry.label),
              ],
            ),
          ),
      ],
      onSelected: (langCode) {
        ref.read(localeProvider.notifier).state = Locale(langCode);
      },
    );
  }
}
