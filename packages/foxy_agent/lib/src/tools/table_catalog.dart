/// Metadata for one column of a queryable table.
final class ColumnInfo {
  const ColumnInfo({
    required this.name,
    this.label = '',
    this.type = 'text',
    this.primaryKey = false,
  });

  /// Physical column name, as used in tool filters.
  final String name;

  /// Human-readable meaning shown to the model (e.g. a Chinese label).
  final String label;

  /// Logical type: `int`, `decimal`, `text` or `bool`.
  final String type;

  /// Whether the column is part of the primary key.
  final bool primaryKey;

  Map<String, Object?> toJson() => {
    'name': name,
    if (label.isNotEmpty) 'label': label,
    'type': type,
    if (primaryKey) 'primaryKey': true,
  };
}

/// Metadata for one queryable table.
final class TableInfo {
  const TableInfo({
    required this.name,
    this.database = '',
    this.label = '',
    this.columns = const [],
  });

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

  /// The canonical model-facing name: `database.name` when [database] is set,
  /// otherwise [name].
  String get qualifiedName => database.isEmpty ? name : '$database.$name';

  /// Columns flagged as the primary key.
  Iterable<ColumnInfo> get primaryKey =>
      columns.where((column) => column.primaryKey);

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

/// The set of tables an agent may read, possibly spanning several databases.
final class TableCatalog {
  const TableCatalog(this.tables);

  final List<TableInfo> tables;

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
