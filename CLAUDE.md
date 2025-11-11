# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Foxy is a Flutter desktop application for managing AzerothCore World of Warcraft database objects. It provides a user interface for CRUD operations on game objects like creatures, items, quests, and smart scripts. The application connects to a MySQL database containing AzerothCore world data.

## Technology Stack

- **Framework**: Flutter (Desktop - Windows, Linux, macOS)
- **Database**: MySQL with AzerothCore schema
- **State Management**: Signals (replacing Riverpod)
- **Dependency Injection**: GetIt (replacing Riverpod)
- **Routing**: auto_route
- **Database Client**: mysql_client
- **Query Builder**: laconic (custom package)

## Architecture

The application follows a layered architecture:

- **Models** (`lib/model/`): Data models for database entities
- **Services** (`lib/service/`): Business logic and database operations
- **Repositories** (`lib/repository/`): Data access layer using laconic query builder
- **Pages/ViewModels** (`lib/page/`): UI pages with corresponding view models
- **Widgets** (`lib/widget/`): Reusable UI components
- **Router** (`lib/router/`): Navigation configuration using auto_route

### Key Components

- **Bootstrap**: Database connection setup and configuration
- **Scaffold**: Main application shell with navigation
- **Dashboard**: Home page with statistics and quick access
- **Template Modules**: CRUD interfaces for creature templates, items, quests, etc.

## Database Configuration

Database connection is configured via `config.yaml`:
```yaml
host: 127.0.0.1
port: "3306"
database: acore_world
username: acore
password: acore
```

## Development Commands

### Build and Run
```bash
flutter run                    # Run in development mode
flutter build windows         # Build Windows executable
flutter build linux           # Build Linux executable
flutter build macos           # Build macOS executable
```

### Code Quality
```bash
flutter analyze               # Run static analysis
flutter test                 # Run unit and widget tests
flutter clean                # Clean build artifacts
```

### Code Generation
```bash
flutter packages pub run build_runner build          # Generate auto_route files
flutter packages pub run build_runner build --delete-conflicting-outputs  # Force regenerate
```

## Database Schema

The application works with AzerothCore database tables:
- `creature_template`: NPC definitions
- `item_template`: Item definitions  
- `quest_template`: Quest definitions
- `gameobject_template`: Game object definitions
- `gossip_menu`: NPC dialogue menus
- `smart_scripts`: AI scripting system

## Important Files

- `lib/di.dart`: Dependency injection setup using GetIt
- `lib/service/service.dart`: MySQL connection wrapper and query helpers
- `lib/router/router.dart`: Application routing configuration
- `config.yaml`: Database connection configuration
- `pubspec.yaml`: Flutter dependencies and project configuration

## Development Notes

- The project is transitioning from Riverpod to GetIt + Signals for state management
- Window management is handled via window_manager package for desktop functionality
- The laconic package provides a fluent query builder interface for MySQL operations
- All database operations go through the Service mixin which handles connection management and logging