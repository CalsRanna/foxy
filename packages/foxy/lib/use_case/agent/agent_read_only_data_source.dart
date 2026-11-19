import 'package:collection/collection.dart';
import 'package:foxy/exception/foxy_exceptions.dart';
import 'package:foxy/infrastructure/config/config_util.dart';
import 'package:foxy/infrastructure/database/database.dart';
import 'package:foxy_agent/foxy_agent.dart';
import 'package:laconic/laconic.dart';

const _foxySchema = 'foxy';

/// Read-only data access for the built-in agent tools.
///
/// The catalog is built from `information_schema` for the connected world
/// database and the `foxy` schema. Every query re-resolves the table and its
/// columns against that catalog before a parameterized `select` is built, so
/// only allowlisted tables/columns ever reach SQL. Only reads are issued.
class AgentReadOnlyDataSource implements ReadOnlyDataSource {
  AgentReadOnlyDataSource(this._configUtil);

  static const _maxRows = 51;

  final ConfigUtil _configUtil;

  TableCatalog? _catalog;

  /// Loads (and caches) the table catalog from `information_schema`.
  Future<TableCatalog> getCatalog({bool refresh = false}) async {
    final cached = _catalog;
    if (!refresh && cached != null) return cached;
    final worldDatabase = await _worldDatabaseName();
    final rows = await Database.instance.laconic
        .table('information_schema.columns')
        .whereIn('table_schema', [worldDatabase, _foxySchema])
        .orderBy('table_schema')
        .orderBy('table_name')
        .orderBy('ordinal_position')
        .get();
    final catalog = buildAgentTableCatalog(
      rows.map((row) => row.toMap()).toList(),
    );
    _catalog = catalog;
    return catalog;
  }

  @override
  Future<List<Map<String, Object?>>> queryRows({
    required String table,
    required List<RowFilter> filters,
    required int limit,
  }) async {
    final catalog = await getCatalog();
    final info = catalog.find(table);
    if (info == null) {
      throw ValidationException('unknown agent table: $table');
    }
    final query = filters.fold<QueryBuilder>(
      Database.instance.laconic.table(info.qualifiedName),
      (builder, filter) {
        if (info.findColumn(filter.column) == null) {
          throw ValidationException(
            'unknown column for agent table ${info.qualifiedName}: '
            '${filter.column}',
          );
        }
        return _applyFilter(builder, filter);
      },
    );
    final capped = limit < 1 ? 1 : (limit > _maxRows ? _maxRows : limit);
    final rows = await query.limit(capped).get();
    return rows.map((row) => row.toMap()).toList();
  }

  Future<String> _worldDatabaseName() async {
    final config = await _configUtil.load();
    final database = config['database'];
    if (database is String && database.isNotEmpty) return database;
    throw const DatabaseNotConnectedException(
      'world database name is not configured',
    );
  }
}

/// Builds the agent catalog from `information_schema.columns` rows.
///
/// World tables stay unqualified; `foxy` schema tables carry the `foxy`
/// qualifier so the model can tell the two namespaces apart. Result map keys
/// use the server casing (uppercase for `information_schema`), so lookups are
/// case-insensitive.
TableCatalog buildAgentTableCatalog(List<Map<String, Object?>> rows) {
  final parsed = rows.map(_parseColumn).whereType<_CatalogColumn>().toList();
  final grouped = groupBy(
    parsed,
    (column) => '${column.schema}.${column.table}',
  );
  final tables = grouped.entries.map((entry) {
    final first = entry.value.first;
    return TableInfo(
      name: first.table,
      database: first.schema == _foxySchema ? _foxySchema : '',
      columns: entry.value.map((column) => column.column).toList(),
    );
  }).toList();
  return TableCatalog(tables);
}

final class _CatalogColumn {
  const _CatalogColumn({
    required this.schema,
    required this.table,
    required this.column,
  });

  final String schema;

  final String table;

  final ColumnInfo column;
}

_CatalogColumn? _parseColumn(Map<String, Object?> row) {
  final schema = _rowString(row, 'TABLE_SCHEMA');
  final tableName = _rowString(row, 'TABLE_NAME');
  final columnName = _rowString(row, 'COLUMN_NAME');
  if (schema.isEmpty || tableName.isEmpty || columnName.isEmpty) return null;
  return _CatalogColumn(
    schema: schema,
    table: tableName,
    column: ColumnInfo(
      name: columnName,
      label: _rowString(row, 'COLUMN_COMMENT'),
      type: _logicalType(_rowString(row, 'DATA_TYPE')),
      primaryKey: _rowString(row, 'COLUMN_KEY') == 'PRI',
    ),
  );
}

String _rowString(Map<String, Object?> row, String key) {
  final value = row.entries
      .firstWhereOrNull((entry) => entry.key.toUpperCase() == key.toUpperCase())
      ?.value;
  return value is String ? value : '';
}

String _logicalType(String dataType) {
  final type = dataType.toLowerCase();
  if (type.contains('int')) return 'int';
  if (type.contains('decimal') ||
      type.contains('numeric') ||
      type.contains('float') ||
      type.contains('double')) {
    return 'decimal';
  }
  if (type == 'bit') return 'bool';
  return 'text';
}

QueryBuilder _applyFilter(QueryBuilder builder, RowFilter filter) {
  final column = '`${filter.column}`';
  final value = filter.value;
  return switch (filter.operator) {
    FilterOperator.equals =>
      value == null ? builder.whereNull(column) : builder.where(column, value),
    FilterOperator.notEquals =>
      value == null
          ? builder.whereNotNull(column)
          : builder.whereNot(column, value),
    FilterOperator.contains => builder.whereLike(column, '%$value%'),
    FilterOperator.inList => builder.whereIn(
      column,
      value is List<Object?> ? value : const <Object?>[],
    ),
    FilterOperator.greaterThan => builder.where(column, value, comparator: '>'),
    FilterOperator.greaterOrEqual => builder.where(
      column,
      value,
      comparator: '>=',
    ),
    FilterOperator.lessThan => builder.where(column, value, comparator: '<'),
    FilterOperator.lessOrEqual => builder.where(
      column,
      value,
      comparator: '<=',
    ),
  };
}
