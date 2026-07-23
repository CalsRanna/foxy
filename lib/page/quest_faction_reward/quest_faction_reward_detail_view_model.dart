import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/quest_faction_reward_entity.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:foxy/repository/quest_faction_reward_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/form/validation/quest_faction_reward_entity_validation_mixin.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

class QuestFactionRewardDetailViewModel
    with
        ViewModelValidationMixin,
        QuestFactionRewardValidationMixin,
        FieldControllerMixin {
  final _repository = GetIt.instance.get<QuestFactionRewardRepository>();
  final _activityLogService = GetIt.instance.get<ActivityLogService>();

  final entity = signal<QuestFactionRewardEntity?>(null);
  final persistedKey = signal<int?>(null);
  final loading = signal(false);
  final submitting = signal(false);
  final errorMessage = signal<String?>(null);

  /// Basic
  late final idController = registerController(IntFieldController());

  /// Difficulty
  late final difficulty0Controller = registerController(IntFieldController());
  late final difficulty1Controller = registerController(IntFieldController());
  late final difficulty2Controller = registerController(IntFieldController());
  late final difficulty3Controller = registerController(IntFieldController());
  late final difficulty4Controller = registerController(IntFieldController());
  late final difficulty5Controller = registerController(IntFieldController());
  late final difficulty6Controller = registerController(IntFieldController());
  late final difficulty7Controller = registerController(IntFieldController());
  late final difficulty8Controller = registerController(IntFieldController());
  late final difficulty9Controller = registerController(IntFieldController());

  /// 从所有 Controller 收集数据构建 QuestFactionReward

  Future<void> initSignals({int? key}) async {
    loading.value = true;
    errorMessage.value = null;
    try {
      if (key == null) {
        final blank = await _repository.createQuestFactionReward();
        entity.value = blank;
        _applyCandidate(blank);
        persistedKey.value = null;
        return;
      }
      final result = await _repository.getQuestFactionReward(key);
      if (result == null) {
        throw StateError('原任务声望不存在，可能已被其他操作修改或删除');
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
      validateQuestFactionRewardFields(candidate);
      final originalKey = persistedKey.value;
      final action = originalKey == null
          ? ActivityActionType.create
          : ActivityActionType.update;
      if (originalKey == null) {
        await _repository.storeQuestFactionReward(candidate);
      } else {
        await _repository.updateQuestFactionReward(originalKey, candidate);
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

  QuestFactionRewardEntity _collectCandidate() {
    return QuestFactionRewardEntity(
      id: idController.collect(),
      difficulty0: difficulty0Controller.collect(),
      difficulty1: difficulty1Controller.collect(),
      difficulty2: difficulty2Controller.collect(),
      difficulty3: difficulty3Controller.collect(),
      difficulty4: difficulty4Controller.collect(),
      difficulty5: difficulty5Controller.collect(),
      difficulty6: difficulty6Controller.collect(),
      difficulty7: difficulty7Controller.collect(),
      difficulty8: difficulty8Controller.collect(),
      difficulty9: difficulty9Controller.collect(),
    );
  }

  void _applyCandidate(QuestFactionRewardEntity table) {
    idController.init(table.id);
    difficulty0Controller.init(table.difficulty0);
    difficulty1Controller.init(table.difficulty1);
    difficulty2Controller.init(table.difficulty2);
    difficulty3Controller.init(table.difficulty3);
    difficulty4Controller.init(table.difficulty4);
    difficulty5Controller.init(table.difficulty5);
    difficulty6Controller.init(table.difficulty6);
    difficulty7Controller.init(table.difficulty7);
    difficulty8Controller.init(table.difficulty8);
    difficulty9Controller.init(table.difficulty9);
  }

  void _logActivity(ActivityActionType action, QuestFactionRewardEntity t) {
    final log = ActivityLogEntity(
      module: 'quest_faction_reward',
      actionType: action,
      entityName: 'QuestFactionReward ${t.id}',
      createdAt: DateTime.now(),
    );
    _activityLogService.recordBestEffort(log);
  }

  void dispose() {
    disposeControllers();
  }
}
