import 'package:meta/meta_meta.dart';

@Target({TargetKind.classType})
final class FoxyFilter {
  /// Physical column name; when omitted, the generator infers it via
  /// "filter name → entity field with the same name → that field's
  /// `@FoxyFullField` column name", and errors at build time if it cannot be
  /// inferred.
  final String? column;
  final Object defaultValue;
  final String name;
  final FoxyFilterType type;

  const FoxyFilter.boolean(
    this.name, {
    bool this.defaultValue = false,
    this.column,
  }) : type = FoxyFilterType.boolean;

  const FoxyFilter.decimal(
    this.name, {
    double this.defaultValue = 0.0,
    this.column,
  }) : type = FoxyFilterType.decimal;

  const FoxyFilter.integer(this.name, {int this.defaultValue = 0, this.column})
    : type = FoxyFilterType.integer;

  const FoxyFilter.text(this.name, {String this.defaultValue = '', this.column})
    : type = FoxyFilterType.text;
}

enum FoxyFilterType { boolean, decimal, integer, text }

@Target({TargetKind.classType})
final class FoxyRepository {
  /// The Full Entity this repository maps to; when omitted, the generator
  /// derives it from the class name (`XxxRepository` → `XxxEntity`).
  final Type? entity;

  /// Link-key fields (entity dart names). When declared, the query layer is
  /// generated in the link-key form: `getBrief*`/`count*`/`create*` take the
  /// link keys as their first positional parameters, and lists only query
  /// the subset under those link values (e.g. the "Loot" tab of the creature
  /// detail page). Most child tables have one link key; the
  /// player_create_info family uses two, (race, class).
  final List<String> linkKey;

  /// Primary-key field that store automatically reallocates on a duplicate
  /// key (entity dart name).
  ///
  /// In composite-key tables (e.g. smart_scripts'
  /// entryorguid/source_type/id/link), "pasting an existing row" triggers an
  /// ER_DUP_ENTRY retry: if undeclared, the generated code takes a global
  /// MAX+1 for every non-link int primary key, which can silently write
  /// unrelated garbage rows. Once declared, the retry only reallocates this
  /// column, scoped by [autoIncrementScope] (matching the hand-written
  /// `copySmartScript` which recomputes only `id` with scope
  /// `entryorguid+source_type`). When undeclared and there is more than one
  /// non-link int primary key, the retry throws [DuplicateKeyException]
  /// rather than rewriting several keys.
  final String? autoIncrementKey;

  /// Scope fields for the [autoIncrementKey] reallocation (entity dart
  /// names; must be key fields). Merged with [linkKey] into the where
  /// condition of `nextMaxPlusOne`.
  final List<String> autoIncrementScope;

  const FoxyRepository({
    this.entity,
    this.linkKey = const [],
    this.autoIncrementKey,
    this.autoIncrementScope = const [],
  });
}
