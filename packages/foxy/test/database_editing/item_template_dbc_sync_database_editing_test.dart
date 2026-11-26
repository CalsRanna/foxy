import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/item_template_entity.dart';
import 'package:foxy/repository/dbc_item_repository.dart';
import 'package:foxy/repository/item_template_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:laconic/laconic.dart';
import 'package:laconic_mysql/laconic_mysql.dart';

void main() {
  setUp(() => GetIt.instance.reset());

  test(
    'Creating an item writes all eight mapped columns to foxy.dbc_item',
    () async {
      final env = _build();
      final candidate = _candidate();

      final storedKey = await env.repository.storeItemTemplate(candidate);
      expect(storedKey, 56807);

      final dbcQueries = _dbcQueries(env.queries);
      expect(dbcQueries, hasLength(2));
      expect(dbcQueries[0].sql.toLowerCase(), contains('select'));
      expect(dbcQueries[0].bindings.first, 56807);
      expect(dbcQueries[1].sql.toLowerCase(), contains('insert'));
      expect(dbcQueries[1].bindings, [56807, 16, 8, -1, 0, 58830, 0, 2]);
    },
  );

  test(
    'An existing DBC row is updated without inserting a duplicate',
    () async {
      final env = _build(
        selectResult: [
          {'ID': 56807},
        ],
      );

      await env.repository.storeItemTemplate(_candidate());

      final dbcQueries = _dbcQueries(env.queries);
      expect(dbcQueries, hasLength(2));
      expect(dbcQueries[1].sql.toLowerCase(), contains('update'));
      expect(dbcQueries[1].bindings, [56807, 16, 8, -1, 0, 58830, 0, 2, 56807]);
    },
  );

  test('Saving a changed display ID updates the DBC row', () async {
    final env = _build(
      selectResult: [
        {'ID': 56807},
      ],
    );

    await env.repository.updateItemTemplate(
      56807,
      _candidate().copyWith(displayId: 70000),
    );

    final dbcQueries = _dbcQueries(env.queries);
    expect(dbcQueries, hasLength(2));
    expect(dbcQueries[1].sql.toLowerCase(), contains('update'));
    expect(dbcQueries[1].bindings, [56807, 16, 8, -1, 0, 70000, 0, 2, 56807]);
  });

  test(
    'Changing entry deletes the old DBC row and writes the new ID',
    () async {
      final env = _build(
        selectResult: [
          {'ID': 56807},
        ],
      );

      await env.repository.updateItemTemplate(
        50000,
        _candidate().copyWith(entry: 56807),
      );

      final dbcQueries = _dbcQueries(env.queries);
      expect(dbcQueries, hasLength(3));
      expect(dbcQueries[0].sql.toLowerCase(), contains('delete'));
      expect(dbcQueries[0].bindings, [50000]);
      expect(dbcQueries[1].bindings.first, 56807);
      expect(dbcQueries[2].sql.toLowerCase(), contains('update'));
      expect(dbcQueries[2].bindings, [56807, 16, 8, -1, 0, 58830, 0, 2, 56807]);
    },
  );

  test('Deleting an item also deletes its DBC row', () async {
    final env = _build();

    await env.repository.destroyItemTemplate(56807);

    final dbcQueries = _dbcQueries(env.queries);
    expect(dbcQueries, hasLength(1));
    expect(dbcQueries.single.sql.toLowerCase(), contains('delete'));
    expect(dbcQueries.single.bindings, [56807]);
  });

  test('Deleting an item succeeds when its DBC row is missing', () async {
    final env = _build(
      affectingRowsFor: (sql) => sql.contains('dbc_item') ? 0 : 1,
    );

    await env.repository.destroyItemTemplate(56807);
  });

  test(
    'Best-effort DBC synchronization failures do not prevent an item save',
    () async {
      final env = _build(selectThrowsFor: (sql) => sql.contains('dbc_item'));

      final storedKey = await env.repository.storeItemTemplate(_candidate());
      expect(storedKey, 56807);
      // The existence-check select is recorded even though it throws; the
      // sync must stop there and never reach a dbc_item insert.
      final dbcQueries = _dbcQueries(env.queries);
      expect(dbcQueries, hasLength(1));
      expect(dbcQueries.single.sql.toLowerCase(), contains('select'));
    },
  );
}

({List<LaconicQuery> queries, ItemTemplateRepository repository}) _build({
  List<Map<String, Object?>> selectResult = const [],
  bool Function(String sql)? selectThrowsFor,
  int Function(String sql)? affectingRowsFor,
}) {
  final queries = <LaconicQuery>[];
  final laconic = Laconic(
    _RecordingDriver(
      selectResult: selectResult,
      selectThrowsFor: selectThrowsFor,
      affectingRowsFor: affectingRowsFor,
    ),
    listen: queries.add,
  );
  GetIt.instance.registerSingleton<DbcItemRepository>(
    _TestDbcItemRepository(laconic),
  );
  return (queries: queries, repository: _TestItemTemplateRepository(laconic));
}

ItemTemplateEntity _candidate() {
  return const ItemTemplateEntity(
    entry: 56807,
    className: 16,
    subclass: 8,
    soundOverrideSubclass: -1,
    material: 0,
    displayId: 58830,
    inventoryType: 0,
    sheath: 2,
  );
}

List<LaconicQuery> _dbcQueries(List<LaconicQuery> queries) {
  return queries.where((q) => q.sql.contains('dbc_item')).toList();
}

class _RecordingDriver implements DatabaseDriver {
  @override
  final SqlGrammar grammar = MysqlGrammar();
  final int affectedRows = 1;
  final List<Map<String, Object?>> selectResult;
  final bool Function(String sql)? selectThrowsFor;
  final int Function(String sql)? affectingRowsFor;

  _RecordingDriver({
    this.selectResult = const [],
    this.selectThrowsFor,
    this.affectingRowsFor,
  });

  @override
  Future<int> affectingStatement(
    String sql, [
    List<Object?> params = const [],
  ]) async {
    final fn = affectingRowsFor;
    return fn != null ? fn(sql) : affectedRows;
  }

  @override
  Future<void> close() async {}

  @override
  Future<int> insertAndGetId(
    String sql, [
    List<Object?> params = const [],
  ]) async => 1;

  @override
  Future<List<LaconicResult>> select(
    String sql, [
    List<Object?> params = const [],
  ]) async {
    final fn = selectThrowsFor;
    if (fn != null && fn(sql)) throw StateError('simulated sync failure');
    return [for (final row in selectResult) LaconicResult.fromMap(row)];
  }

  @override
  Future<void> statement(String sql, [List<Object?> params = const []]) async {}

  @override
  Future<T> transaction<T>(Future<T> Function() action) => action();
}

class _TestDbcItemRepository extends DbcItemRepository {
  @override
  final Laconic laconic;

  _TestDbcItemRepository(this.laconic);
}

class _TestItemTemplateRepository extends ItemTemplateRepository {
  @override
  final Laconic laconic;

  _TestItemTemplateRepository(this.laconic);
}
