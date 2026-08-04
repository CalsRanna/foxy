import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/condition_entity.dart';
import 'package:foxy/event/event_bus.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/infrastructure/errors/foxy_exceptions.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/condition_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/view_model/condition_detail_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:laconic/laconic.dart';
import 'package:laconic_mysql/laconic_mysql.dart';

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
        throwsA(isA<RecordNotFoundException>()),
      );
      await expectLater(
        repository.destroyCondition(key),
        throwsA(isA<RecordNotFoundException>()),
      );
    });

    test('重复键按 MySQL 错误码转换且其他错误继续传播', () async {
      final duplicate = LaconicException(
        'MysqlServerException [1062]: duplicate',
      );
      final repository = _TestConditionRepository(
        Laconic(_RecordingDriver(error: duplicate)),
      );
      final key = ConditionKey.fromEntity(_condition());

      expect(MysqlErrorUtil.isDuplicateEntry(duplicate), isTrue);
      expect(
        MysqlErrorUtil.isDuplicateEntry(
          LaconicException('MysqlServerException [1452]: other'),
        ),
        isFalse,
      );
      expect(
        MysqlErrorUtil.isDuplicateEntry(
          LaconicException('transaction failed', cause: duplicate),
        ),
        isTrue,
      );
      expect(
        MysqlErrorUtil.isDuplicateEntry(
          LaconicException('request 1062 failed'),
        ),
        isFalse,
      );
      await expectLater(
        repository.updateCondition(key, _condition()),
        throwsA(isA<DuplicateKeyException>()),
      );
    });

    test('affectingStatement 保留参数绑定并通知 query listener', () async {
      final driver = _RecordingDriver(affectedRows: 1);
      final queries = <LaconicQuery>[];
      final laconic = Laconic(driver, listen: queries.add);

      final affectedRows = await laconic.affectingStatement(
        'update conditions set Comment = ? where SourceEntry = ? limit 1',
        ['value', 42],
      );

      expect(affectedRows, 1);
      expect(queries.single.bindings, ['value', 42]);
      expect(queries.single.sql, contains('limit 1'));
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
      GetIt.instance.registerSingleton(ActivityLogService(activityLogs));
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
      await viewModel.initSignals(key: original);
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
      await viewModel.initSignals(key: original);
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

  group('ConditionDetailViewModel 引用模式 encode/decode', () {
    late _FakeConditionRepository repository;
    late _RecordingActivityLogRepository activityLogs;

    setUp(() {
      repository = _FakeConditionRepository(_condition());
      GetIt.instance.registerSingleton<EventBus>(EventBus(sync: true));
      activityLogs = _RecordingActivityLogRepository();
      GetIt.instance.registerSingleton<ActivityLogRepository>(activityLogs);
      GetIt.instance.registerSingleton(ActivityLogService(activityLogs));
      GetIt.instance.registerSingleton<ConditionRepository>(repository);
      GetIt.instance.registerSingleton<RouterFacade>(RouterFacade());
    });

    tearDown(() async {
      await GetIt.instance.reset();
    });

    test('普通类型无损加载与保存', () async {
      final viewModel = ConditionDetailViewModel();
      addTearDown(viewModel.dispose);
      await viewModel.initSignals(key: ConditionKey.fromEntity(_condition()));

      expect(viewModel.selectedSourceMode.value, 0);
      expect(viewModel.selectedConditionMode.value, 0);
      expect(viewModel.selectedSourceType.value, 17);
      expect(viewModel.selectedConditionType.value, 2);

      await viewModel.persist();
      expect(repository.stored!.sourceTypeOrReferenceId, 17);
      expect(repository.stored!.conditionTypeOrReference, 2);
    });

    test('来源引用 -7 无损加载、编辑、保存', () async {
      final reference = _condition(sourceTypeOrReferenceId: -7);
      repository.stored = reference;
      final viewModel = ConditionDetailViewModel();
      addTearDown(viewModel.dispose);
      await viewModel.initSignals(key: ConditionKey.fromEntity(reference));

      expect(viewModel.selectedSourceMode.value, 1);
      expect(viewModel.sourceReferenceIdController.collect(), 7);
      expect(viewModel.selectedSourceType.value, 0);

      viewModel.sourceReferenceIdController.init(13);
      await viewModel.persist();
      expect(repository.stored!.sourceTypeOrReferenceId, -13);
    });

    test('条件引用 -5 无损加载、编辑、保存', () async {
      final reference = _condition(conditionTypeOrReference: -5);
      repository.stored = reference;
      final viewModel = ConditionDetailViewModel();
      addTearDown(viewModel.dispose);
      await viewModel.initSignals(key: ConditionKey.fromEntity(reference));

      expect(viewModel.selectedConditionMode.value, 1);
      expect(viewModel.conditionReferenceIdController.collect(), 5);
      expect(viewModel.selectedConditionType.value, 0);

      viewModel.conditionReferenceIdController.init(9);
      await viewModel.persist();
      expect(repository.stored!.conditionTypeOrReference, -9);
    });

    test('int32 边界附近的引用 ID 可往返', () async {
      repository.stored = _condition(sourceTypeOrReferenceId: -1);
      final viewModel = ConditionDetailViewModel();
      addTearDown(viewModel.dispose);
      await viewModel.initSignals(
        key: ConditionKey.fromEntity(_condition(sourceTypeOrReferenceId: -1)),
      );
      expect(viewModel.sourceReferenceIdController.collect(), 1);

      viewModel.sourceReferenceIdController.init(0x7FFFFFFF);
      await viewModel.persist();
      expect(repository.stored!.sourceTypeOrReferenceId, -0x7FFFFFFF);
    });

    test('引用模式投影未使用列为 0，切回普通模式保留 controller 草稿', () async {
      final viewModel = ConditionDetailViewModel();
      addTearDown(viewModel.dispose);
      await viewModel.initSignals();
      _initControllers(viewModel, _condition());
      // 切换到来源引用模式
      viewModel.sourceModeController.init(1);
      viewModel.sourceReferenceIdController.init(7);
      // 隐藏字段的旧草稿
      viewModel.sourceGroupController.init(5);
      viewModel.sourceEntryController.init(2);
      viewModel.sourceIdController.init(1);
      viewModel.conditionTargetController.init(1);
      viewModel.errorTypeController.init(12);
      viewModel.errorTextIdController.init(3);

      await viewModel.persist();

      final stored = repository.stored!;
      expect(stored.sourceTypeOrReferenceId, -7);
      expect(stored.sourceGroup, 0);
      expect(stored.sourceEntry, 0);
      expect(stored.sourceId, 0);
      expect(stored.conditionTarget, 0);
      expect(stored.errorType, 0);
      expect(stored.errorTextId, 0);

      // 切回普通模式，草稿仍保留
      viewModel.sourceModeController.init(0);
      expect(viewModel.sourceGroupController.collect(), 5);
      expect(viewModel.sourceEntryController.collect(), 2);
      expect(viewModel.sourceIdController.collect(), 1);
    });

    test('条件引用模式投影 Value 与目标为 0', () async {
      final viewModel = ConditionDetailViewModel();
      addTearDown(viewModel.dispose);
      await viewModel.initSignals();
      _initControllers(viewModel, _condition());
      // 切换到条件引用模式
      viewModel.conditionModeController.init(1);
      viewModel.conditionReferenceIdController.init(5);
      viewModel.conditionValue1Controller.init(3);
      viewModel.conditionValue2Controller.init(4);
      viewModel.conditionValue3Controller.init(5);
      viewModel.conditionTargetController.init(1);
      viewModel.negativeConditionController.init(1);

      await viewModel.persist();

      final stored = repository.stored!;
      expect(stored.conditionTypeOrReference, -5);
      expect(stored.conditionValue1, 0);
      expect(stored.conditionValue2, 0);
      expect(stored.conditionValue3, 0);
      expect(stored.conditionTarget, 0);
      expect(stored.negativeCondition, 0);
    });

    test('引用 ID 为 0 时保存报错', () async {
      final viewModel = ConditionDetailViewModel();
      addTearDown(viewModel.dispose);
      await viewModel.initSignals();
      _initControllers(viewModel, _condition(sourceTypeOrReferenceId: -7));
      viewModel.sourceReferenceIdController.init(0);

      await expectLater(viewModel.persist(), throwsArgumentError);
      expect(repository.stored!.sourceTypeOrReferenceId, isNot(-0));
    });

    test('Value1 裸负号输入不抛未捕获异常，修复后保存成功', () async {
      final viewModel = ConditionDetailViewModel();
      addTearDown(viewModel.dispose);
      await viewModel.initSignals();
      _initControllers(viewModel, _condition());

      // 裸负号是非法草稿：组不通知、不抛异常，最后合法值保留。
      viewModel.conditionValue1Controller.numberController.controller.text =
          '-';
      expect(viewModel.selectedConditionValue1.value, 1);

      // 修复后正常保存。
      viewModel.conditionValue1Controller.numberController.controller.text =
          '3';
      await viewModel.persist();
      expect(repository.stored!.conditionValue1, 3);
    });
  });
}

ConditionEntity _condition({
  int sourceTypeOrReferenceId = 17,
  int sourceEntry = 1,
  int elseGroup = 0,
  int conditionTypeOrReference = 2,
  String comment = 'condition',
}) {
  return ConditionEntity(
    sourceTypeOrReferenceId: sourceTypeOrReferenceId,
    sourceEntry: sourceEntry,
    elseGroup: elseGroup,
    conditionTypeOrReference: conditionTypeOrReference,
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
  // 普通类型模式（测试数据均为非负来源/条件类型）。
  viewModel.sourceModeController.init(0);
  viewModel.sourceTypeController.init(condition.sourceTypeOrReferenceId);
  viewModel.sourceGroupController.init(condition.sourceGroup);
  viewModel.sourceEntryController.init(condition.sourceEntry);
  viewModel.sourceIdController.init(condition.sourceId);
  viewModel.elseGroupController.init(condition.elseGroup);
  viewModel.conditionModeController.init(0);
  viewModel.conditionTypeController.init(condition.conditionTypeOrReference);
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
