import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/quest_template_entity.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:foxy/repository/quest_template_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';
import 'package:foxy/infrastructure/codegen/form_annotations.dart';

part 'quest_template_detail_view_model.g.dart';

@FoxyDetailViewModel(entity: QuestTemplateEntity, flags: {'allowableRaces', 'flags'}, selects: {'questType': 2, 'rewardMoneyDifficulty': 0, 'rewardXpDifficulty': 0})
class QuestTemplateDetailViewModel
    with
        FieldControllerMixin, _QuestTemplateDetailViewModelMixin {
  final _repository = GetIt.instance.get<QuestTemplateRepository>();
  final _activityLogService = GetIt.instance.get<ActivityLogService>();

  final entity = signal<QuestTemplateEntity?>(null);
  final persistedKey = signal<int?>(null);
  final loading = signal(false);
  final submitting = signal(false);
  final errorMessage = signal<String?>(null);

  Future<void> initSignals({int? key}) async {
    loading.value = true;
    errorMessage.value = null;
    try {
      if (key == null) {
        final blank = await _repository.createQuestTemplate();
        entity.value = blank;
        _applyCandidate(blank);
        persistedKey.value = null;
        return;
      }
      final result = await _repository.getQuestTemplate(key);
      if (result == null) {
        throw StateError('原任务模板不存在，可能已被其他操作修改或删除');
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
        await _repository.storeQuestTemplate(candidate);
      } else {
        await _repository.updateQuestTemplate(originalKey, candidate);
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

  void _logActivity(ActivityActionType action, QuestTemplateEntity t) {
    final log = ActivityLogEntity(
      module: 'quest_template',
      actionType: action,
      entityName: t.logTitle,
      createdAt: DateTime.now(),
    );
    _activityLogService.recordBestEffort(log);
  }

  void dispose() {
    disposeControllers();
  }
}
