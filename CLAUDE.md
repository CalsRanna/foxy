# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**Foxy** is a desktop Flutter application for World of Warcraft database management, designed as "做最好的魔兽世界编辑器". It provides tools for managing creatures, items, quests, game objects, and smart scripts through a MySQL connection to WoW databases.

## Development Commands

### Setup & Installation
```bash
flutter pub get
flutter pub run build_runner build
```

### Development Server
```bash
# Desktop
desktop-run

# Web
flutter run -d chrome

# Mobile
flutter run
```

### Build Commands
```bash
# Desktop builds
flutter build windows
flutter build macos
flutter build linux

# Web build
flutter build web

# Mobile builds
flutter build apk
flutter build ios
```

### Code Generation
```bash
# Generate all code
flutter pub run build_runner build

# Watch for changes
flutter pub run build_runner watch

# Clean generated files
flutter pub run build_runner clean
```

### Testing
```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/widget_test.dart
```

## Architecture Overview

### Tech Stack
- **State Management**: Signals (reactive state management) - migrated from Riverpod
- **Navigation**: AutoRoute for type-safe routing
- **Database**: MySQL (primary) + Isar (local settings)
- **DI**: GetIt service locator
- **Platform**: Desktop-first (Windows, macOS, Linux)

### Key Entry Points
1. `main.dart` → Bootstrap initial setup
2. `lib/page/bootstrap/` → Configuration wizard
3. `lib/page/scaffold/` → Main application interface

### Directory Structure
```
lib/
├── page/           # Feature-based UI pages
├── provider/       # Signals state management (legacy: Riverpod providers)
├── service/        # Business logic & database access
├── model/          # Data models
├── schema/         # Isar database schemas
├── router/         # AutoRoute navigation
└── util/           # Utilities
```

### State Management Patterns
- **Global State**: Signals for reactive state management across the app
- **Local UI State**: Signals package for reactive components
- **Services**: GetIt registration for database and business logic

### Database Architecture
- **MySQL**: Primary WoW database connection via `mysql_client`
- **Isar**: Local encrypted storage for settings and configuration
- **Service Pattern**: Each entity has dedicated service (CreatureTemplateService, etc.)
- **Query Style**: Raw SQL with parameterized queries, locale joins for zhCN support

### Code Generation
- **AutoRoute**: Generates `router.gr.dart` for type-safe navigation
- **Isar**: Generates database schemas from model annotations
- **Legacy**: Riverpod previously generated `*.g.dart` files (being phased out)

## Common Development Tasks

### Adding New Routes
1. Add route to `lib/router/app_router.dart`
2. Run `flutter pub run build_runner build`
3. Import generated route in `router.gr.dart`

### Adding New State Signals
1. Create signals in appropriate service or page file
2. Use `signal()` for reactive state
3. Use `computed()` for derived state
4. No code generation needed for Signals

### Database Operations
1. Create service in `lib/service/`
2. Extend base `Service` mixin for MySQL operations
3. Use existing patterns for pagination and search

### UI Development
1. Create page in appropriate `lib/page/` subdirectory
2. Use existing component patterns from scaffold/
3. Follow established responsive design for desktop

## Configuration Files

- **Database**: Configure MySQL via UI bootstrap process
- **Window Settings**: Custom window management in `lib/util/window_initializer.dart`
- **Locale**: Chinese (zhCN) support built-in
- **Build**: Desktop-specific configurations in platform directories