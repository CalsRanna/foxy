import 'package:foxy_agent/foxy_agent.dart';
import 'package:test/test.dart';

void main() {
  test('list_tables returns every table and filters by query', () async {
    const tool = ListTablesTool(_catalog);

    final all = _asMap(await tool.call({}));
    expect(all['count'], 3);
    expect(_asList(all['tables']), hasLength(3));

    final filtered = _asMap(await tool.call({'query': '物品'}));
    expect(_asList(filtered['tables']).single, {
      'name': 'item_template',
      'label': '物品模板',
    });

    final byName = _asMap(await tool.call({'query': 'CREATURE'}));
    expect(_asList(byName['tables']).single, {
      'name': 'creature_template',
      'label': '生物模板',
    });
  });

  test('list_tables exposes qualified names for other databases', () async {
    const tool = ListTablesTool(_catalog);

    final result = _asMap(await tool.call({'query': 'foxy'}));

    expect(_asList(result['tables']).single, {
      'name': 'foxy.activity_log',
      'database': 'foxy',
      'label': '操作日志',
    });
  });

  test('describe_table returns the table schema', () async {
    const tool = DescribeTableTool(_catalog);

    final result = _asMap(await tool.call({'table': 'creature_template'}));

    final table = _asMap(result['table']);
    expect(table['name'], 'creature_template');
    expect(table['label'], '生物模板');
    final columns = _asList(table['columns']);
    expect(columns, hasLength(5));
    final entry = _asMap(columns.first);
    expect(entry['name'], 'entry');
    expect(entry['primaryKey'], true);
    expect(entry['type'], 'int');
  });

  test('describe_table resolves unique bare names', () async {
    const tool = DescribeTableTool(_catalog);

    final result = _asMap(await tool.call({'table': 'activity_log'}));

    final table = _asMap(result['table']);
    expect(table['name'], 'foxy.activity_log');
    expect(table['database'], 'foxy');
  });

  test('describe_table rejects ambiguous bare names', () async {
    const catalog = TableCatalog([
      TableInfo(name: 'activity_log', database: 'world'),
      TableInfo(name: 'activity_log', database: 'foxy'),
    ]);
    const tool = DescribeTableTool(catalog);

    final result = await tool.call({'table': 'activity_log'});

    expect(result, contains('Ambiguous table name "activity_log"'));
  });

  test('describe_table reports unknown tables', () async {
    const tool = DescribeTableTool(_catalog);

    final result = await tool.call({'table': 'nope'});

    expect(result, contains('Unknown table "nope"'));
  });

  test('query_rows validates filters and clamps the limit', () async {
    final source = _FakeDataSource([
      {'entry': 1},
      {'entry': 2},
    ]);
    final tool = QueryRowsTool(_catalog, source);

    final result = _asMap(
      await tool.call({
        'table': 'creature_template',
        'filters': [
          {'column': 'minlevel', 'operator': 'greaterOrEqual', 'value': 10},
        ],
        'limit': 999,
      }),
    );

    expect(result['count'], 2);
    expect(source.calls.single.table, 'creature_template');
    expect(source.calls.single.limit, QueryRowsTool.maxLimit + 1);
    final filter = source.calls.single.filters.single;
    expect(filter.column, 'minlevel');
    expect(filter.operator, FilterOperator.greaterOrEqual);
    expect(filter.value, 10);
  });

  test('query_rows routes qualified names to the data source', () async {
    final source = _FakeDataSource([
      {'id': 1, 'module': 'item_template'},
    ]);
    final tool = QueryRowsTool(_catalog, source);

    final result = _asMap(
      await tool.call({
        'table': 'foxy.activity_log',
        'filters': [
          {'column': 'module', 'operator': 'equals', 'value': 'item_template'},
        ],
        'limit': 5,
      }),
    );

    expect(result['count'], 1);
    expect(source.calls.single.table, 'foxy.activity_log');
  });

  test('query_rows marks truncated results', () async {
    final source = _FakeDataSource([
      {'entry': 1},
      {'entry': 2},
      {'entry': 3},
    ]);
    final tool = QueryRowsTool(_catalog, source);

    final result = _asMap(
      await tool.call({'table': 'creature_template', 'limit': 2}),
    );

    expect(result['count'], 2);
    expect(result['truncated'], true);
    expect(result['nextOffset'], 2);
    expect(_asList(result['rows']), hasLength(2));
  });

  test(
    'query_rows forwards ordering and can continue from nextOffset',
    () async {
      final source = _FakeDataSource([
        for (var entry = 1; entry <= 120; entry++) {'entry': entry},
      ]);
      final tool = QueryRowsTool(_catalog, source);
      final arguments = <String, Object?>{
        'table': 'creature_template',
        'limit': 50,
        'orderBy': [
          {'column': 'minlevel', 'direction': 'desc'},
          {'column': 'entry', 'direction': 'asc'},
        ],
      };
      final entries = <Object?>[];
      var offset = 0;
      for (final expectedOffset in [50, 100, null]) {
        final page = _asMap(await tool.call({...arguments, 'offset': offset}));
        entries.addAll(
          _asList(page['rows']).map((row) => _asMap(row)['entry']),
        );
        final call = source.calls.last;
        expect(call.offset, offset);
        expect(call.orderBy.map((order) => (order.column, order.direction)), [
          ('minlevel', SortDirection.desc),
          ('entry', SortDirection.asc),
        ]);
        expect(page['nextOffset'], expectedOffset);
        offset = page['nextOffset'] as int? ?? 0;
      }
      expect(entries, List.generate(120, (index) => index + 1));
    },
  );

  test(
    'query_rows rejects invalid sort keys, directions and offsets',
    () async {
      final source = _FakeDataSource([]);
      final tool = QueryRowsTool(_catalog, source);
      for (final invalid in <Map<String, Object?>>[
        {'offset': -1},
        {'offset': 1.5},
        {'offset': '10'},
        {'orderBy': 'entry desc'},
        {
          'orderBy': [
            {'column': 'missing', 'direction': 'desc'},
          ],
        },
        {
          'orderBy': [
            {'column': 'entry', 'direction': 'desc, rand()'},
          ],
        },
        {
          'orderBy': [
            {'column': 'entry', 'direction': 'asc'},
            {'column': 'entry', 'direction': 'desc'},
          ],
        },
      ]) {
        expect(
          await tool.call({'table': 'creature_template', ...invalid}),
          isA<String>(),
        );
      }
      expect(source.calls, isEmpty);
    },
  );

  test('query_rows rejects unknown columns and operators', () async {
    final tool = QueryRowsTool(_catalog, _FakeDataSource([]));

    final unknownColumn = await tool.call({
      'table': 'creature_template',
      'filters': [
        {'column': 'nope', 'operator': 'equals', 'value': 1},
      ],
    });
    expect(unknownColumn, contains('Unknown column "nope"'));

    final unknownOperator = await tool.call({
      'table': 'creature_template',
      'filters': [
        {'column': 'entry', 'operator': 'like', 'value': 1},
      ],
    });
    expect(unknownOperator, contains('Unknown filter operator "like"'));
  });

  test('query_rows passes in-list filters to the data source', () async {
    final source = _FakeDataSource([
      {'entry': 1},
    ]);
    final tool = QueryRowsTool(_catalog, source);

    final result = _asMap(
      await tool.call({
        'table': 'creature_template',
        'filters': [
          {
            'column': 'entry',
            'operator': 'in',
            'value': [1, 2, 3],
          },
        ],
      }),
    );

    expect(result['count'], 1);
    final filter = source.calls.single.filters.single;
    expect(filter.operator, FilterOperator.inList);
    expect(filter.value, [1, 2, 3]);
  });

  test('query_rows validates in-list and scalar filter values', () async {
    final tool = QueryRowsTool(_catalog, _FakeDataSource([]));

    final emptyList = await tool.call({
      'table': 'creature_template',
      'filters': [
        {'column': 'entry', 'operator': 'in', 'value': <Object?>[]},
      ],
    });
    expect(emptyList, contains('non-empty array'));

    final scalarForIn = await tool.call({
      'table': 'creature_template',
      'filters': [
        {'column': 'entry', 'operator': 'in', 'value': 1},
      ],
    });
    expect(scalarForIn, contains('non-empty array'));

    final listForEquals = await tool.call({
      'table': 'creature_template',
      'filters': [
        {
          'column': 'entry',
          'operator': 'equals',
          'value': [1],
        },
      ],
    });
    expect(listForEquals, contains('must be a scalar'));
  });

  test('describe_table exposes column semantics summaries', () async {
    const tool = DescribeTableTool(_catalog);

    final result = _asMap(await tool.call({'table': 'creature_template'}));

    final columns = _asList(_asMap(result['table'])['columns']);
    final type = _asMap(
      columns.firstWhere((column) => _asMap(column)['name'] == 'type'),
    );
    final semantics = _asMap(type['semantics']);
    expect(semantics['kind'], 'enum');
    expect(semantics['label'], '生物类型');
    expect(semantics.containsKey('values'), isFalse);

    final plain = _asMap(
      columns.firstWhere((column) => _asMap(column)['name'] == 'name'),
    );
    expect(plain.containsKey('semantics'), isFalse);
  });

  test('describe_field_values returns the full enum mapping', () async {
    const tool = DescribeFieldValuesTool(_catalog);

    final result = _asMap(
      await tool.call({'table': 'creature_template', 'column': 'type'}),
    );

    final semantics = _asMap(result['semantics']);
    expect(semantics['kind'], 'enum');
    expect(semantics['label'], '生物类型');
    expect(_asMap(semantics['values'])['4'], '元素生物');
  });

  test('describe_field_values returns flag definitions', () async {
    const tool = DescribeFieldValuesTool(_catalog);

    final result = _asMap(
      await tool.call({'table': 'creature_template', 'column': 'unit_flags'}),
    );

    final semantics = _asMap(result['semantics']);
    expect(semantics['kind'], 'flags');
    final flags = _asList(semantics['flags']);
    expect(flags, hasLength(2));
    expect(_asMap(flags.last)['value'], 64);
  });

  test('describe_field_values reports columns without semantics', () async {
    const tool = DescribeFieldValuesTool(_catalog);

    final result = await tool.call({
      'table': 'creature_template',
      'column': 'name',
    });

    expect(result, contains('No semantic definition'));
  });

  test('get_row queries by primary key with equality filters', () async {
    final source = _FakeDataSource([
      {'entry': 1234, 'name': 'Hogger'},
    ]);
    final tool = GetRowTool(_catalog, source);

    final result = _asMap(
      await tool.call({
        'table': 'creature_template',
        'key': {'entry': 1234},
      }),
    );

    expect(result['found'], true);
    expect(_asMap(result['row'])['name'], 'Hogger');
    expect(source.calls.single.limit, 1);
    final filter = source.calls.single.filters.single;
    expect(filter.column, 'entry');
    expect(filter.operator, FilterOperator.equals);
  });

  test('get_row reads rows from other databases by qualified name', () async {
    final source = _FakeDataSource([
      {'id': 7, 'module': 'item_template', 'action_type': 'update'},
    ]);
    final tool = GetRowTool(_catalog, source);

    final result = _asMap(
      await tool.call({
        'table': 'foxy.activity_log',
        'key': {'id': 7},
      }),
    );

    expect(result['found'], true);
    expect(source.calls.single.table, 'foxy.activity_log');
    expect(source.calls.single.filters.single.operator, FilterOperator.equals);
  });

  test('get_row requires the primary-key columns', () async {
    final tool = GetRowTool(_catalog, _FakeDataSource([]));

    final result = await tool.call({
      'table': 'creature_template',
      'key': {'name': 'Hogger'},
    });

    expect(result, contains('Missing primary-key column(s) entry'));
  });

  test('get_row reports missing rows', () async {
    final tool = GetRowTool(_catalog, _FakeDataSource([]));

    final result = _asMap(
      await tool.call({
        'table': 'creature_template',
        'key': {'entry': 1},
      }),
    );

    expect(result['found'], false);
  });

  test('createReadOnlyTools builds the full toolset', () {
    final tools = createReadOnlyTools(
      catalog: _catalog,
      dataSource: _FakeDataSource([]),
    );

    expect(tools.map((tool) => tool.name), [
      'list_tables',
      'describe_table',
      'describe_field_values',
      'describe_references',
      'server_time',
      'count_rows',
      'aggregate_rows',
      'query_rows',
      'get_row',
    ]);
  });

  test('server_time returns the data source clock', () async {
    final source = _FakeDataSource([]);
    expect(await ServerTimeTool(source).call({}), {
      'localTime': '2026-11-21 12:00:00',
      'sessionTimeZone': '+08:00',
    });
    expect(source.calls, isEmpty);
  });
}

