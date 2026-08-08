# AGENTS.md

Guidance for AI coding assistants working in this repository. Read this before making changes.

## Project Overview

**Foxy** — a Flutter desktop app for visually managing the **AzerothCore** (WoW 3.3.5 emulator) `world` database: creatures, items, quests, spells, game objects, gossip, SmartAI scripts, loot tables, and 130+ more tables. It also syncs DBC files from a game client, extracts game icons from MPQ/BLP assets, and supports zhCN localization via locale-table JOINs.

- Language: **Dart/Flutter desktop** (Windows primary; macOS/Linux also targeted). Flutter 3.44.x stable, Dart SDK `^3.9.2` (pubspec).
- **All project docs and inline comments are in Chinese (zh-CN)**. UI strings are Chinese. Keep new comments in Chinese to match; exception messages must be English (see lint rules).
- Git branch: `main`. Commit style: `type(scope): description` (e.g. `feat(codegen): ...`, `fix(ui): ...`).

## Quick Start

Monorepo (Dart pub workspace): the Flutter app lives in `packages/foxy`; the
code generators and annotations in `packages/foxy_generator` +
`packages/foxy_annotation`; the custom_lint plugin in `packages/foxy_lint`.
Run Flutter commands from `packages/foxy`.

```bash
cd packages/foxy
flutter pub get                          # install deps (workspace resolution)
dart run build_runner build --delete-conflicting-outputs   # regenerate .g.dart (SLOW, can take many minutes)
flutter analyze                          # includes the 8 custom_lint rules
flutter test                             # ~99 test files; can take a while
flutter run -d windows                   # run (reads config.yaml for DB connection)
```

Generator tests live in `packages/foxy_generator/test/` — run them from that
package with `dart test` (pure Dart, no Flutter runtime).

`config.yaml` (gitignored) holds the MySQL connection (`acore_world`) and client/DBC paths. Without it the app opens the Bootstrap page.

## ⭐ The Code Generation System (read this first)

The architecture is **annotation-declared + code-generated**. Hand-written code only declares *what* things are via `@Foxy*` annotations; mechanical boilerplate is emitted into `*.g.dart` **part files** by three custom `build_runner` builders. The annotations live in the `foxy_annotation` package (`packages/foxy_annotation/lib/`), the generators in `foxy_generator` (`packages/foxy_generator/lib/`).

**Golden rules:**

1. **Never hand-edit `*.g.dart` files** — they are `// GENERATED CODE - DO NOT MODIFY BY HAND` parts, committed to git. Change the annotations in the hand-written file, then re-run build_runner.
2. After **any** annotation change (or adding an entity/repository/view_model file), you **must** run `dart run build_runner build --delete-conflicting-outputs` before code compiles.
3. Generated code is a **mixin** (`_XxxMixin on RepositoryMixin` / `FieldControllerMixin`), mixed into the handwritten class via `with` — override generated methods in the handwritten class to customize ("显式覆写").
4. Physical column names exist **once** — in `@FoxyFullField('column')`. Everything else derives from the Entity.
5. `build.yaml` scopes generation: `lib/entity/**_entity.dart`, `lib/repository/**_repository.dart`, `lib/view_model/**_view_model.dart` only.

### Architecture Layers

```
Page (列表/详情/子表 Tab) ── Watch(signals)
   ▼
ViewModel (List / Detail / LinkedDetail / LinkedList — annotated, generated)
   ▼
UseCase (cross-table transactions, DBC import/export, icon extraction)
   ▼
Repository (single-table boundary, linkKey sub-query layer — generated)
   ▼
Entity (Brief = list row / Full = complete record — generated)
   ▼
laconic query builder ──► MySQL (AzerothCore `world` DB + `foxy` meta DB)
```

### Annotation Quick Reference

| Annotation | Target | Generates |
| --- | --- | --- |
| `@FoxyBriefEntity` / `@FoxyBriefField` | Entity class / field | List-row entity `BriefXxxEntity` (+ `@FoxyBriefField.text('name')` for locale display names) |
| `@FoxyFullEntity(table:)` / `@FoxyFullField('col', key: true)` | Entity class / field | Full record: `fromJson` / `copyWith` / `==` / field metadata; `key: true` marks the primary key (single source of key info) |
| `@FoxyRepository(entity:, linkKey:)` | Repository class | `getBriefXxxs` / `countXxxs` / `getXxx` / `createXxx` / `copyXxx` / `destroyXxx`; `linkKey` adds sub-table (child-set) query forms |
| `@FoxyFilter` | Repository class | Public `XxxFilter` class (single source of truth for list filters) |
| `@FoxyListViewModel(entity:, repository:)` | List VM | Filter controllers, pagination, query-version race token, operation hooks |
| `@FoxyDetailViewModel(entity:, selects:/flags:/groups:/nullable:/exclude:, repository:)` | Detail VM | Form controllers by type inference (`int→IntFieldController`, `double→DoubleFieldController`, `String→StringFieldController`, `bool→SelectFieldController<int>`), `collect/apply/initSignals/persist` skeleton |
| `@FoxyLinkedListViewModel(...)` | Sub-table list VM | Child-set list + row editor skeleton (requires repository `linkKey`) |
| `@FoxyLinkedDetailViewModel(...)` | 1:1 sub-table VM | get-or-create single-row editor skeleton |

