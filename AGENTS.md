# AGENTS.md

Guidance for AI coding assistants working in this repository. Read this before making changes.

## Project Overview

**Foxy** — a Flutter desktop app for visually managing the **AzerothCore** (WoW 3.3.5 emulator) `world` database: creatures, items, quests, spells, game objects, gossip, SmartAI scripts, loot tables, and 130+ more tables. It also syncs DBC files from a game client, extracts game icons from MPQ/BLP assets, and supports zhCN localization via locale-table JOINs.

- Language: **Dart/Flutter desktop** (Windows primary; macOS/Linux also targeted). Flutter 3.44.x stable, Dart SDK `^3.9.2`.
- **Code comments are English** (`//`, `///`, yaml `#`). UI strings, log messages, and docs (README/AGENTS/doc) stay in Chinese; exception messages must be English (see lint rules).
- Git branch: `main`. Commit style: `type(scope): description` (e.g. `feat(codegen): ...`, `fix(ui): ...`).

## Repository Layout

Monorepo (Dart pub workspace, root `pubspec.yaml`):

| Path | Package | Role |
| --- | --- | --- |
| `packages/foxy` | `foxy` (v1.1.1+665) | The Flutter app — the only runnable package |
| `packages/foxy_annotation` | `foxy_annotation` | Annotation definitions (`@Foxy*`) consumed by the generators |
| `packages/foxy_generator` | `foxy_generator` | source_gen builders that read annotations and emit `.g.dart` parts |
| `packages/foxy_lint` | `foxy_lint` | Project-specific **analyzer plugin** (8 rules) |

Run Flutter commands from `packages/foxy`; run generator/lint tests from their own packages (`dart test`).

## Quick Start

```bash
cd packages/foxy
flutter pub get                          # install deps (workspace resolution)
dart run build_runner build --delete-conflicting-outputs   # regenerate .g.dart (SLOW, can take many minutes)
flutter analyze                          # includes the 8 foxy_lint plugin rules
flutter test                             # ~91 test files; can take a while
flutter run -d windows                   # run (reads config.yaml for DB connection)
```

`config.yaml` (gitignored, in the run dir) holds the MySQL connection (`acore_world`), `use_ssl`, `locale_enabled`, `dbc_path`, and `client_dir`. Without it the app opens the Bootstrap wizard.

## ⭐ The Code Generation System (read this first)

The architecture is **annotation-declared + code-generated**. Hand-written code only declares *what* things are via `@Foxy*` annotations; mechanical boilerplate is emitted into `*.g.dart` **part files** by three custom `build_runner` builders (registered in `packages/foxy/build.yaml`, not in the generator package):

| Builder | `generate_for` | Emits |
| --- | --- | --- |
| `foxy:foxy_entity` | `lib/entity/**_entity.dart` | `BriefXxxEntity` list-row DTO + Key class (composite keys) + `mixin _XxxEntityMixin` (fromJson/toJson/copyWith/==) |
| `foxy:foxy_repository` | `lib/repository/**_repository.dart` | `XxxFilter` class + `mixin _XxxRepositoryMixin on RepositoryMixin` (CRUD + link-key query layer) |
| `foxy:foxy_view_model` | `lib/view_model/**_view_model.dart` | `mixin _Xxx...ViewModelMixin on FieldControllerMixin[, QueryVersionMixin]` (signals + controllers) |

On disk: 125 entity `.g.dart`, 124 repository `.g.dart`, 84 view_model `.g.dart`.

**Golden rules:**

1. **Never hand-edit `*.g.dart` files** — they are `// GENERATED CODE - DO NOT MODIFY BY HAND` parts, committed to git. Change the annotations in the hand-written file, then re-run build_runner.
2. After **any** annotation change (or adding an entity/repository/view_model file), you **must** run `dart run build_runner build --delete-conflicting-outputs` before code compiles.
3. Generated code is a **mixin** (`_XxxMixin on RepositoryMixin` / `FieldControllerMixin`), mixed into the handwritten class via `with` — override generated methods in the handwritten class to customize.
4. Physical column names exist **once** — in `@FoxyFullField('column')`. Everything else derives from the Entity.
5. Entity files must also keep the delegated `factory Xxx.fromJson(...) => _XxxMixin.fromJson(...);` and the `with _XxxMixin` clause — the readers validate this at build time.

