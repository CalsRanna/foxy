import 'package:foxy_agent/src/tools/column_semantics.dart';

/// Metadata for one column of a queryable table.
final class ColumnInfo {
  /// Physical column name, as used in tool filters.
  final String name;

  /// Human-readable meaning shown to the model (e.g. a Chinese label).
  final String label;

  /// Logical type such as `int`, `decimal`, `text`, `bool`, or a MySQL
  /// temporal type (`date`, `datetime`, `timestamp`, `time`, `year`).
  final String type;

  /// Whether the column is part of the primary key.
  final bool primaryKey;

  /// Machine-readable meaning (enum values, bit flags, reference target);
  /// `describe_table` shows a summary and `describe_field_values` the detail.
  final ColumnSemantics? semantics;

  const ColumnInfo({
    required this.name,
    this.label = '',
    this.type = 'text',
    this.primaryKey = false,
    this.semantics,
  });

  Map<String, Object?> toJson() => {
    'name': name,
    if (label.isNotEmpty) 'label': label,
    'type': type,
    if (primaryKey) 'primaryKey': true,
    if (semantics != null) 'semantics': semantics!.summaryJson(),
  };
}

/// The set of tables an agent may read, possibly spanning several databases.
final class TableCatalog {
  final List<TableInfo> tables;

  const TableCatalog(this.tables);

  /// Resolves a model-facing table name.
  ///
  /// Matches the qualified name (`database.name`) first, then the bare name
  /// when exactly one table uses it. Returns `null` when the name is unknown
  /// or a bare name is ambiguous.
  TableInfo? find(String name) {
    TableInfo? bareMatch;
    var bareMatches = 0;
    for (final table in tables) {
      if (table.qualifiedName == name) {
        return table;
      }
      if (table.name == name) {
        bareMatch ??= table;
        bareMatches++;
      }
    }
    return bareMatches == 1 ? bareMatch : null;
  }
}

/// Metadata for one queryable table.
final class TableInfo {
  /// Physical table name, without the database qualifier.
  final String name;

  /// Optional database (schema) qualifier, e.g. `foxy`.
  ///
  /// When set, [qualifiedName] (`database.name`) is the canonical name the
  /// built-in tools accept and pass to the data source.
  final String database;

  /// Human-readable meaning shown to the model.
  final String label;

  /// Column metadata; column names must be provided for filter validation.
  final List<ColumnInfo> columns;

  const TableInfo({
    required this.name,
    this.database = '',
    this.label = '',
    this.columns = const [],
  });

  /// Columns flagged as the primary key.
  Iterable<ColumnInfo> get primaryKey =>
      columns.where((column) => column.primaryKey);

  bool hasSingleColumnPrimaryKey(String column) {
    final keys = primaryKey.toList();
    return keys.length == 1 && keys.single.name == column;
  }

  /// The canonical model-facing name: `database.name` when [database] is set,
  /// otherwise [name].
  String get qualifiedName => database.isEmpty ? name : '$database.$name';

  /// The column named [name], or `null` when it is unknown.
  ColumnInfo? findColumn(String name) {
    for (final column in columns) {
      if (column.name == name) {
        return column;
      }
    }
    return null;
  }

  Map<String, Object?> toJson() => {
    'name': qualifiedName,
    if (database.isNotEmpty) 'database': database,
    if (label.isNotEmpty) 'label': label,
    'columns': [for (final column in columns) column.toJson()],
  };
}
