# AGENTS.md

## Purpose and scope

This file applies to the whole repository. Foxy is a Flutter desktop application for visually editing AzerothCore 3.3.5a data. It connects to a MySQL world database, edits normal AzerothCore tables, and imports/exports client DBC data through tables in a separate `foxy` schema. The UI and most user-facing errors are Chinese.

`README.md` provides the user/developer overview and setup instructions. There is no CI configuration; use the source, contract tests, `pubspec.yaml`, `README.md`, and this file together as the repository documentation.

## Cold start

Requirements:

- Flutter stable with Dart compatible with `sdk: ^3.9.2` (`.metadata` records the Flutter project revision).
- A desktop toolchain for the target platform. Tracked runners exist for Linux, macOS, and Windows.
- MySQL only for running the application and the opt-in integration tests; the normal test suite is primarily hermetic.

Run commands from the repository root. Several tests inspect files through relative paths such as `lib/entity`, so invoking them from another working directory can give misleading failures.

```bash
flutter pub get
flutter analyze
flutter test
flutter run -d macos       # or windows/linux when available
```

The application reads and writes `config.yaml` relative to `Directory.current`, so launch it from the project root during development. That file contains connection settings, including the password, and is intentionally gitignored. Never commit it or credentials.

Useful focused commands:

```bash
flutter test test/<name>_test.dart
flutter test test/<name>_test.dart --plain-name '<exact test name>'
dart format <changed .dart files>
dart run build_runner build --delete-conflicting-outputs
flutter build macos        # or windows/linux
```

Do not globally format the repository as incidental cleanup. Format only changed Dart files and keep diffs surgical.

## Repository map

- `lib/main.dart` — Flutter entry point; initializes the desktop window, DI, and the app.
- `lib/di.dart` — central `get_it` registration for repositories, utilities, and view models.
- `lib/database/` — connection singleton and append-only application migrations.
- `lib/infrastructure/`
  - `config/` — root-relative YAML configuration.
  - `database/` — MySQL-specific error helpers.
  - `dbc/` — DBC definitions, import worker, sync orchestration, export encoding, locale codecs, and export registry.
  - `logging/`, `preferences/`, `util/`, `window/` — shared infrastructure.
- `lib/entity/` — immutable full entities, brief/list entities, and typed composite/special row keys.
- `lib/repository/` — Laconic query and persistence layer plus Repository-owned Filter query models. Most repositories map one physical table or a tightly related table family.
- `lib/use_case/` — concrete user-intent operations for cross-repository orchestration, transactions, migrations, and cancellable workflows.
- `lib/page/<module>/` — MVVM feature folders containing pages, views, view models, and occasional module validation.
- `lib/widget/` — shared shadcn-based widgets, form controllers, pickers, locale editors, tables, and dialogs.
- `lib/constant/` — AzerothCore/DBC enums, flags, schemas, and UI option definitions.
- `lib/router/` — AutoRoute configuration, navigation facade/menu model, and generated routes.
- `lib/event/` — small synchronous application event bus.
- `test/` — unit/widget tests plus extensive source-level architecture and database-editing contract tests.
- `asset/image/` — Flutter-bundled app images.
- `asset/icon/` — thousands of game icons deliberately kept out of the Flutter asset bundle.
- `linux/`, `macos/`, `windows/` — desktop runners and packaging configuration.

`build/`, `.dart_tool/`, Flutter plugin metadata, IDE state, logs, and `config.yaml` are generated/local artifacts; do not edit or commit them.

## Architecture and data flow

The normal feature flow is:

1. A `@RoutePage()` page obtains a factory-created view model from `GetIt`, calls `initSignals()` in `initState`, and disposes it with the page.
2. A view renders shadcn widgets and delegates behavior to the view model.
3. The view model owns Signals state and registered field controllers, validates a collected candidate, and calls a repository.
4. The repository maps physical SQL rows to entities through Laconic.
5. `RouterFacade` keeps AutoRoute navigation and the signal-backed breadcrumb/menu path in sync.