Full docs: `doc/codegen/README.md` (architecture), `doc/codegen/usage.md` (module dev guide — **read this before adding a module**), `doc/codegen/generators.md` (generator internals), `doc/codegen/extending.md` (modifying/adding generators).

### The 5 Module Forms (from usage.md)

1. **Main List + Detail** (creature, item, quest, spell…) — 4 files: `entity/X_entity.dart`, `repository/X_repository.dart`, `view_model/X_list_view_model.dart` + `X_detail_view_model.dart`, `page/X/` (list page, detail page, view).
2. **linkKey sub-repository** — child tables reachable only from a parent detail (e.g. loot tabs).
3. **Linked List Tab** — child-set row editing inside a parent detail page.
4. **Linked Detail Tab** — 1:1 child form (e.g. `creature_template_addon`).
5. **Composite-key tables** — hand-written, no generation.

### Wiring a New Module

- Register the ViewModel/Repository/etc. in **`lib/di.dart`** (get_it: 251 explicit registrations — 106 `registerFactory`, 137 `registerLazySingleton`, 8 `registerSingleton`; ALL registration is explicit here — no service-locator magic).
- Add routes in **`lib/router/router.dart`** (`@AutoRoute`, generated into `router.gr.dart`; `RouterFacade` handles breadcrumbs/menu highlighting — ViewModels must not touch routing).
- Seed the `foxy.features` table (drives sidebar pinning / "更多" page / dashboard favorites) via a **migration**, matching existing insert patterns.

## Conventions & Enforced Rules

### Naming & structure (validated at codegen time)

- Class↔file snake_case: `XxxEntity` ↔ `xxx_entity.dart`, `XxxRepository` ↔ `xxx_repository.dart`; `BriefXxxEntity` for list rows.
- Generated method names: `getBriefXxxs` / `countXxxs` / `getXxx` / `createXxx` / `copyXxx` / `destroyXxx`; Filter class `XxxFilter`.
- Handwritten classes must mix in the generated mixin and declare `part 'xxx.g.dart';`.

### custom_lint rules (enforced by `flutter analyze` — 8 rules in `packages/foxy_lint/lib/rules/`)

| Rule | Meaning |
| --- | --- |
| `entity_scalar_only` | Entities only contain scalar fields |
| `entity_no_flutter_import` | Entity layer must not import Flutter |
| `repository_no_save` | Repositories never expose direct save; use generated behavior skeletons |
| `view_model_no_router_facade` | ViewModels don't reach into routing |
| `no_collection_loops` | No hand-written collection loops — use collection methods (`map/where/...`) |
| `no_flex_in_view` | No `Flex` widgets in views — use `Row`/`Column` with `spacing:` |
| `no_readonly_in_view` | Don't instantiate read-only inputs directly (use `FoxyInputReadonly`) |
| `no_chinese_throw` | **Exception messages must be English** — Chinese UI text is not allowed in throws |

### Error handling

All business errors are **`sealed class FoxyException`** subtypes (`lib/infrastructure/errors/foxy_exceptions.dart`): `RecordNotFoundException`, `DuplicateKeyException`, `InvalidPrimaryKeyException`, `BusyException`, `LinkNotLoadedException`, `IdExhaustedException`, `ValidationException`, `DatabaseNotConnectedException`, etc. `implements Exception` (no `Exception:` prefix).

- Exceptions carry **English** diagnostic messages (logs only).
- User-facing **Chinese** copy is mapped centrally by `foxyErrorMessage(error)` (same file) — the **only** entry point for displaying errors in the UI.
- `MysqlErrorUtil.isDuplicateEntry` translates MySQL duplicate-entry errors into `DuplicateKeyException`.

## State Management & UI