### Annotation Quick Reference

| Annotation | Target | Generates |
| --- | --- | --- |
| `@FoxyBriefEntity()` / `@FoxyBriefField` | Entity class / field | List-row entity `BriefXxxEntity`; class-level `@FoxyBriefField.text('name')` declares locale display-name projections |
| `@FoxyFullEntity(table:)` / `@FoxyFullField('col', key: true)` | Entity class / field | Full record: `fromJson` / `copyWith` / `==` / field metadata; `key: true` marks the primary key (single source of key info). `table` omitted → derived from class name (`CreatureLootTemplateEntity` → `creature_loot_template`) |
| `@FoxyRepository(entity:, linkKey:, autoIncrementKey:, autoIncrementScope:)` | Repository class | `getBriefXxx` / `countXxx` / `getXxx` / `storeXxx` / `updateXxx` / `destroyXxx` / `createXxx` / `copyXxx` + `_beforeStore`/`_beforeDestroy` hooks; `linkKey` adds sub-table (child-set) query forms taking link keys as first positional params |
| `@FoxyFilter.text/integer/decimal/boolean(name, {column, defaultValue})` | Repository class | Public `XxxFilter` class (single source of truth for list filters); `column` defaults to name → entity field → its `@FoxyFullField` column |
| `@FoxyListViewModel(entity:, repository:)` | List VM | Filter controllers, `items/page/total/loading/submitting/errorMessage` signals, `copy/destroy/paginate/reset/search/_refresh` with a refresh-race token, `_logActivity` (default resolves the record name from the DB via the generated query layer, chaining candidate name fields `name` → `*NameLangZhCN` → `titleLangZhCN` → `title` → `logTitle` → `comment` with a key fallback; override in the hand-written class) |
| `@FoxyDetailViewModel(entity:, selects:, flags:, groups:, exclude:, repository:, skeleton:)` | Detail VM | Per-field controllers by type inference (`int→IntFieldController`, `double→DoubleFieldController`, `String→StringFieldController`, `String?→NullableStringFieldController`, `bool→SelectFieldController<int>`), `entity/persistedKey/loading/submitting/errorMessage` signals, `initSignals({key})`, `_applyCandidate`/`_collectCandidate`/`persist`/`_logActivity` |
| `@FoxyLinkedListViewModel(...)` | Sub-table list VM | Child-set list + row editor skeleton (requires repository `linkKey`) |
| `@FoxyLinkedDetailViewModel(...)` | 1:1 sub-table VM | get-or-create single-row editor skeleton (entity must have exactly one physical key) |

`selects` has two forms: `Set<String>` (fallback derived from the entity constructor default) or `Map<String, int>` (explicit fallback). `flags` fields get `FlagFieldController`.

### The 5 Module Forms

1. **Main List + Detail** (creature, item, quest, spell…) — `entity/X_entity.dart`, `repository/X_repository.dart`, `view_model/X_list_view_model.dart` + `X_detail_view_model.dart`, `page/X/` (list page, detail page, view).
2. **linkKey sub-repository** — child tables reachable only from a parent detail (e.g. loot tabs; `player_create_info_*` uses two link keys).
3. **Linked List Tab** — child-set row editing inside a parent detail page.
4. **Linked Detail Tab** — 1:1 child form (e.g. `creature_template_addon`).
5. **Composite-key tables** — hand-written, no generation (`condition`, `waypoint_data`, `item_enchantment_template` …).

### Wiring a New Module

- Register the ViewModel/Repository/etc. in **`lib/di.dart`** (get_it: 252 explicit registrations — 105 `registerFactory`, 137 `registerLazySingleton`, 10 `registerSingleton`; ALL registration is explicit here — no service-locator magic).
- Add routes in **`lib/router/router.dart`** (`@AutoRoute`, generated into `router.gr.dart`; 57 routes total). `RouterFacade` handles breadcrumbs/menu highlighting — ViewModels must not touch routing.
- Seed the `foxy.features` table (drives sidebar pinning / "更多" page / dashboard favorites) via a **migration**, matching existing insert patterns.