State management uses `signals`/`signals_flutter`; reactive widget regions use `Watch`. Dependencies are obtained through `GetIt.instance`. Register infrastructure, repositories, use cases, global state ViewModels, and interaction ViewModels in that order in `lib/di.dart`.

Every ViewModel belongs to exactly one closed category and declares it in both
the class and file suffix: `ListViewModel`, `DetailViewModel`,
`CollectionEditorViewModel`, `SingleEditorViewModel`, `ReadViewModel`,
`WorkflowViewModel`, or `StateViewModel`. Do not add an unclassified
`SomethingViewModel`, a generic/base CRUD ViewModel, or a marker hierarchy.
Global `StateViewModel` and cross-page workflow owners are singletons; ordinary
page and editor ViewModels are factories.

ViewModels own Signals, typed field controllers, candidate collection and
validation, explicit `persistedKey`/`editingKey`, and stale-response protection.
They must not accept `BuildContext`, show Dialog/Toast, navigate, access
`Database`/`Laconic`/transactions, or depend on another page ViewModel. UI
interaction surfaces own Flutter side effects. Simple single-table operations
may call a concrete Repository directly; cross-table writes, transactions,
cross-table validation, bootstrap, and cancellable long-running work belong in
a concrete `lib/use_case/` class with an `execute()` method. Do not introduce a
generic UseCase, command bus, mediator, or global UI-effect framework.

List view models commonly use a monotonically increasing `_refreshToken` to prevent stale async responses from replacing newer search/pagination results. Preserve that race protection when changing refresh logic.

## Database boundaries

`Database.instance` owns the active `Laconic` connection. Before connection, accessing `laconic` throws. Startup is coordinated by `BootstrapWorkflowViewModel` through `BootstrapApplicationUseCase`:

1. connects to the configured database (normally the AzerothCore world schema),
2. detects locale-table availability and loads locale preference,
3. creates/migrates the `foxy` schema,
4. loads feature/menu data,
5. persists connection configuration.

Table naming matters:

- Unqualified names such as `creature_template` refer to the configured world database.
- DBC mirrors use qualified names such as `foxy.dbc_spell`.
- App-owned tables use `foxy.features`, `foxy.activity_log`, and `foxy.migrations`.

Migrations are ordered explicitly in `lib/database/migration_runner.dart`. Add a new timestamped migration file, import it, and append it to the list. Do not rewrite a migration that may already be recorded in `foxy.migrations`; add a corrective migration instead. Consider that startup needs permission to create/use the `foxy` schema.

Locale joins are conditional on `RepositoryMixin.localeEnabled`; do not assume AzerothCore `*_locale` tables exist. Existing list queries generally prefer `zhCN` text when locale support is enabled and fall back to the base name.

## Entity and persistence contracts

These are deliberate repository-wide invariants, enforced by many tests.

### Full and brief entities

- Full entities are immutable data objects with `final` scalar fields, a const/default constructor, `fromJson`, `copyWith`, and `toJson` where applicable.
- JSON keys must match physical SQL/DBC column spelling and casing exactly.
- Repeated physical columns remain explicit scalar fields. Do not collapse them into lists or maps unless the database model itself requires that representation.
- List/picker queries return a dedicated `Brief...Entity` from its own file. A brief entity contains only display data and complete persisted identity; it must not expose write-model APIs such as `toJson` or `copyWith`.
- A brief entity exposes `key`. Use a plain `int` or `String` for a single-column locator. Create a dedicated immutable `...Key` value object only for composite or genuinely special locators; implement value equality and `hashCode`.
- Filter query models belong to Repository libraries and use the `...Filter`
  suffix without `Entity`. Repository-specific Filters are generated from
  repeatable `@FoxyFilter.text/integer/decimal/boolean` annotations. Standard
  persisted-row repositories use `@FoxyRepository(EntityType)` to generate
  missing public `get/store/update/destroy` row operations and physical-key
  query binding from Entity metadata. A Repository method with the same
  operation signature is a complete special implementation and suppresses
  only that generated operation; do not add thin forwarding wrappers. Do not
  share one Filter type across Repository libraries; each Repository owns its
  query contract even when field shapes currently match.

