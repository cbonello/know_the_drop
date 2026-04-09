import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/responsive/breakpoints.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../l10n/generated/app_localizations.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  static const _seenKey = 'onboarding_seen';

  Future<void> _complete(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_seenKey, true);
    if (context.mounted) {
      context.go(AppRoutes.home);
    }
  }

  static Future<bool> hasBeenSeen() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_seenKey) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final screenSize = Breakpoints.of(context);

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
                AppColors.deepPurple.withAlpha(140),
                AppColors.deepPurple.withAlpha(220),
                AppColors.deepPurple,
              ],
              stops: const [0.0, 0.45, 0.75],
            ),
          ),
          child: SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: screenSize.isPhone ? double.infinity : 500,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenSize.isPhone ? 32 : 48,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(flex: 3),
                      Text(
                        l10n.onboardingWelcome,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        l10n.appTitle,
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge
                            ?.copyWith(fontSize: 40),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 48),
                      _FeatureRow(
                        icon: Icons.library_music,
                        text: l10n.onboardingLine1,
                      ),
                      const SizedBox(height: 20),
                      _FeatureRow(
                        icon: Icons.tune,
                        text: l10n.onboardingLine2,
                      ),
                      const SizedBox(height: 20),
                      _FeatureRow(
                        icon: Icons.local_fire_department,
                        text: l10n.onboardingLine3,
                      ),
                      const Spacer(flex: 2),
                      ElevatedButton(
                        onPressed: () => _complete(context),
                        child: Text(l10n.onboardingStart),
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FeatureRow extends StatelessWidget {
  const _FeatureRow({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColors.brightPurple, size: 28),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ],
    );
  }
}