## Architecture Layers

```
Page (列表/详情/子表 Tab) ── Watch(signals)
   ▼
ViewModel (List / Detail / LinkedDetail / LinkedList — annotated, generated; + FieldControllerMixin, QueryVersionMixin)
   ▼
UseCase (cross-table transactions, DBC import/export, icon extraction) → Repository (single-table boundary, linkKey sub-query layer — generated)
   ▼
Entity (Brief = list row / Full = complete record — generated)
   ▼
laconic query builder ──► MySQL (AzerothCore `world` DB + `foxy` meta DB)
```

## Conventions & Enforced Rules

### Naming & structure (validated at codegen time)

- Class↔file snake_case: `XxxEntity` ↔ `xxx_entity.dart`, `XxxRepository` ↔ `xxx_repository.dart`; `BriefXxxEntity` for list rows.
- Generated method names: `getBriefXxx` / `countXxx` / `getXxx` / `storeXxx` / `updateXxx` / `destroyXxx` / `createXxx` / `copyXxx`; Filter class `XxxFilter`.
- Handwritten classes must mix in the generated mixin and declare `part 'xxx.g.dart';`.
- `lib/entity/` holds ~130 `*_entity.dart` files (125 generated); hand-written-only ones: `activity_log_entity.dart`, `dbc_locale.dart`, `feature_entity.dart`, `version_entity.dart`, composite-key DTOs (`condition_entity` … are generated, keys are hand-written `*_key.dart`).

### foxy_lint rules (enforced by `flutter analyze` — analyzer plugin, 8 rules in `packages/foxy_lint/lib/rules/`, registered in `lib/main.dart`)

| Rule | Meaning |
| --- | --- |
| `entity_scalar_only` | Entities only contain scalar fields (no `List`/`Map`/`Set`) |
| `entity_no_flutter_import` | Entity layer must not import Flutter / UI packages |
| `repository_no_save` | Repositories never expose direct `save*`; use generated store/update/destroy |
| `view_model_no_router_facade` | ViewModels don't reach into routing |
| `no_collection_loops` | No hand-written `List.generate`/`for-in` collection loops — use collection methods (`map/where/...`) |
| `no_flex_in_view` | No `flex:` named args in views — uniform spacing uses `Expanded` |
| `no_readonly_in_view` | Don't instantiate read-only inputs directly (use `FoxyInputReadonly`) |
| `no_chinese_throw` | **Exception messages must be English** — Chinese UI text is not allowed in throws |

