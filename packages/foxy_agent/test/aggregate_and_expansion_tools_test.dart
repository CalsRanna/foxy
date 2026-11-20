import 'package:foxy_agent/foxy_agent.dart';
import 'package:test/test.dart';

void main() {
  test(
    'count_rows returns exact totals without querying sample rows',
    () async {
      final source = _Source();
      final result = await CountRowsTool(_catalog, source).call({
        'table': 'items',
        'filters': [
          {'column': 'expansion', 'operator': 'equals', 'value': 2},
        ],
      });
      expect(result, {'table': 'foxy.items', 'count': 120});
      expect(source.countTable, 'foxy.items');
      expect(source.filters.single.column, 'expansion');
      expect(source.filters.single.value, 2);
      expect(source.rowCalls, isEmpty);
    },
  );

  test(
    'aggregate_rows forwards groups and metrics and marks omitted groups',
    () async {
      final source = _Source()
        ..aggregates = [
          {'expansion': 0, 'count': 80, 'sum_price': '1234.50'},
          {'expansion': 1, 'count': 40, 'sum_price': '200.00'},
        ];
      final result = await AggregateRowsTool(_catalog, source).call({
        'table': 'foxy.items',
        'groupBy': ['expansion'],
        'metrics': [
          {'function': 'count'},
          {'function': 'sum', 'column': 'price'},
        ],
        'limit': 1,
        'filters': [
          {'column': 'price', 'operator': 'greaterOrEqual', 'value': 0},
        ],
      });
      expect(result, {
        'table': 'foxy.items',
        'count': 1,
        'rows': [source.aggregates.first],
        'truncated': true,
      });
      expect(source.aggregateTable, 'foxy.items');
      expect(source.groups, ['expansion']);
      expect(source.metrics.map((metric) => metric.outputName), [
        'count',
        'sum_price',
      ]);
      expect(source.filters.single.operator, FilterOperator.greaterOrEqual);
      expect(source.limit, 2);
      expect(source.rowCalls, isEmpty);
    },
  );

  test(
    'ungrouped aggregation supports every function and clamps output only',
    () async {
      final source = _Source()
        ..aggregates = [
          {
            'count_price': 0,
            'sum_price': null,
            'avg_price': null,
            'min_price': null,
            'max_price': null,
          },
        ];
      final tool = AggregateRowsTool(_catalog, source);
      final result = await tool.call({
        'table': 'foxy.items',
        'metrics': [
          for (final function in AggregateFunction.values)
            {'function': function.name, 'column': 'price'},
        ],
        'limit': 500,
      }) as Map<String, Object?>;
      expect(source.groups, isEmpty);
      expect(source.limit, 51);
      expect(result['rows'], source.aggregates);
      expect(result.containsKey('truncated'), isFalse);
      await tool.call({
        'table': 'foxy.items',
        'metrics': [
          {'function': 'count'},
        ],
        'limit': -1,
      });
      expect(source.limit, 2);
    },
  );

  test(
    'count and aggregate validate tables and filters before data access',
    () async {
      final source = _Source();
      for (final tool in <AgentTool>[
        CountRowsTool(_catalog, source),
        AggregateRowsTool(_catalog, source),
      ]) {
        for (final input in <Map<String, Object?>>[
          {'table': 'missing'},
          {'table': 'foxy.items', 'filters': 'SQL'},
          {
            'table': 'foxy.items',
            'filters': [
              {'column': 'password', 'operator': 'equals', 'value': 1},
            ],
          },
          {
            'table': 'foxy.items',
            'filters': [
              {'column': 'id', 'operator': 'raw', 'value': 1},
            ],
          },
          {
            'table': 'foxy.items',
            'filters': [
              {'column': 'id', 'operator': 'equals'},
            ],
          },
          {
            'table': 'foxy.items',
            'filters': [
              {'column': 'id', 'operator': 'in', 'value': <int>[]},
            ],
          },
          {
            'table': 'foxy.items',
            'filters': [
              {
                'column': 'id',
                'operator': 'in',
                'value': [
                  {'sql': 'select'},
                ],
              },
            ],
          },
        ]) {
          expect(
            await tool.call({
              ...input,
              'metrics': [
                {'function': 'count'},
              ],
            }),
            isA<String>(),
          );
        }
      }
      expect(source.countTable, isNull);
      expect(source.aggregateTable, isNull);
    },
  );

  test(
    'aggregate rejects invalid dimensions, expressions and output collisions',
    () async {
      final source = _Source();
      final tool = AggregateRowsTool(_catalog, source);
      for (final input in <Map<String, Object?>>[
        {'metrics': []},
        {
          'metrics': [
            for (var i = 0; i < 9; i++) {'function': 'count'},
          ],
        },
        {
          'metrics': [
            {'function': 'count(DISTINCT id)'},
          ],
        },
        {
          'metrics': [
            {'function': 'sum', 'column': 'name'},
          ],
        },
        {
          'metrics': [
            {'function': 'sum'},
          ],
        },
        {
          'metrics': [
            {'function': 'count', 'column': 'password'},
          ],
        },
        {
          'metrics': [
            {'function': 'count'},
            {'function': 'count'},
          ],
        },
        {
          'groupBy': ['id', 'id'],
        },
        {
          'groupBy': ['id', 'name', 'price', 'expansion'],
        },
        {
          'groupBy': ['password'],
        },
        {
          'groupBy': ['count'],
        },
        {'limit': 1.5},
      ]) {
        expect(
          await tool.call({
            'table': 'foxy.items',
            'metrics': [
              {'function': 'count'},
            ],
            ...input,
          }),
          isA<String>(),
          reason: '$input',
        );
      }
      expect(source.aggregateTable, isNull);
    },
  );

  test(
    'query_rows batches expansion, preserves IDs and projects target columns',
    () async {
      final source = _Source()
        ..tables['links'] = [
          {'id': 1, 'item': 10},
          {'id': 2, 'item': 10},
          {'id': 3, 'item': 404},
          {'id': 4, 'item': null},
          {'id': 5, 'item': 20},
        ];
      final result = await QueryRowsTool(_catalog, source).call({
        'table': 'links',
        'limit': 4,
        'expand': [
          {
            'column': 'item',
            'columns': ['name'],
          },
        ],
      }) as Map<String, Object?>;
      final rows = result['rows']! as List<Map<String, Object?>>;
      expect(result['truncated'], true);
      expect(rows[0], {
        'id': 1,
        'item': 10,
        '_expanded': {
          'item': {'id': 10, 'name': 'Sword'},
        },
      });
      expect(rows[1]['_expanded'], rows[0]['_expanded']);
      expect(rows[2]['_expanded'], {'item': null});
      expect(rows[3]['_expanded'], {'item': null});
      expect(source.rowCalls, hasLength(2));
      expect(source.rowCalls.last.table, 'foxy.items');
      expect(source.rowCalls.last.filters.single.value, [10, 404]);
      expect(source.rowCalls.last.limit, 2);
      expect(source.tables['links']!.first.containsKey('_expanded'), isFalse);
    },
  );

  test('get_row can expand two references in the same tool call', () async {
    final source = _Source();
    final result = await GetRowTool(_catalog, source).call({
      'table': 'links',
      'key': {'id': 1},
      'expand': [
        {
          'column': 'item',
          'columns': ['name'],
        },
        {
          'column': 'other_item',
          'columns': ['price'],
        },
      ],
    }) as Map<String, Object?>;
    expect(result['found'], true);
    expect((result['row']! as Map<String, Object?>)['_expanded'], {
      'item': {'id': 10, 'name': 'Sword'},
      'other_item': {'id': 20, 'price': 15},
    });
    expect(source.rowCalls, hasLength(3));
  });

  test(
    'empty, missing and null results do not query reference tables',
    () async {
      final source = _Source()..tables['links'] = [];
      final tool = QueryRowsTool(_catalog, source);
      final arguments = <String, Object?>{
        'table': 'links',
        'expand': [
          {
            'column': 'item',
            'columns': ['name'],
          },
        ],
      };
      expect((await tool.call(arguments) as Map<String, Object?>)['count'], 0);
      expect(
        await GetRowTool(_catalog, source).call({
          ...arguments,
          'key': {'id': 1},
        }),
        {'found': false},
      );
      source.tables['links'] = [
        {'id': 1, 'item': null},
      ];
      final result = await tool.call(arguments) as Map<String, Object?>;
      expect(
        (result['rows']! as List<Map<String, Object?>>).single['_expanded'],
        {'item': null},
      );
      expect(source.rowCalls.every((call) => call.table == 'links'), isTrue);
    },
  );

  test(
    'expansion rejects undeclared, hidden and nonunique targets before reading',
    () async {
      final source = _Source();
      for (final tool in <AgentTool>[
        QueryRowsTool(_catalog, source),
        GetRowTool(_catalog, source),
      ]) {
        for (final expand in <Object?>[
          'item',
          [1],
          [
            {
              'column': 'id',
              'columns': ['name'],
            },
          ],
          [
            {
              'column': 'item',
              'columns': ['password'],
            },
          ],
          [
            {'column': 'item', 'columns': <String>[]},
          ],
          [
            {
              'column': 'many',
              'columns': ['name'],
            },
          ],
          [
            {
              'column': 'hidden',
              'columns': ['name'],
            },
          ],
          [
            {
              'column': 'item',
              'columns': ['name'],
            },
            {
              'column': 'item',
              'columns': ['name'],
            },
          ],
          List.filled(6, {
            'column': 'item',
            'columns': ['name'],
          }),
        ]) {
          expect(
            await tool.call({
              'table': 'links',
              'key': {'id': 1},
              'expand': expand,
            }),
            isA<String>(),
          );
        }
      }
      expect(source.rowCalls, isEmpty);
    },
  );
}

