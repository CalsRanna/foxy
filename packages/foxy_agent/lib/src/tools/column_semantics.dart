/// One labelled bit inside a flags column.
final class ColumnFlag {
  /// Bit value (a power of two for single-bit flags).
  final int value;

  /// Human-readable meaning.
  final String label;

  const ColumnFlag({required this.value, required this.label});

  Map<String, Object?> toJson() => {'value': value, 'label': label};
}

/// Target of a reference (id) column.
final class ColumnReference {
  /// Referenced table, as listed by `list_tables` (may be qualified).
  final String table;

  /// Referenced column, usually the primary key.
  final String column;

  const ColumnReference({required this.table, required this.column});

  Map<String, Object?> toJson() => {'table': table, 'column': column};
}

/// What kind of meaning a [ColumnSemantics] carries.
enum ColumnSemanticKind { enumValues, flags, reference }

/// Machine-readable meaning of a physical column.
///
/// Attached to `ColumnInfo` by the host app; `describe_table` shows the
/// compact [summaryJson], and the `describe_field_values` tool returns the
/// full [toJson] on demand so large value tables never bloat every schema
/// response.
final class ColumnSemantics {
  /// Human-readable label, e.g. `生物类型`.
  final String label;

  final ColumnSemanticKind _kind;

  /// Enum value → label (only for [ColumnSemanticKind.enumValues]).
  final Map<int, String> _values;

  /// Bit definitions (only for [ColumnSemanticKind.flags]).
  final List<ColumnFlag> flags;

  /// Reference target (only for [ColumnSemanticKind.reference]).
  final ColumnReference? reference;

  const ColumnSemantics.enumValues({
    required String label,
    required Map<int, String> values,
  }) : this._(label, ColumnSemanticKind.enumValues, values, const [], null);

  const ColumnSemantics.flags({
    required String label,
    required List<ColumnFlag> flags,
  }) : this._(label, ColumnSemanticKind.flags, const {}, flags, null);

  const ColumnSemantics.reference({
    required String label,
    required ColumnReference reference,
  }) : this._(
         label,
         ColumnSemanticKind.reference,
         const {},
         const [],
         reference,
       );

  const ColumnSemantics._(
    this.label,
    this._kind,
    this._values,
    this.flags,
    this.reference,
  );

  ColumnSemanticKind get kind => _kind;

  Map<int, String> get values => _values;

  String get _kindName => switch (_kind) {
    ColumnSemanticKind.enumValues => 'enum',
    ColumnSemanticKind.flags => 'flags',
    ColumnSemanticKind.reference => 'reference',
  };

  /// Compact form shown by `describe_table`.
  Map<String, Object?> summaryJson() => {
    'kind': _kindName,
    'label': label,
    if (reference != null) 'reference': reference!.toJson(),
  };

  /// Full form returned by `describe_field_values`.
  Map<String, Object?> toJson() => {
    'kind': _kindName,
    'label': label,
    ...switch (_kind) {
      ColumnSemanticKind.enumValues => {
        'values': {
          for (final entry in _values.entries) '${entry.key}': entry.value,
        },
      },
      ColumnSemanticKind.flags => {
        'flags': [for (final flag in flags) flag.toJson()],
      },
      ColumnSemanticKind.reference => {'reference': reference!.toJson()},
    },
  };
}