### Explicit row identity

Persisted identity and the editable candidate are intentionally separate. Primary-key fields remain editable in forms.

- `create...()` preallocates a key, usually through `RepositoryMixin.nextMaxPlusOne`, but does **not** insert a row.
- `store...()` inserts the complete candidate. It returns `Future<void>`; do not return a replacement/generated key or infer identity during save.
- `update...(originalKey, candidate)` locates the old physical row using the complete original key and writes the complete candidate, including edited key fields.
- `destroy...(key)` accepts the complete physical locator.
- Every row update/delete checks the returned matched/deleted row count and throws when it is zero. The MySQL driver is expected to use matched-row semantics, so an unchanged existing update returns `1`, while a missing row returns `0`.
- Translate duplicate-entry errors with `MysqlErrorUtil.isDuplicateEntry` when the module needs a stable user-facing message.
- Do not infer old identity from candidate values, silently ignore missing rows, add generic `save...` methods, or perform implicit cross-table deletes.
- Repositories should persist their stated table boundary. Related child/locale writes are explicit operations.

For standalone detail screens, keep `persistedKey` nullable: `null` means unsaved/create; non-null means update. Change it to the candidate key only after persistence succeeds. Inline editors use the equivalent `editingKey` rule and retain the old key after a failed save so retry still targets the original row.

Brief list queries are paginated with `kPageSize` (currently 50), and count queries must apply the same joins and filters as list queries.

## Forms, validation, and UI

- Use the typed controllers in `lib/widget/form/field_controller.dart`; declare them with `registerController(...)` and call `disposeControllers()` from the view model.
- `IntFieldController`/`DoubleFieldController` treat empty text as zero but throw `FormatException` for invalid non-empty text. Never silently coerce malformed input.
- Collect a complete candidate from controllers, then validate before calling the repository.
- Shared assertions live in `ViewModelValidationMixin`; module rules live in `lib/widget/form/validation/` or the module folder. Keep entities as data objects rather than embedding UI validation in them.
- Reuse `FoxyFormSection`, `FoxyFormItem`, typed inputs, flag/select widgets, locale widgets, `FoxyEntityPicker`, tables, tabs, pagination, and `DialogUtil` rather than introducing parallel controls.
- Add reusable picker behavior through the existing picker delegate system. Picker results should be brief entities with real physical identity.
- Preserve Chinese terminology and nearby message style for user-facing copy. Dart identifiers remain English.
- Log technical failures through `LoggerUtil`; show actionable user feedback with the existing toast/dialog patterns. Activity logging is intentionally best-effort and should not make the primary write fail.
- After `await`, check `context.mounted` before using a `BuildContext`.

## Routing and adding a module

`lib/router/router.gr.dart` is generated and tracked. Never hand-edit it. When route annotations, constructor arguments, or `router.dart` change, regenerate it with build_runner and include the generated diff.

A new navigable data module usually requires all applicable pieces below:

1. Full/brief row entities, Repository Filter, and composite-key types.
2. A repository with count/list/create/get/store/update/destroy behavior and explicit identity handling.
3. Validation mixin and tests for SQL/DBC value constraints.
4. List/detail view models, pages, and views.
5. `@RoutePage`, an `AutoRoute` child in `router.dart`, generated route output, and `RouterMenu`/feature wiring.
6. Repository and view-model registrations in `di.dart`.
7. Picker delegate registration if other modules reference it.
8. For DBC-backed modules: `dbc_definitions.dart`, export registry delegate, locale field metadata/codec as needed, and the migration that creates/seeds the `foxy.dbc_*` table or feature entry.
9. Contract tests modeled on the closest existing module.

