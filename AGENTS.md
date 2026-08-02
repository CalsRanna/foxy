# AGENTS.md

## Purpose and scope

This file applies to the whole repository. Foxy is a Flutter desktop application for visually editing AzerothCore 3.3.5a data. It connects to a MySQL world database, edits normal AzerothCore tables, and imports/exports client DBC data through tables in a separate `foxy` schema. The UI and most user-facing errors are Chinese.

A large share of the codebase — entity value semantics, repository CRUD, filter query models, and view-model form/list boilerplate — is generated at build time by in-repo annotation-driven builders. Most invariants below are enforced by those generators (build errors) or by the in-repo custom_lint plugin (`flutter analyze`), not by source-reading contract tests. When a section below says "the generator rejects X", the violation fails the build before tests ever run.

`README.md` provides the user/developer overview and setup instructions. There is no CI configuration; use the source, the contract tests, `pubspec.yaml`, `README.md`, and this file together as the repository documentation.

## Cold start

Requirements:

- Flutter stable with Dart compatible with `sdk: ^3.9.2` (`.metadata` records the Flutter project revision).
- A desktop toolchain for the target platform. Tracked runners exist for Linux, macOS, and Windows.
- MySQL only for running the application and the opt-in integration tests; the normal test suite is primarily hermetic.

