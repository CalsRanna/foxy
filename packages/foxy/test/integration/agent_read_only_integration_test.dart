@Tags(['integration'])
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/infrastructure/config/config_util.dart';
import 'package:foxy/infrastructure/database/database.dart';
import 'package:foxy/use_case/agent/agent_read_only_data_source.dart';
import 'package:foxy_agent/foxy_agent.dart';

import 'integration_mysql.dart';

void main() {
  late AgentReadOnlyDataSource source;
  late TableCatalog catalog;

  setUpAll(() async {
    await connectIntegrationWorldDatabase([
      'drop view if exists agent_stat_view',
      'drop table if exists agent_stat_fixture',
      '''create table agent_stat_fixture (
        id int not null primary key,
        expansion int not null,
        price decimal(12, 2) null,
        linked_id int null,
        created_at timestamp not null default current_timestamp,
        name varchar(32) not null
      )''',
      'create view agent_stat_view as select id from agent_stat_fixture',
    ]);
    final database = Database.instance.laconic;
    await database
        .table('agent_stat_fixture')
        .insert(
          List.generate(
            120,
            (index) => <String, Object?>{
              'id': index + 1,
              'expansion': index < 80 ? 0 : 1,
              'price': index.isEven ? '1.25' : null,
              'linked_id': index < 2 ? index + 2 : null,
              'name': 'Item ${index + 1}',
            },
          ),
        );
    source = AgentReadOnlyDataSource(_Config());
    final actual = await source.getCatalog();
    catalog = TableCatalog([
      actual.find('agent_stat_view')!,
      TableInfo(
        name: 'agent_stat_fixture',
        columns: actual.find('agent_stat_fixture')!.columns.map((column) {
          if (column.name != 'linked_id') return column;
          return ColumnInfo(
            name: column.name,
            type: column.type,
            semantics: const ColumnSemantics.reference(
              label: '关联记录',
              reference: ColumnReference(
                table: 'agent_stat_fixture',
                column: 'id',
              ),
            ),
          );
        }).toList(),
      ),
    ]);
  });

  test('real MySQL ranks all rows and pages ties without duplicates', () async {
    final tool = QueryRowsTool(catalog, source);
    final arguments = <String, Object?>{
      'table': 'agent_stat_fixture',
      'orderBy': [
        {'column': 'price', 'direction': 'desc'},
      ],
      'limit': 50,
    };
    final ids = <Object?>[];
    var offset = 0;
    for (final expectedNextOffset in [50, 100, null]) {
      final page = await tool.call({
        ...arguments,
        'offset': offset,
      }) as Map<String, Object?>;
      final rows = page['rows']! as List<Map<String, Object?>>;
      ids.addAll(rows.map((row) => row['id']));
      expect(page['nextOffset'], expectedNextOffset);
      offset = page['nextOffset'] as int? ?? 0;
    }
    expect(ids, [
      for (var i = 1; i <= 120; i += 2) i,
      for (var i = 2; i <= 120; i += 2) i,
    ]);
  });

  tearDownAll(() async {
    await Database.instance.laconic.statement(
      'drop view if exists agent_stat_view',
    );
    await Database.instance.laconic.statement(
      'drop table if exists agent_stat_fixture',
    );
    await Database.instance.close();
  });

  test(
    'query_sql executes a catalog-checked MySQL join and aggregation',
    () async {
      final tools = createReadOnlyTools(catalog: catalog, dataSource: source);
      final tool = tools.singleWhere((tool) => tool.name == 'query_sql');

      expect(
        await tool.call({
          'sql': '''
      SELECT parent.expansion, COUNT(*) AS related_count, SUM(child.price) AS total
      FROM agent_stat_fixture parent
      JOIN agent_stat_fixture child ON parent.linked_id = child.id
      GROUP BY parent.expansion
      HAVING COUNT(*) >= 2
      ORDER BY related_count DESC
    ''',
        }),
        {
          'rows': [
            {'expansion': 0, 'related_count': 2, 'total': '1.25'},
          ],
          'truncated': false,
          'elapsedMs': isNonNegative,
        },
      );

      final page = await tool.call({
        'sql': 'SELECT id FROM agent_stat_fixture ORDER BY id',
      }) as Map<String, Object?>;
      expect(page['rows'], hasLength(50));
      expect(page['truncated'], isTrue);

      expect(
        await tools.singleWhere((tool) => tool.name == 'list_tables').call({}),
        {
          'tables': [
            {'name': 'agent_stat_fixture'},
          ],
          'count': 1,
        },
      );
      expect(
        await tool.call({'sql': 'SELECT id FROM agent_stat_view'}),
        startsWith('SQL rejected: Table is outside the catalog'),
      );
    },
  );

  test(
    'explain_sql reports the plan and table statistics from MySQL',
    () async {
      final tools = createReadOnlyTools(catalog: catalog, dataSource: source);
      final tool = tools.singleWhere((tool) => tool.name == 'explain_sql');
      const select = 'SELECT f.id FROM agent_stat_fixture f';

      final indexed = await tool.call({
        'sql': '$select WHERE f.id BETWEEN 2 AND 4',
      }) as Map<String, Object?>;
      expect(
        indexed['plan'],
        containsPair(
          'query_block',
          allOf(
            containsPair('cost_info', contains('query_cost')),
            containsPair(
              'table',
              allOf(
                containsPair('table_name', 'f'),
                containsPair('key', 'PRIMARY'),
                containsPair('used_key_parts', ['id']),
              ),
            ),
          ),
        ),
      );

      final scanned = await tool.call({
        'sql': "$select WHERE f.name LIKE '%Item%'",
      }) as Map<String, Object?>;
      expect(
        scanned['plan'],
        containsPair(
          'query_block',
          containsPair(
            'table',
            allOf(
              containsPair('access_type', 'ALL'),
              containsPair('rows_examined_per_scan', isPositive),
              isNot(contains('key')),
              isNot(contains('attached_condition')),
            ),
          ),
        ),
      );
      expect(scanned['tables'], [
        allOf(
          containsPair('table', 'agent_stat_fixture'),
          containsPair('aliases', ['f']),
          containsPair('estimatedRows', isPositive),
          containsPair('dataBytes', isPositive),
          containsPair('indexBytes', isNonNegative),
          containsPair('indexes', [
            allOf(
              containsPair('name', 'PRIMARY'),
              containsPair('columns', [containsPair('column', 'id')]),
            ),
          ]),
        ),
      ]);
    },
  );

  test('query_sql paginates explicit 200-row pages in MySQL', () async {
    final tool = QuerySqlTool(catalog, source);
    const sql = '''
SELECT a.id AS row_id, b.id AS joined_id
FROM agent_stat_fixture a
JOIN agent_stat_fixture b ON b.id <= 2
ORDER BY a.id, b.id''';

    final first =
        await tool.call({'sql': '$sql LIMIT 200'}) as Map<String, Object?>;
    final second = await tool.call({
      'sql': '$sql LIMIT 200 OFFSET 200',
    }) as Map<String, Object?>;
    final firstRows = first['rows'] as List<Map<String, Object?>>;
    final secondRows = second['rows'] as List<Map<String, Object?>>;

    expect(firstRows, hasLength(200));
    expect(firstRows.last, {'row_id': 100, 'joined_id': 2});
    expect(secondRows, hasLength(40));
    expect(secondRows.first, {'row_id': 101, 'joined_id': 1});
  });

  test(
    'real MySQL counts all 120 rows and filters instead of sampling 50',
    () async {
      final tool = CountRowsTool(catalog, source);
      expect(await tool.call({'table': 'agent_stat_fixture'}), {
        'table': 'agent_stat_fixture',
        'count': 120,
      });
      expect(
        await tool.call({
          'table': 'agent_stat_fixture',
          'filters': [
            {'column': 'expansion', 'operator': 'equals', 'value': 0},
          ],
        }),
        {'table': 'agent_stat_fixture', 'count': 80},
      );
    },
  );

  test('real MySQL groups every row before the output limit', () async {
    final tool = AggregateRowsTool(catalog, source);
    final arguments = <String, Object?>{
      'table': 'agent_stat_fixture',
      'groupBy': ['expansion'],
      'metrics': [
        {'function': 'count'},
        {'function': 'count', 'column': 'price'},
        {'function': 'sum', 'column': 'price'},
        {'function': 'avg', 'column': 'price'},
        {'function': 'min', 'column': 'price'},
        {'function': 'max', 'column': 'price'},
      ],
      'orderBy': [
        {'column': 'sum_price', 'direction': 'asc'},
      ],
      'limit': 1,
    };
    final result = await tool.call(arguments) as Map<String, Object?>;
    final first = (result['rows']! as List<Map<String, Object?>>).single;
    expect(first['expansion'], 1);
    expect(first['count'], 40);
    expect(result['nextOffset'], 1);
    final next = await tool.call({
      ...arguments,
      'offset': result['nextOffset'],
    }) as Map<String, Object?>;
    final row = (next['rows']! as List<Map<String, Object?>>).single;
    expect(next.containsKey('nextOffset'), isFalse);
    expect(row['expansion'], 0);
    expect(row['count'], 80);
    expect(row['count_price'], 40);
    expect(num.parse('${row['sum_price']}'), 50);
    for (final name in ['avg_price', 'min_price', 'max_price']) {
      expect(num.parse('${row[name]}'), 1.25);
    }
  });

  test('real MySQL reports its session clock for timestamp filters', () async {
    final database = Database.instance.laconic;
    await database.transaction(() async {
      await database.statement("set session time_zone = '+05:30'");
      try {
        final clock =
            await ServerTimeTool(source).call({}) as Map<String, Object?>;
        expect(clock['sessionTimeZone'], '+05:30');
        expect(clock['utcOffsetSeconds'], 19800);
        final utc = DateTime.parse(clock['utcTime']! as String);
        final localTime = clock['localTime']! as String;
        final wallTime = DateTime.parse('${localTime}Z');
        expect(wallTime.difference(utc), const Duration(hours: 5, minutes: 30));
        expect(clock['unixTimestamp'], utc.millisecondsSinceEpoch ~/ 1000);
        expect(
          catalog.find('agent_stat_fixture')!.findColumn('created_at')!.type,
          'timestamp',
        );
        expect(
          await CountRowsTool(catalog, source).call({
            'table': 'agent_stat_fixture',
            'filters': [
              {
                'column': 'created_at',
                'operator': 'lessOrEqual',
                'value': localTime,
              },
            ],
          }),
          {'table': 'agent_stat_fixture', 'count': 120},
        );
      } finally {
        await database.statement('set session time_zone = default');
      }
    });
  });

  test('real MySQL preserves SQL empty-set and null semantics', () async {
    final tool = AggregateRowsTool(catalog, source);
    final arguments = <String, Object?>{
      'table': 'agent_stat_fixture',
      'filters': [
        {'column': 'id', 'operator': 'equals', 'value': -1},
      ],
      'metrics': [
        {'function': 'count'},
        {'function': 'sum', 'column': 'price'},
      ],
    };
    final empty = await tool.call(arguments) as Map<String, Object?>;
    expect(empty['rows'], [
      {'count': 0, 'sum_price': null},
    ]);
    final grouped = await tool.call({
      ...arguments,
      'groupBy': ['expansion'],
    }) as Map<String, Object?>;
    expect(grouped['rows'], isEmpty);
  });

  test(
    'real MySQL expands declared references without multiplying rows',
    () async {
      final result = await QueryRowsTool(catalog, source).call({
        'table': 'agent_stat_fixture',
        'filters': [
          {
            'column': 'id',
            'operator': 'in',
            'value': [1, 3],
          },
        ],
        'expand': [
          {
            'column': 'linked_id',
            'columns': ['name'],
            'expand': [
              {
                'column': 'linked_id',
                'columns': ['name'],
              },
            ],
          },
        ],
      }) as Map<String, Object?>;
      final rows = result['rows']! as List<Map<String, Object?>>;
      expect(rows, hasLength(2));
      expect(rows.firstWhere((row) => row['id'] == 1)['_expanded'], {
        'linked_id': {
          'id': 2,
          'name': 'Item 2',
          'linked_id': 3,
          '_expanded': {
            'linked_id': {'id': 3, 'name': 'Item 3'},
          },
        },
      });
      expect(rows.firstWhere((row) => row['id'] == 3)['_expanded'], {
        'linked_id': null,
      });
    },
  );
}

class _Config extends ConfigUtil {
  @override
  Future<Map<String, Object?>> load() async => {
    'database': integrationWorldMysqlConfig().database,
  };
}
