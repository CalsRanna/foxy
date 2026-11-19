/// A comparison applied to a single column.
final class RowFilter {
  const RowFilter({
    required this.column,
    required this.operator,
    required this.value,
  });

  final String column;

  final FilterOperator operator;

  /// Scalar value to compare against; for [FilterOperator.inList] a non-empty
  /// list of scalars.
  final Object? value;
}

/// Comparison operators supported by row filters.
enum FilterOperator {
  equals('equals'),
  notEquals('notEquals'),
  contains('contains'),
  inList('in'),
  greaterThan('greaterThan'),
  greaterOrEqual('greaterOrEqual'),
  lessThan('lessThan'),
  lessOrEqual('lessOrEqual');

  const FilterOperator(this.wireName);

  /// Name used in tool input and error messages.
  final String wireName;

  /// Parses a wire name; returns `null` when it is unknown.
  static FilterOperator? tryParse(String name) {
    for (final operator in values) {
      if (operator.wireName == name) {
        return operator;
      }
    }
    return null;
  }
}

/// Read-only data access used by the built-in tools.
///
/// Implementations live in the host app and must:
/// - only read and never write;
/// - reject tables and columns outside the catalog allowlist;
/// - return at most [limit] rows, with JSON-encodable values.
abstract interface class ReadOnlyDataSource {
  /// Returns rows of [table] matching every filter (logical AND).
  Future<List<Map<String, Object?>>> queryRows({
    required String table,
    required List<RowFilter> filters,
    required int limit,
  });
}
