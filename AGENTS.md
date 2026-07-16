# AGENTS.md — Foxy repository guide

This file is the cold-start guide for AI coding agents working in this repository. Treat the current source and tests as the final authority; there is no separate checked-in README or `docs/` tree.

## 1. What this project is

Foxy is a Chinese-language Flutter desktop application for visually editing an AzerothCore / World of Warcraft 3.3.5a world database. It manages creatures, items, quests, game objects, gossip, SmartAI, conditions, spells, talents, achievements, and related tables. It also imports client DBC files into a companion MySQL schema and exports those mirror tables back to `.dbc` files.

- Package: `foxy`
- Current version: `1.0.0+431`
- Dart constraint: `^3.9.2`
- Primary target: Windows desktop; Linux and macOS runners are present.
- UI and user-facing errors are primarily Chinese. Match the surrounding language.
- License: MIT.

Two schemas are used through one MySQL connection:

- The configured world schema, normally `acore_world`. Unqualified repository table names such as `creature_template` resolve here.
- The fixed `foxy` schema. It contains migrations, application metadata, activity logs, features, and `dbc_*` mirror tables. Always fully qualify these tables, for example `foxy.dbc_spell`.

## 2. Cold-start commands

Run commands from the repository root; several tests read source files through relative paths.

```bash
flutter pub get
flutter analyze
flutter test
```

Useful focused commands:

```bash
# Format only files touched by the task.
dart format path/to/changed.dart test/path/to/changed_test.dart

# Run the closest contract or widget test first.
flutter test test/area_table_contract_test.dart

# Regenerate auto_route output after changing router.dart or @RoutePage pages.
dart run build_runner build --delete-conflicting-outputs

# Primary runtime target.
flutter run -d windows

# Other checked-in desktop runners.
flutter run -d macos
flutter run -d linux
```

Do not edit generated/cache output in `.dart_tool/`, `build/`, or platform `flutter/ephemeral/` directories.

### Current test baseline

At the time this guide was created (2026-07-16):

- `flutter analyze` passes with no issues.
- The full suite runs roughly 300 tests, with the MySQL worker integration group skipped unless explicitly enabled.
- One existing test fails even in isolation: `test/dbc_sync_util_test.dart`, case `DBC 导入：同一定义匹配多个文件时报错`. It expects an error containing `多个`, but the worker instead attempts a localhost MySQL connection and reports `Connection refused`.
- Some negative-path tests intentionally print `[ERROR]` logs and stack traces while still passing. Judge the final test summary, not the presence of log output alone.

Do not hide a new regression behind the known DBC failure. Run the nearest tests independently, and report the known baseline separately from failures caused by your change. There is no checked-in CI workflow, so local analysis and tests are the release gate.

The reserved MySQL integration test is gated by both:

```text
FOXY_TEST_MYSQL=1
FOXY_TEST_MYSQL_FOXY_SCHEMA=<an isolated schema name other than foxy>
```

Never point destructive/integration work at the default `foxy` schema or a real world database.

## 3. Technology map

| Concern | Package / implementation |
| --- | --- |
| UI | Flutter Material plus `shadcn_ui` |
| Icons | `lucide_icons_flutter` |
| Reactive state | `signals` and `signals_flutter`; widgets generally subscribe with `Watch` |
| Dependency injection | `get_it`, registrations centralized in `lib/di.dart` |
| Routing | `auto_route`; generated output is `lib/router/router.gr.dart` |
| Database | `laconic` with `laconic_mysql` |
| DBC parsing/writing | `warcrafty` |
| Desktop window | `window_manager` |
| Local settings | YAML through `yaml` / `yaml_edit`, plus `shared_preferences` for window size |
| File selection | `file_selector` |
| Analysis | `flutter_lints`; no project-specific lint overrides |
| Tests | `flutter_test`, including unit, widget, source-contract, and guarded integration tests |

## 4. Repository layout