const _catalog = TableCatalog([
  TableInfo(
    name: 'creature_template',
    label: '生物模板',
    columns: [
      ColumnInfo(name: 'entry', label: '编号', type: 'int', primaryKey: true),
      ColumnInfo(name: 'name', label: '名称'),
      ColumnInfo(name: 'minlevel', label: '最低等级', type: 'int'),
      ColumnInfo(
        name: 'type',
        label: '生物类型',
        type: 'int',
        semantics: ColumnSemantics.enumValues(
          label: '生物类型',
          values: {1: '野兽', 4: '元素生物'},
        ),
      ),
      ColumnInfo(
        name: 'unit_flags',
        label: '单位标志',
        type: 'int',
        semantics: ColumnSemantics.flags(
          label: '单位标志',
          flags: [
            ColumnFlag(value: 1, label: '不可攻击'),
            ColumnFlag(value: 64, label: '不可选择'),
          ],
        ),
      ),
    ],
  ),
  TableInfo(
    name: 'item_template',
    label: '物品模板',
    columns: [
      ColumnInfo(name: 'entry', label: '编号', type: 'int', primaryKey: true),
      ColumnInfo(name: 'name', label: '名称'),
    ],
  ),
  TableInfo(
    name: 'activity_log',
    database: 'foxy',
    label: '操作日志',
    columns: [
      ColumnInfo(name: 'id', label: '编号', type: 'int', primaryKey: true),
      ColumnInfo(name: 'module', label: '模块'),
      ColumnInfo(name: 'action_type', label: '操作类型'),
      ColumnInfo(name: 'entity_name', label: '实体名称'),
      ColumnInfo(name: 'created_at', label: '时间'),
    ],
  ),
]);

