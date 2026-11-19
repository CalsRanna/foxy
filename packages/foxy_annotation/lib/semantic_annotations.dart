import 'package:foxy_game_definition/foxy_game_definition.dart';
import 'package:meta/meta_meta.dart';

/// Declares the machine-readable meaning of a physical column.
///
/// The semantics generator aggregates these declarations into the runtime
/// table consumed by non-UI consumers (the agent catalog). UI editors keep
/// their own wiring; the label data itself stays defined in
/// `foxy_game_definition`.
@Target({TargetKind.field})
final class FoxyFieldMeaning {
  const FoxyFieldMeaning._(
    this.label,
    this.values,
    this.flags,
    this.referenceTable,
    this.referenceColumn,
  );

  const FoxyFieldMeaning.enumValues(
    String label, {
    required Map<int, String> values,
  }) : this._(label, values, null, null, null);

  const FoxyFieldMeaning.flags(String label, {required List<FlagItem> flags})
    : this._(label, null, flags, null, null);

  const FoxyFieldMeaning.reference(
    String label, {
    required String table,
    required String column,
  }) : this._(label, null, null, table, column);

  /// Human-readable label, e.g. `生物类型`.
  final String label;

  /// Enum value → label, set by [FoxyFieldMeaning.enumValues].
  final Map<int, String>? values;

  /// Bit flags, set by [FoxyFieldMeaning.flags].
  final List<FlagItem>? flags;

  /// Referenced table, set by [FoxyFieldMeaning.reference].
  final String? referenceTable;

  /// Referenced column, set by [FoxyFieldMeaning.reference].
  final String? referenceColumn;
}
