import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/brief_condition_entity.dart';
import 'package:foxy/entity/condition_filter_entity.dart';
import 'package:foxy/entity/condition_entity.dart';
import 'package:foxy/entity/feature_entity.dart';
import 'package:foxy/event/event_bus.dart';
import 'package:foxy/infrastructure/config/config_util.dart';
import 'package:foxy/infrastructure/dbc/dbc_sync_util.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:foxy/page/condition/condition_list_view_model.dart';
import 'package:foxy/page/feature/feature_state_view_model.dart';
import 'package:foxy/page/more/more_read_view_model.dart';
import 'package:foxy/page/setting/dbc_import_workflow_view_model.dart';
import 'package:foxy/page/workflow/workflow_status.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/condition_repository.dart';
import 'package:foxy/repository/feature_repository.dart';
import 'package:foxy/use_case/dbc/import_dbc_use_case.dart';
import 'package:get_it/get_it.dart';

void main() {
  group('ListViewModel 行为协议', () {
    late _ConditionRepository repository;
    late EventBus eventBus;

    setUp(() {
      eventBus = EventBus(sync: true);
      repository = _ConditionRepository();
      GetIt.instance.registerSingleton<EventBus>(eventBus);
      final activityRepository = _ActivityLogRepository();
      GetIt.instance.registerSingleton<ConditionRepository>(repository);
      GetIt.instance.registerSingleton<ActivityLogRepository>(
        activityRepository,
      );
      GetIt.instance.registerSingleton(ActivityLogService(activityRepository));
    });

    tearDown(() async {
      eventBus.destroy();
      await GetIt.instance.reset();
    });

    test('筛选快照用于 count/list，写入期间拒绝第二次提交', () async {
      final viewModel = ConditionListViewModel();
      addTearDown(viewModel.dispose);
      viewModel.sourceTypeController.init('17');
      viewModel.sourceEntryController.init('42');
      await viewModel.search();

      expect(repository.listFilter?.sourceTypeOrReferenceId, '17');
      expect(repository.countFilter?.sourceEntry, '42');
      expect(viewModel.loading.value, isFalse);

      final first = viewModel.destroy(_conditionKey);
      await repository.destroyStarted.future;
      expect(viewModel.submitting.value, isTrue);
      await expectLater(viewModel.destroy(_conditionKey), throwsStateError);
      repository.releaseDestroy.complete();
      await first;
      expect(viewModel.submitting.value, isFalse);
    });
  });

  test('ReadViewModel 刷新、筛选、重置和 dispose 使用同一状态源', () async {
    final viewModel = MoreReadViewModel();
    await viewModel.initSignals();
    viewModel.setFeatures([_feature(1, 'Alpha'), _feature(2, 'Beta')]);
    viewModel.searchController.init('alp');
    await viewModel.refresh();

    expect(viewModel.filteredModules.value.map((item) => item.name), ['Alpha']);
    viewModel.reset();
    await viewModel.refresh();
    expect(viewModel.filteredModules.value, hasLength(2));

    viewModel.dispose();
    expect(viewModel.loading.value, isFalse);
  });

  test('StateViewModel 成功后原子更新，失败时保留原状态', () async {
    final repository = _FeatureRepository([_feature(1, 'Alpha')]);
    final viewModel = FeatureStateViewModel(repository: repository);
    await viewModel.initSignals();

    await viewModel.toggleFavorite(1);
    expect(viewModel.allFeatures.value.single.isFavorite, isTrue);

    repository.failFavorite = true;
    await expectLater(viewModel.toggleFavorite(1), throwsStateError);
    expect(viewModel.allFeatures.value.single.isFavorite, isTrue);
    expect(viewModel.errorMessage.value, contains('更新收藏状态失败'));
  });

  test('WorkflowViewModel 校验失败、retry 和 reset 使用统一状态', () async {
    final configUtil = ConfigUtil();
    final viewModel = DbcImportWorkflowViewModel(
      useCase: ImportDbcUseCase(
        configUtil: configUtil,
        dbcSyncUtil: DbcSyncUtil(),
      ),
      configUtil: configUtil,
    );

    await expectLater(viewModel.start(), throwsStateError);
    expect(viewModel.status.value, WorkflowStatus.failed);
    expect(viewModel.errorMessage.value, contains('选择 DBC 文件目录'));

    await expectLater(viewModel.retry(), throwsStateError);
    expect(viewModel.status.value, WorkflowStatus.failed);
    viewModel.reset();
    expect(viewModel.status.value, WorkflowStatus.idle);
    expect(viewModel.errorMessage.value, isNull);
    viewModel.dispose();
  });
}

const _conditionKey = ConditionKey(
  sourceTypeOrReferenceId: 17,
  sourceGroup: 0,
  sourceEntry: 42,
  sourceId: 0,
  elseGroup: 0,
  conditionTypeOrReference: 2,
  conditionTarget: 0,
  conditionValue1: 1,
  conditionValue2: 0,
  conditionValue3: 0,
);

FeatureEntity _feature(int id, String name) {
  final timestamp = DateTime(2026);
  return FeatureEntity(
    id: id,
    name: name,
    description: '',
    icon: '',
    routerMenu: name.toLowerCase(),
    createdAt: timestamp,
    updatedAt: timestamp,
  );
}

final class _ConditionRepository extends ConditionRepository {
  ConditionFilterEntity? countFilter;
  ConditionFilterEntity? listFilter;
  final destroyStarted = Completer<void>();
  final releaseDestroy = Completer<void>();

  @override
  Future<int> countConditions({ConditionFilterEntity? filter}) async {
    countFilter = filter;
    return 0;
  }

  @override
  Future<List<BriefConditionEntity>> getBriefConditions({
    int page = 1,
    ConditionFilterEntity? filter,
  }) async {
    listFilter = filter;
    return const [];
  }

  @override
  Future<void> destroyCondition(ConditionKey key) async {
    if (!destroyStarted.isCompleted) destroyStarted.complete();
    await releaseDestroy.future;
  }
}

final class _FeatureRepository extends FeatureRepository {
  _FeatureRepository(this.features);

  final List<FeatureEntity> features;
  bool failFavorite = false;

  @override
  Future<List<FeatureEntity>> getFeatures() async => List.of(features);

  @override
  Future<void> updateFavorite(int id, bool favorite) async {
    if (failFavorite) throw StateError('favorite failed');
  }
}

final class _ActivityLogRepository extends ActivityLogRepository {
  @override
  void storeActivityLogBestEffort(ActivityLogEntity log) {}
}