```text
lib/
├── main.dart                 App entry: Flutter binding → window init → DI → FoxyApp
├── di.dart                   All GetIt registrations
├── constant/                AzerothCore/DBC enums, flags, value sets, DBC schemas
├── database/
│   ├── database.dart         MySQL/Laconic connection singleton
│   ├── migration_runner.dart Migration interface, ordered registry, foxy bootstrap
│   └── migration/            Timestamp-named foxy schema migrations
├── entity/                  Immutable full, brief, filter, locale, and support entities
├── event/                   EventBus and activity events
├── infrastructure/
│   ├── config/              Root-local config.yaml persistence
│   ├── dbc/                 DBC definitions plumbing, worker, import/export, locale codec
│   ├── logging/             Logger wrapper
│   ├── preferences/         Window-size SharedPreferences wrapper
│   ├── util/                Small stateless parsing/formatting helpers
│   └── window/              Desktop window initialization
├── page/
│   ├── bootstrap/           MySQL connection/bootstrap flow
│   ├── foxy_app/            Root app and global locale state
│   ├── scaffold/            Main shell, navigation, startup DBC checks
│   ├── dashboard/           Home/activity/version display
│   ├── setting/             DBC import/export UI
│   └── <domain>/            Domain pages, views, validation mixins, and ViewModels
├── repository/              One data-access class per physical table in most cases
├── router/                  Route config, generated routes, menus, facade, breadcrumbs
└── widget/                  Shared UI, entity pickers, forms, tables, dialogs, locale UI

test/                        Unit/widget/contract/integration tests
test/support/                Shared test helpers
asset/image/                 Flutter-bundled bootstrap/dashboard images
asset/icon/                  Large game-icon set copied beside the Windows executable
windows/, macos/, linux/      Desktop runner projects
```

Do not recreate a top-level `util/` directory. Cross-domain non-UI helpers belong under `lib/infrastructure/`; UI helpers belong under `lib/widget/`; domain-specific behavior stays with its page/repository/entity area.

## 5. Runtime flow

`lib/main.dart` performs initialization in this order:

1. `WidgetsFlutterBinding.ensureInitialized()`
2. `WindowInitializer.ensureInitialized()`
3. `DI.ensureInitialized()`
4. Disable the global `SignalsObserver`
5. `runApp(FoxyApp())`

The initial route is `BootstrapRoute`. `BootstrapViewModel.connect`:

1. Parses and validates the MySQL port.
2. Connects `Database.instance`; SQL is sent to `LoggerUtil`.
3. Reads server/core version information.
4. Detects world `*_locale` tables and initializes global locale settings.
5. Runs `MigrationRunner`, which creates `foxy` and `foxy.migrations` if needed and applies registered migrations in order.
6. Loads feature/menu metadata.
7. Saves connection values to `config.yaml`.
8. Replaces the route stack with `DashboardRoute`.

`Database.instance.laconic` throws until a connection exists. Most repository code cannot be exercised without either this bootstrap or a test-installed database setup.

`config.yaml` lives in the current working directory and may contain:

```yaml
host: 127.0.0.1
port: "3306"
database: acore_world
username: ...
password: ...
dbc_path: ...
locale_enabled: true
```

It is gitignored because it contains credentials. Never commit it, print its secrets, or replace it with a tracked fixture.

## 6. Architecture and dependency boundaries

The normal feature flow is:

```text
Page / shared Widget
        ↓
ViewModel (signals + FieldControllers)
        ↓
Repository (Laconic queries and referential integrity)
        ↓
Entity / Filter / Brief Entity
        ↓
Database.instance → MySQL
```

`infrastructure/` provides cross-cutting runtime services rather than an extra mandatory layer in every call chain.

### DI lifetimes

Follow `lib/di.dart` exactly:

- `RouterFacade`, `FoxyViewModel`, `EventBus`, and `ScaffoldViewModel` are persistent singletons.
- Repositories and infrastructure utilities are lazy singletons.
- Most page/list/detail ViewModels are factories so reopening a page gets fresh controllers and signals.
- Add every new repository and ViewModel to `DI`; a class existing on disk does not make it injectable.
- Existing code obtains dependencies with `GetIt.instance.get<T>()`; match the adjacent module instead of introducing a second injection style.

