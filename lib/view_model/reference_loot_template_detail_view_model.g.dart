// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reference_loot_template_detail_view_model.dart';

mixin _ReferenceLootTemplateDetailViewModelMixin on FieldControllerMixin {
  final _repository = GetIt.instance.get<ReferenceLootTemplateRepository>();

  final entity = signal<ReferenceLootTemplateEntity?>(null);

  final persistedKey = signal<ReferenceLootTemplateKey?>(null);

  final loading = signal(false);

  final submitting = signal(false);

  final errorMessage = signal<String?>(null);

  late final entryController = registerController(IntFieldController());
  late final itemController = registerController(IntFieldController());
  late final referenceController = registerController(IntFieldController());
  late final chanceController = registerController(DoubleFieldController());
  late final questRequiredController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final lootModeController = registerController(IntFieldController());
  late final groupIdController = registerController(IntFieldController());
  late final minCountController = registerController(IntFieldController());
  late final maxCountController = registerController(IntFieldController());
  late final commentController = registerController(StringFieldController());

  void dispose() {
    disposeControllers();
  }

  Future<void> initSignals({ReferenceLootTemplateKey? key}) async {
    loading.value = true;
    errorMessage.value = null;
    try {
      if (key == null) {
        final blank = await _repository.createReferenceLootTemplate();
        entity.value = blank;
        _applyCandidate(blank);
        persistedKey.value = null;
        return;
      }
      final result = await _repository.getReferenceLootTemplate(key);
      if (result == null) {
        throw RecordNotFoundException('record not found');
      }
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
    if (submitting.value) throw BusyException('operation already in progress');
    submitting.value = true;
    errorMessage.value = null;
    try {
      final candidate = _collectCandidate();
      final originalKey = persistedKey.value;
      final action = originalKey == null
          ? ActivityActionType.create
          : ActivityActionType.update;
      if (originalKey == null) {
        await _repository.storeReferenceLootTemplate(candidate);
      } else {
        await _repository.updateReferenceLootTemplate(originalKey, candidate);
      }
      persistedKey.value = ReferenceLootTemplateKey.fromEntity(candidate);
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
    ReferenceLootTemplateEntity referenceLootTemplate,
  ) {}

  void _applyCandidate(ReferenceLootTemplateEntity referenceLootTemplate) {
    entryController.init(referenceLootTemplate.entry);
    itemController.init(referenceLootTemplate.item);
    referenceController.init(referenceLootTemplate.reference);
    chanceController.init(referenceLootTemplate.chance);
    questRequiredController.init(referenceLootTemplate.questRequired ? 1 : 0);
    lootModeController.init(referenceLootTemplate.lootMode);
    groupIdController.init(referenceLootTemplate.groupId);
    minCountController.init(referenceLootTemplate.minCount);
    maxCountController.init(referenceLootTemplate.maxCount);
    commentController.init(referenceLootTemplate.comment);
    _afterApplyCandidate(referenceLootTemplate);
  }

  ReferenceLootTemplateEntity _collectCandidate() {
    return ReferenceLootTemplateEntity(
      entry: entryController.collect(),
      item: itemController.collect(),
      reference: referenceController.collect(),
      chance: chanceController.collect(),
      questRequired: questRequiredController.collect() == 1,
      lootMode: lootModeController.collect(),
      groupId: groupIdController.collect(),
      minCount: minCountController.collect(),
      maxCount: maxCountController.collect(),
      comment: commentController.collect(),
    );
  }

  void _logActivity(
    ActivityActionType action,
    ReferenceLootTemplateEntity referenceLootTemplate,
  ) {}
}
