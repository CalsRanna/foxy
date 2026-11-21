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
    expect(creature.findColumn('created_at')!.type, 'datetime');

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
        'select `guid` from `players`.`shared` order by `guid` asc limit ?',
      );
      expect(driver.queries[1].params, [2]);
      expect(
        driver.queries[2].sql,
        'select `id`, `username` from `login`.`account` where `id` = ? order by `id` asc limit ?',
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

  test(
    'exposes logical inventory links using the configured character schema',
    () async {
      final driver = _ReadOnlyDriver([
        _row('players', 'character_inventory', 'item', 'int', 'PRI', ''),
        _row('players', 'item_instance', 'guid', 'int', 'PRI', ''),
        _row('players', 'item_instance', 'itemEntry', 'mediumint', '', ''),
        _row('world', 'item_template', 'entry', 'int', 'PRI', ''),
        _row('world', 'item_instance', 'guid', 'int', 'PRI', ''),
      ]);
      final source = AgentReadOnlyDataSource(
        _AgentConfig({'database': 'world', 'characters_database': 'players'}),
        laconic: Laconic(driver),
      );
      final catalog = await source.getCatalog();
      final result = await DescribeReferencesTool(
        catalog,
      ).call({'table': 'players.item_instance'}) as Map<String, Object?>;
      expect(result['incoming'], [
        {
          'sourceTable': 'players.character_inventory',
          'sourceColumn': 'item',
          'targetTable': 'players.item_instance',
          'targetColumn': 'guid',
          'expandable': true,
        },
      ]);
      expect(result['outgoing'], [
        {
          'sourceTable': 'players.item_instance',
          'sourceColumn': 'itemEntry',
          'targetTable': 'item_template',
          'targetColumn': 'entry',
          'expandable': true,
        },
      ]);
      expect(driver.queries, hasLength(1));
    },
  );

  test('query_rows safely orders and offsets in SQL with compound key tie-breakers', () async {
    final driver = _ReadOnlyDriver([
      _row('world', 'loot', 'Entry', 'int', 'PRI', ''),
      _row('world', 'loot', 'Item', 'int', 'PRI', ''),
      _row('world', 'loot', 'Chance', 'decimal', '', ''),
    ]);
    final source = AgentReadOnlyDataSource(
      _AgentConfig({'database': 'world'}),
      laconic: Laconic(driver),
    );
    await source.queryRows(
      table: 'loot',
      filters: [],
      orderBy: const [
        RowOrder(column: 'Chance', direction: SortDirection.desc),
      ],
      offset: 50,
      limit: 51,
    );
    expect(
      driver.queries.last.sql,
      'select `Entry`, `Item`, `Chance` from `loot` order by `Chance` desc, `Entry` asc, `Item` asc limit ? offset ?',
    );
    expect(driver.queries.last.params, [51, 50]);
    await expectLater(
      source.queryRows(
        table: 'loot',
        filters: [],
        orderBy: const [
          RowOrder(column: 'RAND()', direction: SortDirection.asc),
        ],
        limit: 10,
      ),
      throwsA(isA<ValidationException>()),
    );
    expect(driver.queries, hasLength(2));
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

  test(
    'count_rows uses COUNT(*) with bound filters and no sample limit',
    () async {
      final driver = _ReadOnlyDriver(
        [
          _row('world', 'items', 'id', 'int', 'PRI', ''),
          _row('world', 'items', 'name', 'varchar', '', ''),
        ],
        resultRows: [
          {'aggregate': '120'},
        ],
      );
      final source = AgentReadOnlyDataSource(
        _AgentConfig({'database': 'world'}),
        laconic: Laconic(driver),
      );
      final count = await source.countRows(
        table: 'items',
        filters: const [
          RowFilter(
            column: 'name',
            operator: FilterOperator.contains,
            value: "Sword' OR 1=1",
          ),
          RowFilter(
            column: 'id',
            operator: FilterOperator.greaterThan,
            value: 5,
          ),
        ],
      );
      expect(count, 120);
      expect(
        driver.queries.last.sql,
        'select COUNT(*) as aggregate from `items` where `name` like ? and `id` > ?',
      );
      expect(driver.queries.last.params, ["%Sword' OR 1=1%", 5]);
      driver.resultRows = [
        {'aggregate': 0},
      ];
      expect(await source.countRows(table: 'items', filters: []), 0);
    },
  );

  test(
    'aggregates in SQL before capping and ordering the returned groups',
    () async {
      final driver = _ReadOnlyDriver(
        [
          _row('world', 'items', 'id', 'int', 'PRI', ''),
          _row('world', 'items', 'expansion', 'int', '', ''),
          _row('world', 'items', 'price', 'decimal', '', ''),
        ],
        resultRows: [
          {'expansion': 2, 'count': 120, 'sum_price': '1234.50'},
        ],
      );
      final source = AgentReadOnlyDataSource(
        _AgentConfig({'database': 'world'}),
        laconic: Laconic(driver),
      );
      final rows = await source.aggregateRows(
        table: 'items',
        filters: const [
          RowFilter(
            column: 'id',
            operator: FilterOperator.inList,
            value: [1, 2, 3],
          ),
        ],
        groupBy: ['expansion'],
        metrics: const [
          AggregateMetric(function: AggregateFunction.count),
          AggregateMetric(function: AggregateFunction.sum, column: 'price'),
        ],
        limit: 500,
      );
      expect(rows, driver.resultRows);
      expect(
        driver.queries.last.sql,
        'select `expansion`, COUNT(*) as `count`, SUM(`price`) as `sum_price` from `items` where `id` in (?, ?, ?) group by `expansion` order by `expansion` asc limit ?',
      );
      expect(driver.queries.last.params, [1, 2, 3, 51]);
      await source.aggregateRows(
        table: 'items',
        filters: [],
        groupBy: ['expansion'],
        metrics: const [
          AggregateMetric(function: AggregateFunction.sum, column: 'price'),
        ],
        orderBy: const [
          RowOrder(column: 'sum_price', direction: SortDirection.desc),
        ],
        limit: 20,
        offset: 20,
      );
      expect(
        driver.queries.last.sql,
        'select `expansion`, SUM(`price`) as `sum_price` from `items` group by `expansion` order by `sum_price` desc, `expansion` asc limit ? offset ?',
      );
      expect(driver.queries.last.params, [20, 20]);
    },
  );

  test(
    'aggregates route qualified schemas and preserve null and decimal values',
    () async {
      final driver = _ReadOnlyDriver(
        [_row('foxy', 'stats', 'price', 'decimal', '', '')],
        resultRows: [
          {
            'count_price': 0,
            'avg_price': null,
            'min_price': null,
            'max_price': null,
          },
        ],
      );
      final source = AgentReadOnlyDataSource(
        _AgentConfig({'database': 'world'}),
        laconic: Laconic(driver),
      );
      final rows = await source.aggregateRows(
        table: 'foxy.stats',
        filters: [],
        groupBy: [],
        metrics: const [
          AggregateMetric(function: AggregateFunction.count, column: 'price'),
          AggregateMetric(function: AggregateFunction.avg, column: 'price'),
          AggregateMetric(function: AggregateFunction.min, column: 'price'),
          AggregateMetric(function: AggregateFunction.max, column: 'price'),
        ],
        limit: 1,
      );
      expect(rows, driver.resultRows);
      expect(
        driver.queries.last.sql,
        'select COUNT(`price`) as `count_price`, AVG(`price`) as `avg_price`, MIN(`price`) as `min_price`, MAX(`price`) as `max_price` from `foxy`.`stats` limit ?',
      );
      expect(driver.queries.last.params, [1]);
    },
  );

  test(
    'count and aggregates reject hidden tables and columns even without tools',
    () async {
      final driver = _ReadOnlyDriver([
        _row('acore_auth', 'account', 'id', 'int', 'PRI', ''),
        _row('acore_auth', 'account', 'username', 'varchar', '', ''),
        _row('acore_auth', 'account', 'verifier', 'binary', '', ''),
        _row('acore_auth', 'secret_digest', 'id', 'int', 'PRI', ''),
      ]);
      final source = AgentReadOnlyDataSource(
        _AgentConfig({'database': 'world'}),
        laconic: Laconic(driver),
      );
      await source.getCatalog();
      for (final table in [
        'acore_auth.secret_digest',
        'account; DROP TABLE account',
      ]) {
        await expectLater(
          source.countRows(table: table, filters: []),
          throwsA(isA<ValidationException>()),
        );
      }
      await expectLater(
        source.queryRows(
          table: 'acore_auth.account',
          filters: [],
          orderBy: const [
            RowOrder(column: 'verifier', direction: SortDirection.asc),
          ],
          limit: 1,
        ),
        throwsA(isA<ValidationException>()),
      );
      await expectLater(
        source.countRows(
          table: 'acore_auth.account',
          filters: const [
            RowFilter(
              column: 'verifier',
              operator: FilterOperator.equals,
              value: 1,
            ),
          ],
        ),
        throwsA(isA<ValidationException>()),
      );
      for (final groups in [
        ['verifier'],
        ['id', 'id'],
      ]) {
        await expectLater(
          source.aggregateRows(
            table: 'acore_auth.account',
            filters: [],
            groupBy: groups,
            metrics: const [AggregateMetric(function: AggregateFunction.count)],
            limit: 1,
          ),
          throwsA(isA<ValidationException>()),
        );
      }
      for (final metric in const [
        AggregateMetric(function: AggregateFunction.sum, column: 'username'),
        AggregateMetric(function: AggregateFunction.count, column: 'verifier'),
      ]) {
        await expectLater(
          source.aggregateRows(
            table: 'acore_auth.account',
            filters: [],
            groupBy: [],
            metrics: [metric],
            limit: 1,
          ),
          throwsA(isA<ValidationException>()),
        );
      }
      await expectLater(
        source.countRows(
          table: 'acore_auth.account',
          filters: const [
            RowFilter(column: 'id', operator: FilterOperator.inList, value: []),
          ],
        ),
        throwsA(isA<ValidationException>()),
      );
      expect(driver.queries, hasLength(1));
    },
  );
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
  'TABLE_TYPE': 'BASE TABLE',
  'COLUMN_NAME': column,
  'DATA_TYPE': dataType,
  'COLUMN_KEY': columnKey,
  'COLUMN_COMMENT': comment,
};

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
  List<Map<String, Object?>> resultRows;
  final queries = <({String sql, List<Object?> params})>[];

  _ReadOnlyDriver(this.catalogRows, {this.resultRows = const []});

  @override
  Future<List<LaconicResult>> select(
    String sql, [
    List<Object?> params = const [],
  ]) async {
    queries.add((sql: sql, params: params));
    return sql.contains('from information_schema.columns')
        ? catalogRows.map(LaconicResult.fromMap).toList()
        : resultRows.map(LaconicResult.fromMap).toList();
  }
}
