import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/smart_script_entity.dart';
import 'package:foxy/infrastructure/errors/foxy_exceptions.dart';
import 'package:foxy/repository/smart_script_repository.dart';
import 'package:laconic/laconic.dart';
import 'package:laconic_mysql/laconic_mysql.dart';

/// H2 回归:生成 store 的重复键重试只重分配声明的 autoIncrementKey(id),
/// 并按 autoIncrementScope(entryorguid+source_type)限定作用域——
/// 修复前会把全部 4 个主键列取全局 MAX+1,粘贴已存在的行会静默写入
/// entryorguid 为全表最大+1 的无关垃圾行。
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

    // 重试前先取 MAX(id),where 限定 entryorguid=10 + source_type=1
    // (第三个绑定是 laconic first() 附加的 limit 1)。
    final maxSelect = queries
        .where((q) => q.sql.contains('MAX'))
        .single;
    expect(maxSelect.bindings.take(2).toList(), [10, 1]);

    // 两次 insert:第一次命中 ER_DUP_ENTRY,第二次重试成功。
    final inserts = queries
        .where((q) => q.sql.toLowerCase().contains('insert'))
        .toList();
    expect(inserts, hasLength(2));
    // 重试的实体只改 id(MAX+1 = 1000),其余主键列保持原值。
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
    // 重试失败时不再尝试改写其他主键。
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

  /// 重试的 insert 是否也命中重复键。
  final bool retryAlsoFails;
  var _insertCount = 0;

  _DuplicateRetryDriver({this.retryAlsoFails = false});

  static final _duplicateError = LaconicException(
    'MysqlServerException [1062]: Duplicate entry '
    "'10-1-2-3' for key 'PRIMARY'",
  );

  /// laconic 对无自增列的 insert 走 [statement],两种入口都注入重复键。
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
    // nextMaxPlusOne: SELECT MAX(`id`) AS max_id ... → 返回 999。
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
