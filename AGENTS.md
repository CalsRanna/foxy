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
├── entity/                  Immutable full, key, brief, filter, locale, and support entities
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
Repository (Laconic queries and single-table persistence)
        ↓
Entity / Key / Filter / Brief Entity
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
- Detail routes pass the module's locator only as the initial load argument: a database-compatible scalar for an ordinary single-column locator, or a dedicated `FooKey` for a compound or special locator. The detail ViewModel owns a `persistedKey` signal as the runtime source of truth for the currently stored row; pages and child tabs watch it after create or primary-key changes instead of reading stale constructor arguments or replacing the route.
- Form ViewModels normally mix in `FieldControllerMixin` and declare fields with `registerController(...)`.
- Use `IntFieldController`, `DoubleFieldController`, `StringFieldController`, `FlagFieldController`, and `SelectFieldController<T>` according to the physical field.
- Initialize all controllers from the loaded entity, collect all editable values on save, and call `disposeControllers()` from `dispose()`.
- Standalone detail ViewModels keep the current persisted row locator in `persistedKey`. Inline child-table editors have no detail route and instead keep the selected Brief row's original locator in a separate `editingKey`; they must never use the edited candidate key to locate the old child row.
- Every physical column represented by a full detail entity's `toJson()` belongs to the editable candidate and must have an editable form control. Do not keep a permanently read-only control for an `AUTO_INCREMENT` column, a column with a database default, a primary key, or a vague module-level semantic restriction.
- A physical field may be temporarily disabled only when an explicit current type or mode does not use that field. When the type or mode makes the field applicable, the control must become editable again.
- Brief/list query aliases and computed display getters are presentation data, not read-only detail fields. Keep them outside the full detail candidate and do not create disabled form controls for them.
- Numeric field parsing is strict: an empty input becomes zero, malformed input throws `FormatException`. Do not reintroduce silent `tryParse(...) ?? 0` in ViewModels.
- While a legacy module is still being refactored, preserve any not-yet-rendered physical columns with `loadedEntity.copyWith(...)` rather than constructing a partial replacement entity. This is a transition safeguard against data loss, not permission to leave candidate columns without editable controls in the completed module.

## 7. Database, entity, and validation invariants

These conventions are heavily enforced by contract tests.

### Entities mirror physical storage

- Entities are immutable data classes with `final` scalar fields, a `const` constructor with database-compatible defaults, `fromJson`, `toJson`, and usually `copyWith`.
- Dart camelCase names map explicitly to exact MySQL/DBC column spelling and case.
- `toJson()` key order frequently represents the physical column order and is asserted in tests.
- DBC numeric values that may arrive as either integer or floating-point should use `(json['Column'] as num?)?.toDouble()` where appropriate.
- Repeated physical slots must remain explicit scalar fields (`itemId1`, `itemId2`, etc.). Do not replace them with `List`, `Map`, loops, `List.generate`, or index-based dispatch merely to reduce code. Tests intentionally enforce explicit physical columns in Entity, ViewModel, and UI.
- Every editable module exposed through a list, entity picker, editable child-table list, or detail navigation must define a dedicated Brief Entity. Do not use the Full Entity as a list-row substitute, even when no Brief Entity exists yet; add the missing Brief Entity as part of the module refactor.
- Brief entities contain only displayed list/picker columns plus every column required by the table's row locator, including locator columns that are not rendered. Each Brief Entity exposes a semantic `key`: the exact physical scalar type for an ordinary single-column locator, or a dedicated `FooKey` covering every column of a compound or special locator. Filter entities generally store text-field input as `String`.
- An ordinary single-column, non-null `PRIMARY KEY` (or qualifying single-column `UNIQUE` constraint) uses its database-compatible Dart scalar directly when normal MySQL equality is sufficient. Do not create a nominal wrapper, typedef, or extension type merely to rename that scalar.
- A dedicated `FooKey` is required when the physical locator contains multiple columns or needs nullable, null-safe, binary-text, full-row, `LIMIT 1`, or another reviewed special comparison strategy. It normally contains every physical `PRIMARY KEY` column; if a table has no primary key, use every column of a declared non-null `UNIQUE` constraint. Do not silently invent a subset from field names.
- The existing `playercreateinfo_cast_spell` table has neither a primary key nor a unique constraint. Its explicit exception is a strongly typed full-row locator containing `raceMask`, `classMask`, `spell`, and the exact nullable `note`; update and delete use every original value plus `LIMIT 1`. Refactor its Full Entity, Brief Entity, Key, controller, and `toJson()` so database `NULL` remains distinguishable from `''` and the UI can explicitly preserve or choose either value. Nullable comparisons use MySQL's null-safe equality, and text comparisons use binary semantics so collation does not select a visibly different row. Brief rows for this table therefore contain all physical columns. Use a parameterized result-returning raw write if the Laconic query builder cannot compile write limits; never interpolate values into SQL. Future keyless tables require an equally explicit reviewed strategy rather than a generic Map/reflection fallback.
- Every retained dedicated `FooKey` is an immutable value object and must explicitly implement `operator ==` and `hashCode` from all locator fields. Equality must not rely on object identity or omit any compound-key component.
- Do not use `Map<String, dynamic>` to represent or pass a dedicated key or row locator. This restriction is specific to locators; it does not prohibit unrelated legitimate Map usage elsewhere in the project.
- Entities must remain pure data objects. Do not add `validate()` methods or business/database dependencies to them.