List<Object?> _asList(Object? value) => value! as List<Object?>;

Map<String, Object?> _asMap(Object? value) => value! as Map<String, Object?>;

final class _FakeDataSource implements ReadOnlyDataSource {
  final List<Map<String, Object?>> rows;

  final calls =
      <
        ({
          String table,
          List<RowFilter> filters,
          int limit,
          List<RowOrder> orderBy,
          int offset,
        })
      >[];

  _FakeDataSource(this.rows);

  @override
  Future<List<Map<String, Object?>>> aggregateRows({
    required String table,
    required List<RowFilter> filters,
    required List<String> groupBy,
    required List<AggregateMetric> metrics,
    required int limit,
    List<RowOrder> orderBy = const [],
    int offset = 0,
  }) => throw UnimplementedError();

  @override
  Future<int> countRows({
    required String table,
    required List<RowFilter> filters,
  }) => throw UnimplementedError();

  @override
  Future<List<Map<String, Object?>>> queryRows({
    required String table,
    required List<RowFilter> filters,
    required int limit,
    List<RowOrder> orderBy = const [],
    int offset = 0,
  }) async {
    calls.add((
      table: table,
      filters: filters,
      limit: limit,
      orderBy: orderBy,
      offset: offset,
    ));
    return rows.skip(offset).take(limit).toList();
  }

  @override
  Future<Map<String, Object?>> serverTime() async => {
    'localTime': '2026-11-21 12:00:00',
    'sessionTimeZone': '+08:00',
  };
}
