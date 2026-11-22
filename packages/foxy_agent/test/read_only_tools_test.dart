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
      'query_sql',
    ]);
  });

  test('describe_references reports incoming and outgoing edges', () async {
    const catalog = TableCatalog([
      TableInfo(
        name: 'items',
        database: 'foxy',
        columns: [
          ColumnInfo(name: 'id', type: 'int', primaryKey: true),
          ColumnInfo(name: 'name'),
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
            name: 'many',
            type: 'int',
            semantics: ColumnSemantics.reference(
              label: '多项',
              reference: ColumnReference(table: 'foxy.items', column: 'name'),
            ),
          ),
        ],
      ),
    ]);
    const tool = DescribeReferencesTool(catalog);

    final result = _asMap(await tool.call({'table': 'items'}));

    final incoming = _asList(result['incoming']).cast<Map<String, Object?>>();
    expect(incoming.map((edge) => edge['sourceColumn']), ['item', 'many']);
    expect(incoming.first, {
      'sourceTable': 'links',
      'sourceColumn': 'item',
      'targetTable': 'foxy.items',
      'targetColumn': 'id',
    });
    expect(_asList(result['outgoing']), isEmpty);

    final links = _asMap(await tool.call({'table': 'links'}));
    expect(_asList(links['incoming']), isEmpty);
    expect(_asList(links['outgoing']), incoming);
  });

  test('server_time returns the data source clock', () async {
    final source = _FakeDataSource([]);
    expect(await ServerTimeTool(source).call({}), {
      'localTime': '2026-11-21 12:00:00',
      'sessionTimeZone': '+08:00',
    });
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

  _FakeDataSource(this.rows);

  @override
  Future<List<Map<String, Object?>>> querySql(ReadOnlySql sql) async => rows;

  @override
  Future<Map<String, Object?>> serverTime() async => {
    'localTime': '2026-11-21 12:00:00',
    'sessionTimeZone': '+08:00',
  };
}
