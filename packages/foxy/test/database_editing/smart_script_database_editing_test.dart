import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/smart_script_entity.dart';
import 'package:foxy/event/event_bus.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/smart_script_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/use_case/activity_log/activity_log_service.dart';
import 'package:foxy/view_model/smart_script_detail_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:laconic/laconic.dart';

import 'in_memory_row_editing.dart';
import 'inline_editing_expectations.dart';
import 'repository_contract.dart';
import 'row_key_expectations.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test(
    'SmartScriptKey and its brief entity include all four primary key fields',
    () {
      const entity = SmartScriptEntity(
        entryOrGuid: 10,
        sourceType: 1,
        id: 2,
        link: 3,
      );
      final key = SmartScriptKey.fromEntity(entity);
      const brief = BriefSmartScriptEntity(
        entryOrGuid: 10,
        sourceType: 1,
        id: 2,
        link: 3,
        comment: '测试脚本',
      );

      expectRowKeyEquality(
        key,
        SmartScriptKey.fromEntity,
        sameKeyRow: entity.copyWith(comment: 'x'),
        differentKeyRows: [
          entity.copyWith(sourceType: 2),
          entity.copyWith(link: 4),
        ],
      );
      expect(brief.key, key);
      expect(brief.displayName, '测试脚本');
    },
  );

  group('SmartScriptRepository write contract', () {
    const oldKey = SmartScriptKey(
      entryOrGuid: 10,
      sourceType: 0,
      id: 2,
      link: 3,
    );
    const candidate = SmartScriptEntity(
      entryOrGuid: 11,
      sourceType: 1,
      id: 4,
      link: 5,
      eventType: 6,
      actionType: 7,
      targetType: 8,
      comment: 'candidate',
    );

    testRepositoryWrites(
      createRepository: _TestRepository.new,
      originalKey: oldKey,
      candidate: candidate,
      missingCandidate: const SmartScriptEntity(),
      update: (repository, key, row) => repository.updateSmartScript(key, row),
      destroy: (repository, key) => repository.destroySmartScript(key),
      expectedBindings: [
        ...candidate.toJson().values,
        oldKey.entryOrGuid,
        oldKey.sourceType,
        oldKey.id,
        oldKey.link,
      ],
    );
  });

  group('persisted detail identity', () {
    late _FakeRepository repository;

    setUp(() {
      repository = _FakeRepository([
        const SmartScriptEntity(
          entryOrGuid: 10,
          sourceType: 0,
          id: 2,
          link: 0,
          eventType: 4,
          actionType: 24,
          targetType: 1,
        ),
      ]);
      GetIt.instance.registerSingleton<SmartScriptRepository>(repository);
      GetIt.instance.registerSingleton<RouterFacade>(RouterFacade());
      GetIt.instance.registerSingleton<EventBus>(EventBus());
      final activityLogRepository = _FakeActivityLogRepository();
      GetIt.instance.registerSingleton<ActivityLogRepository>(
        activityLogRepository,
      );
      GetIt.instance.registerSingleton(
        ActivityLogService(activityLogRepository),
      );
    });

    tearDown(() async => GetIt.instance.reset());

    test('A failed primary key update retains the old key and a successful retry adopts the new key', () async {
      const oldKey = SmartScriptKey(
        entryOrGuid: 10,
        sourceType: 0,
        id: 2,
        link: 0,
      );
      final viewModel = SmartScriptDetailViewModel();
      addTearDown(viewModel.dispose);
      await viewModel.initSignals(key: oldKey);
      viewModel.entryOrGuidController.init(11);
      viewModel.idController.init(3);
      viewModel.linkController.init(4);

      await expectSaveRetry(
        repository: repository,
        originalKey: oldKey,
        editingKey: viewModel.persistedKey,
        persist: viewModel.persist,
      );
      const newKey = SmartScriptKey(
        entryOrGuid: 11,
        sourceType: 0,
        id: 3,
        link: 4,
      );
      expect(viewModel.persistedKey.value, newKey);
      expect(viewModel.entity.value, isNotNull);
    });

    test(
      'Opening a new form preallocates an explicit ID that is reused on save',
      () async {
        repository.rows.clear();
        final viewModel = SmartScriptDetailViewModel();
        addTearDown(viewModel.dispose);
        await viewModel.initSignals();
        expect(viewModel.idController.collect(), 1);
        viewModel.entryOrGuidController.init(20);
        viewModel.eventTypeController.init(4);
        viewModel.actionTypeController.init(24);
        viewModel.targetTypeController.init(1);

        await viewModel.persist();

        expect(repository.stored.single.id, 1);
        expect(viewModel.persistedKey.value?.id, 1);
      },
    );
  });
}

class _FakeActivityLogRepository extends ActivityLogRepository {
  @override
  void storeActivityLogBestEffort(ActivityLogEntity log) {}
}

class _FakeRepository extends SmartScriptRepository
    with InMemoryRowEditing<SmartScriptEntity, SmartScriptKey> {
  @override
  final List<SmartScriptEntity> rows;
  final stored = <SmartScriptEntity>[];

  _FakeRepository(this.rows);

  @override
  SmartScriptKey keyOf(SmartScriptEntity row) => SmartScriptKey.fromEntity(row);

  @override
  Future<SmartScriptEntity> createSmartScript({
    int entryOrGuid = 0,
    int sourceType = 0,
  }) async => SmartScriptEntity(
    entryOrGuid: entryOrGuid,
    sourceType: sourceType,
    id: 1,
  );

  @override
  Future<SmartScriptEntity?> getSmartScript(SmartScriptKey key) async =>
      findRow(key);

  @override
  Future<void> storeSmartScript(SmartScriptEntity script) async {
    stored.add(script);
    rows.add(script);
  }

  @override
  Future<void> updateSmartScript(
    SmartScriptKey originalKey,
    SmartScriptEntity script,
  ) async => updateRow(originalKey, script);
}

class _TestRepository extends SmartScriptRepository {
  @override
  final Laconic laconic;
  _TestRepository(this.laconic);
}