### State and lifecycle

- Use `signal(...)` for mutable ViewModel state and `Watch((_) => ...)` in reactive UI.
- Form ViewModels normally mix in `FieldControllerMixin` and declare fields with `registerController(...)`.
- Use `IntFieldController`, `DoubleFieldController`, `StringFieldController`, `FlagFieldController`, and `SelectFieldController<T>` according to the physical field.
- Initialize all controllers from the loaded entity, collect all editable values on save, and call `disposeControllers()` from `dispose()`.
- Numeric field parsing is strict: an empty input becomes zero, malformed input throws `FormatException`. Do not reintroduce silent `tryParse(...) ?? 0` in ViewModels.
- Preserve non-rendered database columns by collecting with `loadedEntity.copyWith(...)`, not by constructing a partial replacement entity.

## 7. Database, entity, and validation invariants

These conventions are heavily enforced by contract tests.

### Entities mirror physical storage

- Entities are immutable data classes with `final` scalar fields, a `const` constructor with database-compatible defaults, `fromJson`, `toJson`, and usually `copyWith`.
- Dart camelCase names map explicitly to exact MySQL/DBC column spelling and case.
- `toJson()` key order frequently represents the physical column order and is asserted in tests.
- DBC numeric values that may arrive as either integer or floating-point should use `(json['Column'] as num?)?.toDouble()` where appropriate.
- Repeated physical slots must remain explicit scalar fields (`itemId1`, `itemId2`, etc.). Do not replace them with `List`, `Map`, loops, `List.generate`, or index-based dispatch merely to reduce code. Tests intentionally enforce explicit physical columns in Entity, ViewModel, and UI.
- Brief entities contain only list/picker columns. Filter entities generally store text-field input as `String`.
- Entities must remain pure data objects. Do not add `validate()` methods or business/database dependencies to them.

### Validation belongs with ViewModels

- Shared assertions are in `lib/widget/form/view_model_validation_mixin.dart`.
- Reusable entity-field rules are in `lib/widget/form/validation/*_validation_mixin.dart` or a domain validation mixin beside the page, and expose methods such as `validateFooFields`.
- The detail ViewModel composes the relevant validation mixins and validates after collecting controllers but before any write.
- Pure range, flags, enum, and cross-field checks do not belong in repositories.
- Database-backed uniqueness, foreign-key existence, and reverse-reference deletion protection use repository query methods. Some repositories enforce referential integrity inside `store*`, `update*`, or `destroy*`; follow the closest domain precedent.
- Error messages use `StateError` and are user-facing Chinese in existing modules.

Before changing validation, read both the module's contract test and `test/view_model_validation_contract_test.dart`.

### Repository conventions

Most repositories mix in `RepositoryMixin`, which supplies:

- `laconic`
- `kPageSize = 50`
- `nextMaxPlusOne(...)`
- the global world-locale toggle

Public repository methods are kept in consistent alphabetical CRUD order, followed by private helpers in alphabetical order. Typical names are:

```text
copyFoo
countFoos
createFoo
destroyFoo
getBriefFoos
getFoo / getFoos
saveFoo
storeFoo
updateFoo
_applyFilter / _getNextId / _validateReference
```

Do not introduce synonyms such as `searchFoo`, `deleteFoo`, or `insertFoo` when the established CRUD name applies.

Key behavior:

- List pages and entity pickers use `getBrief*` plus `count*`, pagination, and `kPageSize`; they must not load full tables.
- Full `getFoos()` methods are primarily for DBC export/batch work.
- `createFoo()` creates an unsaved entity and commonly preallocates a read-only key with `MAX(column) + 1`.
- `storeFoo()` preserves a positive preallocated ID, allocating only if needed, and returns the final ID when callers need to update UI/route state.
- Primary keys are read-only in the UI. Do not calculate `MAX+1` in a ViewModel.
- `updateFoo()` removes immutable key columns from the JSON update payload.
- `destroyFoo()` may first protect reverse references.
- Compound-key child repositories must filter/update/delete by every key component.
- Use `comparator: 'like'` and `%...%` for text filters. Escape/quote reserved columns as the neighboring repository does; `rank` is a known MySQL reserved word.
- Keep all `foxy`/DBC table names fully qualified. Do not qualify normal world tables with a hard-coded `acore_world` schema because the world schema is configurable.

Activity logging after a successful business write normally uses `ActivityLogRepository.storeActivityLogBestEffort`; logging failure must not turn a successful save into a failed save.

## 8. Locale and DBC rules

There are two distinct locale models:

1. AzerothCore world tables use separate `*_locale` rows. Whether list repositories join these tables is controlled globally by `FoxyViewModel.localeEnabled`; the current `RepositoryMixin` → `FoxyViewModel` lookup is an existing narrow exception to the usual dependency direction.
2. DBC mirror tables are wide tables with fixed language columns (typically 16 locale columns plus flags). They use `DbcLocaleRepositoryMixin`, `DbcLocaleFieldDefinition`, and `DbcLocaleFieldCodec`. Pages must call repository `get*Locales` / `save*Locales` APIs rather than querying Laconic directly.

When adding or changing a DBC table, audit all of these together:

- Exact `DbcDefinition` schema and file name in `lib/constant/dbc_definitions.dart`
- Locale field definitions in `lib/constant/dbc_locale_fields.dart`, if applicable
- Entity `fromJson` / `toJson` physical field coverage and order
- A repository using a fully qualified `foxy.dbc_*` table
- Repository registration in `lib/di.dart`
- Export registration in `lib/infrastructure/dbc/dbc_export_registry.dart`
- Picker delegate registration if other forms reference it
- DBC definition/export/entity tests

DBC import runs in an isolate. Preserve progress/error stream completion and anti-reentrancy behavior when touching `dbc_sync_util.dart` or `dbc_import_worker.dart`.

## 9. Routing and navigation

- Route declarations live in `lib/router/router.dart`.
- Pages exposed to auto_route have `@RoutePage()`.
- `lib/router/router.gr.dart` is generated **and tracked**. Regenerate it after route/page annotation changes; do not hand-edit it.
- Feature navigation should go through `RouterFacade`, which owns the route stack's breadcrumb `path` signal and active menu calculation.
- Use `navigateToMenu`, `navigateToDetail`, `replaceCurrentDetail`, `navigateToBreadcrumb`, and `goBack` as appropriate.
- The bootstrap flow's direct `AutoRouter.replaceAll([DashboardRoute()])` is intentional because it clears connection history; it is not the pattern for ordinary feature navigation.
- Add visible top-level features to `RouterMenu` and, when applicable, to migration-backed `foxy.features` data.

## 10. UI conventions

- Reuse Foxy wrappers before reaching for raw shadcn/Material widgets: `FoxyShadTable`, `FoxyPagination`, `FoxyTab`, `FoxyFormItem`, `FoxyFormSection`, number/string inputs, flag picker, and entity/locale pickers.
- Use `FoxyEntityPickerDelegates` for references rather than duplicating picker queries.
- Existing detail forms often require rows of exactly four equal `Expanded` children. Source-contract tests count these structures, so inspect the module's test before changing layout or abstracting repeated fields.
- Use `ShadSonner` / `ShadToast` for save feedback.
- Use `DialogUtil.instance` or `showFoxyDialog` for dialogs. Do not call `showShadDialog` directly; its default opaque route can stop the underlying page from painting.
- Check `context.mounted` after awaited work before using context.
- Preserve Chinese labels and error messages in Chinese-facing modules.
- Match local declaration/import ordering. Recent repository style intentionally orders public methods consistently and places private methods after them; do not create noisy reorder-only diffs.

