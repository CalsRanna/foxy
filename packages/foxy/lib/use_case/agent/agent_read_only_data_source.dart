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
/// auth and `foxy` schemas. Queries run through [querySql] only.
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

  /// Builds the agent catalog from `information_schema.columns` rows.
  ///
  /// World tables stay unqualified. Other tables retain their schema name.
  /// Auth credentials are omitted from the catalog.
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
      isBaseTable: _rowString(row, 'TABLE_TYPE') == 'BASE TABLE',
      column: ColumnInfo(
        name: columnName,
        label: _rowString(row, 'COLUMN_COMMENT'),
        type: _logicalType(_rowString(row, 'DATA_TYPE')),
        primaryKey: _rowString(row, 'COLUMN_KEY') == 'PRI',
      ),
    );
  }

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

  final bool isBaseTable;

  final ColumnInfo column;

  const _CatalogColumn({
    required this.schema,
    required this.table,
    required this.isBaseTable,
    required this.column,
  });
}
