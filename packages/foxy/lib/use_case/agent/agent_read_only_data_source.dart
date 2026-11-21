import 'dart:convert';

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
class AgentReadOnlyDataSource
    implements
        ReadOnlyDataSource,
        ReadOnlySqlDataSource,
        SqlDiagnosticsDataSource {
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

  static const _planFields = {
    'query_block',
    'select_id',
    'cost_info',
    'query_cost',
    'sort_cost',
    'read_cost',
    'eval_cost',
    'prefix_cost',
    'data_read_per_join',
    'ordering_operation',
    'grouping_operation',
    'duplicates_removal',
    'nested_loop',
    'table',
    'table_name',
    'access_type',
    'possible_keys',
    'key',
    'key_length',
    'ref',
    'rows_examined_per_scan',
    'rows_produced_per_join',
    'filtered',
    'using_index',
    'using_filesort',
    'using_temporary_table',
    'using_join_buffer',
    'message',
    'inputs',
    'index_name',
    'estimated_rows',
    'estimated_total_cost',
    'estimated_first_row_cost',
  };

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

  @override
  Future<Map<String, Object?>> explainSql(ReadOnlySql sql) async {
    final database = _database;
    final rows = await database.select('EXPLAIN FORMAT=JSON ${sql.statement}');
    final plan = switch (rows.single.values) {
      [final String value] => jsonDecode(value),
      _ => throw const FormatException('MySQL did not return a JSON plan.'),
    };
    if (plan is! Map<String, Object?>) {
      throw const FormatException('MySQL did not return a JSON plan object.');
    }
    return {
      'plan': _diagnosticPlan(plan, sql.tables),
      'tables': await _tableStatistics(database, sql.tables),
    };
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
    final rows = await _database.select(
      '''
select c.*, t.TABLE_TYPE
from information_schema.columns c
join information_schema.tables t
  on c.TABLE_SCHEMA = t.TABLE_SCHEMA and c.TABLE_NAME = t.TABLE_NAME
 and binary c.TABLE_SCHEMA = binary t.TABLE_SCHEMA
 and binary c.TABLE_NAME = binary t.TABLE_NAME
where c.TABLE_SCHEMA in (?, ?, ?, ?)
order by c.TABLE_SCHEMA, c.TABLE_NAME, c.ORDINAL_POSITION
''',
      [worldDatabase, _foxySchema, charactersDatabase, authDatabase],
    );
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
  Future<List<Map<String, Object?>>> querySql(ReadOnlySql sql) async {
    final rows = await _database.select(sql.statement);
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
        isBaseTable: first.isBaseTable,
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

  static Object? _diagnosticPlan(Object? node, Map<String, TableInfo> tables) {
    return switch (node) {
      final List<Object?> values =>
        values.map((value) => _diagnosticPlan(value, tables)).toList(),
      final Map<String, Object?> fields => {
        for (final entry in fields.entries)
          if (_planFields.contains(entry.key))
            entry.key: _diagnosticPlan(entry.value, tables),
        if (fields case {
          'table_name': final String alias,
          'used_key_parts': final List<Object?> parts,
        })
          'used_key_parts': parts
              .whereType<String>()
              .where((name) => tables[alias]?.findColumn(name) != null)
              .toList(),
      },
      _ => node,
    };
  }

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
      isBaseTable: _rowString(row, 'TABLE_TYPE') == 'BASE TABLE',
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

  static Future<List<Map<String, Object?>>> _tableStatistics(
    Laconic database,
    Map<String, TableInfo> aliases,
  ) async {
    final tables = aliases.values.toSet();
    final conditions = List.filled(
      tables.length,
      "(t.TABLE_SCHEMA = COALESCE(NULLIF(?, ''), DATABASE()) AND t.TABLE_NAME = ?)",
    ).join(' OR ');
    final rows = await database.select('''
SELECT CASE WHEN BINARY t.TABLE_SCHEMA = BINARY DATABASE()
            THEN '' ELSE t.TABLE_SCHEMA END AS catalogSchema,
       t.TABLE_NAME AS tableName, t.ENGINE AS engine, t.TABLE_ROWS AS estimatedRows,
       t.DATA_LENGTH AS dataBytes, t.INDEX_LENGTH AS indexBytes,
       s.INDEX_NAME AS indexName, s.NON_UNIQUE AS nonUnique, s.INDEX_TYPE AS indexType,
       s.SEQ_IN_INDEX AS position, s.COLUMN_NAME AS columnName,
       s.SUB_PART AS prefixLength, s.CARDINALITY AS estimatedCardinality
FROM information_schema.tables t
LEFT JOIN information_schema.statistics s
  ON t.TABLE_SCHEMA = s.TABLE_SCHEMA AND t.TABLE_NAME = s.TABLE_NAME
 AND BINARY t.TABLE_SCHEMA = BINARY s.TABLE_SCHEMA
 AND BINARY t.TABLE_NAME = BINARY s.TABLE_NAME
WHERE t.TABLE_TYPE = 'BASE TABLE' AND ($conditions)
ORDER BY t.TABLE_SCHEMA, t.TABLE_NAME, s.INDEX_NAME, s.SEQ_IN_INDEX
''', tables.expand((table) => [table.database, table.name]).toList());
    final groups = groupBy(
      rows.map((row) => row.toMap()),
      (row) => (row['catalogSchema'], row['tableName']),
    );
    return tables.map((table) {
      final entries = groups[(table.database, table.name)] ?? const [];
      final stats = entries.firstOrNull;
      final indexes = groupBy(
        entries.where((row) => row['indexName'] is String),
        (row) => row['indexName'],
      );
      final visibleIndexes = indexes.values
          .where(
            (parts) => parts.every((part) {
              final column = part['columnName'];
              return column == null ||
                  (column is String && table.findColumn(column) != null);
            }),
          )
          .toList();
      return {
        'table': table.qualifiedName,
        'aliases': aliases.entries
            .where((entry) => entry.value == table)
            .map((entry) => entry.key)
            .toList(),
        if (stats != null) ...{
          'engine': stats['engine'],
          'estimatedRows': stats['estimatedRows'],
          'dataBytes': stats['dataBytes'],
          'indexBytes': stats['indexBytes'],
          if (visibleIndexes.length < indexes.length) 'indexesFiltered': true,
          'indexes': visibleIndexes
              .map(
                (parts) => {
                  'name': parts.first['indexName'],
                  'unique': parts.first['nonUnique'] == 0,
                  'type': parts.first['indexType'],
                  'columns': parts
                      .map(
                        (part) => {
                          'column': part['columnName'],
                          'position': part['position'],
                          'prefixLength': part['prefixLength'],
                          'estimatedCardinality': part['estimatedCardinality'],
                        },
                      )
                      .toList(),
                },
              )
              .toList(),
        },
      };
    }).toList();
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

  final bool isBaseTable;

  final ColumnInfo column;

  const _CatalogColumn({
    required this.schema,
    required this.table,
    required this.isBaseTable,
    required this.column,
  });
}
