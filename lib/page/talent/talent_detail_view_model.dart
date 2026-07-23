import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/talent_entity.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:foxy/repository/talent_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/form/validation/talent_entity_validation_mixin.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

class TalentDetailViewModel
    with ViewModelValidationMixin, TalentValidationMixin, FieldControllerMixin {
  final _repository = GetIt.instance.get<TalentRepository>();
  final _activityLogService = GetIt.instance.get<ActivityLogService>();

  final entity = signal<TalentEntity?>(null);
  final persistedKey = signal<int?>(null);
  final loading = signal(false);
  final submitting = signal(false);
  final errorMessage = signal<String?>(null);

  /// Basic
  late final idController = registerController(IntFieldController());
  late final tabIdController = registerController(IntFieldController());
  late final tierIdController = registerController(IntFieldController());
  late final columnIndexController = registerController(IntFieldController());
  late final flagsController = registerController(IntFieldController());
  late final requiredSpellIdController = registerController(
    IntFieldController(),
  );
  late final spellRank0Controller = registerController(IntFieldController());
  late final spellRank1Controller = registerController(IntFieldController());
  late final spellRank2Controller = registerController(IntFieldController());
  late final spellRank3Controller = registerController(IntFieldController());
  late final spellRank4Controller = registerController(IntFieldController());
  late final spellRank5Controller = registerController(IntFieldController());
  late final spellRank6Controller = registerController(IntFieldController());
  late final spellRank7Controller = registerController(IntFieldController());
  late final spellRank8Controller = registerController(IntFieldController());
  late final prereqTalent0Controller = registerController(IntFieldController());
  late final prereqTalent1Controller = registerController(IntFieldController());
  late final prereqTalent2Controller = registerController(IntFieldController());
  late final prereqRank0Controller = registerController(IntFieldController());
  late final prereqRank1Controller = registerController(IntFieldController());
  late final prereqRank2Controller = registerController(IntFieldController());
  late final categoryMask0Controller = registerController(IntFieldController());
  late final categoryMask1Controller = registerController(IntFieldController());

  /// 从所有 Controller 收集数据构建 Talent

  Future<void> initSignals({int? key}) async {
    loading.value = true;
    errorMessage.value = null;
    try {
      if (key == null) {
        final blank = await _repository.createTalent();
        entity.value = blank;
        _applyCandidate(blank);
        persistedKey.value = null;
        return;
      }
      final result = await _repository.getTalent(key);
      if (result == null) {
        throw StateError('原天赋不存在，可能已被其他操作修改或删除');
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
      final t = _collectCandidate();
      validateTalentFields(t);
      final originalKey = persistedKey.value;
      final action = originalKey == null
          ? ActivityActionType.create
          : ActivityActionType.update;
      if (originalKey == null) {
        await _repository.storeTalent(t);
      } else {
        await _repository.updateTalent(originalKey, t);
      }
      persistedKey.value = t.id;
      entity.value = t;
      _logActivity(action, t);
    } catch (error) {
      errorMessage.value = error.toString();
      rethrow;
    } finally {
      submitting.value = false;
    }
  }

  TalentEntity _collectCandidate() {
    return TalentEntity(
      id: idController.collect(),
      tabId: tabIdController.collect(),
      tierId: tierIdController.collect(),
      columnIndex: columnIndexController.collect(),
      spellRank0: spellRank0Controller.collect(),
      spellRank1: spellRank1Controller.collect(),
      spellRank2: spellRank2Controller.collect(),
      spellRank3: spellRank3Controller.collect(),
      spellRank4: spellRank4Controller.collect(),
      spellRank5: spellRank5Controller.collect(),
      spellRank6: spellRank6Controller.collect(),
      spellRank7: spellRank7Controller.collect(),
      spellRank8: spellRank8Controller.collect(),
      prereqTalent0: prereqTalent0Controller.collect(),
      prereqTalent1: prereqTalent1Controller.collect(),
      prereqTalent2: prereqTalent2Controller.collect(),
      prereqRank0: prereqRank0Controller.collect(),
      prereqRank1: prereqRank1Controller.collect(),
      prereqRank2: prereqRank2Controller.collect(),
      flags: flagsController.collect(),
      requiredSpellId: requiredSpellIdController.collect(),
      categoryMask0: categoryMask0Controller.collect(),
      categoryMask1: categoryMask1Controller.collect(),
    );
  }

  void _applyCandidate(TalentEntity talent) {
    idController.init(talent.id);
    tabIdController.init(talent.tabId);
    tierIdController.init(talent.tierId);
    columnIndexController.init(talent.columnIndex);
    spellRank0Controller.init(talent.spellRank0);
    spellRank1Controller.init(talent.spellRank1);
    spellRank2Controller.init(talent.spellRank2);
    spellRank3Controller.init(talent.spellRank3);
    spellRank4Controller.init(talent.spellRank4);
    spellRank5Controller.init(talent.spellRank5);
    spellRank6Controller.init(talent.spellRank6);
    spellRank7Controller.init(talent.spellRank7);
    spellRank8Controller.init(talent.spellRank8);
    prereqTalent0Controller.init(talent.prereqTalent0);
    prereqTalent1Controller.init(talent.prereqTalent1);
    prereqTalent2Controller.init(talent.prereqTalent2);
    prereqRank0Controller.init(talent.prereqRank0);
    prereqRank1Controller.init(talent.prereqRank1);
    prereqRank2Controller.init(talent.prereqRank2);
    flagsController.init(talent.flags);
    requiredSpellIdController.init(talent.requiredSpellId);
    categoryMask0Controller.init(talent.categoryMask0);
    categoryMask1Controller.init(talent.categoryMask1);
  }

  void _logActivity(ActivityActionType action, TalentEntity t) {
    final log = ActivityLogEntity(
      module: 'talent',
      actionType: action,
      entityName: 'Talent ${t.id}',
      createdAt: DateTime.now(),
    );
    _activityLogService.recordBestEffort(log);
  }

  void dispose() {
    disposeControllers();
  }
}
