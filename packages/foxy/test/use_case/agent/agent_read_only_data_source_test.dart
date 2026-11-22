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

  group('conditional field meanings', () {
    const type = 'ConditionTypeOrReference';
    const value1 = 'ConditionValue1';
    const value2 = 'ConditionValue2';
    const value3 = 'ConditionValue3';
    const rows = [
      {type: 2, value1: 67, value2: 123},
      {type: 31, value1: 3, value2: 123},
      {type: 31, value1: 5, value2: 123},
    ];

    late _ReadOnlyDriver driver;
    late List<AgentTool> tools;

    AgentTool tool(String name) =>
        tools.singleWhere((tool) => tool.name == name);

    Future<Map<String, Object?>> describe(
      String column, [
      Map<String, Object?>? context,
    ]) async {
      final result = await tool('describe_field_values').call({
        'table': 'conditions',
        'column': column,
        'context': ?context,
      }) as Map<String, Object?>;
      return result['semantics']! as Map<String, Object?>;
    }

    setUp(() async {
      driver = _ReadOnlyDriver(
        [type, value1, value2, value3]
            .map(
              (column) => _row('world', 'conditions', column, 'int', 'PRI', ''),
            )
            .toList(),
        resultRows: rows,
      );
      final source = AgentReadOnlyDataSource(
        _AgentConfig({'database': 'world'}),
        laconic: Laconic(driver),
      );
      tools = createReadOnlyTools(
        catalog: await source.getCatalog(),
        dataSource: source,
      );
    });

    test(
      'discovers the exact predicates before querying three equal values',
      () async {
        final schema = await tool(
          'describe_table',
        ).call({'table': 'conditions'}) as Map<String, Object?>;
        final table = schema['table']! as Map<String, Object?>;
        final columns = table['columns']! as List<Map<String, Object?>>;
        expect(columns.skip(1).map((column) => column['semantics']), [
          containsPair('dependsOn', [type]),
          containsPair('dependsOn', [type, value1]),
          containsPair('dependsOn', [type]),
        ]);
        final discovery = await describe(value2);
        final branches = discovery['branches']! as List<Map<String, Object?>>;
        final creatureBranch = branches.singleWhere((branch) {
          final semantics = branch['semantics']! as Map<String, Object?>;
          final reference = semantics['reference'] as Map<String, Object?>?;
          return reference?['table'] == 'creature_template';
        });
        final conditions =
            creatureBranch['when']! as List<Map<String, Object?>>;
        expect(conditions, [
          {'column': type, 'operator': 'equals', 'value': 31},
          {'column': value1, 'operator': 'equals', 'value': 3},
        ]);

        const select = 'SELECT $type, $value1, $value2 FROM conditions';
        final querySql = tool('query_sql');
        final all =
            await querySql.call({'sql': select}) as Map<String, Object?>;
        final rawRows = all['rows']! as List<Map<String, Object?>>;
        expect(rawRows, rows);
        final explanations = await Future.wait(
          rawRows.map((row) => describe(value2, row)),
        );
        expect(
          explanations.map((result) => result['status']),
          everyElement('resolved'),
        );
        expect(explanations.map((result) => result['value']), [123, 123, 123]);
        expect(
          explanations.map(
            (result) =>
                (result['branch']! as Map<String, Object?>)['semantics'],
          ),
          [
            {'kind': 'number', 'label': '数量'},
            containsPair('reference', {
              'table': 'creature_template',
              'column': 'entry',
            }),
            containsPair('reference', {
              'table': 'gameobject_template',
              'column': 'entry',
            }),
          ],
        );

        expect(
          rawRows.where(
            (row) =>
                row[value2] == 123 &&
                conditions.every(
                  (condition) => row[condition['column']] == condition['value'],
                ),
          ),
          [rows[1]],
        );
        final predicates = conditions.map(
          (condition) => '${condition['column']} = ${condition['value']}',
        );
        await querySql.call({
          'sql': '$select WHERE ${predicates.join(' AND ')} AND $value2 = 123',
        });
        expect(
          driver.queries.last.sql,
          contains('WHERE $type = 31 AND $value1 = 3 AND $value2 = 123'),
        );
      },
    );

    test(
      'handles partial context, unknown selectors, unused and special values',
      () async {
        final partial = await describe(value2, {type: 31});
        expect(partial['status'], 'needsContext');
        expect(partial['missingContext'], [value1]);
        expect(partial['branches'], hasLength(4));

        final unknown = await describe(value2, {
          type: 31,
          value1: 99,
          value2: 123,
        });
        expect(unknown['status'], 'unknown');
        expect(unknown['value'], 123);

        final template = await describe(value2, {type: -3, value2: 0});
        expect(
          template['branch'],
          containsPair('semantics', {'kind': 'unused', 'label': '未使用'}),
        );

        final anyEntry = await describe(value2, {
          type: 31,
          value1: 3,
          value2: 0,
        });
        expect(anyEntry['valueLabel'], '不限制对象条目，无需联表');

        final standState = await describe(value2, {
          type: 42,
          value1: 0,
          value2: 1,
        });
        final standCategory = await describe(value2, {
          type: 42,
          value1: 1,
          value2: 1,
        });
        expect(standState['valueLabel'], '坐下');
        expect(standCategory['valueLabel'], isNot(standState['valueLabel']));

        expect(
          await tool('describe_field_values').call({
            'table': 'conditions',
            'column': value2,
            'context': {type: '31'},
          }),
          'Context column "$type" must be an integer.',
        );
      },
    );
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
