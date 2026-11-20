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
      'drop table if exists agent_stat_fixture',
      '''create table agent_stat_fixture (
        id int not null primary key,
        expansion int not null,
        price decimal(12, 2) null,
        linked_id int null,
        name varchar(32) not null
      )''',
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
              'linked_id': index == 0 ? 2 : null,
              'name': 'Item ${index + 1}',
            },
          ),
        );
    source = AgentReadOnlyDataSource(_Config());
    final actual = await source.getCatalog();
    catalog = TableCatalog([
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

  tearDownAll(() async {
    await Database.instance.laconic.statement(
      'drop table if exists agent_stat_fixture',
    );
    await Database.instance.close();
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
    final result = await AggregateRowsTool(catalog, source).call({
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
      'limit': 1,
    }) as Map<String, Object?>;
    final row = (result['rows']! as List<Map<String, Object?>>).single;
    expect(result['truncated'], true);
    expect(row['expansion'], 0);
    expect(row['count'], 80);
    expect(row['count_price'], 40);
    expect(num.parse('${row['sum_price']}'), 50);
    for (final name in ['avg_price', 'min_price', 'max_price']) {
      expect(num.parse('${row[name]}'), 1.25);
    }
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
            'value': [1, 2],
          },
        ],
        'expand': [
          {
            'column': 'linked_id',
            'columns': ['name'],
          },
        ],
      }) as Map<String, Object?>;
      final rows = result['rows']! as List<Map<String, Object?>>;
      expect(rows, hasLength(2));
      expect(rows.firstWhere((row) => row['id'] == 1)['_expanded'], {
        'linked_id': {'id': 2, 'name': 'Item 2'},
      });
      expect(rows.firstWhere((row) => row['id'] == 2)['_expanded'], {
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