const _catalog = TableCatalog([
  TableInfo(
    name: 'items',
    database: 'foxy',
    columns: [
      ColumnInfo(name: 'id', type: 'int', primaryKey: true),
      ColumnInfo(name: 'name'),
      ColumnInfo(name: 'expansion', type: 'int'),
      ColumnInfo(name: 'price', type: 'decimal'),
      ColumnInfo(name: 'count', type: 'int'),
    ],
  ),
  TableInfo(
    name: 'links',
    columns: [
      ColumnInfo(name: 'id', type: 'int', primaryKey: true),
      ColumnInfo(
        name: 'item',
        type: 'int',
        semantics: ColumnSemantics.reference(
          label: '物品',
          reference: ColumnReference(table: 'foxy.items', column: 'id'),
        ),
      ),
      ColumnInfo(
        name: 'other_item',
        type: 'int',
        semantics: ColumnSemantics.reference(
          label: '物品',
          reference: ColumnReference(table: 'foxy.items', column: 'id'),
        ),
      ),
      ColumnInfo(
        name: 'many',
        type: 'int',
        semantics: ColumnSemantics.reference(
          label: '多项',
          reference: ColumnReference(table: 'foxy.items', column: 'expansion'),
        ),
      ),
      ColumnInfo(
        name: 'hidden',
        type: 'int',
        semantics: ColumnSemantics.reference(
          label: '隐藏',
          reference: ColumnReference(table: 'secrets', column: 'id'),
        ),
      ),
    ],
  ),
]);

