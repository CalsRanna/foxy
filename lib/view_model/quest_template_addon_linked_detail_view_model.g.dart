// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quest_template_addon_linked_detail_view_model.dart';

mixin _QuestTemplateAddonLinkedDetailViewModelMixin on FieldControllerMixin {
  final _repository = GetIt.instance.get<QuestTemplateAddonRepository>();

  final linkKey = signal<int?>(null);

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

  void _afterApplyCandidate(QuestTemplateAddonEntity questTemplateAddon) {}

  void _applyCandidate(QuestTemplateAddonEntity questTemplateAddon) {
    idController.init(questTemplateAddon.id);
    maxLevelController.init(questTemplateAddon.maxLevel);
    allowableClassesController.init(questTemplateAddon.allowableClasses);
    sourceSpellIdController.init(questTemplateAddon.sourceSpellId);
    prevQuestIdController.init(questTemplateAddon.prevQuestId);
    nextQuestIdController.init(questTemplateAddon.nextQuestId);
    exclusiveGroupController.init(questTemplateAddon.exclusiveGroup);
    breadcrumbForQuestIdController.init(
      questTemplateAddon.breadcrumbForQuestId,
    );
    rewardMailTemplateIdController.init(
      questTemplateAddon.rewardMailTemplateId,
    );
    rewardMailDelayController.init(questTemplateAddon.rewardMailDelay);
    requiredSkillIdController.init(questTemplateAddon.requiredSkillId);
    requiredSkillPointsController.init(questTemplateAddon.requiredSkillPoints);
    requiredMinRepFactionController.init(
      questTemplateAddon.requiredMinRepFaction,
    );
    requiredMaxRepFactionController.init(
      questTemplateAddon.requiredMaxRepFaction,
    );
    requiredMinRepValueController.init(questTemplateAddon.requiredMinRepValue);
    requiredMaxRepValueController.init(questTemplateAddon.requiredMaxRepValue);
    providedItemCountController.init(questTemplateAddon.providedItemCount);
    specialFlagsController.init(questTemplateAddon.specialFlags);
    _afterApplyCandidate(questTemplateAddon);
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

  int _refreshToken = 0;
  int _linkToken = 0;

  Future<void> destroy() async {
    if (submitting.value) throw BusyException('operation already in progress');
    final key = editingKey.value;
    if (key == null) return;
    final linkSnapshot = linkKey.value;
    final linkToken = _linkToken;
    submitting.value = true;
    errorMessage.value = null;
    try {
      await _repository.destroyQuestTemplateAddon(key);
      if (linkToken != _linkToken || linkKey.value != linkSnapshot) {
        return;
      }
      editingKey.value = null;
      await _refresh();
    } catch (error) {
      if (linkToken != _linkToken || linkKey.value != linkSnapshot) {
        return;
      }
      errorMessage.value = foxyErrorMessage(error);
      rethrow;
    } finally {
      submitting.value = false;
    }
  }

  void dispose() {
    disposeControllers();
  }

  Future<void> initSignals({required int linkKey}) {
    return setLinkKey(linkKey);
  }

  Future<void> persist() async {
    if (submitting.value) throw BusyException('operation already in progress');
    final linkSnapshot = linkKey.value;
    if (linkSnapshot == null) {
      throw LinkNotLoadedException('link record not loaded');
    }
    final linkToken = _linkToken;
    final candidate = _collectCandidate();
    final originalKey = editingKey.value;
    submitting.value = true;
    errorMessage.value = null;
    try {
      if (originalKey == null) {
        await _repository.storeQuestTemplateAddon(candidate);
      } else {
        await _repository.updateQuestTemplateAddon(originalKey, candidate);
      }
      if (linkToken != _linkToken || linkKey.value != linkSnapshot) {
        return;
      }
      entity.value = candidate;
      editingKey.value = candidate.id;
      await _refresh();
    } catch (error) {
      if (linkToken != _linkToken || linkKey.value != linkSnapshot) {
        return;
      }
      errorMessage.value = foxyErrorMessage(error);
      rethrow;
    } finally {
      submitting.value = false;
    }
  }

  Future<void> setLinkKey(int linkKey) async {
    if (this.linkKey.value == linkKey && entity.value != null) return;
    _linkToken++;
    this.linkKey.value = linkKey;
    editingKey.value = null;
    await _refresh();
  }

  Future<void> _refresh() async {
    final token = ++_refreshToken;
    final linkSnapshot = linkKey.value;
    if (linkSnapshot == null) {
      entity.value = null;
      editingKey.value = null;
      return;
    }
    loading.value = true;
    errorMessage.value = null;
    try {
      final existing = await _repository.getQuestTemplateAddon(linkSnapshot);
      if (token != _refreshToken) return;
      final candidate =
          existing ?? await _repository.createQuestTemplateAddon(linkSnapshot);
      if (token != _refreshToken) return;
      entity.value = candidate;
      editingKey.value = existing == null ? null : linkSnapshot;
      _applyCandidate(candidate);
    } catch (error, stackTrace) {
      if (token != _refreshToken) return;
      errorMessage.value = foxyErrorMessage(error);
      LoggerUtil.instance.e('加载单行编辑器失败', error: error, stackTrace: stackTrace);
      rethrow;
    } finally {
      if (token == _refreshToken) loading.value = false;
    }
  }
}
