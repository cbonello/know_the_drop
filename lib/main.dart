import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'l10n/generated/app_localizations.dart';
import 'presentation/providers/locale_provider.dart';
import 'presentation/screens/onboarding/onboarding_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final showOnboarding = !await OnboardingScreen.hasBeenSeen();
  runApp(ProviderScope(child: KnowTheDropApp(showOnboarding: showOnboarding)));
}

class KnowTheDropApp extends ConsumerWidget {
  const KnowTheDropApp({required this.showOnboarding, super.key});

  final bool showOnboarding;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);

    return MaterialApp.router(
      title: 'Tiësto Trivia',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      routerConfig: buildRouter(showOnboarding: showOnboarding),
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
