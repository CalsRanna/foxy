import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/use_case/agent/agent_read_only_data_source.dart';
import 'package:foxy_agent/foxy_agent.dart';

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
    ]);

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

  test('maps common MySQL types to logical types', () {
    final catalog = AgentReadOnlyDataSource.buildCatalog([
      _row('acore_world', 't', 'a', 'bigint', '', ''),
      _row('acore_world', 't', 'b', 'decimal', '', ''),
      _row('acore_world', 't', 'c', 'tinyint', '', ''),
      _row('acore_world', 't', 'd', 'varchar', '', ''),
      _row('acore_world', 't', 'e', 'bit', '', ''),
    ]);

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
    ]);

    expect(catalog.tables, isEmpty);
  });
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
