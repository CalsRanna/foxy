import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/brief_condition_entity.dart';
import 'package:foxy/entity/condition_entity.dart';
import 'package:foxy/entity/condition_key.dart';
import 'package:foxy/event/event_bus.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/page/condition/condition_detail_view_model.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/condition_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:get_it/get_it.dart';
import 'package:laconic/laconic.dart';
import 'package:laconic_mysql/laconic_mysql.dart';
import 'package:mysql_client/exception.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('ConditionKey', () {
    test('完整覆盖十列主键并实现值相等', () {
      final entity = _condition();
      final key = ConditionKey.fromEntity(entity);
      final same = ConditionKey.fromEntity(
        entity.copyWith(comment: 'different'),
      );

      expect(key, same);
      expect(key.hashCode, same.hashCode);
      expect(key.sourceTypeOrReferenceId, entity.sourceTypeOrReferenceId);
      expect(key.sourceGroup, entity.sourceGroup);
      expect(key.sourceEntry, entity.sourceEntry);
      expect(key.sourceId, entity.sourceId);
      expect(key.elseGroup, entity.elseGroup);
      expect(key.conditionTypeOrReference, entity.conditionTypeOrReference);
      expect(key.conditionTarget, entity.conditionTarget);
      expect(key.conditionValue1, entity.conditionValue1);
      expect(key.conditionValue2, entity.conditionValue2);
      expect(key.conditionValue3, entity.conditionValue3);

      expect(
        key,
        isNot(ConditionKey.fromEntity(entity.copyWith(sourceGroup: 1))),
      );
      expect(
        key,
        isNot(ConditionKey.fromEntity(entity.copyWith(sourceEntry: 2))),
      );
      expect(key, isNot(ConditionKey.fromEntity(entity.copyWith(sourceId: 1))));
      expect(
        key,
        isNot(ConditionKey.fromEntity(entity.copyWith(elseGroup: 1))),
      );
      expect(
        key,
        isNot(
          ConditionKey.fromEntity(entity.copyWith(conditionTypeOrReference: 3)),
        ),
      );
      expect(
        key,
        isNot(ConditionKey.fromEntity(entity.copyWith(conditionTarget: 1))),
      );
      expect(
        key,
        isNot(ConditionKey.fromEntity(entity.copyWith(conditionValue1: 2))),
      );
      expect(
        key,
        isNot(ConditionKey.fromEntity(entity.copyWith(conditionValue2: 2))),
      );
      expect(
        key,
        isNot(ConditionKey.fromEntity(entity.copyWith(conditionValue3: 2))),
      );
      expect(
        key,
        isNot(
          ConditionKey.fromEntity(entity.copyWith(sourceTypeOrReferenceId: 18)),
        ),
      );
    });

    test('Brief Entity 提供完整强类型 key', () {
      const brief = BriefConditionEntity(
        sourceTypeOrReferenceId: 17,
        sourceGroup: 2,
        sourceEntry: 3,
        sourceId: 4,
        elseGroup: 5,
        conditionTypeOrReference: 6,
        conditionTarget: 7,
        conditionValue1: 8,
        conditionValue2: 9,
        conditionValue3: 10,
      );

      expect(
        brief.key,
        const ConditionKey(
          sourceTypeOrReferenceId: 17,
          sourceGroup: 2,
          sourceEntry: 3,
          sourceId: 4,
          elseGroup: 5,
          conditionTypeOrReference: 6,
          conditionTarget: 7,
          conditionValue1: 8,
          conditionValue2: 9,
          conditionValue3: 10,
        ),
      );
    });
  });

  group('ConditionRepository write contract', () {
    test('UPDATE 使用完整旧 key 定位并写入 candidate 全部十五列', () async {
      final driver = _RecordingDriver(affectedRows: 1);
      final queries = <LaconicQuery>[];
      final repository = _TestConditionRepository(
        Laconic(driver, listen: queries.add),
      );
      final original = ConditionKey.fromEntity(_condition());
      final candidate = _condition(
        sourceTypeOrReferenceId: 18,
        sourceEntry: 20,
        elseGroup: 3,
        comment: 'changed',
      );

      await repository.updateCondition(original, candidate);

      expect(queries, hasLength(1));
      expect(queries.single.sql.toLowerCase(), startsWith('update'));
      expect(queries.single.bindings, [
        ...candidate.toJson().values,
        original.sourceTypeOrReferenceId,
        original.sourceGroup,
        original.sourceEntry,
        original.sourceId,
        original.elseGroup,
        original.conditionTypeOrReference,
        original.conditionTarget,
        original.conditionValue1,
        original.conditionValue2,
        original.conditionValue3,
      ]);
    });

    test('UPDATE 与 DELETE 零行结果报告旧记录不存在', () async {
      final repository = _TestConditionRepository(
        Laconic(_RecordingDriver(affectedRows: 0)),
      );
      final key = ConditionKey.fromEntity(_condition());

      await expectLater(
        repository.updateCondition(key, _condition()),
        throwsA(
          isA<StateError>().having(
            (error) => error.message,
            'message',
            contains('原记录不存在'),
          ),
        ),
      );
      await expectLater(
        repository.destroyCondition(key),
        throwsA(
          isA<StateError>().having(
            (error) => error.message,
            'message',
            contains('原记录不存在'),
          ),
        ),
      );
    });

    test('重复键按 MySQL 错误码转换且其他错误继续传播', () async {
      final duplicate = LaconicException(
        'write failed',
        cause: const MySQLServerException('duplicate', 1062),
      );
      final repository = _TestConditionRepository(
        Laconic(_RecordingDriver(error: duplicate)),
      );
      final key = ConditionKey.fromEntity(_condition());

      expect(MysqlErrorUtil.isDuplicateEntry(duplicate), isTrue);
      expect(
        MysqlErrorUtil.isDuplicateEntry(
          const MySQLServerException('other', 1452),
        ),
        isFalse,
      );
      await expectLater(
        repository.updateCondition(key, _condition()),
        throwsA(
          isA<StateError>().having(
            (error) => error.message,
            'message',
            contains('修改后的主键已存在'),
          ),
        ),
      );
    });

    test('affectingStatement 保留参数绑定并通知 query listener', () async {
      final driver = _RecordingDriver(affectedRows: 1);
      final queries = <LaconicQuery>[];
      final laconic = Laconic(driver, listen: queries.add);

      final affectedRows = await laconic.affectingStatement(
        'UPDATE conditions SET Comment = ? WHERE SourceEntry = ? LIMIT 1',
        ['value', 42],
      );

      expect(affectedRows, 1);
      expect(queries.single.bindings, ['value', 42]);
      expect(queries.single.sql, contains('LIMIT 1'));
    });
  });

  group('ConditionDetailViewModel persisted identity', () {
    late _FakeConditionRepository repository;
    late _RecordingActivityLogRepository activityLogs;
    late EventBus eventBus;

    setUp(() {
      repository = _FakeConditionRepository(_condition());
      eventBus = EventBus(sync: true);
      GetIt.instance.registerSingleton<EventBus>(eventBus);
      activityLogs = _RecordingActivityLogRepository();
      GetIt.instance.registerSingleton<ActivityLogRepository>(activityLogs);
      GetIt.instance.registerSingleton<ConditionRepository>(repository);
      GetIt.instance.registerSingleton<RouterFacade>(RouterFacade());
    });

    tearDown(() async {
      eventBus.destroy();
      await GetIt.instance.reset();
    });

    test('主键变化成功后切换 key，连续保存使用新 key', () async {
      final original = ConditionKey.fromEntity(_condition());
      final viewModel = ConditionDetailViewModel();
      addTearDown(viewModel.dispose);
      await viewModel.initSignals(conditionKey: original);
      final changed = _condition(
        sourceTypeOrReferenceId: 18,
        sourceEntry: 20,
        comment: 'changed',
      );
      _initControllers(viewModel, changed);

      await viewModel.persist();

      final changedKey = ConditionKey.fromEntity(changed);
      expect(repository.updateKeys, [original]);
      expect(viewModel.persistedKey.value, changedKey);
      viewModel.commentController.init('second save');
      await viewModel.persist();
      expect(repository.updateKeys, [original, changedKey]);
      expect(activityLogs.logs, hasLength(2));
    });

    test('保存失败保留旧 key，修正后仍用旧 key 重试', () async {
      final original = ConditionKey.fromEntity(_condition());
      final viewModel = ConditionDetailViewModel();
      addTearDown(viewModel.dispose);
      await viewModel.initSignals(conditionKey: original);
      _initControllers(
        viewModel,
        _condition(sourceTypeOrReferenceId: 18, sourceEntry: 20),
      );
      repository.failUpdates = true;

      await expectLater(viewModel.persist(), throwsStateError);
      expect(viewModel.persistedKey.value, original);
      expect(activityLogs.logs, isEmpty);

      repository.failUpdates = false;
      await viewModel.persist();
      expect(repository.updateKeys, [original, original]);
      expect(
        viewModel.persistedKey.value,
        ConditionKey.fromEntity(
          _condition(sourceTypeOrReferenceId: 18, sourceEntry: 20),
        ),
      );
    });

    test('新建首次保存从 null 切换为 candidate key', () async {
      final viewModel = ConditionDetailViewModel();
      addTearDown(viewModel.dispose);
      await viewModel.initSignals();
      final candidate = _condition();
      _initControllers(viewModel, candidate);

      expect(viewModel.persistedKey.value, isNull);
      await viewModel.persist();
      expect(repository.storeCount, 1);
      expect(viewModel.persistedKey.value, ConditionKey.fromEntity(candidate));
    });
  });

  test('conditions 已移除 Map credential 并解锁已有记录主键', () {
    final files = [
      'lib/entity/condition_entity.dart',
      'lib/entity/brief_condition_entity.dart',
      'lib/repository/condition_repository.dart',
      'lib/page/condition/condition_detail_view_model.dart',
      'lib/page/condition/condition_list_view_model.dart',
      'lib/page/condition/condition_detail_page.dart',
      'lib/page/condition/condition_view.dart',
    ];
    final source = files.map((path) => File(path).readAsStringSync()).join();
    final view = File(
      'lib/page/condition/condition_view.dart',
    ).readAsStringSync();

    expect(source, isNot(contains('buildCredential')));
    expect(source, isNot(contains('Map<String, dynamic>? credential')));
    expect(source, isNot(contains('_originalCredential')));
    expect(view, isNot(contains('pkReadOnly')));
    expect(view, isNot(contains('isExisting')));
    expect(view, contains('enabled: !referenceCondition'));
    expect(view, contains('readOnly: referenceTemplate'));
  });
}

