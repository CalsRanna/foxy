// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skill_line_detail_view_model.dart';

mixin _SkillLineDetailViewModelMixin on FieldControllerMixin {
  final _repository = GetIt.instance.get<SkillLineRepository>();

  final entity = signal<SkillLineEntity?>(null);

  final persistedKey = signal<int?>(null);

  final loading = signal(false);

  final submitting = signal(false);

  final errorMessage = signal<String?>(null);

  late final idController = registerController(IntFieldController());
  late final categoryIdController = registerController(IntFieldController());
  late final skillCostsIdController = registerController(IntFieldController());
  late final displayNameLangZhCNController = registerController(
    StringFieldController(),
  );
  late final displayNameLangFlagsController = registerController(
    IntFieldController(),
  );
  late final descriptionLangZhCNController = registerController(
    StringFieldController(),
  );
  late final descriptionLangFlagsController = registerController(
    IntFieldController(),
  );
  late final spellIconIdController = registerController(IntFieldController());
  late final alternateVerbLangZhCNController = registerController(
    StringFieldController(),
  );
  late final alternateVerbLangFlagsController = registerController(
    IntFieldController(),
  );
  late final canLinkController = registerController(IntFieldController());

  void dispose() {
    disposeControllers();
  }

  Future<void> initSignals({int? key}) async {
    loading.value = true;
    errorMessage.value = null;
    try {
      if (key == null) {
        final blank = await _repository.createSkillLine();
        if (isDisposed) return;
        entity.value = blank;
        _applyCandidate(blank);
        persistedKey.value = null;
        return;
      }
      final result = await _repository.getSkillLine(key);
      if (result == null) {
        throw RecordNotFoundException('record not found');
      }
      if (isDisposed) return;
      entity.value = result;
      _applyCandidate(result);
      persistedKey.value = key;
    } catch (error, stackTrace) {
      errorMessage.value = FoxyExceptions.message(error);
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
      var candidate = _collectCandidate();
      final originalKey = persistedKey.value;
      final action = originalKey == null
          ? ActivityActionType.create
          : ActivityActionType.update;
      if (originalKey == null) {
        final storedKey = await _repository.storeSkillLine(candidate);
        persistedKey.value = storedKey;
        if (storedKey != candidate.id) {
          candidate = candidate.copyWith(id: storedKey);
          if (!isDisposed) {
            idController.init(storedKey);
          }
        }
      } else {
        await _repository.updateSkillLine(originalKey, candidate);
        persistedKey.value = candidate.id;
      }
      entity.value = candidate;
      _logActivity(action, candidate);
    } catch (error) {
      errorMessage.value = FoxyExceptions.message(error);
      rethrow;
    } finally {
      submitting.value = false;
    }
  }

  void _afterApplyCandidate(SkillLineEntity skillLine) {}

  void _applyCandidate(SkillLineEntity skillLine) {
    idController.init(skillLine.id);
    categoryIdController.init(skillLine.categoryId);
    skillCostsIdController.init(skillLine.skillCostsId);
    displayNameLangZhCNController.init(skillLine.displayNameLangZhCN);
    displayNameLangFlagsController.init(skillLine.displayNameLangFlags);
    descriptionLangZhCNController.init(skillLine.descriptionLangZhCN);
    descriptionLangFlagsController.init(skillLine.descriptionLangFlags);
    spellIconIdController.init(skillLine.spellIconId);
    alternateVerbLangZhCNController.init(skillLine.alternateVerbLangZhCN);
    alternateVerbLangFlagsController.init(skillLine.alternateVerbLangFlags);
    canLinkController.init(skillLine.canLink);
    _afterApplyCandidate(skillLine);
  }

  SkillLineEntity _collectCandidate() {
    return SkillLineEntity(
      id: idController.collect(),
      categoryId: categoryIdController.collect(),
      skillCostsId: skillCostsIdController.collect(),
      displayNameLangZhCN: displayNameLangZhCNController.collect(),
      displayNameLangFlags: displayNameLangFlagsController.collect(),
      descriptionLangZhCN: descriptionLangZhCNController.collect(),
      descriptionLangFlags: descriptionLangFlagsController.collect(),
      spellIconId: spellIconIdController.collect(),
      alternateVerbLangZhCN: alternateVerbLangZhCNController.collect(),
      alternateVerbLangFlags: alternateVerbLangFlagsController.collect(),
      canLink: canLinkController.collect(),
    );
  }

  /// Fires the activity-log event after a write; persistence is handled by
  /// the single ActivityLogListener aspect.
  void _logActivity(ActivityActionType action, SkillLineEntity skillLine) {
    GetIt.instance.get<EventBus>().fire(
      EntityWrittenEvent(
        ActivityLogEntity(
          module: 'dbc_skill_line',
          actionType: action,
          entityName: 'SkillLine ${skillLine.id}',
          createdAt: DateTime.now(),
        ),
      ),
    );
  }
}
