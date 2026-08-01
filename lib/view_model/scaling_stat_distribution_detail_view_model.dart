import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/scaling_stat_distribution_entity.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:foxy/repository/scaling_stat_distribution_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';
import 'package:foxy/infrastructure/codegen/form_annotations.dart';

part 'scaling_stat_distribution_detail_view_model.g.dart';

@FoxyDetailViewModel(entity: ScalingStatDistributionEntity, selects: {'statId0': 0, 'statId1': 0, 'statId2': 0, 'statId3': 0, 'statId4': 0, 'statId5': 0, 'statId6': 0, 'statId7': 0, 'statId8': 0, 'statId9': 0})
class ScalingStatDistributionDetailViewModel
    with
        FieldControllerMixin, _ScalingStatDistributionDetailViewModelMixin {
  final _repository = GetIt.instance.get<ScalingStatDistributionRepository>();
  final _activityLogService = GetIt.instance.get<ActivityLogService>();

  final entity = signal<ScalingStatDistributionEntity?>(null);
  final persistedKey = signal<int?>(null);
  final loading = signal(false);
  final submitting = signal(false);
  final errorMessage = signal<String?>(null);

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
