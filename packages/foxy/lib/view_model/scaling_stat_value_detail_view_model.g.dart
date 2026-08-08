// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scaling_stat_value_detail_view_model.dart';

mixin _ScalingStatValueDetailViewModelMixin on FieldControllerMixin {
  final _repository = GetIt.instance.get<ScalingStatValueRepository>();

  final entity = signal<ScalingStatValueEntity?>(null);

  final persistedKey = signal<int?>(null);

  final loading = signal(false);

  final submitting = signal(false);

  final errorMessage = signal<String?>(null);

  late final idController = registerController(IntFieldController());
  late final charlevelController = registerController(IntFieldController());
  late final shoulderBudgetController = registerController(
    IntFieldController(),
  );
  late final trinketBudgetController = registerController(IntFieldController());
  late final weaponBudget1HController = registerController(
    IntFieldController(),
  );
  late final rangedBudgetController = registerController(IntFieldController());
  late final clothShoulderArmorController = registerController(
    IntFieldController(),
  );
  late final leatherShoulderArmorController = registerController(
    IntFieldController(),
  );
  late final mailShoulderArmorController = registerController(
    IntFieldController(),
  );
  late final plateShoulderArmorController = registerController(
    IntFieldController(),
  );
  late final weaponDPS1HController = registerController(IntFieldController());
  late final weaponDPS2HController = registerController(IntFieldController());
  late final spellcasterDPS1HController = registerController(
    IntFieldController(),
  );
  late final spellcasterDPS2HController = registerController(
    IntFieldController(),
  );
  late final rangedDPSController = registerController(IntFieldController());
  late final wandDPSController = registerController(IntFieldController());
  late final spellPowerController = registerController(IntFieldController());
  late final primaryBudgetController = registerController(IntFieldController());
  late final tertiaryBudgetController = registerController(
    IntFieldController(),
  );
  late final clothCloakArmorController = registerController(
    IntFieldController(),
  );
  late final clothChestArmorController = registerController(
    IntFieldController(),
  );
  late final leatherChestArmorController = registerController(
    IntFieldController(),
  );
  late final mailChestArmorController = registerController(
    IntFieldController(),
  );
  late final plateChestArmorController = registerController(
    IntFieldController(),
  );

  void dispose() {
    disposeControllers();
  }

  Future<void> initSignals({int? key}) async {
    loading.value = true;
    errorMessage.value = null;
    try {
      if (key == null) {
        final blank = await _repository.createScalingStatValue();
        if (isDisposed) return;
        entity.value = blank;
        _applyCandidate(blank);
        persistedKey.value = null;
        return;
      }
      final result = await _repository.getScalingStatValue(key);
      if (result == null) {
        throw RecordNotFoundException('record not found');
      }
      if (isDisposed) return;
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
    if (submitting.value) {
      throw BusyException('operation already in progress');
    }
    submitting.value = true;
    errorMessage.value = null;
    try {
      final candidate = _collectCandidate();
      final originalKey = persistedKey.value;
      final action = originalKey == null
          ? ActivityActionType.create
          : ActivityActionType.update;
      if (originalKey == null) {
        final storedKey = await _repository.storeScalingStatValue(candidate);
        persistedKey.value = storedKey;
      } else {
        await _repository.updateScalingStatValue(originalKey, candidate);
        persistedKey.value = candidate.id;
      }
      entity.value = candidate;
      _logActivity(action, candidate);
    } catch (error) {
      errorMessage.value = foxyErrorMessage(error);
      rethrow;
    } finally {
      submitting.value = false;
    }
  }

  void _afterApplyCandidate(ScalingStatValueEntity scalingStatValue) {}

  void _applyCandidate(ScalingStatValueEntity scalingStatValue) {
    idController.init(scalingStatValue.id);
    charlevelController.init(scalingStatValue.charlevel);
    shoulderBudgetController.init(scalingStatValue.shoulderBudget);
    trinketBudgetController.init(scalingStatValue.trinketBudget);
    weaponBudget1HController.init(scalingStatValue.weaponBudget1H);
    rangedBudgetController.init(scalingStatValue.rangedBudget);
    clothShoulderArmorController.init(scalingStatValue.clothShoulderArmor);
    leatherShoulderArmorController.init(scalingStatValue.leatherShoulderArmor);
    mailShoulderArmorController.init(scalingStatValue.mailShoulderArmor);
    plateShoulderArmorController.init(scalingStatValue.plateShoulderArmor);
    weaponDPS1HController.init(scalingStatValue.weaponDPS1H);
    weaponDPS2HController.init(scalingStatValue.weaponDPS2H);
    spellcasterDPS1HController.init(scalingStatValue.spellcasterDPS1H);
    spellcasterDPS2HController.init(scalingStatValue.spellcasterDPS2H);
    rangedDPSController.init(scalingStatValue.rangedDPS);
    wandDPSController.init(scalingStatValue.wandDPS);
    spellPowerController.init(scalingStatValue.spellPower);
    primaryBudgetController.init(scalingStatValue.primaryBudget);
    tertiaryBudgetController.init(scalingStatValue.tertiaryBudget);
    clothCloakArmorController.init(scalingStatValue.clothCloakArmor);
    clothChestArmorController.init(scalingStatValue.clothChestArmor);
    leatherChestArmorController.init(scalingStatValue.leatherChestArmor);
    mailChestArmorController.init(scalingStatValue.mailChestArmor);
    plateChestArmorController.init(scalingStatValue.plateChestArmor);
    _afterApplyCandidate(scalingStatValue);
  }

  ScalingStatValueEntity _collectCandidate() {
    return ScalingStatValueEntity(
      id: idController.collect(),
      charlevel: charlevelController.collect(),
      shoulderBudget: shoulderBudgetController.collect(),
      trinketBudget: trinketBudgetController.collect(),
      weaponBudget1H: weaponBudget1HController.collect(),
      rangedBudget: rangedBudgetController.collect(),
      clothShoulderArmor: clothShoulderArmorController.collect(),
      leatherShoulderArmor: leatherShoulderArmorController.collect(),
      mailShoulderArmor: mailShoulderArmorController.collect(),
      plateShoulderArmor: plateShoulderArmorController.collect(),
      weaponDPS1H: weaponDPS1HController.collect(),
      weaponDPS2H: weaponDPS2HController.collect(),
      spellcasterDPS1H: spellcasterDPS1HController.collect(),
      spellcasterDPS2H: spellcasterDPS2HController.collect(),
      rangedDPS: rangedDPSController.collect(),
      wandDPS: wandDPSController.collect(),
      spellPower: spellPowerController.collect(),
      primaryBudget: primaryBudgetController.collect(),
      tertiaryBudget: tertiaryBudgetController.collect(),
      clothCloakArmor: clothCloakArmorController.collect(),
      clothChestArmor: clothChestArmorController.collect(),
      leatherChestArmor: leatherChestArmorController.collect(),
      mailChestArmor: mailChestArmorController.collect(),
      plateChestArmor: plateChestArmorController.collect(),
    );
  }

  /// Fires the activity-log event after a write; persistence is handled by
  /// the single ActivityLogListener aspect.
  void _logActivity(
    ActivityActionType action,
    ScalingStatValueEntity scalingStatValue,
  ) {
    GetIt.instance.get<EventBus>().fire(
      EntityWrittenEvent(
        ActivityLogEntity(
          module: 'dbc_scaling_stat_values',
          actionType: action,
          entityName: 'ScalingStatValue ${scalingStatValue.id}',
          createdAt: DateTime.now(),
        ),
      ),
    );
  }
}