ConditionEntity _condition({
  int sourceTypeOrReferenceId = 17,
  int sourceEntry = 1,
  int elseGroup = 0,
  String comment = 'condition',
}) {
  return ConditionEntity(
    sourceTypeOrReferenceId: sourceTypeOrReferenceId,
    sourceEntry: sourceEntry,
    elseGroup: elseGroup,
    conditionTypeOrReference: 2,
    conditionValue1: 1,
    conditionValue2: 1,
    conditionValue3: 1,
    comment: comment,
  );
}

void _initControllers(
  ConditionDetailViewModel viewModel,
  ConditionEntity condition,
) {
  viewModel.sourceTypeOrReferenceIdController.init(
    condition.sourceTypeOrReferenceId,
  );
  viewModel.sourceGroupController.init(condition.sourceGroup);
  viewModel.sourceEntryController.init(condition.sourceEntry);
  viewModel.sourceIdController.init(condition.sourceId);
  viewModel.elseGroupController.init(condition.elseGroup);
  viewModel.conditionTypeOrReferenceController.init(
    condition.conditionTypeOrReference,
  );
  viewModel.conditionTargetController.init(condition.conditionTarget);
  viewModel.conditionValue1Controller.init(condition.conditionValue1);
  viewModel.conditionValue2Controller.init(condition.conditionValue2);
  viewModel.conditionValue3Controller.init(condition.conditionValue3);
  viewModel.negativeConditionController.init(condition.negativeCondition);
  viewModel.errorTypeController.init(condition.errorType);
  viewModel.errorTextIdController.init(condition.errorTextId);
  viewModel.scriptNameController.init(condition.scriptName);
  viewModel.commentController.init(condition.comment);
}

