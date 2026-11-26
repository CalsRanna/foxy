import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/condition_entity.dart';
import 'package:foxy/event/event_bus.dart';
import 'package:foxy/exception/foxy_exceptions.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/condition_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/use_case/activity_log/activity_log_listener.dart';
import 'package:foxy/use_case/activity_log/activity_log_service.dart';
import 'package:foxy/view_model/condition_detail_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:laconic/laconic.dart';

import 'recording_driver.dart';
import 'repository_contract.dart';
import 'row_key_expectations.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('ConditionKey', () {
    test('All ten primary key columns participate in value equality', () {
      final entity = _condition();
      final key = ConditionKey.fromEntity(entity);

      expectRowKeyEquality(
        key,
        ConditionKey.fromEntity,
        sameKeyRow: entity.copyWith(comment: 'different'),
        differentKeyRows: [
          entity.copyWith(sourceGroup: 1),
          entity.copyWith(sourceEntry: 2),
          entity.copyWith(sourceId: 1),
          entity.copyWith(elseGroup: 1),
          entity.copyWith(conditionTypeOrReference: 3),
          entity.copyWith(conditionTarget: 1),
          entity.copyWith(conditionValue1: 2),
          entity.copyWith(conditionValue2: 2),
          entity.copyWith(conditionValue3: 2),
          entity.copyWith(sourceTypeOrReferenceId: 18),
        ],
      );
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
    });

    test('The brief entity exposes the complete typed key', () {
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
    final original = ConditionKey.fromEntity(_condition());
    final candidate = _condition(
      sourceTypeOrReferenceId: 18,
      sourceEntry: 20,
      elseGroup: 3,
      comment: 'changed',
    );

    testRepositoryWrites(
      createRepository: _TestConditionRepository.new,
      originalKey: original,
      candidate: candidate,
      missingCandidate: _condition(),
      update: (repository, key, row) => repository.updateCondition(key, row),
      destroy: (repository, key) => repository.destroyCondition(key),
      expectedBindings: [
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
      ],
    );

    test('Duplicate keys are translated by MySQL error code and other errors propagate', () async {
      final duplicate = LaconicException(
        'MysqlServerException [1062]: duplicate',
        driver: 'mysql',
        code: '1062',
      );
      final repository = _TestConditionRepository(
        Laconic(RecordingDriver(error: duplicate)),
      );
      final key = ConditionKey.fromEntity(_condition());

      expect(MysqlErrorUtil.isDuplicateEntry(duplicate), isTrue);
      expect(
        MysqlErrorUtil.isDuplicateEntry(
          LaconicException(
            'MysqlServerException [1452]: other',
            driver: 'mysql',
            code: '1452',
          ),
        ),
        isFalse,
      );
      // Same numeric code on another driver must not be treated as a
      // MySQL duplicate entry.
      expect(
        MysqlErrorUtil.isDuplicateEntry(
          LaconicException(
            'MysqlServerException [1062]: duplicate',
            driver: 'postgres',
            code: '1062',
          ),
        ),
        isFalse,
      );
      // Hand-thrown errors without structured driver/code fields never
      // match, even when the message mentions 1062.
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

    test('affectingStatement preserves parameter bindings and notifies the query listener', () async {
      final driver = RecordingDriver();
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
      // Persistence aspect mirrors production DI: subscribes
      // EntityWrittenEvent and records through the service.
      GetIt.instance.registerSingleton(
        ActivityLogListener(eventBus, () => ActivityLogService(activityLogs))
          ..start(),
      );
    });

    tearDown(() async {
      eventBus.destroy();
      await GetIt.instance.reset();
    });

    test(
      'A successful primary key change makes subsequent saves use the new key',
      () async {
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
      },
    );

    test('A failed save retains the old key for retry', () async {
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

    test('The first save of a new record replaces the null key with the candidate key', () async {
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

  group('ConditionDetailViewModel reference mode encoding and decoding', () {
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

    test('Regular conditions load and save without losing data', () async {
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

    test('Source reference -7 survives loading, editing, and saving', () async {
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

    test(
      'Condition reference -5 survives loading, editing, and saving',
      () async {
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
      },
    );

    test('Reference IDs near the int32 boundary round trip', () async {
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

    test('Reference mode projects unused columns as zero and preserves controller drafts when switching back', () async {
      final viewModel = ConditionDetailViewModel();
      addTearDown(viewModel.dispose);
      await viewModel.initSignals();
      _initControllers(viewModel, _condition());
      // Switch to source-reference mode
      viewModel.sourceModeController.init(1);
      viewModel.sourceReferenceIdController.init(7);
      // Old draft of a hidden field
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

      // Switching back to normal mode keeps the draft
      viewModel.sourceModeController.init(0);
      expect(viewModel.sourceGroupController.collect(), 5);
      expect(viewModel.sourceEntryController.collect(), 2);
      expect(viewModel.sourceIdController.collect(), 1);
    });

    test(
      'Condition reference mode projects value and target fields as zero',
      () async {
        final viewModel = ConditionDetailViewModel();
        addTearDown(viewModel.dispose);
        await viewModel.initSignals();
        _initControllers(viewModel, _condition());
        // Switch to condition-reference mode
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
      },
    );

    test('Saving with reference ID zero throws an error', () async {
      final viewModel = ConditionDetailViewModel();
      addTearDown(viewModel.dispose);
      await viewModel.initSignals();
      _initControllers(viewModel, _condition(sourceTypeOrReferenceId: -7));
      viewModel.sourceReferenceIdController.init(0);

      await expectLater(viewModel.persist(), throwsArgumentError);
      expect(repository.stored!.sourceTypeOrReferenceId, isNot(-0));
    });

    test('A lone minus sign in Value1 causes no uncaught exception and saving succeeds after correction', () async {
      final viewModel = ConditionDetailViewModel();
      addTearDown(viewModel.dispose);
      await viewModel.initSignals();
      _initControllers(viewModel, _condition());

      // A bare minus is an invalid draft: the group neither notifies nor
      // throws, and the last valid value is kept.
      viewModel.conditionValue1Controller.numberController.controller.text =
          '-';
      expect(viewModel.selectedConditionValue1.value, 1);

      // Saving works again after fixing the input.
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
  // Normal-type mode (all test data uses non-negative source/condition
  // types).
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

class _TestConditionRepository extends ConditionRepository {
  @override
  final Laconic laconic;

  _TestConditionRepository(this.laconic);
}
