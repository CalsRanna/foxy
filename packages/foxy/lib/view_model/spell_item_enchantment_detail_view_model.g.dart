// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spell_item_enchantment_detail_view_model.dart';

mixin _SpellItemEnchantmentDetailViewModelMixin on FieldControllerMixin {
  final _repository = GetIt.instance.get<SpellItemEnchantmentRepository>();

  final entity = signal<SpellItemEnchantmentEntity?>(null);

  final persistedKey = signal<int?>(null);

  final loading = signal(false);

  final submitting = signal(false);

  final errorMessage = signal<String?>(null);

  late final idController = registerController(IntFieldController());
  late final chargesController = registerController(IntFieldController());
  late final effect0Controller = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final effect1Controller = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final effect2Controller = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final effectPointsMin0Controller = registerController(
    IntFieldController(),
  );
  late final effectPointsMin1Controller = registerController(
    IntFieldController(),
  );
  late final effectPointsMin2Controller = registerController(
    IntFieldController(),
  );
  late final effectPointsMax0Controller = registerController(
    IntFieldController(),
  );
  late final effectPointsMax1Controller = registerController(
    IntFieldController(),
  );
  late final effectPointsMax2Controller = registerController(
    IntFieldController(),
  );
  late final effectArg0Controller = registerController(
    IntFieldControllerGroup(),
  );
  late final effectArg1Controller = registerController(
    IntFieldControllerGroup(),
  );
  late final effectArg2Controller = registerController(
    IntFieldControllerGroup(),
  );
  late final nameLangZhCNController = registerController(
    StringFieldController(),
  );
  late final nameLangFlagsController = registerController(IntFieldController());
  late final itemVisualController = registerController(IntFieldController());
  late final flagsController = registerController(FlagFieldController());
  late final srcItemIdController = registerController(IntFieldController());
  late final conditionIdController = registerController(IntFieldController());
  late final requiredSkillIdController = registerController(
    IntFieldController(),
  );
  late final requiredSkillRankController = registerController(
    IntFieldController(),
  );
  late final minLevelController = registerController(IntFieldController());

  void dispose() {
    disposeControllers();
  }

  Future<void> initSignals({int? key}) async {
    loading.value = true;
    errorMessage.value = null;
    try {
      if (key == null) {
        final blank = await _repository.createSpellItemEnchantment();
        if (isDisposed) return;
        entity.value = blank;
        _applyCandidate(blank);
        persistedKey.value = null;
        return;
      }
      final result = await _repository.getSpellItemEnchantment(key);
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
        final storedKey = await _repository.storeSpellItemEnchantment(
          candidate,
        );
        persistedKey.value = storedKey;
        if (storedKey != candidate.id) {
          candidate = candidate.copyWith(id: storedKey);
          if (!isDisposed) {
            idController.init(storedKey);
          }
        }
      } else {
        await _repository.updateSpellItemEnchantment(originalKey, candidate);
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

  void _afterApplyCandidate(SpellItemEnchantmentEntity spellItemEnchantment) {}

  void _applyCandidate(SpellItemEnchantmentEntity spellItemEnchantment) {
    idController.init(spellItemEnchantment.id);
    chargesController.init(spellItemEnchantment.charges);
    effect0Controller.init(spellItemEnchantment.effect0);
    effect1Controller.init(spellItemEnchantment.effect1);
    effect2Controller.init(spellItemEnchantment.effect2);
    effectPointsMin0Controller.init(spellItemEnchantment.effectPointsMin0);
    effectPointsMin1Controller.init(spellItemEnchantment.effectPointsMin1);
    effectPointsMin2Controller.init(spellItemEnchantment.effectPointsMin2);
    effectPointsMax0Controller.init(spellItemEnchantment.effectPointsMax0);
    effectPointsMax1Controller.init(spellItemEnchantment.effectPointsMax1);
    effectPointsMax2Controller.init(spellItemEnchantment.effectPointsMax2);
    effectArg0Controller.init(spellItemEnchantment.effectArg0);
    effectArg1Controller.init(spellItemEnchantment.effectArg1);
    effectArg2Controller.init(spellItemEnchantment.effectArg2);
    nameLangZhCNController.init(spellItemEnchantment.nameLangZhCN);
    nameLangFlagsController.init(spellItemEnchantment.nameLangFlags);
    itemVisualController.init(spellItemEnchantment.itemVisual);
    flagsController.init(spellItemEnchantment.flags);
    srcItemIdController.init(spellItemEnchantment.srcItemId);
    conditionIdController.init(spellItemEnchantment.conditionId);
    requiredSkillIdController.init(spellItemEnchantment.requiredSkillId);
    requiredSkillRankController.init(spellItemEnchantment.requiredSkillRank);
    minLevelController.init(spellItemEnchantment.minLevel);
    _afterApplyCandidate(spellItemEnchantment);
  }

  SpellItemEnchantmentEntity _collectCandidate() {
    return SpellItemEnchantmentEntity(
      id: idController.collect(),
      charges: chargesController.collect(),
      effect0: effect0Controller.collect(),
      effect1: effect1Controller.collect(),
      effect2: effect2Controller.collect(),
      effectPointsMin0: effectPointsMin0Controller.collect(),
      effectPointsMin1: effectPointsMin1Controller.collect(),
      effectPointsMin2: effectPointsMin2Controller.collect(),
      effectPointsMax0: effectPointsMax0Controller.collect(),
      effectPointsMax1: effectPointsMax1Controller.collect(),
      effectPointsMax2: effectPointsMax2Controller.collect(),
      effectArg0: effectArg0Controller.collect(),
      effectArg1: effectArg1Controller.collect(),
      effectArg2: effectArg2Controller.collect(),
      nameLangZhCN: nameLangZhCNController.collect(),
      nameLangFlags: nameLangFlagsController.collect(),
      itemVisual: itemVisualController.collect(),
      flags: flagsController.collect(),
      srcItemId: srcItemIdController.collect(),
      conditionId: conditionIdController.collect(),
      requiredSkillId: requiredSkillIdController.collect(),
      requiredSkillRank: requiredSkillRankController.collect(),
      minLevel: minLevelController.collect(),
    );
  }

  /// Fires the activity-log event after a write; persistence is handled by
  /// the single ActivityLogListener aspect.
  void _logActivity(
    ActivityActionType action,
    SpellItemEnchantmentEntity spellItemEnchantment,
  ) {
    GetIt.instance.get<EventBus>().fire(
      EntityWrittenEvent(
        ActivityLogEntity(
          module: 'dbc_spell_item_enchantment',
          actionType: action,
          entityName: 'SpellItemEnchantment ${spellItemEnchantment.id}',
          createdAt: DateTime.now(),
        ),
      ),
    );
  }
}