class _FakeConditionRepository extends ConditionRepository {
  ConditionEntity? stored;
  bool failUpdates = false;
  int storeCount = 0;
  final updateKeys = <ConditionKey>[];

  _FakeConditionRepository(this.stored);

  @override
  Future<ConditionEntity> createCondition() async => const ConditionEntity();

  @override
  Future<ConditionEntity?> getCondition(ConditionKey key) async {
    final value = stored;
    if (value == null || ConditionKey.fromEntity(value) != key) return null;
    return value;
  }

  @override
  Future<void> storeCondition(ConditionEntity condition) async {
    storeCount++;
    stored = condition;
  }

  @override
  Future<void> updateCondition(
    ConditionKey originalKey,
    ConditionEntity condition,
  ) async {
    updateKeys.add(originalKey);
    if (failUpdates) throw StateError('write failed');
    stored = condition;
  }
}

class _RecordingActivityLogRepository extends ActivityLogRepository {
  final logs = <ActivityLogEntity>[];

  @override
  void storeActivityLogBestEffort(ActivityLogEntity log) {
    logs.add(log);
  }
}

class _RecordingDriver implements DatabaseDriver {
  @override
  final SqlGrammar grammar = MysqlGrammar();

  final int affectedRows;
  final Object? error;

  _RecordingDriver({this.affectedRows = 1, this.error});

  @override
  Future<int> affectingStatement(
    String sql, [
    List<Object?> params = const [],
  ]) async {
    if (error case final error?) throw error;
    return affectedRows;
  }

  @override
  Future<void> close() async {}

  @override
  Future<int> insertAndGetId(
    String sql, [
    List<Object?> params = const [],
  ]) async {
    if (error case final error?) throw error;
    return 1;
  }

  @override
  Future<List<LaconicResult>> select(
    String sql, [
    List<Object?> params = const [],
  ]) async => const [];

  @override
  Future<void> statement(String sql, [List<Object?> params = const []]) async {
    if (error case final error?) throw error;
  }

  @override
  Future<T> transaction<T>(Future<T> Function() action) => action();
}

class _TestConditionRepository extends ConditionRepository {
  @override
  final Laconic laconic;

  _TestConditionRepository(this.laconic);
}
