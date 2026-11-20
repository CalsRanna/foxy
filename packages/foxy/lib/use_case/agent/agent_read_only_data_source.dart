import 'package:collection/collection.dart';
import 'package:foxy/constant/agent_field_semantics.dart';
import 'package:foxy/exception/foxy_exceptions.dart';
import 'package:foxy/infrastructure/config/config_util.dart';
import 'package:foxy/infrastructure/database/database.dart';
import 'package:foxy_agent/foxy_agent.dart';
import 'package:laconic/laconic.dart';

/// Read-only data access for the built-in agent tools.
///
/// The catalog is built from `information_schema` for the world, characters,
/// auth and `foxy` schemas. Queries select only columns in that catalog.
class AgentReadOnlyDataSource implements ReadOnlyDataSource {
  static const _foxySchema = 'foxy';
  static const _defaultCharactersDatabase = 'acore_characters';
  static const _defaultAuthDatabase = 'acore_auth';

  static const _authAccountColumns = {
    'id',
    'username',
    'email',
    'reg_mail',
    'joindate',
    'last_ip',
    'last_attempt_ip',
    'failed_logins',
    'locked',
    'lock_country',
    'last_login',
    'online',
    'expansion',
    'flags',
    'mutetime',
    'mutereason',
    'muteby',
    'locale',
    'os',
    'recruiter',
    'totaltime',
  };

  static const _maxRows = 51;

  final ConfigUtil _configUtil;
  final Laconic? _laconic;

  TableCatalog? _catalog;

  AgentReadOnlyDataSource(this._configUtil, {this._laconic});

  Laconic get _database => _laconic ?? Database.instance.laconic;

  /// Loads (and caches) the table catalog from `information_schema`.
  Future<TableCatalog> getCatalog({bool refresh = false}) async {
    final cached = _catalog;
    if (!refresh && cached != null) return cached;
    final config = await _configUtil.load();
    final worldDatabase = _databaseName(config['database']);
    if (worldDatabase == null) {
      throw const DatabaseNotConnectedException(
        'world database name is not configured',
      );
    }
    final charactersDatabase =
        _databaseName(config['characters_database']) ??
        _defaultCharactersDatabase;
    final authDatabase =
        _databaseName(config['auth_database']) ?? _defaultAuthDatabase;
    final rows = await _database
        .table('information_schema.columns')
        .whereIn('table_schema', [
          worldDatabase,
          _foxySchema,
          charactersDatabase,
          authDatabase,
        ])
        .orderBy('table_schema')
        .orderBy('table_name')
        .orderBy('ordinal_position')
        .get();
    final catalog = buildCatalog(
      rows.map((row) => row.toMap()).toList(),
      worldDatabase: worldDatabase,
      authDatabase: authDatabase,
      semantics: AgentFieldSemantics.values,
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
    final tableName = _quoteIdentifier(info.name);
    final qualifiedName = info.database.isEmpty
        ? tableName
        : '${_quoteIdentifier(info.database)}.$tableName';
    final columns = info.columns
        .map((column) => _quoteIdentifier(column.name))
        .toList();
    final query = filters.fold<QueryBuilder>(
      _database.table(qualifiedName).select(columns),
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

  /// Builds the agent catalog from `information_schema.columns` rows.
  ///
  /// World tables stay unqualified. Other tables retain their schema name.
  /// Auth credentials are omitted from the catalog and query projections.
  static TableCatalog buildCatalog(
    List<Map<String, Object?>> rows, {
    required String worldDatabase,
    String authDatabase = _defaultAuthDatabase,
    Map<String, Map<String, ColumnSemantics>> semantics = const {},
  }) {
    final authSchema = authDatabase.toLowerCase();
    final parsed = rows.map(_parseColumn).whereType<_CatalogColumn>().where((
      row,
    ) {
      if (row.schema.toLowerCase() != authSchema) return true;
      return switch (row.table.toLowerCase()) {
        'account' => _authAccountColumns.contains(
          row.column.name.toLowerCase(),
        ),
        'secret_digest' => false,
        _ => true,
      };
    });
    final grouped = groupBy(
      parsed,
      (column) => '${column.schema}.${column.table}',
    );
    final tables = grouped.entries.map((entry) {
      final first = entry.value.first;
      final database = first.schema == worldDatabase ? '' : first.schema;
      final qualified = database.isEmpty
          ? first.table
          : '$database.${first.table}';
      final tableSemantics =
          semantics[qualified] ??
          (database == _foxySchema ? semantics[first.table] : null);
      return TableInfo(
        name: first.table,
        database: database,
        columns: entry.value
            .map(
              (column) => _withSemantics(
                column.column,
                tableSemantics?[column.column.name],
              ),
            )
            .toList(),
      );
    }).toList();
    return TableCatalog(tables);
  }

  static QueryBuilder _applyFilter(QueryBuilder builder, RowFilter filter) {
    final column = _quoteIdentifier(filter.column);
    final value = filter.value;
    return switch (filter.operator) {
      FilterOperator.equals =>
        value == null
            ? builder.whereNull(column)
            : builder.where(column, value),
      FilterOperator.notEquals =>
        value == null
            ? builder.whereNotNull(column)
            : builder.whereNot(column, value),
      FilterOperator.contains => builder.whereLike(column, '%$value%'),
      FilterOperator.inList => builder.whereIn(
        column,
        value is List<Object?> ? value : const <Object?>[],
      ),
      FilterOperator.greaterThan => builder.where(
        column,
        value,
        comparator: '>',
      ),
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

  static String? _databaseName(Object? value) =>
      value is String && value.isNotEmpty ? value : null;

  static String _logicalType(String dataType) {
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

  static _CatalogColumn? _parseColumn(Map<String, Object?> row) {
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

  static String _quoteIdentifier(String value) =>
      '`${value.replaceAll('`', '``')}`';

  static String _rowString(Map<String, Object?> row, String key) {
    final value = row.entries
        .firstWhereOrNull(
          (entry) => entry.key.toUpperCase() == key.toUpperCase(),
        )
        ?.value;
    return value is String ? value : '';
  }

  static ColumnInfo _withSemantics(
    ColumnInfo column,
    ColumnSemantics? semantics,
  ) {
    if (semantics == null) return column;
    return ColumnInfo(
      name: column.name,
      label: column.label,
      type: column.type,
      primaryKey: column.primaryKey,
      semantics: semantics,
    );
  }
}

final class _CatalogColumn {
  final String schema;

  final String table;

  final ColumnInfo column;

  const _CatalogColumn({
    required this.schema,
    required this.table,
    required this.column,
  });
}
