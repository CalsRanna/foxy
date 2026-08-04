import 'package:meta/meta_meta.dart';

/// Annotates a Detail ViewModel, declaring the entity its form maps to and
/// any exception fields.
///
/// The generator works on "default inference + exception-driven" rules:
/// - Ordinary fields infer their controller from the Dart type: `int →
///   IntFieldController`, `double → DoubleFieldController`, `String →
///   StringFieldController`,
///   `bool → SelectFieldController<int>(fallback: 0)` (paired with a
///   `collect() == 1` conversion).
/// - Exception fields (select/flag/exclude) must be declared here
///   explicitly; a misspelled field name is caught by the validator at
///   generation time.
@Target({TargetKind.classType})
class FoxyDetailViewModel {
  /// The Full Entity type the form maps to.
  final Type entity;

  /// Exception: controller name → fallback for `SelectFieldController`
  /// (int or String).
  final Map<String, Object> selects;

  /// Exception: controller name → `FlagFieldController`.
  final Set<String> flags;

  /// Exception: controller name → `IntFieldControllerGroup` (dynamic field
  /// editing).
  final Set<String> groups;

  /// Exception: controller name → `NullableStringFieldController`
  /// (nullable String).
  final Set<String> nullable;

  /// Fields excluded from the form (no controller is generated, and they do
  /// not appear in collect/apply).
  final Set<String> exclude;

  /// Repository providing store/update/get/create. The behavior skeleton
  /// (signals/initSignals/persist/dispose/_logActivity hooks) is only
  /// generated when this is declared; declaring only the entity generates
  /// just the controller boilerplate (backward compatible).
  final Type? repository;

  const FoxyDetailViewModel({
    required this.entity,
    this.selects = const {},
    this.flags = const {},
    this.groups = const {},
    this.nullable = const {},
    this.exclude = const {},
    this.repository,
  });
}

/// Annotates a child-table Linked List ViewModel (the row-editing list of a
/// detail-page tab).
///
/// Generates the controller boilerplate plus the full editor skeleton:
/// link-key subset signal, pagination, race token,
/// copy/create/destroy/edit/persist/setLinkKey/_refresh. The Repository
/// must declare `@FoxyRepository(..., linkKey: [...])` (validated at build
/// time).
@Target({TargetKind.classType})
class FoxyLinkedListViewModel {
  /// The Full Entity type the form maps to.
  final Type entity;

  /// Repository type providing getBrief/count/create/copy/store/update.
  final Type repository;

  /// Exception: controller name → fallback for `SelectFieldController`
  /// (int or String).
  final Map<String, Object> selects;

  /// Exception: controller name → `FlagFieldController`.
  final Set<String> flags;

  /// Exception: controller name → `IntFieldControllerGroup` (dynamic field
  /// editing).
  final Set<String> groups;

  /// Exception: controller name → `NullableStringFieldController`
  /// (nullable String).
  final Set<String> nullable;

  /// Fields excluded from the form (no controller is generated, and they do
  /// not appear in collect/apply).
  final Set<String> exclude;

  const FoxyLinkedListViewModel({
    required this.entity,
    required this.repository,
    this.selects = const {},
    this.flags = const {},
    this.groups = const {},
    this.nullable = const {},
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
/// the primary key); composite-key forms stay hand-written.
@Target({TargetKind.classType})
class FoxyLinkedDetailViewModel {
  /// The Full Entity type the form maps to.
  final Type entity;

  /// Repository type providing get/store/update/destroy/create.
  final Type repository;

  /// Exception: controller name → fallback for `SelectFieldController`
  /// (int or String).
  final Map<String, Object> selects;

  /// Exception: controller name → `FlagFieldController`.
  final Set<String> flags;

  /// Exception: controller name → `IntFieldControllerGroup` (dynamic field
  /// editing).
  final Set<String> groups;

  /// Exception: controller name → `NullableStringFieldController`
  /// (nullable String).
  final Set<String> nullable;

  /// Fields excluded from the form (no controller is generated, and they do
  /// not appear in collect/apply).
  final Set<String> exclude;

  const FoxyLinkedDetailViewModel({
    required this.entity,
    required this.repository,
    this.selects = const {},
    this.flags = const {},
    this.groups = const {},
    this.nullable = const {},
    this.exclude = const {},
  });
}