The plugin is declared in the **workspace root** `analysis_options.yaml` (absolute path, see dart-lang/sdk#61477); `packages/foxy/analysis_options.yaml` includes it and adds `always_use_package_imports`.

### Error handling

All business errors are **`sealed class FoxyException`** subtypes (`lib/infrastructure/errors/foxy_exceptions.dart`): `RecordNotFoundException`, `DuplicateKeyException`, `InvalidPrimaryKeyException`, `BusyException`, `LinkNotLoadedException`, `IdExhaustedException`, `ValidationException`, `CopyNotSupportedException`, `DatabaseNotConnectedException`, `UpdateException` (with `UpdateErrorKind`). `implements Exception` (no `Exception:` prefix).

- Exceptions carry **English** diagnostic messages (logs only).
- User-facing **Chinese** copy is mapped centrally by `foxyErrorMessage(error)` (same file) — the **only** entry point for displaying errors in the UI.
- `MysqlErrorUtil.isDuplicateEntry` walks the `cause` chain for MySQL error 1062.

## State Management & UI

- **signals** / **signals_flutter** (reactive signals) — ViewModels expose `signal(...)` fields; pages use `Watch((_) => ...)`. No Provider/Riverpod/Bloc. (`SignalsObserver.instance = null` in main.dart.)
- **shadcn_ui** + **lucide_icons_flutter**; Chinese UI (Windows: Microsoft YaHei UI). App shell: `ShadApp.router`, 57 auto_route routes, 29 `RouterMenu` entries.
- Reusable widgets in `lib/widget/` (28 files): `FoxyDataTable`/`FoxyTableColumn` (typed table, `queryVersion`-based), `FoxyHeader`, `FoxyStringInput`, `FoxyNumberInput`, `FoxyNullableStringInput`, `FoxyPagination`, `FoxyEntityPicker` (+ delegates), `FoxyFlagPicker`, `FoxySignedEntityPicker`, `FoxyShadSelect`, `FoxyFormItem`/`FoxyFormSection`, `ContextMenu`, `FoxyTab` (lazy tabs), `FoxyGameAssetIcon`, `FoxyInputReadonly`, dialogs in `widget/dialog/`, form controllers in `widget/form/field_controller.dart` (`FieldController<T>` sealed hierarchy + `FieldControllerMixin`).
- List pages: filter row → `FoxyDataTable` → pagination; double-click opens detail; right-click context menu copies/deletes rows.
- Detail pages: main form + `FoxyTab` sub-table tabs (12 tabs for `creature_template`).
- `QueryVersionMixin` (in `lib/widget/query_version_mixin.dart`): pagination baseline — `FoxyDataTable` scrolls back to the top when `queryVersion` changes.

## Database Layer

- `Database.instance` singleton (`lib/database/database.dart`): `connect(MysqlConfig)` → `Laconic(MysqlDriver)` (laconic + laconic_mysql). Config from `config.yaml` via `ConfigUtil` (atomic rewrite, corrupt-file self-heal to `.bak`).
- **Two DB namespaces**: AzerothCore `world` tables (unprefixed, e.g. `creature_template`) and the app's own **`foxy` meta DB**: `foxy.features` (sidebar registry, seeded via migrations), `foxy.migrations`, `foxy.activity_log` (id/module/action_type/entity_name/created_at), and ~50 `foxy.dbc_*` mirror tables.
- **Migrations**: `lib/database/migration/migration_YYYYMMDDHHMM.dart` (7 total), appended in order to the list in `lib/database/migration_runner.dart`. Runner also force-creates the `foxy` DB as utf8mb4 and idempotently converts non-utf8mb4 tables (legacy MySQL 5.x bundles default to latin1).
- **Activity logging**: every create/update/delete/copy fires `EntityWrittenEvent` on the `EventBus` (generated `_logActivity`); a **single** `ActivityLogListener` (eager singleton) persists to `foxy.activity_log` via `ActivityLogService.recordBestEffort` (never fails the main write). `DashboardReadViewModel` subscribes for the live feed.
- **Transactions**: `DatabaseTransaction.execute()` for cross-table use cases; nested calls are **merged** via a zone marker (laconic_mysql opens a new connection per `transaction()` call, so nesting would commit independently). Repositories never coordinate transactions.
- **Locale support**: `RepositoryMixin.localeEnabled` toggles zhCN JOINs; `@FoxyBriefField.text` marks locale display-name columns. DBC wide tables use `DbcLocaleRepositoryMixin` + `DbcLocaleFields` (16 languages).
- **Game-semantic constants** (flags, enums, DBC schemas, locale field lists) live in `lib/constant/` (34 files: `dbc_definitions.dart`, `dbc_locale_fields.dart`, `creature_flags.dart`, `spell_flags.dart`, `quest_flags.dart`, `smart_script_constants.dart`, …) — **keep game data knowledge in constants, not scattered in pages**.

## DBC & Game Asset Pipelines

- **DBC import/export** (`lib/infrastructure/dbc/`): `warcrafty` parses DBC binary; `dbc_definitions.dart` maps ~50 table names ↔ warcrafty schemas. Import runs in an **isolate worker** (`dbc_import_worker.dart`, self-contained connection) with stage progress + cancellation, staging-table + atomic rename commit, count/duplicate-ID validation, and a 512 MiB payload guard. Export via `DbcExportRegistry` + `DbcWriter` with re-read validation and atomic replace.
- **Icon extraction** (`lib/infrastructure/game_asset/`): reads MPQ (`GameMpqSource`), decodes BLP (`blp_decoder.dart`, DXT1/3/5), caches to `data/icon/` (6.3k+ `.blp`) with an in-memory LRU (`GameIconCache`).
- Both are one-time setup steps enforced by a non-skippable 3-step wizard on first run (bootstrap → DBC sync → icon extraction).

## Update & Release

- **Distribution**: portable zip (no installer) — `foxy.exe` + `foxy_updater.exe`. Update chain: check manifest → download with SHA-256 verification → extract to `.update_tmp/` → relaunch into `foxy_updater.exe` (self-copies to `%TEMP%`, waits for app exit, mirrors payload over app dir) → relaunch app. `preservedRelPaths = ['config.yaml', 'data/icon']` (user data never overwritten; `data/` also holds `flutter_assets`, so only the `data/icon/` subtree is excluded).
- **Release flow** (sole trigger: pushing a tag): 1) manually bump `version` in `packages/foxy/pubspec.yaml` and add a `## vX.Y.Z` section to `CHANGELOG.md`, commit; 2) `git tag v1.x.y && git push origin v1.x.y`. CI (`.github/workflows/release.yml`) gates on analyze + tests (app, generator, lint), builds Windows release, compiles the updater, zips, generates `latest.yaml` (SHA-256, keeps the 3 most recent releases, `appId: com.calsranna.foxy`), and publishes the GitHub Release. `latest.yaml` is the fixed update entry point.
- Prerelease tags (`v1.1.0-beta`): zip name uses the suffix-stripped version, the Release is marked prerelease and never displaces `releases/latest`; the app skips prerelease entries (`_isNewer` in `update_service.dart`).

