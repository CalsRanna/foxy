import 'package:collection/collection.dart';
import 'package:foxy/constant/agent_field_semantics.dart';
import 'package:foxy/constant/character_agent_field_semantics.dart';
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

  @override
  Future<List<Map<String, Object?>>> aggregateRows({
    required String table,
    required List<RowFilter> filters,
    required List<String> groupBy,
    required List<AggregateMetric> metrics,
    required int limit,
    List<RowOrder> orderBy = const [],
    int offset = 0,
  }) async {
    final info = await _tableInfo(table);
    final error = validateAggregation(info, groupBy, metrics);
    if (error != null) throw ValidationException(error);
    final columns = groupBy.map(_quoteIdentifier).toList();
    for (final metric in metrics) {
      final column = metric.column == null
          ? '*'
          : _quoteIdentifier(metric.column!);
      columns.add(
        '${metric.function.name.toUpperCase()}($column) as '
        '${_quoteIdentifier(metric.outputName)}',
      );
    }
    final query = _filteredQuery(info, filters).select(columns);
    for (final column in groupBy) {
      query.groupBy(_quoteIdentifier(column));
    }
    _applyPage(
      query,
      orderBy: orderBy,
      allowedColumns: {
        ...groupBy,
        for (final metric in metrics) metric.outputName,
      },
      tieBreakers: groupBy,
      limit: limit.clamp(1, AggregateRowsTool.maxLimit + 1),
      offset: offset,
    );
    final rows = await query.get();
    return rows.map((row) => row.toMap()).toList();
  }

  @override
  Future<int> countRows({
    required String table,
    required List<RowFilter> filters,
  }) async {
    final info = await _tableInfo(table);
    return _filteredQuery(info, filters).count();
  }

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
      charactersDatabase: charactersDatabase,
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
    List<RowOrder> orderBy = const [],
    int offset = 0,
  }) async {
    final info = await _tableInfo(table);
    final columns = info.columns
        .map((column) => _quoteIdentifier(column.name))
        .toList();
    final query = _filteredQuery(info, filters).select(columns);
    _applyPage(
      query,
      orderBy: orderBy,
      allowedColumns: {for (final column in info.columns) column.name},
      tieBreakers: info.primaryKey.map((column) => column.name),
      limit: limit.clamp(1, _maxRows),
      offset: offset,
    );
    final rows = await query.get();
    return rows.map((row) => row.toMap()).toList();
  }

  @override
  Future<Map<String, Object?>> serverTime() async {
    final rows = await _database.select('''
select CAST(CURRENT_TIMESTAMP(6) AS CHAR) as `localTime`,
       DATE_FORMAT(UTC_TIMESTAMP(6), '%Y-%m-%dT%H:%i:%s.%fZ') as `utcTime`,
       @@session.time_zone as `sessionTimeZone`,
       @@system_time_zone as `systemTimeZone`,
       TIMESTAMPDIFF(SECOND, UTC_TIMESTAMP(6), CURRENT_TIMESTAMP(6)) as `utcOffsetSeconds`,
       UNIX_TIMESTAMP() as `unixTimestamp`
''');
    return rows.single.toMap();
  }

  QueryBuilder _filteredQuery(TableInfo info, List<RowFilter> filters) {
    final table = _quoteIdentifier(info.name);
    final qualified = info.database.isEmpty
        ? table
        : '${_quoteIdentifier(info.database)}.$table';
    return filters.fold<QueryBuilder>(_database.table(qualified), (
      builder,
      filter,
    ) {
      if (info.findColumn(filter.column) == null) {
        throw ValidationException(
          'unknown column for agent table ${info.qualifiedName}: ${filter.column}',
        );
      }
      final value = filter.value;
      if (filter.operator == FilterOperator.inList) {
        if (value is! List<Object?> ||
            value.isEmpty ||
            value.any((item) => item is List || item is Map)) {
          throw const ValidationException(
            'in filter requires a non-empty scalar array',
          );
        }
      } else if (value is List || value is Map) {
        throw const ValidationException('filter requires a scalar value');
      }
      return _applyFilter(builder, filter);
    });
  }

  Future<TableInfo> _tableInfo(String table) async {
    final catalog = await getCatalog();
    final info = catalog.find(table);
    if (info == null) throw ValidationException('unknown agent table: $table');
    return info;
  }

  /// Builds the agent catalog from `information_schema.columns` rows.
  ///
  /// World tables stay unqualified. Other tables retain their schema name.
  /// Auth credentials are omitted from the catalog and query projections.
  static TableCatalog buildCatalog(
    List<Map<String, Object?>> rows, {
    required String worldDatabase,
    String charactersDatabase = _defaultCharactersDatabase,
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
    final characterSemantics = CharacterAgentFieldSemantics.forDatabase(
      charactersDatabase,
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
                tableSemantics?[column.column.name] ??
                    characterSemantics[qualified]?[column.column.name],
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

  static void _applyPage(
    QueryBuilder query, {
    required List<RowOrder> orderBy,
    required Set<String> allowedColumns,
    required Iterable<String> tieBreakers,
    required int limit,
    required int offset,
  }) {
    if (offset < 0) {
      throw const ValidationException('offset must be non-negative');
    }
    final sorted = <String>{};
    for (final order in orderBy) {
      if (!allowedColumns.contains(order.column) || !sorted.add(order.column)) {
        throw ValidationException(
          'unknown or duplicate sort column: ${order.column}',
        );
      }
      query.orderBy(
        _quoteIdentifier(order.column),
        direction: order.direction.name,
      );
    }
    for (final column in tieBreakers) {
      if (!sorted.contains(column)) query.orderBy(_quoteIdentifier(column));
    }
    query.limit(limit);
    if (offset != 0) query.offset(offset);
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
    return switch (type) {
      'bit' => 'bool',
      'date' || 'datetime' || 'timestamp' || 'time' || 'year' => type,
      _ => 'text',
    };
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
