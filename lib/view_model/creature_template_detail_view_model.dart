import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/creature_template_entity.dart';
import 'package:foxy/infrastructure/codegen/form_annotations.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/creature_template_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'creature_template_detail_view_model.g.dart';

@FoxyDetailViewModel(entity: CreatureTemplateEntity, flags: {'dynamicFlags', 'flagsExtra', 'npcFlag', 'typeFlags', 'unitFlags', 'unitFlags2'}, selects: {'damageSchool': 0, 'exp': 0, 'family': 0, 'movementType': 0, 'racialLeader': 0, 'rank': 0, 'regenHealth': 0, 'type': 0, 'unitClass': 1})
class CreatureTemplateDetailViewModel with FieldControllerMixin, _CreatureTemplateDetailViewModelMixin {
  final _repository = GetIt.instance.get<CreatureTemplateRepository>();
  final _activityLogService = GetIt.instance.get<ActivityLogService>();

  final entity = signal<CreatureTemplateEntity?>(null);
  final persistedKey = signal<int?>(null);
  final loading = signal(false);
  final submitting = signal(false);
  final errorMessage = signal<String?>(null);

  void dispose() {
    disposeControllers();
  }

  /// 从所有字段收集数据构建 CreatureTemplate

  Future<void> initSignals({int? key}) async {
    loading.value = true;
    errorMessage.value = null;
    try {
      if (key == null) {
        final blank = await _repository.createCreatureTemplate();
        entity.value = blank;
        _applyCandidate(blank);
        persistedKey.value = null;
        return;
      }
      final result = await _repository.getCreatureTemplate(key);
      if (result == null) {
        throw StateError('原生物模板不存在，可能已被其他操作修改或删除');
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
      if (candidate.entry <= 0) throw StateError('请输入有效的生物模板 entry');
      final originalKey = persistedKey.value;
      final action = originalKey == null
          ? ActivityActionType.create
          : ActivityActionType.update;
      if (originalKey == null) {
        await _repository.storeCreatureTemplate(candidate);
      } else {
        await _repository.updateCreatureTemplate(originalKey, candidate);
      }
      persistedKey.value = candidate.entry;
      entity.value = candidate;
      _logActivity(action, candidate);
    } catch (error) {
      errorMessage.value = error.toString();
      rethrow;
    } finally {
      submitting.value = false;
    }
  }

  void _logActivity(ActivityActionType action, CreatureTemplateEntity t) {
    final log = ActivityLogEntity(
      module: 'creature_template',
      actionType: action,
      entityName: t.name,
      createdAt: DateTime.now(),
    );
    _activityLogService.recordBestEffort(log);
  }
}
