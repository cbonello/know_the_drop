import 'package:flutter/material.dart';

enum ScreenSize { phone, tabletPortrait, tabletLandscape }

abstract final class Breakpoints {
  static const double phone = 600;
  static const double tabletPortrait = 900;

  static ScreenSize of(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width < phone) return ScreenSize.phone;
    if (width < tabletPortrait) return ScreenSize.tabletPortrait;
    return ScreenSize.tabletLandscape;
  }
}

extension ScreenSizeExtension on ScreenSize {
  bool get isPhone => this == ScreenSize.phone;
  bool get isTablet =>
      this == ScreenSize.tabletPortrait || this == ScreenSize.tabletLandscape;

  T when<T>({
    required T Function() phone,
    required T Function() tabletPortrait,
    required T Function() tabletLandscape,
  }) {
    return switch (this) {
      ScreenSize.phone => phone(),
      ScreenSize.tabletPortrait => tabletPortrait(),
      ScreenSize.tabletLandscape => tabletLandscape(),
    };
  }
}

class ResponsiveBuilder extends StatelessWidget {
  const ResponsiveBuilder({
    required this.phone,
    super.key,
    this.tabletPortrait,
    this.tabletLandscape,
  });

  final Widget Function(BuildContext) phone;
  final Widget Function(BuildContext)? tabletPortrait;
  final Widget Function(BuildContext)? tabletLandscape;

  @override
  Widget build(BuildContext context) {
    final screenSize = Breakpoints.of(context);
    return switch (screenSize) {
      ScreenSize.tabletLandscape =>
        (tabletLandscape ?? tabletPortrait ?? phone)(context),
      ScreenSize.tabletPortrait => (tabletPortrait ?? phone)(context),
      ScreenSize.phone => phone(context),
    };
  }
}