Run commands from the repository root. Several tests inspect files through relative paths such as `lib/entity` or `lib/infrastructure/codegen`, so invoking them from another working directory can give misleading failures.

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
dart test test/infrastructure/codegen
dart run build_runner build --delete-conflicting-outputs
dart format <changed .dart files>
flutter build macos        # or windows/linux
```

Do not globally format the repository as incidental cleanup: a repository-wide format check currently flags ~161 handwritten files that intentionally use a more expanded parameter style than the current `dart format` default (all `.g.dart` files are clean). Format only changed Dart files and keep diffs surgical.

## Repository map

- `lib/main.dart` — Flutter entry point; initializes the desktop window, DI, and the app.
- `lib/di.dart` — central `get_it` registration for repositories, utilities, and view models.
- `lib/database/` — connection singleton and append-only application migrations.
- `lib/entity/` — annotation-driven full entities, brief entities, and typed composite/special row keys. Handwritten files declare fields with `@FoxyFullField`/`@FoxyBriefField` and `part 'xxx.g.dart';`; the `.g.dart` mixins provide value semantics.
- `lib/repository/` — Laconic query and persistence layer. `@FoxyRepository` generates the standard row operations; handwritten files add list queries, count queries, `copy*`, locale helpers, and `_applyFilter`.
- `lib/view_model/` — all view models, centralized here (not under `lib/page/`). `@FoxyListViewModel` generates the list state/search/pagination/copy/destroy boilerplate; `@FoxyDetailViewModel` generates form controllers and candidate collection for detail/editor view models.
- `lib/use_case/` — concrete user-intent operations for cross-repository orchestration, transactions, migrations, and cancellable workflows.
- `lib/page/<module>/` — MVVM feature folders containing pages and pure views (`*_page.dart` route pages, `*_view.dart` form/child-table widgets). Views receive a view model as a constructor parameter; pages obtain it from GetIt.
- `lib/widget/` — shared shadcn-based widgets, form controllers, pickers, locale editors, tables, and dialogs.
- `lib/constant/` — AzerothCore/DBC enums, flags, schemas, UI option definitions, and DBC table/file mappings.
- `lib/router/` — AutoRoute configuration, navigation facade/menu model, and generated routes.
- `lib/event/` — small synchronous application event bus.
- `lib/infrastructure/`
  - `codegen/` — the in-repo annotation-driven builders (entity, repository, filter, list view model, form view model). Each builder splits into reader, model, and emitter, so emitters are unit-testable in isolation.
  - `config/` — root-relative YAML configuration.
  - `database/` — MySQL error helpers and a transaction wrapper.
  - `dbc/` — DBC definitions, import worker, sync orchestration, export encoding, locale codecs, and export registry.
  - `game_asset/` — BLP decoder, MPQ icon extractor, and icon cache (icons are extracted from the player's WoW client, never bundled).
  - `logging/`, `preferences/`, `util/`, `window/` — shared infrastructure.
- `lib/lint/` — custom_lint plugin and rules for codebase-wide constraints.
- `test/` — unit/widget tests, database-editing contract tests, and codegen behavior tests.
- `linux/`, `macos/`, `windows/` — desktop runners and packaging configuration.

`build/`, `.dart_tool/`, Flutter plugin metadata, IDE state, logs, and `config.yaml` are generated/local artifacts; do not edit or commit them. Generated `.g.dart` files under `lib/` are tracked; never hand-edit them, but do commit their diffs after regeneration.

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
`LinkedListViewModel`, `LinkedDetailViewModel`, `ReadViewModel`,
`WorkflowViewModel`, or `StateViewModel`. Do not add an unclassified
`SomethingViewModel`, a generic/base CRUD ViewModel, or a marker hierarchy.
Global `StateViewModel` and cross-page workflow owners are singletons; ordinary
page and editor ViewModels are factories.

Standard List and Detail/Editor view models are generated: a handwritten shell
annotated with `@FoxyListViewModel` or `@FoxyDetailViewModel` mixes in a
generated `_<Name>Mixin`. The shell carries module-specific logic (activity
logging, multi-step `persist`, cross-entity wiring); the generated mixin
carries the repetitive state/controller boilerplate. If a module's form is too
irregular for the annotations (e.g. `achievement_detail_view_model.dart` with
~60 locale controllers), handwrite it entirely; do not fight the generator.

ViewModels own Signals, typed field controllers, candidate collection and
validation, explicit `persistedKey`/`editingKey`, and stale-response protection.
They must not accept `BuildContext`, show Dialog/Toast, navigate, access
`Database`/`Laconic`/transactions, or depend on another page ViewModel. UI
interaction surfaces own Flutter side effects. Simple single-table operations
may call a concrete Repository directly; cross-table writes, transactions,
cross-table validation, bootstrap, and cancellable long-running work belong in
a concrete `lib/use_case/` class with an `execute()` method. Do not introduce a
generic UseCase, command bus, mediator, or global UI-effect framework.

List view models commonly use a monotonically increasing `_refreshToken` to
prevent stale async responses from replacing newer search/pagination results.
Generated list view models and handwritten collection/single editors both
follow this pattern (the latter add `_interactionToken` for parent-key
changes). Preserve that race protection when changing refresh logic.

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

These are deliberate repository-wide invariants. The majority are enforced at build time by the generators (see "Code generation" below); the rest are pinned by contract tests.

### Full and brief entities

- Full entities are annotated `@FoxyFullEntity(table:)`; the generator produces the `_<Name>EntityMixin` with `fromJson`, `copyWith`, `toJson`, `==`, `hashCode`, and `toString`. The handwritten class only declares fields and a const constructor; it must `part '<file>.g.dart';`, mix in the generated mixin, and delegate `fromJson`.
- Fields are `final` scalars (`int`/`double`/`String`/`bool` and their nullable forms), each annotated `@FoxyFullField(column, key: true for physical identity)`, bound to named initializing formals with constant defaults. Physical column spelling and casing are exact — `toJson` keys must match the SQL/DBC columns.
- Repeated physical columns remain explicit scalar fields. Do not collapse them into lists or maps unless the database model itself requires that representation.
- `@FoxyBriefEntity` makes the generator also emit a `Brief<Name>Entity` read model in the same file: display data plus complete persisted identity, value semantics, no write API (`toJson`/`copyWith`). Fields included in the projection are marked `@FoxyBriefField()`; class-level `@FoxyBriefField.text/integer/decimal/boolean(name, defaultValue)` declares projection-only fields supplied by a query alias (e.g. `localeName` from a locale join).
- A brief entity exposes `key`: a plain `int`/`String` for a single key column, or a generated composite `XxxKey` value object when there is more than one key field. Composite keys implement value equality and `hashCode`.
- Filter query models are generated per repository from repeatable `@FoxyFilter.text/integer/decimal/boolean(name, defaultValue)` annotations on the repository class; each Repository owns its `<Name>Filter` even when field shapes currently match. Do not share one Filter type across Repository libraries.

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

- Use the typed controllers in `lib/widget/form/field_controller.dart`; declare them with `registerController(...)` and call `disposeControllers()` from the view model. Generated form mixins do this automatically.
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

1. Full/brief row entities (annotation-driven), Repository Filter (`@FoxyFilter`), and composite-key types.
2. A repository annotated `@FoxyRepository(Entity)` with count/list behavior and explicit identity handling.
3. Validation mixin and tests for SQL/DBC value constraints.
4. List/detail view models (annotation-driven where possible), pages, and views.
5. `@RoutePage`, an `AutoRoute` child in `router.dart`, generated route output, and `RouterMenu`/feature wiring.
6. Repository and view-model registrations in `di.dart`.
7. Picker delegate registration if other modules reference it.
8. For DBC-backed modules: `dbc_definitions.dart`, export registry delegate, locale field metadata/codec as needed, and the migration that creates/seeds the `foxy.dbc_*` table or feature entry.
9. Contract tests modeled on the closest existing module.

Start by finding the nearest module with the same key shape and storage type rather than inventing a new abstraction. For example, use an existing scalar-key DBC detail module for scalar DBC work and an existing inline composite-key child editor for relation tables.

## DBC rules

DBC support targets the 3.3.5.12340/3.3.5a physical layouts asserted in tests.

- `lib/constant/dbc_definitions.dart` is the source of table-to-file/schema mappings; binary structure comes from the warcrafty package.
- `DbcExportRegistry` must have a delegate for every exported definition.
- Entity `toJson` fields must cover the complete DBC schema; round-trip and export-field tests enforce this.
- Import orchestration is in `dbc_sync_util.dart`, while parsing/database work occurs in `dbc_import_worker.dart` (a background isolate). Keep isolate messages serializable and aggregate per-file failures rather than losing partial results.
- Imports currently target the hard-coded `foxy` schema. Do not run destructive integration work against a real/default `foxy` schema from tests.
- DBC filename matching is case-insensitive.

Game icons are extracted from the player's WoW client by the user via Settings → 游戏图标 (extract from `Data/<locale>/*.MPQ` as BLP), cached beside the executable in `data/icon/`, and rendered by `FoxyGameAssetIcon` through `GameIconCache` (BLP2 DXT1/3/5 decoded in memory). No game icons are bundled — do not add an icon directory to `pubspec.yaml` assets. The extraction pipeline lives in `lib/infrastructure/game_asset/` and runs in a background isolate (`game_icon_extract_worker.dart`).

## Lint and code generation

### Custom lint rules

A custom_lint plugin at `lib/lint/` enforces architecture constraints during `flutter analyze`:

| Rule | Scope | Constraint |
|------|-------|------------|
| `entity_scalar_only` | Entity | Fields must be int/double/String/bool; no List/Map/Set |
| `repository_no_save` | Repository | No handwritten `save*`/`insertAndGetId` (excludes `*Locale(s)` names) |
| `no_collection_loops` | Entity/ViewModel/View | No `List.generate` or `for (` |
| `entity_no_flutter_import` | Entity | No Flutter material/widgets/rendering, `dart:ui`, page/widget, or `signals_flutter` imports |
| `viewmodel_no_router_facade` | ViewModel | No RouterFacade import |
| `no_flex_in_view` | View files | No `flex:` parameter |
| `no_readonly_in_view` | View files | No `readOnly: true` |

### Code generation

`lib/infrastructure/codegen/` contains three build_runner builders registered in `build.yaml`:

- `foxy_entity` → `lib/entity/**_entity.dart`
- `foxy_repository` → `lib/repository/**_repository.dart`
- `foxy_view_model` → `lib/view_model/**_view_model.dart`

Each builder is split into reader (element inspection + validation), model, and emitter (pure string building), so the emitters are unit-testable in isolation. Generated symbols follow Dart "Sort Members" ordering conventions (see the repo memory notes); the emitters reproduce that order so generated files read like the handwritten ones.

Annotation vocabulary:

| Annotation | Target | Effect |
|------------|--------|--------|
| `@FoxyFullEntity(table:)` | Entity class | Generates the `_<Name>EntityMixin` with `fromJson`/`copyWith`/`toJson`/`==`/`hashCode`/`toString` |
| `@FoxyFullField(column, key:)` | Entity field | Maps the field to a physical column; `key: true` marks physical identity |
| `@FoxyBriefEntity` | Entity class | Also generates `Brief<Name>Entity` (read model, value semantics, no write API) |
| `@FoxyBriefField()` | Entity field | Includes that physical field in the Brief projection |
| `@FoxyBriefField.text/integer/decimal/boolean(name, defaultValue)` | Entity class | Declares a Brief-only projection field supplied by a query alias |
| `@FoxyRepository(Entity, linkKey:)` | Repository class | Generates `get`/`store`/`update`/`destroy` plus `_whereKey` in `_<Name>RepositoryMixin`; repositories with a list page also get the generated query layer (`create`/`copy`/`getBrief*`/`count*`/`get*`/`_applyFilter`); `linkKey: ['field']` declares a child table (detail-page Tab) and switches `count*`/`getBrief*`/`create*` to the link-key form (list scoped to the linked record, non-link keys preallocated via `nextMaxPlusOne(where: {link})`) |
| `@FoxyFilter.text/integer/decimal/boolean(name, defaultValue, column:)` | Repository class | Generates the `<Name>Filter` query input object (with `fromJson`/`copyWith`/`toJson`); `column` pins the physical column when it cannot be inferred from a same-named entity field |
| `@FoxyListViewModel(entity:, repository:)` | ViewModel class | Generates the `_<Name>ListViewModelMixin` list boilerplate (see below) |
| `@FoxyDetailViewModel(entity:, selects:, flags:, groups:, nullable:, exclude:, repository:)` | ViewModel class | Generates form controllers plus `_applyCandidate`/`_afterApplyCandidate`/`_collectCandidate` (see below); with `repository:` also generates the behavior skeleton (entity/persistedKey/loading/submitting/errorMessage signals, `initSignals`/`persist`/`dispose`, empty `_logActivity` hook) |
| `@FoxyLinkedListViewModel(entity:, repository:, selects:, flags:, groups:, nullable:, exclude:)` | ViewModel class | Generates the full child-table editor skeleton (linkKey/items/editingKey/selectedKey/page/total/loading/submitting/errorMessage signals, `_refreshToken`/`_interactionToken`, `copy`/`create`/`destroy`/`edit`/`paginate`/`persist`/`setLinkKey`/`_refresh`) plus the form controllers; requires the repository to declare a single `linkKey` |
| `@FoxyLinkedDetailViewModel(entity:, repository:, selects:, flags:, groups:, nullable:, exclude:)` | ViewModel class | Generates the single-row linked editor skeleton (linkKey/editingKey/entity/loading/submitting/errorMessage signals, `_refreshToken`/`_linkToken`, `destroy`/`dispose`/`initSignals`/`persist`/`setLinkKey`/`_refresh` with get-or-create) plus the form controllers; requires exactly one physical key field (the link key is the primary key), composite keys stay handwritten |

Conventions the generators enforce at build time (violations are build errors, not test failures):

- One `@FoxyFullEntity` class per file, and the file name must be the class name in snake_case (same for Repository and ViewModel files).
- The class must apply the generated mixin, declare `part '<file>.g.dart';`, and — for entities — keep the canonical `factory XxxEntity.fromJson(Map<String, dynamic> json) => _XxxEntityMixin.fromJson(json);` delegation.
- Entity fields must be `final`, scalar, annotated exactly once, bound to named initializing formals with constant defaults; handwritten `copyWith`/`toJson`/`toString`/`==`/`hashCode` are rejected. Key fields may not be nullable — `column = NULL` is never true in SQL, so a generated lookup would silently match zero rows.
- Repository and Entity share a base name; `Repository._table` must match `@FoxyFullEntity.table` exactly.
- The query layer is fully generated for repositories that have a list page (detected by the presence of `lib/view_model/<base>_list_view_model.dart`) or declare `linkKey:`: `create*` (preallocates key columns via `nextMaxPlusOne`), `copy*` (get + create + copyWith new key + store, returns the new key), `getBrief*`/`count*` (filtered, paginated, key-ordered), `get*` (full list, key-ordered, list-page repos only), and `_applyFilter` (exact matches on filter columns, list-page repos only). The link-key form takes the link key as the first positional parameter (`count<Base>s(int link)`, `getBrief<Base>s(int link, {page})`, `create<Base>(int link)`) and preallocates non-link keys with `nextMaxPlusOne(where: {linkColumn: link})`. A handwritten method with the same signature automatically overrides the generated mixin member (class members win over mixin members), so modules with joins, LIKE, bound checks, or special key semantics keep handwritten versions annotated `@override`. List method names follow the convention `getBrief<Base>s`/`count<Base>s`/`copy<Base>`/`destroy<Base>` (consonant-`y` names pluralize to `-ies`, e.g. `GemProperty` → `GemProperties`); signature mismatches surface as compiler errors, not generator errors. Repositories mixing `DbcLocaleRepositoryMixin` with `dbcLocaleTableName` also get generated `get*Locales`/`save*Locales` delegations (the mixin `on` clause widens to include the locale mixin).
- ViewModel `with` lists must order `FieldControllerMixin` (and `QueryVersionMixin` for lists) before the generated mixin.

Generated Repository writes go through `RepositoryMixin.prepareWriteJson`, which backtick-quotes every column. laconic does not escape identifiers, so this is what keeps reserved-word columns such as `index` and `rank` working. Generated `store` also rejects an int key `<= 0`, and both `store`/`update` translate duplicate-entry errors into `StateError` with user-facing Chinese messages; `update`/`destroy` throw when the matched/deleted row count is zero.

`@FoxyListViewModel` reads the repository's `@FoxyFilter` annotations and generates: the `items`/`page`/`total`/`loading`/`submitting`/`errorMessage` signals, one `StringFieldController` per filter field, `search`/`reset`/`paginate` (each calls `markQueryVersion()`), `copy`/`destroy` (submitting guard, `normalizePageAfterDelete`, activity-log hook), `initSignals`, `dispose`, and `_refresh` with `_refreshToken` stale-response protection. Only `@FoxyFilter.text` filters are currently supported for lists. The repository methods are called by fixed convention names — `getBrief<Base>s`/`count<Base>s`/`copy<Base>`/`destroy<Base>` — which the repository generator emits for every repository with a list page; the generator no longer inspects repository source text. The shell overrides the empty `_logActivity` hook to record module-specific activity.

`@FoxyDetailViewModel` generates one controller per entity constructor field: `int` → `IntFieldController`, `double` → `DoubleFieldController`, `String` → `StringFieldController`, `bool` → `SelectFieldController<int>(fallback: 0)` (collected as `== 1`). Exceptions must be declared explicitly and are mutually exclusive: `selects` (`int`/`String` fallback), `flags` (`FlagFieldController`), `groups` (`IntFieldControllerGroup` for dynamic integer editors), `nullable` (`NullableStringFieldController`, `String?` only), `exclude` (not in the form). Misspelled field names are caught at build time. The generated `_applyCandidate`/`_collectCandidate` plus the `_afterApplyCandidate` override point handle form loading and saving. The same controller boilerplate is reused by `@FoxyLinkedListViewModel`/`@FoxyLinkedDetailViewModel`, which add their behavior skeletons; `npc_text` is the one handwritten linked detail that stays hand-written (use cases + locale repository, no annotation).

A composite `<Name>Key` class is generated only when there is more than one key field; a single key field is used as a plain scalar.

The generator suites use `build_test` and require `dart:mirrors`, so they are skipped under `flutter test`. Run them with `dart test test/infrastructure/codegen`.

## Testing expectations

Behavioral tests verify actual runtime behavior: entity serialization, validation, repository write contracts, view model identity flows, and DBC format correctness. Do not write tests that read Dart source files to assert method names, signatures, import boundaries, or prohibited APIs — those constraints belong to codegen (build-time) or custom lint rules (`flutter analyze`). (`test/scaffold_export_boundary_test.dart` is a pre-rule leftover of exactly that shape; do not add more like it, and migrate it when the constraints move to lint/codegen.)

For a change:

1. Run the closest focused contract/unit/widget test while iterating.
2. Add a regression test for a bug or a contract test for a new table/module.
3. Format only changed Dart files.
4. Run `flutter analyze`.
5. Run `flutter test`, and report any baseline or environment-dependent failure clearly.

Codegen suites are organized as entry + VM implementation + conditional import: each `test/infrastructure/codegen/<x>_generator_test.dart` imports `<x>_generator_vm.dart` under a pure-VM conditional (`if (dart.library.ui)` → `generator_flutter_skip.dart`), so `flutter test` skips them and `dart test test/infrastructure/codegen` runs the real suites. The VM suites drive `build_test`'s `testBuilder` with in-memory asset maps and assert on the generated `.part` source text; `generated_entity_behavior_test.dart` instead imports real generated entities and asserts their runtime behavior. Test inputs read the real annotation sources from disk (`generator_test_support.dart`) rather than hand-copied definitions, so annotations cannot drift from the tests. Known gap: `repository_filter_generator_vm.dart` still hand-copies its annotation source, and the form (`FoxyDetailViewModel`) generator has no dedicated suite — mirror the other suites when adding coverage.

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

- `flutter analyze` is clean.
- Five MySQL integration tests are skipped unless the environment variables above are supplied.
- The generator suites under `test/infrastructure/codegen/` are skipped by `flutter test`; run them with `dart test test/infrastructure/codegen`.
- A repository-wide `dart format` check currently flags ~161 handwritten files (expanded parameter style; `.g.dart` outputs are clean). Do not reformat unrelated files as part of another task.
- `test/support/local_dart_library_source.dart` is currently an orphan (no callers) — a leftover of the source-reading approach.
- Some widget tests intentionally log error stack traces while verifying failure UI; an error log is not itself a test failure—use the final test status.

## Change discipline

- Keep changes limited to the requested behavior; this is a large repetitive codebase where broad cleanup creates noisy risk.
- Match local naming, formatting, import style, and Chinese copy.
- Do not edit generated route code, generated plugin registrants, `.g.dart` outputs, build output, or local config by hand. When annotations or generated inputs change, regenerate with build_runner and include the `.g.dart` diff in the same change.
- Do not change physical SQL/DBC column names, key shapes, flags, enum values, or table boundaries without checking the relevant contract tests and AzerothCore/DBC semantics.
- When a change makes one of your imports/controllers/registrations obsolete, remove that orphan; do not clean up unrelated existing code.
- Use conventional commit-style subjects if asked to commit; recent history uses forms such as `feat:`, `fix:`, `refactor(database):`, `test(repository):`, and `feat(codegen):`.
