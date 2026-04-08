# Know the Drop

A Flutter trivia app about DJ Tiësto.

## Features

- 150 trivia questions across three categories: Discography, Biography, and EDM Culture
- Three difficulty levels: Casual Fan, True Fan, and Scholar
- 10 randomized questions per game
- Localized in English and Spanish
- Dark purple club-inspired UI
- Tablet support (phone, tablet portrait, tablet landscape breakpoints)

## Architecture

Clean Architecture with three layers:

- **Domain** — entities, repository interfaces
- **Data** — JSON data source, models, repository implementations
- **Presentation** — screens, providers (Riverpod), widgets

## Tech Stack

- [Flutter](https://flutter.dev)
- [Riverpod](https://riverpod.dev) — state management
- [GoRouter](https://pub.dev/packages/go_router) — navigation
- [ARB / flutter_localizations](https://docs.flutter.dev/ui/accessibility-and-internationalization/internationalization) — i18n

## Getting Started

```bash
flutter pub get
flutter gen-l10n
flutter run
```

## Credits

Background image: [Bangkok, Thailand, Party, Lights and sounds, Electronic music](https://commons.wikimedia.org/wiki/File:Bangkok,_Thailand,_Party,_Lights_and_sounds,_Electronic_music.jpg) — Wikimedia Commons / CC BY-SA 4.0
