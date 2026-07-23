import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/scaling_stat_distribution_entity.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:foxy/repository/scaling_stat_distribution_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/form/validation/scaling_stat_distribution_entity_validation_mixin.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

class ScalingStatDistributionDetailViewModel
    with
        ViewModelValidationMixin,
        ScalingStatDistributionValidationMixin,
        FieldControllerMixin {
  final _repository = GetIt.instance.get<ScalingStatDistributionRepository>();
  final _activityLogService = GetIt.instance.get<ActivityLogService>();

  final entity = signal<ScalingStatDistributionEntity?>(null);
  final persistedKey = signal<int?>(null);
  final loading = signal(false);
  final submitting = signal(false);
  final errorMessage = signal<String?>(null);

  /// Basic
  late final idController = registerController(IntFieldController());
  late final statId0Controller = registerController(IntFieldController());
  late final statId1Controller = registerController(IntFieldController());
  late final statId2Controller = registerController(IntFieldController());
  late final statId3Controller = registerController(IntFieldController());
  late final statId4Controller = registerController(IntFieldController());
  late final statId5Controller = registerController(IntFieldController());
  late final statId6Controller = registerController(IntFieldController());
  late final statId7Controller = registerController(IntFieldController());
  late final statId8Controller = registerController(IntFieldController());
  late final statId9Controller = registerController(IntFieldController());
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

  /// 从所有 Controller 收集数据构建 ScalingStatDistribution

  Future<void> initSignals({int? key}) async {
    loading.value = true;
    errorMessage.value = null;
    try {
      if (key == null) {
        final blank = await _repository.createScalingStatDistribution();
        entity.value = blank;
        _applyCandidate(blank);
        persistedKey.value = null;
        return;
      }
      final result = await _repository.getScalingStatDistribution(key);
      if (result == null) {
        throw StateError('原属性缩放分布不存在，可能已被其他操作修改或删除');
      }
      entity.value = result;
      _applyCandidate(result);
      persistedKey.value = key;
    } catch (error, stackTrace) {
      errorMessage.value = error.toString();
      LoggerUtil.instance.e('加载详情失败', error: error, stackTrace: stackTrace);
      rethrow;
    } finally {
      loading.value = false;
    }
  }

  /// 退出页面
  Future<void> persist() async {
    if (submitting.value) throw StateError('正在保存，请稍候');
    submitting.value = true;
    errorMessage.value = null;
    try {
      final candidate = _collectCandidate();
      validateScalingStatDistributionFields(candidate);
      final originalKey = persistedKey.value;
      final action = originalKey == null
          ? ActivityActionType.create
          : ActivityActionType.update;
      if (originalKey == null) {
        await _repository.storeScalingStatDistribution(candidate);
      } else {
        await _repository.updateScalingStatDistribution(originalKey, candidate);
      }
      persistedKey.value = candidate.id;
      entity.value = candidate;
      _logActivity(action, candidate);
    } catch (error) {
      errorMessage.value = error.toString();
      rethrow;
    } finally {
      submitting.value = false;
    }
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

  void _applyCandidate(ScalingStatDistributionEntity item) {
    idController.init(item.id);
    statId0Controller.init(item.statId0);
    statId1Controller.init(item.statId1);
    statId2Controller.init(item.statId2);
    statId3Controller.init(item.statId3);
    statId4Controller.init(item.statId4);
    statId5Controller.init(item.statId5);
    statId6Controller.init(item.statId6);
    statId7Controller.init(item.statId7);
    statId8Controller.init(item.statId8);
    statId9Controller.init(item.statId9);
    bonus0Controller.init(item.bonus0);
    bonus1Controller.init(item.bonus1);
    bonus2Controller.init(item.bonus2);
    bonus3Controller.init(item.bonus3);
    bonus4Controller.init(item.bonus4);
    bonus5Controller.init(item.bonus5);
    bonus6Controller.init(item.bonus6);
    bonus7Controller.init(item.bonus7);
    bonus8Controller.init(item.bonus8);
    bonus9Controller.init(item.bonus9);
    maxlevelController.init(item.maxlevel);
  }

  void _logActivity(
    ActivityActionType action,
    ScalingStatDistributionEntity t,
  ) {
    final log = ActivityLogEntity(
      module: 'scaling_stat_distribution',
      actionType: action,
      entityName: 'ScalingStatDistribution ${t.id}',
      createdAt: DateTime.now(),
    );
    _activityLogService.recordBestEffort(log);
  }

  void dispose() {
    disposeControllers();
  }
}
