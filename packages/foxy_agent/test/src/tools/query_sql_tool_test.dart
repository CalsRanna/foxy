import 'package:foxy_agent/foxy_agent.dart';
import 'package:test/test.dart';

void main() {
  group('query_sql', () {
    late _SqlSource source;
    late QuerySqlTool tool;

    setUp(() {
      source = _SqlSource();
      tool = QuerySqlTool(_catalog, source);
    });

    test('validates a join, conditions, grouping and a result alias', () async {
      const sql = '''SELECT v.entry, COUNT(DISTINCT i.entry) AS item_count,
       SUM(CASE WHEN i.BuyPrice > 0 THEN i.BuyPrice ELSE 0 END) AS cost
FROM npc_vendor v
LEFT JOIN item_template AS i ON v.item = i.entry
WHERE v.entry IN (10, 20) AND i.name LIKE 'O''Brien%'
GROUP BY v.entry HAVING COUNT(*) >= 1
ORDER BY item_count DESC LIMIT 10 OFFSET 2''';
      source.rows = [
        {'entry': 10, 'item_count': 2, 'cost': '3.50'},
      ];

      expect(await tool.call({'sql': '  $sql;\n'}), {
        'rows': source.rows,
        'truncated': false,
      });
      expect(
        source.executed.single,
        sql.replaceFirst('SELECT', 'SELECT /*+ MAX_EXECUTION_TIME(5000) */'),
      );
    });

    test('limits the SQL and reports when more rows exist', () async {
      source.rows = List.generate(51, (index) => {'entry': index});

      expect(
        await tool.call({
          'sql': 'SELECT entry FROM item_template ORDER BY entry',
        }),
        {'rows': hasLength(50), 'truncated': true},
      );
      expect(source.executed.single, endsWith('ORDER BY entry LIMIT 51'));
    });

    test('returns up to 200 rows with either explicit OFFSET syntax', () async {
      source.rows = List.generate(200, (index) => {'entry': index + 250});
      const select = 'SELECT entry FROM item_template ORDER BY entry';
      const clauses = ['LIMIT 200 OFFSET 250', 'LIMIT 250, 200'];

      for (final clause in clauses) {
        expect(await tool.call({'sql': '$select $clause'}), {
          'rows': source.rows,
          'truncated': false,
        });
        expect(source.executed.last, endsWith('ORDER BY entry $clause'));
      }
    });

    test('rejects an explicit page size over 200 before executing', () async {
      for (final clause in ['LIMIT 201', 'LIMIT 250, 201']) {
        expect(
          await tool.call({'sql': 'SELECT entry FROM item_template $clause'}),
          'SQL rejected: LIMIT must be at most 200.',
        );
      }
      expect(source.executed, isEmpty);
    });

    test('accepts a qualified table and quotes names literally', () async {
      expect(
        await tool.call({
          'sql': 'SELECT `a`.`username` FROM `acore_auth`.`account` AS `a` LIMIT 1',
        }),
        {'rows': isEmpty, 'truncated': false},
      );
      expect(source.executed.single, contains('`acore_auth`.`account`'));
    });

    test('requires distinct names for joined result columns', () async {
      const from = 'FROM npc_vendor v JOIN item_template i ON v.item = i.entry';
      expect(
        await tool.call({'sql': 'SELECT v.entry, i.entry $from'}),
        contains('Give the columns different AS aliases'),
      );
      expect(source.executed, isEmpty);

      expect(
        await tool.call({'sql': 'SELECT v.entry, i.entry AS item_entry $from'}),
        {'rows': isEmpty, 'truncated': false},
      );
      expect(source.executed, hasLength(1));
    });

    test('rejects noncatalog tables, columns and unqualified joins', () async {
      const queries = [
        'SELECT id FROM account',
        'SELECT id FROM acore_auth.secret_digest',
        'SELECT id FROM other_db.account',
        'SELECT password FROM acore_auth.account',
        'SELECT a.id FROM acore_auth.account a WHERE a.password IS NULL',
        'SELECT a.id FROM acore_auth.account a ORDER BY a.password',
        'SELECT a.id FROM acore_auth.account a GROUP BY a.password',
        'SELECT COUNT(*) FROM acore_auth.account HAVING MIN(password) > 0',
        'SELECT a.id AS password FROM acore_auth.account a GROUP BY password',
        'SELECT a.id FROM acore_auth.account a JOIN item_template i ON a.password = i.name',
        'SELECT entry FROM npc_vendor v JOIN item_template i ON v.item = i.entry',
      ];

      for (final sql in queries) {
        expect(
          await tool.call({'sql': sql}),
          startsWith('SQL rejected:'),
          reason: sql,
        );
      }
      expect(source.executed, isEmpty);
    });

    test('rejects SQL outside the single SELECT grammar', () async {
      const queries = [
        '',
        'UPDATE item_template SET BuyPrice = 1',
        'SELECT entry FROM item_template; SELECT entry FROM npc_vendor',
        'SELECT entry FROM item_template FOR UPDATE',
        'SELECT * FROM acore_auth.account',
        'SELECT a.* FROM acore_auth.account a',
        'SELECT entry FROM item_template LIMIT -1',
        'SELECT entry FROM item_template ORDER BY',
        'SELECT (SELECT entry FROM item_template) FROM npc_vendor',
        'SELECT entry FROM item_template UNION SELECT entry FROM npc_vendor',
        'SELECT entry FROM item_template /* comment */',
        'SELECT entry-- 1\nFROM item_template',
        'SELECT UNKNOWN_FUNCTION(entry) FROM item_template',
        'SELECT COUNT (*) FROM item_template',
        'SELECT "name" FROM item_template',
        r"SELECT name FROM item_template WHERE name = 'a\b'",
      ];

      for (final sql in queries) {
        expect(
          await tool.call({'sql': sql}),
          startsWith('SQL rejected:'),
          reason: sql,
        );
      }
      expect(source.executed, isEmpty);
    });
  });
}

const _catalog = TableCatalog([
  TableInfo(
    name: 'npc_vendor',
    columns: [
      ColumnInfo(name: 'entry'),
      ColumnInfo(name: 'item'),
    ],
  ),
  TableInfo(
    name: 'item_template',
    columns: [
      ColumnInfo(name: 'entry'),
      ColumnInfo(name: 'name'),
      ColumnInfo(name: 'BuyPrice'),
    ],
  ),
  TableInfo(
    name: 'account',
    database: 'acore_auth',
    columns: [
      ColumnInfo(name: 'id'),
      ColumnInfo(name: 'username'),
    ],
  ),
]);

final class _SqlSource implements ReadOnlyDataSource {
  final executed = <String>[];
  List<Map<String, Object?>> rows = [];

  @override
  Future<List<Map<String, Object?>>> querySql(ReadOnlySql sql) async {
    executed.add(sql.statement);
    return rows;
  }

  @override
  Future<Map<String, Object?>> serverTime() async => const {};
}
