import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/exception/foxy_exceptions.dart';
import 'package:foxy/infrastructure/config/config_util.dart';
import 'package:foxy/use_case/agent/agent_read_only_data_source.dart';
import 'package:foxy_agent/foxy_agent.dart';
import 'package:laconic/laconic.dart';
import 'package:laconic_mysql/laconic_mysql.dart';

void main() {
  test('builds the catalog for world and foxy tables', () {
    final catalog = AgentReadOnlyDataSource.buildCatalog([
      _row('acore_world', 'creature_template', 'entry', 'int', 'PRI', '编号'),
      _row('acore_world', 'creature_template', 'name', 'varchar', '', '名称'),
      _row(
        'acore_world',
        'creature_template',
        'created_at',
        'datetime',
        '',
        '',
      ),
      _row('foxy', 'activity_log', 'id', 'int', 'PRI', '编号'),
      _row('foxy', 'activity_log', 'module', 'varchar', '', '模块'),
    ], worldDatabase: 'acore_world');

    final creature = catalog.find('creature_template');
    expect(creature, isNotNull);
    expect(creature!.database, '');
    expect(creature.qualifiedName, 'creature_template');
    expect(creature.columns, hasLength(3));
    final entry = creature.findColumn('entry')!;
    expect(entry.primaryKey, isTrue);
    expect(entry.label, '编号');
    expect(entry.type, 'int');
    expect(creature.findColumn('created_at')!.type, 'text');

    final log = catalog.find('foxy.activity_log');
    expect(log, isNotNull);
    expect(log!.database, 'foxy');
    expect(catalog.find('activity_log'), isNotNull);
  });

  test(
    'uses default characters and auth schemas on the existing connection',
    () async {
      final driver = _ReadOnlyDriver([]);
      final source = AgentReadOnlyDataSource(
        _AgentConfig({'database': 'acore_world'}),
        laconic: Laconic(driver),
      );

      await source.getCatalog();

      expect(
        driver.queries.single.sql,
        contains('from information_schema.columns'),
      );
      expect(driver.queries.single.params, [
        'acore_world',
        'foxy',
        'acore_characters',
        'acore_auth',
      ]);
    },
  );

  test(
    'reads configured characters and auth tables without selecting credentials',
    () async {
      final driver = _ReadOnlyDriver([
        _row('world', 'shared', 'id', 'int', 'PRI', ''),
        _row('players', 'shared', 'guid', 'int', 'PRI', ''),
        _row('login', 'account', 'id', 'int', 'PRI', ''),
        _row('login', 'account', 'username', 'varchar', '', ''),
        _row('login', 'account', 'salt', 'binary', '', ''),
        _row('login', 'account', 'verifier', 'binary', '', ''),
        _row('login', 'account', 'session_key', 'binary', '', ''),
        _row('login', 'account', 'totp_secret', 'binary', '', ''),
        _row('login', 'secret_digest', 'id', 'int', 'PRI', ''),
      ]);
      final source = AgentReadOnlyDataSource(
        _AgentConfig({
          'database': 'world',
          'characters_database': 'players',
          'auth_database': 'login',
        }),
        laconic: Laconic(driver),
      );

      final catalog = await source.getCatalog();
      expect(driver.queries.single.params, [
        'world',
        'foxy',
        'players',
        'login',
      ]);
      expect(catalog.find('shared')!.qualifiedName, 'shared');
      expect(catalog.find('players.shared')!.database, 'players');
      expect(catalog.find('login.secret_digest'), isNull);
      expect(
        catalog.find('login.account')!.columns.map((column) => column.name),
        ['id', 'username'],
      );

      await source.queryRows(table: 'players.shared', filters: [], limit: 2);
      await source.queryRows(
        table: 'login.account',
        filters: const [
          RowFilter(column: 'id', operator: FilterOperator.equals, value: 7),
        ],
        limit: 2,
      );
      expect(
        driver.queries[1].sql,
        'select `guid` from `players`.`shared` limit ?',
      );
      expect(driver.queries[1].params, [2]);
      expect(
        driver.queries[2].sql,
        'select `id`, `username` from `login`.`account` where `id` = ? limit ?',
      );
      expect(driver.queries[2].params, [7, 2]);

      await expectLater(
        source.queryRows(
          table: 'login.account',
          filters: const [
            RowFilter(
              column: 'verifier',
              operator: FilterOperator.equals,
              value: 'value',
            ),
          ],
          limit: 2,
        ),
        throwsA(isA<ValidationException>()),
      );
      expect(driver.queries, hasLength(3));
    },
  );

  test('maps common MySQL types to logical types', () {
    final catalog = AgentReadOnlyDataSource.buildCatalog([
      _row('acore_world', 't', 'a', 'bigint', '', ''),
      _row('acore_world', 't', 'b', 'decimal', '', ''),
      _row('acore_world', 't', 'c', 'tinyint', '', ''),
      _row('acore_world', 't', 'd', 'varchar', '', ''),
      _row('acore_world', 't', 'e', 'bit', '', ''),
    ], worldDatabase: 'acore_world');

    final table = catalog.find('t')!;
    expect(table.findColumn('a')!.type, 'int');
    expect(table.findColumn('b')!.type, 'decimal');
    expect(table.findColumn('c')!.type, 'int');
    expect(table.findColumn('d')!.type, 'text');
    expect(table.findColumn('e')!.type, 'bool');
  });

  test('attaches field semantics from the generated registry', () {
    final catalog = AgentReadOnlyDataSource.buildCatalog(
      [_row('acore_world', 'creature_template', 'type', 'int', '', '')],
      worldDatabase: 'acore_world',
      semantics: const {
        'creature_template': {
          'type': ColumnSemantics.enumValues(label: '生物类型', values: {1: '野兽'}),
        },
      },
    );

    final column = catalog.find('creature_template')!.findColumn('type')!;
    expect(column.semantics, isNotNull);
    expect(column.semantics!.label, '生物类型');
    expect(column.semantics!.values[1], '野兽');
  });

  test('skips rows with missing identifiers', () {
    final catalog = AgentReadOnlyDataSource.buildCatalog([
      _row('acore_world', '', 'x', 'int', '', ''),
      _row('', 't', 'x', 'int', '', ''),
      _row('acore_world', 't', '', 'int', '', ''),
    ], worldDatabase: 'acore_world');

    expect(catalog.tables, isEmpty);
  });
}

class _AgentConfig extends ConfigUtil {
  final Map<String, Object?> values;

  _AgentConfig(this.values);

  @override
  Future<Map<String, Object?>> load() async => values;
}

class _ReadOnlyDriver extends Fake implements DatabaseDriver {
  @override
  final SqlGrammar grammar = MysqlGrammar();
  final List<Map<String, Object?>> catalogRows;
  final queries = <({String sql, List<Object?> params})>[];

  _ReadOnlyDriver(this.catalogRows);

  @override
  Future<List<LaconicResult>> select(
    String sql, [
    List<Object?> params = const [],
  ]) async {
    queries.add((sql: sql, params: params));
    return sql.contains('from information_schema.columns')
        ? catalogRows.map(LaconicResult.fromMap).toList()
        : [];
  }
}

Map<String, Object?> _row(
  String schema,
  String table,
  String column,
  String dataType,
  String columnKey,
  String comment,
) => {
  'TABLE_SCHEMA': schema,
  'TABLE_NAME': table,
  'COLUMN_NAME': column,
  'DATA_TYPE': dataType,
  'COLUMN_KEY': columnKey,
  'COLUMN_COMMENT': comment,
};
