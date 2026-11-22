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
      actual.find('agent_stat_fixture')!,
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
          await QuerySqlTool(catalog, source).call({
            'sql':
                "SELECT COUNT(*) AS total FROM agent_stat_fixture "
                "WHERE created_at <= '$localTime'",
          }),
          {
            'rows': [
              {'total': 120},
            ],
            'truncated': false,
          },
        );
      } finally {
        await database.statement('set session time_zone = default');
      }
    });
  });

  test('real MySQL preserves SQL empty-set and null semantics', () async {
    final tool = QuerySqlTool(catalog, source);
    expect(
      await tool.call({
        'sql':
            'SELECT COUNT(*) AS total, SUM(price) AS total_price '
            'FROM agent_stat_fixture WHERE id = -1',
      }),
      {
        'rows': [
          {'total': 0, 'total_price': null},
        ],
        'truncated': false,
      },
    );
    expect(
      await tool.call({
        'sql':
            'SELECT expansion, COUNT(*) AS total FROM agent_stat_fixture '
            'WHERE id = -1 GROUP BY expansion',
      }),
      {'rows': <Object?>[], 'truncated': false},
    );
  });

  test('real MySQL expands declared references without multiplying rows', () async {
    final result = await QuerySqlTool(catalog, source).call({
      'sql':
          'SELECT parent.id, child.id AS linked_id, child.name AS linked_name '
          'FROM agent_stat_fixture parent '
          'LEFT JOIN agent_stat_fixture child ON parent.linked_id = child.id '
          'WHERE parent.id IN (1, 3) ORDER BY parent.id',
    }) as Map<String, Object?>;
    final rows = result['rows']! as List<Map<String, Object?>>;
    expect(rows, [
      {'id': 1, 'linked_id': 2, 'linked_name': 'Item 2'},
      {'id': 3, 'linked_id': null, 'linked_name': null},
    ]);
  });
}

class _Config extends ConfigUtil {
  @override
  Future<Map<String, Object?>> load() async => {
    'database': integrationWorldMysqlConfig().database,
  };
}
