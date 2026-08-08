import 'package:meta/meta_meta.dart';

/// Annotates a Detail ViewModel, declaring the entity its form maps to and
/// any exception fields.
///
/// The generator works on "default inference + exception-driven" rules:
/// - Ordinary fields infer their controller from the Dart type: `int →
///   IntFieldController`, `double → DoubleFieldController`, `String →
///   StringFieldController`, `String? → NullableStringFieldController`,
///   `bool → SelectFieldController<int>(fallback: 0)` (paired with a
///   `collect() == 1` conversion).
/// - Exception fields (select/flag/exclude) must be declared here
///   explicitly; a misspelled field name is caught by the validator at
///   generation time.
/// - The entity is derived from the class name (`XxxDetailViewModel` →
///   `XxxEntity`); an explicit `entity:` overrides it.
/// - The behavior skeleton is generated when a same-named repository exists
///   (or `repository:` is declared); `skeleton: false` opts out.
@Target({TargetKind.classType})
class FoxyDetailViewModel {
  /// Exception override: the Full Entity type the form maps to. When
  /// omitted, derived from the class name.
  final Type? entity;

  /// Exception: select-field names with a fallback. Two shapes:
  /// a Map `{'type': 0}` (explicit fallback for `SelectFieldController`)
  /// or a Set `{'type'}` (fallback derived from the entity constructor
  /// default for the same field).
  final Object selects;

  /// Exception: controller name → `FlagFieldController`.
  final Set<String> flags;

  /// Exception: controller name → `IntFieldControllerGroup` (dynamic field
  /// editing).
  final Set<String> groups;

  /// Fields excluded from the form (no controller is generated, and they do
  /// not appear in collect/apply).
  final Set<String> exclude;

  /// Repository providing store/update/get/create. When omitted, a
  /// same-named repository that is present and migrated (`@FoxyRepository`)
  /// enables the behavior skeleton (signals/initSignals/persist/dispose/
  /// _logActivity hooks). Declaring neither entity nor repository generates
  /// just the controller boilerplate (backward compatible).
  final Type? repository;

  /// Opt out of the behavior skeleton even when a same-named repository
  /// exists. Mutually exclusive with [repository].
  final bool? skeleton;

  const FoxyDetailViewModel({
    this.entity,
    this.selects = const {},
    this.flags = const {},
    this.groups = const {},
    this.exclude = const {},
    this.repository,
    this.skeleton,
  });
}

/// Annotates a child-table Linked List ViewModel (the row-editing list of a
/// detail-page tab).
///
/// Generates the controller boilerplate plus the full editor skeleton:
/// link-key subset signal, pagination, race token,
/// copy/create/destroy/edit/persist/setLinkKey/_refresh. The Repository
/// must declare `@FoxyRepository(..., linkKey: [...])` (validated at build
/// time). The entity and repository are derived from the class name
/// (`XxxLinkedListViewModel` → `XxxEntity` / `XxxRepository`); explicit
/// overrides are validated against the derivation.
@Target({TargetKind.classType})
class FoxyLinkedListViewModel {
  /// Exception override: the Full Entity type the form maps to. When
  /// omitted, derived from the class name.
  final Type? entity;

  /// Exception override: Repository type providing
  /// getBrief/count/create/copy/store/update. When omitted, derived from
  /// the class name.
  final Type? repository;

  /// Exception: select-field names with a fallback (Map with explicit
  /// fallback, or Set deriving it from the entity constructor default).
  final Object selects;

  /// Exception: controller name → `FlagFieldController`.
  final Set<String> flags;

  /// Exception: controller name → `IntFieldControllerGroup` (dynamic field
  /// editing).
  final Set<String> groups;

  /// Fields excluded from the form (no controller is generated, and they do
  /// not appear in collect/apply).
  final Set<String> exclude;

  const FoxyLinkedListViewModel({
    this.entity,
    this.repository,
    this.selects = const {},
    this.flags = const {},
    this.groups = const {},
    this.exclude = const {},
  });
}

/// Annotates a single-row Linked Detail ViewModel (the one-to-one linked
/// form of a detail-page tab).
///
/// Generates the controller boilerplate plus the single-row editor
/// skeleton: link-key/editing-key/entity signals, race token,
/// initSignals/setLinkKey/destroy/persist/_refresh (get-or-create: when no
/// record exists, pre-create a default row via the repository's `create*`).
/// Requires the entity to have exactly one physical Key (the link key is
/// the primary key); composite-key forms stay hand-written. The entity and
/// repository are derived from the class name (`XxxLinkedDetailViewModel` →
/// `XxxEntity` / `XxxRepository`).
@Target({TargetKind.classType})
class FoxyLinkedDetailViewModel {
  /// Exception override: the Full Entity type the form maps to. When
  /// omitted, derived from the class name.
  final Type? entity;

  /// Exception override: Repository type providing get/store/update/
  /// destroy/create. When omitted, derived from the class name.
  final Type? repository;

  /// Exception: select-field names with a fallback (Map with explicit
  /// fallback, or Set deriving it from the entity constructor default).
  final Object selects;

  /// Exception: controller name → `FlagFieldController`.
  final Set<String> flags;

  /// Exception: controller name → `IntFieldControllerGroup` (dynamic field
  /// editing).
  final Set<String> groups;

  /// Fields excluded from the form (no controller is generated, and they do
  /// not appear in collect/apply).
  final Set<String> exclude;

  const FoxyLinkedDetailViewModel({
    this.entity,
    this.repository,
    this.selects = const {},
    this.flags = const {},
    this.groups = const {},
    this.exclude = const {},
  });
}
