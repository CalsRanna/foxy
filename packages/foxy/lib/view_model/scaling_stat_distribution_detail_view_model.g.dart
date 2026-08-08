// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scaling_stat_distribution_detail_view_model.dart';

mixin _ScalingStatDistributionDetailViewModelMixin on FieldControllerMixin {
  final _repository = GetIt.instance.get<ScalingStatDistributionRepository>();

  final entity = signal<ScalingStatDistributionEntity?>(null);

  final persistedKey = signal<int?>(null);

  final loading = signal(false);

  final submitting = signal(false);

  final errorMessage = signal<String?>(null);

  late final idController = registerController(IntFieldController());
  late final statId0Controller = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final statId1Controller = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final statId2Controller = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final statId3Controller = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final statId4Controller = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final statId5Controller = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final statId6Controller = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final statId7Controller = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final statId8Controller = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final statId9Controller = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final bonus0Controller = registerController(IntFieldController());
  late final bonus1Controller = registerController(IntFieldController());
  late final bonus2Controller = registerController(IntFieldController());
  late final bonus3Controller = registerController(IntFieldController());
  late final bonus4Controller = registerController(IntFieldController());
  late final bonus5Controller = registerController(IntFieldController());
  late final bonus6Controller = registerController(IntFieldController());
  late final bonus7Controller = registerController(IntFieldController());
  late final bonus8Controller = registerController(IntFieldController());
  late final bonus9Controller = registerController(IntFieldController());
  late final maxlevelController = registerController(IntFieldController());

  void dispose() {
    disposeControllers();
  }

  Future<void> initSignals({int? key}) async {
    loading.value = true;
    errorMessage.value = null;
    try {
      if (key == null) {
        final blank = await _repository.createScalingStatDistribution();
        if (isDisposed) return;
        entity.value = blank;
        _applyCandidate(blank);
        persistedKey.value = null;
        return;
      }
      final result = await _repository.getScalingStatDistribution(key);
      if (result == null) {
        throw RecordNotFoundException('record not found');
      }
      if (isDisposed) return;
      entity.value = result;
      _applyCandidate(result);
      persistedKey.value = key;
    } catch (error, stackTrace) {
      errorMessage.value = foxyErrorMessage(error);
      LoggerUtil.instance.e('加载详情失败', error: error, stackTrace: stackTrace);
      rethrow;
    } finally {
      loading.value = false;
    }
  }

  Future<void> persist() async {
    if (submitting.value) {
      throw BusyException('operation already in progress');
    }
    submitting.value = true;
    errorMessage.value = null;
    try {
      final candidate = _collectCandidate();
      final originalKey = persistedKey.value;
      final action = originalKey == null
          ? ActivityActionType.create
          : ActivityActionType.update;
      if (originalKey == null) {
        final storedKey = await _repository.storeScalingStatDistribution(
          candidate,
        );
        persistedKey.value = storedKey;
      } else {
        await _repository.updateScalingStatDistribution(originalKey, candidate);
        persistedKey.value = candidate.id;
      }
      entity.value = candidate;
      _logActivity(action, candidate);
    } catch (error) {
      errorMessage.value = foxyErrorMessage(error);
      rethrow;
    } finally {
      submitting.value = false;
    }
  }

  void _afterApplyCandidate(
    ScalingStatDistributionEntity scalingStatDistribution,
  ) {}

  void _applyCandidate(ScalingStatDistributionEntity scalingStatDistribution) {
    idController.init(scalingStatDistribution.id);
    statId0Controller.init(scalingStatDistribution.statId0);
    statId1Controller.init(scalingStatDistribution.statId1);
    statId2Controller.init(scalingStatDistribution.statId2);
    statId3Controller.init(scalingStatDistribution.statId3);
    statId4Controller.init(scalingStatDistribution.statId4);
    statId5Controller.init(scalingStatDistribution.statId5);
    statId6Controller.init(scalingStatDistribution.statId6);
    statId7Controller.init(scalingStatDistribution.statId7);
    statId8Controller.init(scalingStatDistribution.statId8);
    statId9Controller.init(scalingStatDistribution.statId9);
    bonus0Controller.init(scalingStatDistribution.bonus0);
    bonus1Controller.init(scalingStatDistribution.bonus1);
    bonus2Controller.init(scalingStatDistribution.bonus2);
    bonus3Controller.init(scalingStatDistribution.bonus3);
    bonus4Controller.init(scalingStatDistribution.bonus4);
    bonus5Controller.init(scalingStatDistribution.bonus5);
    bonus6Controller.init(scalingStatDistribution.bonus6);
    bonus7Controller.init(scalingStatDistribution.bonus7);
    bonus8Controller.init(scalingStatDistribution.bonus8);
    bonus9Controller.init(scalingStatDistribution.bonus9);
    maxlevelController.init(scalingStatDistribution.maxlevel);
    _afterApplyCandidate(scalingStatDistribution);
  }

  ScalingStatDistributionEntity _collectCandidate() {
    return ScalingStatDistributionEntity(
      id: idController.collect(),
      statId0: statId0Controller.collect(),
      statId1: statId1Controller.collect(),
      statId2: statId2Controller.collect(),
      statId3: statId3Controller.collect(),
      statId4: statId4Controller.collect(),
      statId5: statId5Controller.collect(),
      statId6: statId6Controller.collect(),
      statId7: statId7Controller.collect(),
      statId8: statId8Controller.collect(),
      statId9: statId9Controller.collect(),
      bonus0: bonus0Controller.collect(),
      bonus1: bonus1Controller.collect(),
      bonus2: bonus2Controller.collect(),
      bonus3: bonus3Controller.collect(),
      bonus4: bonus4Controller.collect(),
      bonus5: bonus5Controller.collect(),
      bonus6: bonus6Controller.collect(),
      bonus7: bonus7Controller.collect(),
      bonus8: bonus8Controller.collect(),
      bonus9: bonus9Controller.collect(),
      maxlevel: maxlevelController.collect(),
    );
  }

  /// Fires the activity-log event after a write; persistence is handled by
  /// the single ActivityLogListener aspect.
  void _logActivity(
    ActivityActionType action,
    ScalingStatDistributionEntity scalingStatDistribution,
  ) {
    GetIt.instance.get<EventBus>().fire(
      EntityWrittenEvent(
        ActivityLogEntity(
          module: 'dbc_scaling_stat_distribution',
          actionType: action,
          entityName: 'ScalingStatDistribution ${scalingStatDistribution.id}',
          createdAt: DateTime.now(),
        ),
      ),
    );
  }
}
