import 'package:foxy/entity/quest_template_addon_entity.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/quest_template_addon_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/form/validation/quest_template_addon_entity_validation_mixin.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

class QuestTemplateAddonSingleEditorViewModel
    with
        ViewModelValidationMixin,
        QuestTemplateAddonValidationMixin,
        FieldControllerMixin {
  final _repository = GetIt.instance.get<QuestTemplateAddonRepository>();

  final parentKey = signal<int?>(null);
  final editingKey = signal<int?>(null);
  final entity = signal<QuestTemplateAddonEntity?>(null);
  final loading = signal(false);
  final submitting = signal(false);
  final errorMessage = signal<String?>(null);

  late final idController = registerController(IntFieldController());
  late final maxLevelController = registerController(IntFieldController());
  late final allowableClassesController = registerController(
    FlagFieldController(),
  );
  late final sourceSpellIdController = registerController(IntFieldController());
  late final prevQuestIdController = registerController(IntFieldController());
  late final nextQuestIdController = registerController(IntFieldController());
  late final exclusiveGroupController = registerController(
    IntFieldController(),
  );
  late final breadcrumbForQuestIdController = registerController(
    IntFieldController(),
  );
  late final rewardMailTemplateIdController = registerController(
    IntFieldController(),
  );
  late final rewardMailDelayController = registerController(
    IntFieldController(),
  );
  late final requiredSkillIdController = registerController(
    IntFieldController(),
  );
  late final requiredSkillPointsController = registerController(
    IntFieldController(),
  );
  late final requiredMinRepFactionController = registerController(
    IntFieldController(),
  );
  late final requiredMaxRepFactionController = registerController(
    IntFieldController(),
  );
  late final requiredMinRepValueController = registerController(
    IntFieldController(),
  );
  late final requiredMaxRepValueController = registerController(
    IntFieldController(),
  );
  late final providedItemCountController = registerController(
    IntFieldController(),
  );
  late final specialFlagsController = registerController(FlagFieldController());

  int _refreshToken = 0;
  int _parentToken = 0;

  Future<void> initSignals({required int parentKey}) {
    return setParentKey(parentKey);
  }

  Future<void> setParentKey(int parentKey) async {
    if (this.parentKey.value == parentKey && entity.value != null) return;
    _parentToken++;
    this.parentKey.value = parentKey;
    editingKey.value = null;
    await _refresh();
  }

  Future<void> persist() async {
    if (submitting.value) throw StateError('正在保存，请稍候');
    final parentSnapshot = parentKey.value;
    if (parentSnapshot == null) throw StateError('父记录尚未加载');
    final parentToken = _parentToken;
    final candidate = _collectCandidate();
    validateQuestTemplateAddonFields(candidate);
    final originalKey = editingKey.value;
    submitting.value = true;
    errorMessage.value = null;
    try {
      if (originalKey == null) {
        await _repository.storeQuestTemplateAddon(candidate);
      } else {
        await _repository.updateQuestTemplateAddon(originalKey, candidate);
      }
      if (parentToken != _parentToken ||
          parentKey.value != parentSnapshot) {
        return;
      }
      entity.value = candidate;
      editingKey.value = candidate.id;
      await _refresh();
    } catch (error) {
      if (parentToken != _parentToken ||
          parentKey.value != parentSnapshot) {
        return;
      }
      errorMessage.value = error.toString();
      rethrow;
    } finally {
      submitting.value = false;
    }
  }

  Future<void> destroy() async {
    if (submitting.value) throw StateError('正在提交，请稍候');
    final key = editingKey.value;
    if (key == null) return;
    final parentSnapshot = parentKey.value;
    final parentToken = _parentToken;
    submitting.value = true;
    errorMessage.value = null;
    try {
      await _repository.destroyQuestTemplateAddon(key);
      if (parentToken != _parentToken ||
          parentKey.value != parentSnapshot) {
        return;
      }
      editingKey.value = null;
      await _refresh();
    } catch (error) {
      if (parentToken != _parentToken ||
          parentKey.value != parentSnapshot) {
        return;
      }
      errorMessage.value = error.toString();
      rethrow;
    } finally {
      submitting.value = false;
    }
  }

QuestTemplateAddonEntity _collectCandidate() {
    return QuestTemplateAddonEntity(
      id: idController.collect(),
      maxLevel: maxLevelController.collect(),
      allowableClasses: allowableClassesController.collect(),
      sourceSpellId: sourceSpellIdController.collect(),
      prevQuestId: prevQuestIdController.collect(),
      nextQuestId: nextQuestIdController.collect(),
      exclusiveGroup: exclusiveGroupController.collect(),
      breadcrumbForQuestId: breadcrumbForQuestIdController.collect(),
      rewardMailTemplateId: rewardMailTemplateIdController.collect(),
      rewardMailDelay: rewardMailDelayController.collect(),
      requiredSkillId: requiredSkillIdController.collect(),
      requiredSkillPoints: requiredSkillPointsController.collect(),
      requiredMinRepFaction: requiredMinRepFactionController.collect(),
      requiredMaxRepFaction: requiredMaxRepFactionController.collect(),
      requiredMinRepValue: requiredMinRepValueController.collect(),
      requiredMaxRepValue: requiredMaxRepValueController.collect(),
      providedItemCount: providedItemCountController.collect(),
      specialFlags: specialFlagsController.collect(),
    );
  }

void _applyCandidate(QuestTemplateAddonEntity addon) {
    idController.init(addon.id);
    maxLevelController.init(addon.maxLevel);
    allowableClassesController.init(addon.allowableClasses);
    sourceSpellIdController.init(addon.sourceSpellId);
    prevQuestIdController.init(addon.prevQuestId);
    nextQuestIdController.init(addon.nextQuestId);
    exclusiveGroupController.init(addon.exclusiveGroup);
    breadcrumbForQuestIdController.init(addon.breadcrumbForQuestId);
    rewardMailTemplateIdController.init(addon.rewardMailTemplateId);
    rewardMailDelayController.init(addon.rewardMailDelay);
    requiredSkillIdController.init(addon.requiredSkillId);
    requiredSkillPointsController.init(addon.requiredSkillPoints);
    requiredMinRepFactionController.init(addon.requiredMinRepFaction);
    requiredMaxRepFactionController.init(addon.requiredMaxRepFaction);
    requiredMinRepValueController.init(addon.requiredMinRepValue);
    requiredMaxRepValueController.init(addon.requiredMaxRepValue);
    providedItemCountController.init(addon.providedItemCount);
    specialFlagsController.init(addon.specialFlags);
  }

  Future<void> _refresh() async {
    final token = ++_refreshToken;
    final parentSnapshot = parentKey.value;
    if (parentSnapshot == null) {
      entity.value = null;
      editingKey.value = null;
      return;
    }
    loading.value = true;
    errorMessage.value = null;
    try {
      final existing = await _repository.getQuestTemplateAddon(parentSnapshot);
      if (token != _refreshToken) return;
      final candidate =
          existing ??
          await _repository.createQuestTemplateAddon(parentSnapshot);
      if (token != _refreshToken) return;
      entity.value = candidate;
      editingKey.value = existing == null ? null : parentSnapshot;
      _applyCandidate(candidate);
    } catch (error, stackTrace) {
      if (token != _refreshToken) return;
      errorMessage.value = error.toString();
      LoggerUtil.instance.e('加载单行编辑器失败', error: error, stackTrace: stackTrace);
      rethrow;
    } finally {
      if (token == _refreshToken) loading.value = false;
    }
  }

  void dispose() {
    disposeControllers();
  }
}
