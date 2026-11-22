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

/// A field meaning that applies when every comparison in [when] holds.
final class ColumnSemanticBranch {
  final String label;
  final List<ColumnSemanticCondition> when;
  final ColumnSemantics semantics;

  const ColumnSemanticBranch({
    required this.label,
    required this.when,
    required this.semantics,
  });

  Map<String, Object?> toJson({required bool compact}) => {
    'label': label,
    'when': when.map((condition) => condition.toJson()).toList(),
    'semantics': compact ? semantics.summaryJson() : semantics.toJson(),
  };
}

/// An integer comparison over the row that determines a field's meaning.
final class ColumnSemanticCondition {
  final String column;
  final FilterOperator operator;
  final int value;

  const ColumnSemanticCondition.equals(this.column, this.value)
    : operator = FilterOperator.equals;

  const ColumnSemanticCondition.lessThan(this.column, this.value)
    : operator = FilterOperator.lessThan;

  bool matches(Map<String, Object?> context) {
    if (!context.containsKey(column)) return true;
    final actual = context[column];
    return operator == FilterOperator.equals
        ? actual == value
        : actual is num && actual < value;
  }

  Map<String, Object?> toJson() => {
    'column': column,
    'operator': operator.wireName,
    'value': value,
  };
}

/// What kind of meaning a [ColumnSemantics] carries.
enum ColumnSemanticKind {
  enumValues,
  flags,
  reference,
  number,
  unused,
  conditional,
}

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

  final List<String> dependsOn;
  final List<ColumnSemanticBranch> Function(List<String>)? _buildBranches;
  final Map<int, String> _specialValues;

  const ColumnSemantics.conditional({
    required String label,
    required List<String> dependsOn,
    required List<ColumnSemanticBranch> Function(List<String>) branches,
  }) : this._(
         label,
         ColumnSemanticKind.conditional,
         const {},
         const [],
         null,
         dependsOn: dependsOn,
         buildBranches: branches,
       );

  const ColumnSemantics.enumValues({
    required String label,
    required Map<int, String> values,
  }) : this._(label, ColumnSemanticKind.enumValues, values, const [], null);

  const ColumnSemantics.flags({
    required String label,
    required List<ColumnFlag> flags,
  }) : this._(label, ColumnSemanticKind.flags, const {}, flags, null);

  const ColumnSemantics.number({
    required String label,
    Map<int, String> specialValues = const {},
  }) : this._(
         label,
         ColumnSemanticKind.number,
         const {},
         const [],
         null,
         specialValues: specialValues,
       );

  const ColumnSemantics.reference({
    required String label,
    required ColumnReference reference,
    Map<int, String> specialValues = const {},
  }) : this._(
         label,
         ColumnSemanticKind.reference,
         const {},
         const [],
         reference,
         specialValues: specialValues,
       );

  const ColumnSemantics.unused({required String label})
    : this._(label, ColumnSemanticKind.unused, const {}, const [], null);

  const ColumnSemantics._(
    this.label,
    this._kind,
    this._values,
    this.flags,
    this.reference, {
    this.dependsOn = const [],
    this._buildBranches,
    this._specialValues = const {},
  });

  ColumnSemanticKind get kind => _kind;

  Map<int, String> get values => _values;

  String get _kindName => switch (_kind) {
    ColumnSemanticKind.enumValues => 'enum',
    ColumnSemanticKind.flags => 'flags',
    ColumnSemanticKind.reference => 'reference',
    ColumnSemanticKind.number => 'number',
    ColumnSemanticKind.unused => 'unused',
    ColumnSemanticKind.conditional => 'conditional',
  };

  /// Returns the matching conditional branch and details for a row.
  Map<String, Object?> describeForRow(
    String column,
    Map<String, Object?> context,
  ) {
    final matching = _buildBranches!(dependsOn)
        .where((branch) => branch.when.every((test) => test.matches(context)))
        .toList();
    final missing = dependsOn
        .where(
          (name) =>
              !context.containsKey(name) &&
              matching.any(
                (branch) => branch.when.any((test) => test.column == name),
              ),
        )
        .toList();
    final rawValue = context[column];
    final result = {
      ...summaryJson(),
      if (context.containsKey(column)) 'value': rawValue,
    };
    if (missing.isNotEmpty) {
      return {
        ...result,
        'status': 'needsContext',
        'missingContext': missing,
        'branches': matching
            .map((branch) => branch.toJson(compact: true))
            .toList(),
      };
    }
    if (matching.length != 1) {
      return {...result, 'status': 'unknown'};
    }
    final branch = matching.single;
    final valueLabel =
        branch.semantics._specialValues[rawValue] ??
        branch.semantics.values[rawValue];
    return {
      ...result,
      'status': 'resolved',
      'branch': branch.toJson(compact: false),
      'valueLabel': ?valueLabel,
    };
  }

  /// Compact form shown by `describe_table`.
  Map<String, Object?> summaryJson() => {
    'kind': _kindName,
    'label': label,
    if (reference != null) 'reference': reference!.toJson(),
    if (dependsOn.isNotEmpty) 'dependsOn': dependsOn,
    if (_specialValues.isNotEmpty)
      'specialValues': {
        for (final entry in _specialValues.entries) '${entry.key}': entry.value,
      },
  };

  /// Full form returned by `describe_field_values`.
  Map<String, Object?> toJson() => {
    ...summaryJson(),
    ...switch (_kind) {
      ColumnSemanticKind.enumValues => {
        'values': {
          for (final entry in _values.entries) '${entry.key}': entry.value,
        },
      },
      ColumnSemanticKind.flags => {
        'flags': [for (final flag in flags) flag.toJson()],
      },
      ColumnSemanticKind.conditional => {
        'branches': _buildBranches!(dependsOn)
            .map((branch) => branch.toJson(compact: true))
            .toList(),
      },
      _ => const <String, Object?>{},
    },
  };
}

/// Comparison used by a conditional semantic branch.
enum FilterOperator {
  equals('equals'),
  lessThan('lessThan');

  /// Name used in tool output.
  final String wireName;

  const FilterOperator(this.wireName);
}