### Validation belongs with ViewModels

- Shared assertions are in `lib/widget/form/view_model_validation_mixin.dart`.
- Reusable entity-field rules are in `lib/widget/form/validation/*_validation_mixin.dart` or a domain validation mixin beside the page, and expose methods such as `validateFooFields`.
- The detail ViewModel composes the relevant validation mixins and validates after collecting controllers but before any write.
- Pure range, flags, enum, and cross-field checks do not belong in repositories.
- Database-backed uniqueness within the table currently being edited uses repository query methods.
- Primary-key conflict prechecks are optional for create only. Updates do not precheck the candidate key because Dart equality may not match MySQL collation semantics and a precheck is inherently racy; execute the update and translate the database unique-constraint error instead.
- Foxy deliberately does not enforce cross-table referential integrity. Do not query other tables to validate foreign-key existence, scan reverse references, block a write/delete because another table may refer to the value, or cascade changes into related tables. The user is responsible for cross-table effects, like in a general database client; actual MySQL constraints still apply.
- Existing cross-table existence checks and reverse-reference deletion protection are legacy behavior. Remove them when refactoring the affected module instead of copying them into new code.
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
_applyFilter / _getNextId / _validateUnique
```

Do not introduce synonyms such as `searchFoo`, `deleteFoo`, or `insertFoo` when the established CRUD name applies.

Key behavior:

- List pages, entity pickers, and editable child-table lists use `getBrief*` plus `count*`, pagination, and `kPageSize`; they must not load full tables. A `getBrief*` method must return `Future<List<BriefFooEntity>>`, never `Future<List<FooEntity>>`.
- Brief queries explicitly select only displayed columns plus every row-locator column. Viewing details, copying, and deleting pass `brief.key` rather than loose scalar arguments or maps.
- Full `getFoos()` methods are primarily for DBC export/batch work.
- `createFoo()` creates an unsaved entity and preallocates any key that the database would otherwise generate during insert. For an editable `AUTO_INCREMENT` primary key, this preallocation is mandatory and must produce an explicit nonzero value before the form opens. The preallocated key is only an editable form default; do not calculate `MAX+1` in a ViewModel.
- The entity collected from the form is the final candidate data. `storeFoo()` returns `Future<void>` and inserts that candidate exactly as supplied; it must not allocate, replace, normalize, or otherwise change its primary key during save. For an editable `AUTO_INCREMENT` key, reject an insert candidate whose value such as `0` or `NULL` would trigger implicit database allocation. Do not use `insertAndGetId()` to repair the candidate after insertion. This rule does not apply to internal append-only tables such as the activity log that have no editable detail candidate.
- Copy flows must allocate their new explicit key and construct the complete copy candidate before calling `storeFoo()`; insertion must not choose or return a different key.
- Every physical column in the full detail candidate is editable in the UI, including primary keys and explicitly writable `AUTO_INCREMENT` columns. Being a primary key, having a database default, or normally receiving an automatically allocated value is never by itself a reason to make a field read-only.
- `updateFoo()` receives the original complete locator separately for its `WHERE` clause—a scalar for an ordinary single-column locator or a dedicated Key for a compound/special locator—and writes the complete candidate payload, including changed primary-key columns. It consumes Laconic's update result internally: `matchedRows == 0` means the original row no longer exists, while `matchedRows == 1 && changedRows == 0` is still success. Its public return type remains `Future<void>`.
- Do not use the candidate's current key to infer create versus update. The presence of an original key in the detail ViewModel determines the operation.
- For create, an optional candidate-key precheck may improve the error message, but the database unique constraint remains the final concurrency guarantee. Do not perform an update-key conflict precheck.
- `destroyFoo()` deletes the located row from the current table without scanning reverse references or cascading into other tables. It consumes Laconic's delete result and reports a missing original row when `deletedRows == 0`; activity logging runs only after an actual delete.
- Compound-key child repositories must filter/update/delete by every key component.
- Each Repository write method mutates exactly one physical table. A ViewModel may coordinate separate Repository calls, and may wrap explicitly edited base/locale candidates in one transaction, but a Repository must not automatically save locale rows or child rows because a parent key changed.
- Use `comparator: 'like'` and `%...%` for text filters. Escape/quote reserved columns as the neighboring repository does; `rank` is a known MySQL reserved word.
- Keep all `foxy`/DBC table names fully qualified. Do not qualify normal world tables with a hard-coded `acore_world` schema because the world schema is configurable.

Activity logs use their own auto-increment `id` as the log row's primary key. They do not store or model the business record's primary key: do not add an `entityId`, `entity_id`, full `FooKey`, representative integer, or stable key encoding for the target record. Each caller supplies a human-readable target label instead. Remove the legacy `entity_id` column through a new migration rather than editing an already-applied migration. Logging after a successful business write normally uses `ActivityLogRepository.storeActivityLogBestEffort`; logging failure must not turn a successful save into a failed save.

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
- Use `navigateToMenu`, `navigateToDetail`, `navigateToBreadcrumb`, and `goBack` as appropriate. Do not replace or rebuild a live detail route after save; update its ViewModel `persistedKey` signal and the breadcrumb label signal instead.
- `RouterNode` contains navigation state actually consumed by breadcrumbs and routing; it does not carry a redundant string `id`. Initial detail identity is represented by `PageRouteInfo` arguments containing the module's scalar or dedicated locator, while the live page identity comes from its ViewModel `persistedKey` signal. Do not add string serialization or a stable-encoding API merely for routing.
- `RouterFacade.replaceCurrentDetail` and `RouterNode.id` are legacy unused/rebuild-oriented APIs and must be removed during this refactor.
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

- Full Entity round-trip and exact physical column coverage
- Brief Entity displayed-column coverage, complete row-locator coverage, and typed `key` construction
- Strongly typed Key equality and `hashCode` coverage across every row-locator field
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
3. Add full, locator, filter, and locale entities as needed. Use the exact scalar type for an ordinary single-column locator; add a dedicated immutable Key for compound or special locators. A dedicated Brief Entity is mandatory for every list/picker/editable child-table/detail-navigation flow; it must contain every row-locator column and expose a semantic `key` with that scalar or dedicated type. Preserve exact scalar columns and follow the reviewed full-row-locator exception for a table without a primary or unique key.
4. Add field-validation mixins and tests; keep Entities pure.
5. Add the repository with pagination, ID allocation, current-table uniqueness checks, and single-table CRUD. Do not add cross-table reference checks or deletion protection.
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
