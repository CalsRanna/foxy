import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/condition_entity.dart';
import 'package:foxy/event/entity_written_event.dart';
import 'package:foxy/event/event_bus.dart';
import 'package:foxy/infrastructure/database/database_transaction.dart';
import 'package:foxy/repository/condition_repository.dart';
import 'package:laconic/laconic.dart';
import 'package:laconic_mysql/laconic_mysql.dart';
import 'package:test/test.dart';

void main() {
  const original = ConditionEntity(
    sourceTypeOrReferenceId: 17,
    conditionTypeOrReference: 8,
    conditionValue1: 10,
  );
  final originalKey = ConditionKey.fromEntity(original);
  late _RecordingDriver driver;
  late ConditionRepository repository;
  late EventBus bus;
  late List<ActivityLogEntity> events;

  setUp(() {
    driver = _RecordingDriver(original.toJson());
    repository = _TestRepository(Laconic(driver));
    bus = EventBus(sync: true);
    events = [];
    final subscription = bus.on<EntityWrittenEvent>().listen((event) {
      expect(driver.inTransaction, isFalse);
      events.add(event.log);
    });
    addTearDown(() async {
      await subscription.cancel();
      bus.destroy();
    });
  });

  void publishUpdate() {
    EntityWrittenEvent.publish(
      bus,
      ActivityLogEntity(
        module: 'conditions',
        actionType: ActivityActionType.update,
        entityName: 'Condition',
        createdAt: DateTime.utc(2026, 11, 23),
      ),
    );
  }

  test('事务锁定旧键，按新键读回并比较数据库实际值', () async {
    final candidate = original.copyWith(conditionValue1: 20, comment: 'draft');
    driver.after = {...candidate.toJson(), 'Comment': 'persisted'};

    await EntityWrittenEvent.capture(() async {
      await repository.updateCondition(originalKey, candidate);
      publishUpdate();
    });

    expect(driver.operations, [
      'begin',
      'select',
      'update',
      'select',
      'commit',
    ]);
    expect(driver.keys.first[7], 10);
    expect(driver.keys.last[7], 20);
    final saved = events.single;
    final row = saved.details!.rows.single;
    expect(row.beforeKey, hasLength(10));
    expect(row.beforeKey!['ConditionValue1'], 10);
    expect(row.afterKey!['ConditionValue1'], 20);
    expect(row.changes.keys, unorderedEquals(['ConditionValue1', 'Comment']));
    expect(row.changes['Comment']!.after, 'persisted');
    final readBack = ActivityLogEntity.fromJson({
      ...saved.toJson(),
      'id': 1,
      'created_at': saved.createdAt.toIso8601String(),
    });
    expect(readBack.details!.toJson(), saved.details!.toJson());
  });

  test('保存没有实际差异时不发布动态', () async {
    await EntityWrittenEvent.capture(() async {
      await repository.updateCondition(originalKey, original);
      publishUpdate();
    });

    expect(driver.operations.last, 'commit');
    expect(events, isEmpty);
  });

  test('外层事务未提交时不发布动态，回滚后丢弃', () async {
    final candidate = original.copyWith(comment: 'changed');
    driver.after = candidate.toJson();
    final transaction = DatabaseTransaction(repository.laconic);
    await expectLater(
      transaction.execute(() async {
        await EntityWrittenEvent.capture(() async {
          await repository.updateCondition(originalKey, candidate);
          publishUpdate();
        });
        expect(events, isEmpty);
        throw StateError('rollback');
      }),
      throwsStateError,
    );

    expect(driver.operations, [
      'begin',
      'select',
      'update',
      'select',
      'rollback',
    ]);
    expect(events, isEmpty);
  });

  test('外层事务提交后合并实际变化的记录', () async {
    final candidate = original.copyWith(comment: 'changed');
    final newRecord = original.copyWith(elseGroup: 2);
    driver.after = candidate.toJson();

    await DatabaseTransaction(repository.laconic).execute(() async {
      await EntityWrittenEvent.capture(() async {
        await repository.updateCondition(originalKey, candidate);
        await repository.storeCondition(newRecord);
        publishUpdate();
      });
      expect(events, isEmpty);
    });

    expect(driver.operations, [
      'begin',
      'select',
      'update',
      'select',
      'insert',
      'commit',
    ]);
    final rows = events.single.details!.rows;
    expect(rows, hasLength(2));
    expect(rows.first.changes['Comment']!.after, 'changed');
    expect(rows.last.beforeKey, isNull);
    expect(rows.last.afterKey!['ElseGroup'], 2);
  });
}

final class _RecordingDriver implements DatabaseDriver {
  @override
  final SqlGrammar grammar = MysqlGrammar();
  final Map<String, Object?> before;
  late Map<String, Object?> after = before;
  final operations = <String>[];
  final keys = <List<Object?>>[];
  bool inTransaction = false;

  _RecordingDriver(this.before);

  @override
  Future<int> affectingStatement(
    String sql, [
    List<Object?> params = const [],
  ]) async {
    expect(inTransaction, isTrue);
    operations.add('update');
    return 1;
  }

  @override
  Future<void> close() async {}

  @override
  Future<int> insertAndGetId(String sql, [List<Object?> params = const []]) =>
      throw UnimplementedError();

  @override
  Future<List<LaconicResult>> select(
    String sql, [
    List<Object?> params = const [],
  ]) async {
    expect(inTransaction, isTrue);
    expect(sql, endsWith('for update'));
    operations.add('select');
    keys.add(params);
    return [LaconicResult.fromMap(keys.length == 1 ? before : after)];
  }

  @override
  Future<void> statement(String sql, [List<Object?> params = const []]) async {
    expect(inTransaction, isTrue);
    expect(sql, startsWith('insert'));
    operations.add('insert');
  }

  @override
  Future<T> transaction<T>(Future<T> Function() action) async {
    expect(inTransaction, isFalse);
    inTransaction = true;
    operations.add('begin');
    try {
      final result = await action();
      operations.add('commit');
      return result;
    } catch (_) {
      operations.add('rollback');
      rethrow;
    } finally {
      inTransaction = false;
    }
  }
}

final class _TestRepository extends ConditionRepository {
  @override
  final Laconic laconic;

  _TestRepository(this.laconic);
}