- **signals** / **signals_flutter** (reactive signals) — ViewModels expose `signal(...)` fields; pages use `Watch((_) => ...)`. No Provider/Riverpod/Bloc.
- **shadcn_ui** + **lucide_icons_flutter**; Chinese UI (Windows: Microsoft YaHei UI).
- Reusable widgets in `lib/widget/`: `FoxyShadTable` (virtualized table), `FoxyHeader`, `FoxyStringInput`, `FoxyNumberInput`, `FoxyNullableStringInput`, `FoxyPagination`, `FoxyEntityPicker` (+ delegates), `FoxyFlagPicker`, `FoxyShadSelect`, `FoxyFormItem`/`FoxyFormSection`, `ContextMenu` (right-click copy/delete on rows), dialogs in `widget/dialog/`, form controllers in `widget/form/field_controller.dart` (`FieldControllerMixin`).
- List pages: filter row → `FoxyShadTable` → pagination; double-click opens detail; right-click context menu copies/deletes rows.
- Detail pages: main form + `FoxyTab` sub-table tabs (12 tabs for `creature_template`).

## Database Layer

- `Database.instance` singleton (`lib/database/database.dart`): `connect(MysqlConfig)` → `Laconic(MysqlDriver)` (laconic + laconic_mysql). Config from `config.yaml` (gitignored, at run dir).
- **Two DB namespaces**: AzerothCore `world` tables (unprefixed, e.g. `creature_template`) and the app's own **`foxy` meta DB** (`foxy.features`, `foxy.migrations`, `foxy.activity_log`, `foxy.dbc_*`). DBC data is stored in `foxy.dbc_*` tables to avoid polluting the standard DB.
- **Migrations**: `lib/database/migration/migration_YYYYMMDDHHMM.dart`, appended in order to the list in `lib/database/migration_runner.dart` (currently 6). New features tables / seed rows go through migrations.
- **Activity logging**: every create/update/delete writes to `activity_log` via `ActivityLogService` (use-case level) or generated `_logActivity` hooks; `EventBus` (`lib/event/event_bus.dart`) broadcasts `ActivityLoggedEvent`.
- **Transactions**: `DatabaseTransaction.execute()` for cross-table use cases; repositories never coordinate transactions.
- **Locale support**: `RepositoryMixin.localeEnabled` toggles zhCN JOINs (e.g. `creature_template_locale`); `@FoxyBriefField.text` marks locale display-name columns. DBC wide tables use `DbcLocaleRepositoryMixin` + `DbcLocaleFields` (16 languages).
- **Game-semantic constants** (flags, enums, DBC schemas, locale field lists) live in `lib/constant/` (`dbc_definitions.dart`, `dbc_locale_fields.dart`, `*_flags.dart`, …) — **keep game data knowledge in constants, not scattered in pages**.

## DBC & Game Asset Pipelines

- **DBC import/export** (`lib/infrastructure/dbc/`): `warcrafty` parses DBC binary; import runs in an **isolate worker** (`dbc_import_worker.dart`) with stage progress + cancellation; schema definitions in `lib/constant/dbc_definitions.dart`.
- **Icon extraction** (`lib/infrastructure/game_asset/`): reads MPQ (`game_mpq_source.dart`), decodes BLP (`blp_decoder.dart`), caches (`game_icon_cache.dart`), worker-based.
- Both are one-time setup steps enforced by a non-skippable 3-step wizard on first run.

## Testing

- **Game data tests** (`test/game_data/*_game_data_test.dart`, one per module): verify in-app game-data definitions (enums, flags, column layouts, defaults) match the real AzerothCore 3.3.5 definitions.
- **Database editing tests** (`test/database_editing/*_database_editing_test.dart`): editing behavior (store/update/destroy + exception translation) against a real MySQL; **auto-skip when the DB isn't configured**.
- **Identity tests** (`test/identity/*_identity_test.dart`): identity/state-preservation semantics (activity-log row IDs, locale draft vs original, route breadcrumbs).
- **Codegen tests**: `packages/foxy_generator/test/` — generator unit tests (`dart test` from that package, no Flutter runtime needed); build in-memory sources with `build_test`'s `testBuilder`.
- **Other**: DBC codec/import/export, BLP decoder + MPQ extraction (fixtures in `test/fixture/icons/`), form controllers, widget behavior, use-case tests.
- New annotations/generators **require** codegen tests (see `doc/codegen/extending.md` §d).

## Working Here — Practical Tips

- **Changes to annotations require a full (slow) build_runner pass**; batch your annotation edits.
- After changing an entity field, check the generated file, then run `flutter analyze` — codegen validation errors (`InvalidGenerationSourceError`) pin to the offending element with a `todo:` fix hint.
- Existing generators have no inter-dependencies — they "handshake" via naming conventions and by reading annotations/`_table`/mixin presence from the handwritten source. Follow the same pattern when extending.
- Check `doc/codegen/` docs before touching codegen internals; `doc/codegen/extending.md` has the standard modify-flow and debugging tips (generated code lands in `.dart_tool/build/...`).
- Commits: conventional prefixes with English descriptions, e.g. `feat(codegen): add parent-key query layer`.