## Testing

- **Game data tests** (`test/game_data/*_game_data_test.dart`, 25): in-app game-data definitions (enums, flags, column layouts, defaults) match real AzerothCore 3.3.5 definitions. Pure in-memory — no DB.
- **Database editing tests** (`test/database_editing/*_database_editing_test.dart`, 17): key value semantics, editing behavior, query-builder behavior. Pure in-memory — no DB.
- **Identity tests** (`test/identity/*_identity_test.dart`, 4): identity/state-preservation semantics (activity-log row IDs, locale draft vs original, route breadcrumbs).
- **Infrastructure + widget + use-case tests**: update service (http mock), DBC codec/import/export, BLP decoder + MPQ extraction (fixtures in `test/fixture/icons/`), form controllers, widgets, gossip use cases, migration runner.
- **DB integration test** (`test/dbc_mysql_integration_test.dart`): runs only with `FOXY_TEST_MYSQL=1` **and** `FOXY_TEST_MYSQL_FOXY_SCHEMA` set to an isolated schema (never `foxy`); host/port/username/password from `FOXY_TEST_MYSQL_*` env vars.
- **Codegen tests**: `packages/foxy_generator/test/` — 8 generator suites (`dart test` from that package, no Flutter runtime), built with `build_test`'s `testBuilder` + `decodedMatches` over in-memory sources; `generator_test_support.dart` holds shared test sources.
- **Lint tests**: `packages/foxy_lint/test/` — official `analyzer_testing` harness with `test_reflective_loader`.
- New annotations/generators **require** codegen tests (see `doc/codegen/extending.md`).

## Working Here — Practical Tips

- **Changes to annotations require a full (slow) build_runner pass**; batch your annotation edits.
- After changing an entity field, check the generated file, then run `flutter analyze` — codegen validation errors (`InvalidGenerationSourceError`) pin to the offending element with a `todo:` fix hint.
- Existing generators have no inter-dependencies — they "handshake" via naming conventions and by reading annotations/mixin presence from the handwritten source (source-shape checks are syntax-level AST via `source_shape.dart`). Follow the same pattern when extending.
- Check `doc/codegen/` docs before touching codegen internals; `doc/codegen/extending.md` has the standard modify-flow and debugging tips (generated code lands in `.dart_tool/build/...`).
- Comments: English. UI strings, log messages, and docs: Chinese. Throws: English only (`no_chinese_throw`).
- Commits: conventional prefixes with English descriptions, e.g. `feat(codegen): add parent-key query layer`.