Start by finding the nearest module with the same key shape and storage type rather than inventing a new abstraction. For example, use an existing scalar-key DBC detail module for scalar DBC work and an existing inline composite-key child editor for relation tables.

## DBC rules

DBC support targets the 3.3.5.12340/3.3.5a physical layouts asserted in tests.

- `lib/constant/dbc_definitions.dart` is the source of table-to-file/schema mappings.
- `DbcExportRegistry` must have a delegate for every exported definition.
- Entity `toJson` fields must cover the complete DBC schema; round-trip and export-field tests enforce this.
- Import orchestration is in `dbc_sync_util.dart`, while parsing/database work occurs in `dbc_import_worker.dart`. Keep isolate messages serializable and aggregate per-file failures rather than losing partial results.
- Imports currently target the hard-coded `foxy` schema. Do not run destructive integration work against a real/default `foxy` schema from tests.
- DBC filename matching is case-insensitive.

Game icons in `asset/icon/` are intentionally loaded from the filesystem beside the executable (`data/icon/`) by `FoxyGameAssetIcon`, not through `Image.asset`. Do not add this large directory to `pubspec.yaml`. The current explicit copy rule is in `windows/runner/CMakeLists.txt`; if changing other platform packaging, verify equivalent `data/icon` placement rather than bundling all icons.

## Testing expectations

Tests are part of the design specification. Many contract tests read Dart source and assert method names, signatures, selected columns, exact identity flow, DI/route/registry coverage, and even the absence of prohibited APIs. Preserve the established shapes rather than working around those assertions.

For a change:

1. Run the closest focused contract/unit/widget test while iterating.
2. Add a regression test for a bug or a contract test for a new table/module.
3. Format only changed Dart files.
4. Run `flutter analyze`.
5. Run `flutter test`, and report any baseline or environment-dependent failure clearly.

MySQL integration is opt-in and guarded against the real `foxy` schema:

```bash
FOXY_TEST_MYSQL=1 \
FOXY_TEST_MYSQL_FOXY_SCHEMA=foxy_test_isolated \
FOXY_TEST_MYSQL_HOST=127.0.0.1 \
FOXY_TEST_MYSQL_PORT=3306 \
FOXY_TEST_MYSQL_USERNAME=root \
FOXY_TEST_MYSQL_PASSWORD=... \
flutter test test/dbc_mysql_integration_test.dart
```

The schema must be non-empty, alphanumeric/underscore only, and not named `foxy`. The test creates and drops its own `_foxy_write_result_contract` table there.

### Known baseline quirks

At the time this guide was generated:

- `flutter analyze` passes.
- The full suite passes all other tests but fails `test/dbc_sync_util_test.dart` test `DBC 导入：同一定义匹配多个文件时报错` on the default case-insensitive macOS filesystem. `SpellDuration.dbc` and `SpellDuration.DBC` cannot coexist, so the test reaches the intentionally invalid MySQL connection instead of detecting duplicates. The test only skips Windows. Do not attribute this pre-existing failure to unrelated changes; still report it.
- Five MySQL integration tests are skipped unless the environment variables above are supplied.
- A repository-wide format check currently flags only `test/macos_file_selector_entitlements_test.dart`; do not reformat that unrelated file as part of another task.
- Some widget tests intentionally log error stack traces while verifying failure UI; an error log is not itself a test failure—use the final test status.

## Change discipline

- Keep changes limited to the requested behavior; this is a large repetitive codebase where broad cleanup creates noisy risk.
- Match local naming, formatting, import style, and Chinese copy.
- Do not edit generated route code, generated plugin registrants, build output, or local config by hand.
- Do not change physical SQL/DBC column names, key shapes, flags, enum values, or table boundaries without checking the relevant contract tests and AzerothCore/DBC semantics.
- When a change makes one of your imports/controllers/registrations obsolete, remove that orphan; do not clean up unrelated existing code.
- Use conventional commit-style subjects if asked to commit; recent history uses forms such as `feat:`, `fix:`, `refactor(database):`, and `test(repository):`.