final class _Source implements ReadOnlyDataSource {
  final tables = <String, List<Map<String, Object?>>>{
    'links': [
      {'id': 1, 'item': 10, 'other_item': 20},
    ],
    'foxy.items': [
      {'id': 10, 'name': 'Sword', 'price': 10},
      {'id': 20, 'name': 'Shield', 'price': 15},
    ],
  };
  final rowCalls = <({String table, List<RowFilter> filters, int limit})>[];
  String? countTable;
  String? aggregateTable;
  List<RowFilter> filters = [];
  List<String> groups = [];
  List<AggregateMetric> metrics = [];
  int? limit;
  List<Map<String, Object?>> aggregates = [];

  @override
  Future<int> countRows({
    required String table,
    required List<RowFilter> filters,
  }) async {
    countTable = table;
    this.filters = filters;
    return 120;
  }

  @override
  Future<List<Map<String, Object?>>> aggregateRows({
    required String table,
    required List<RowFilter> filters,
    required List<String> groupBy,
    required List<AggregateMetric> metrics,
    required int limit,
  }) async {
    aggregateTable = table;
    this.filters = filters;
    groups = groupBy;
    this.metrics = metrics;
    this.limit = limit;
    return aggregates;
  }

  @override
  Future<List<Map<String, Object?>>> queryRows({
    required String table,
    required List<RowFilter> filters,
    required int limit,
  }) async {
    rowCalls.add((table: table, filters: filters, limit: limit));
    return tables[table]!
        .where(
          (row) => filters.every(
            (filter) => filter.operator == FilterOperator.inList
                ? (filter.value! as List<Object?>).contains(row[filter.column])
                : row[filter.column] == filter.value,
          ),
        )
        .take(limit)
        .toList();
  }
}