`asset/icon/` contains thousands of game icons and is deliberately not listed as a Flutter asset bundle. `windows/runner/CMakeLists.txt` copies it to `data/icon` beside the executable, and `FoxyGameAssetIcon` loads files from there. Do not add the directory wholesale to `pubspec.yaml`; doing so would greatly inflate/rebuild the Flutter asset bundle. `asset/image/` is the bundled image directory.

## 11. Migrations

Migrations modify the companion `foxy` schema, not AzerothCore's installed schema.

To add one:

1. Create `lib/database/migration/migration_YYYYMMDDNNNN.dart` implementing `Migration`.
2. Give it a unique stable `name`.
3. Import and append it in chronological order in `MigrationRunner.run()`.
4. Make rerun behavior safe where practical, even though successful names are recorded in `foxy.migrations`.
5. Test against an isolated schema; never drop or rebuild a user's default `foxy` schema during automated tests.

Do not alter an already-applied migration to perform new production work; add a new migration.

## 12. Testing strategy

For a bug fix, add or adjust the smallest test that reproduces the behavior before changing implementation. For a new domain feature, expect tests at several levels:

- Entity round-trip and exact physical key coverage
- Constants/enums/flags and 3.3.5a value ranges
- Validation mixin behavior
- Repository query/reference/deletion contracts
- ViewModel controller initialization/collection/save behavior
- UI picker/control/layout contracts
- DBC definition/export registration where relevant
- Widget behavior for reusable components

A large portion of this suite uses `dart:io` to inspect source text. These are intentional architecture/explicitness contracts, not snapshots to bypass. If a source-string assertion fails, understand the invariant before changing the assertion. Keep test files running from the project root.

Recommended verification sequence:

```bash
# 1. Focused tests for the changed domain
flutter test test/<closest_test>.dart

# 2. Static analysis
flutter analyze

# 3. Full suite, accounting for the documented baseline failure
flutter test

# 4. Review generated and unrelated changes
git status --short
git diff --check
git diff --stat
git diff
```

## 13. Feature implementation checklist

Use the nearest complete domain as the template; `area_table`, `gem_property`, `quest_info`, and `talent` demonstrate different combinations of DBC data, validation, references, locale, and CRUD.

1. Confirm the exact AzerothCore/DBC 3.3.5a physical schema and semantics.
2. Add constants/enums/flags only where a dedicated value domain exists.
3. Add full, brief, filter, and locale entities as needed; preserve exact scalar columns.
4. Add field-validation mixins and tests; keep Entities pure.
5. Add the repository with pagination, ID allocation, reference checks, and deletion protection.
6. Add list/detail ViewModels and views using registered FieldControllers and Foxy widgets.
7. Add entity picker delegates for new reference targets.
8. Register repository and ViewModels in `lib/di.dart` with the correct lifetimes.
9. Add routes/menu entries, then regenerate `router.gr.dart`.
10. Add a new migration if `foxy` metadata/schema must change.
11. For DBC data, complete the definition, locale, DI, and export registry chain.
12. Add/update contract tests and run focused analysis/tests before the full suite.

## 14. High-risk pitfalls

- Never commit `config.yaml` or credentials.
- Never use a live/default database for integration tests or destructive migration experiments.
- Do not assume IDs are auto-incremented; many game/DBC keys are allocated in application code.
- Do not enable related child tabs until a new parent record has a real persisted key.
- Do not collapse repeated database columns into collections or generated UI loops when contract tests require explicit fields.
- Do not put field validation back on Entities or silently coerce malformed numeric input.
- Do not query full DBC tables for list pages or pickers.
- Do not hard-code `acore_world`; only `foxy.*` is fixed.
- Do not bypass `RouterFacade` for normal feature navigation.
- Do not hand-edit `router.gr.dart`.
- Do not bundle all of `asset/icon/` through Flutter assets.
- Do not treat expected negative-test logger output as a failure without checking the test result.
- Keep changes surgical: this repository has large, mechanically explicit entities and tests, so unrelated formatting or abstraction creates expensive review noise.
