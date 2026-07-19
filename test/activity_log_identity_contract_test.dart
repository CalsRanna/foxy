import 'dart:async';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/event/event_bus.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:laconic/laconic.dart';
import 'package:laconic_mysql/laconic_mysql.dart';

void main() {
  test('ActivityLog 只保留日志行 ID 和可读目标标签', () {
    final createdAt = DateTime.utc(2026, 7, 19);
    final log = ActivityLogEntity.fromJson({
      'id': 7,
      'module': 'conditions',
      'action_type': 'update',
      'entity_name': 'Condition 17/0/123/0/0',
      'created_at': createdAt.toIso8601String(),
    });

    expect(log.id, 7);
    expect(log.entityName, 'Condition 17/0/123/0/0');
    expect(log.createdAt, createdAt);
    expect(log.toJson(), {
      'module': 'conditions',
      'action_type': 'update',
      'entity_name': 'Condition 17/0/123/0/0',
    });
    expect(log.toJson(), isNot(contains('id')));
    expect(log.toJson(), isNot(contains('entity_id')));
  });

  test('迁移按顺序安全删除旧业务 ID 列', () {
    final migration = File(
      'lib/database/migration/migration_202607190000.dart',
    ).readAsStringSync();
    final runner = File(
      'lib/database/migration_runner.dart',
    ).readAsStringSync();

    expect(migration, contains("String get name => 'migration_202607190000'"));
    expect(migration, contains(".where('TABLE_SCHEMA', 'foxy')"));
    expect(migration, contains(".where('COLUMN_NAME', 'entity_id')"));
    expect(
      migration,
      contains("SET entity_name = CONCAT(module, ' #', entity_id)"),
    );
    expect(
      migration,
      contains('ALTER TABLE foxy.activity_log DROP COLUMN entity_id'),
    );
    expect(migration, contains('if (columnCount == 0) return'));
    expect(
      runner.indexOf('Migration202607190000()'),
      greaterThan(runner.indexOf('Migration202605010000()')),
    );
  });

  test('Repository 与全部业务调用方不再读取或传递业务 ID', () {
    final entity = File(
      'lib/entity/activity_log_entity.dart',
    ).readAsStringSync();
    final repository = File(
      'lib/repository/activity_log_repository.dart',
    ).readAsStringSync();
    final trend = File(
      'lib/page/dashboard/component/trend.dart',
    ).readAsStringSync();
    final pageSources = Directory('lib/page')
        .listSync(recursive: true)
        .whereType<File>()
        .where((file) => file.path.endsWith('.dart'))
        .map((file) => file.readAsStringSync())
        .join();

    expect(entity, isNot(contains('entityId')));
    expect(entity, isNot(contains("'entity_id'")));
    expect(
      repository,
      contains("['id', 'module', 'action_type', 'entity_name', 'created_at']"),
    );
    expect(repository, isNot(contains(".select(['*'])")));
    expect(pageSources, isNot(contains('entityId:')));
    expect(pageSources, isNot(contains("entityName: ''")));
    expect(trend, contains("activity.entityName"));
    expect(trend, isNot(contains('activity.entityId')));
  });

  test('best-effort 日志失败不会泄漏异步错误', () async {
    final eventBus = EventBus(sync: true);
    GetIt.instance.registerSingleton<EventBus>(eventBus);
    addTearDown(() async {
      eventBus.destroy();
      await GetIt.instance.reset();
    });
    final repository = _TestActivityLogRepository(Laconic(_FailingDriver()));
    final uncaught = <Object>[];

    runZonedGuarded(() {
      repository.storeActivityLogBestEffort(
        ActivityLogEntity(
          module: 'conditions',
          actionType: ActivityActionType.update,
          entityName: 'Condition 17/0/123/0/0',
          createdAt: DateTime.now(),
        ),
      );
    }, (error, stackTrace) => uncaught.add(error));
    await Future<void>.delayed(Duration.zero);
    await Future<void>.delayed(Duration.zero);

    expect(uncaught, isEmpty);
  });
}

class _FailingDriver implements DatabaseDriver {
  @override
  final SqlGrammar grammar = MysqlGrammar();

  @override
  Future<int> affectingStatement(
    String sql, [
    List<Object?> params = const [],
  ]) => throw StateError('write failed');

  @override
  Future<void> close() async {}

  @override
  Future<int> insertAndGetId(String sql, [List<Object?> params = const []]) =>
      throw StateError('write failed');

  @override
  Future<List<LaconicResult>> select(
    String sql, [
    List<Object?> params = const [],
  ]) async => const [];

  @override
  Future<void> statement(String sql, [List<Object?> params = const []]) =>
      throw StateError('write failed');

  @override
  Future<T> transaction<T>(Future<T> Function() action) => action();
}

class _TestActivityLogRepository extends ActivityLogRepository {
  @override
  final Laconic laconic;

  _TestActivityLogRepository(this.laconic);
}
