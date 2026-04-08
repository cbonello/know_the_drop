import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'l10n/generated/app_localizations.dart';

void main() => runApp(const ProviderScope(child: KnowTheDropApp()));

class KnowTheDropApp extends StatelessWidget {
  const KnowTheDropApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp.router(
    title: 'Tiësto Trivia',
    debugShowCheckedModeBanner: false,
    theme: AppTheme.dark,
    routerConfig: appRouter,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
  );
}
