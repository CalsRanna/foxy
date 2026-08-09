import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/smart_script_entity.dart';
import 'package:foxy/infrastructure/errors/foxy_exceptions.dart';
import 'package:foxy/repository/smart_script_repository.dart';
import 'package:laconic/laconic.dart';
import 'package:laconic_mysql/laconic_mysql.dart';

/// H2 regression: the generated store's duplicate-key retry only
/// reallocates the declared autoIncrementKey (id), scoped by
/// autoIncrementScope (entryorguid+source_type) — before the fix, all 4
/// primary-key columns took a global MAX+1, and pasting an existing row
/// silently wrote unrelated garbage rows whose entryorguid was
/// table-max+1.
void main() {
  test('store 重复键重试:只重分配 id,作用域 entryorguid+source_type', () async {
    final driver = _DuplicateRetryDriver();
    final queries = <LaconicQuery>[];
    final repository = _TestRepository(Laconic(driver, listen: queries.add));

    const script = SmartScriptEntity(
      entryOrGuid: 10,
      sourceType: 1,
      id: 2,
      link: 3,
      comment: 'x',
    );
    await repository.storeSmartScript(script);

    // Before the retry, take MAX(id) with where scoped to entryorguid=10 +
    // source_type=1 (the third bind is the limit 1 added by laconic
    // first()).
    final maxSelect = queries
        .where((q) => q.sql.toLowerCase().contains('max'))
        .single;
    expect(maxSelect.bindings.take(2).toList(), [10, 1]);

    // Two inserts: the first hits ER_DUP_ENTRY, the retry succeeds.
    final inserts = queries
        .where((q) => q.sql.toLowerCase().contains('insert'))
        .toList();
    expect(inserts, hasLength(2));
    // The retried entity only changes id (MAX+1 = 1000); all other
    // primary-key columns keep their values.
    final retriedBindings = inserts[1].bindings;
    final retriedJson = script.copyWith(id: 1000).toJson();
    expect(retriedBindings, retriedJson.values.toList());
  });

  test('重试仍冲突时抛 DuplicateKeyException 而不是写入垃圾行', () async {
    final driver = _DuplicateRetryDriver(retryAlsoFails: true);
    final queries = <LaconicQuery>[];
    final repository = _TestRepository(Laconic(driver, listen: queries.add));

    const script = SmartScriptEntity(
      entryOrGuid: 10,
      sourceType: 1,
      id: 2,
      link: 3,
    );
    await expectLater(
      repository.storeSmartScript(script),
      throwsA(isA<DuplicateKeyException>()),
    );
    // When the retry fails, no other primary key is rewritten.
    final inserts = queries
        .where((q) => q.sql.toLowerCase().contains('insert'))
        .toList();
    expect(inserts, hasLength(2));
  });
}

class _TestRepository extends SmartScriptRepository {
  @override
  final Laconic laconic;

  _TestRepository(this.laconic);
}

final class _DuplicateRetryDriver implements DatabaseDriver {
  @override
  final SqlGrammar grammar = MysqlGrammar();

  /// Whether the retry insert also hits a duplicate key.
  final bool retryAlsoFails;
  var _insertCount = 0;

  _DuplicateRetryDriver({this.retryAlsoFails = false});

  static final _duplicateError = LaconicException(
    'MysqlServerException [1062]: Duplicate entry '
    "'10-1-2-3' for key 'PRIMARY'",
    driver: 'mysql',
    code: '1062',
  );

  /// laconic routes inserts without auto-increment columns through
  /// [statement]; both entry points inject the duplicate key.
  void _maybeDuplicate(String sql) {
    if (sql.toLowerCase().contains('insert')) {
      _insertCount++;
      if (_insertCount == 1 || retryAlsoFails) {
        throw _duplicateError;
      }
    }
  }

  @override
  Future<int> affectingStatement(
    String sql, [
    List<Object?> params = const [],
  ]) async {
    _maybeDuplicate(sql);
    return 1;
  }

  @override
  Future<List<LaconicResult>> select(
    String sql, [
    List<Object?> params = const [],
  ]) async {
    // nextMaxPlusOne: SELECT MAX(`id`) AS max_id ... → returns 999.
    return [LaconicResult.fromMap({'max_id': 999})];
  }

  @override
  Future<void> close() async {}

  @override
  Future<int> insertAndGetId(
    String sql, [
    List<Object?> params = const [],
  ]) async {
    _maybeDuplicate(sql);
    return 1;
  }

  @override
  Future<void> statement(String sql, [List<Object?> params = const []]) async {
    _maybeDuplicate(sql);
  }

  @override
  Future<T> transaction<T>(Future<T> Function() action) => action();
}
