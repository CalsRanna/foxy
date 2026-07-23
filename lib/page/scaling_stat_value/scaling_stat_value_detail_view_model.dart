import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/scaling_stat_value_entity.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:foxy/repository/scaling_stat_value_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/form/validation/scaling_stat_value_entity_validation_mixin.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

class ScalingStatValueDetailViewModel
    with
        ViewModelValidationMixin,
        ScalingStatValueValidationMixin,
        FieldControllerMixin {
  final _repository = GetIt.instance.get<ScalingStatValueRepository>();
  final _activityLogService = GetIt.instance.get<ActivityLogService>();

  final entity = signal<ScalingStatValueEntity?>(null);
  final persistedKey = signal<int?>(null);
  final loading = signal(false);
  final submitting = signal(false);
  final errorMessage = signal<String?>(null);

  /// Basic
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
  late final primaryBudgetController = registerController(IntFieldController());
  late final tertiaryBudgetController = registerController(
    IntFieldController(),
  );
  late final spellPowerController = registerController(IntFieldController());
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

  /// 从所有 Controller 收集数据构建 ScalingStatValue

  Future<void> initSignals({int? key}) async {
    loading.value = true;
    errorMessage.value = null;
    try {
      if (key == null) {
        final blank = await _repository.createScalingStatValue();
        entity.value = blank;
        _applyCandidate(blank);
        persistedKey.value = null;
        return;
      }
      final result = await _repository.getScalingStatValue(key);
      if (result == null) {
        throw StateError('原缩放属性值不存在，可能已被其他操作修改或删除');
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
      validateScalingStatValueFields(candidate);
      final originalKey = persistedKey.value;
      final action = originalKey == null
          ? ActivityActionType.create
          : ActivityActionType.update;
      if (originalKey == null) {
        await _repository.storeScalingStatValue(candidate);
      } else {
        await _repository.updateScalingStatValue(originalKey, candidate);
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

  void _applyCandidate(ScalingStatValueEntity scalingStatValue) {
    idController.init(scalingStatValue.id);
    charlevelController.init(scalingStatValue.charlevel);
    shoulderBudgetController.init(scalingStatValue.shoulderBudget);
    trinketBudgetController.init(scalingStatValue.trinketBudget);
    weaponBudget1HController.init(scalingStatValue.weaponBudget1H);
    rangedBudgetController.init(scalingStatValue.rangedBudget);
    primaryBudgetController.init(scalingStatValue.primaryBudget);
    tertiaryBudgetController.init(scalingStatValue.tertiaryBudget);
    spellPowerController.init(scalingStatValue.spellPower);
    clothShoulderArmorController.init(scalingStatValue.clothShoulderArmor);
    leatherShoulderArmorController.init(scalingStatValue.leatherShoulderArmor);
    mailShoulderArmorController.init(scalingStatValue.mailShoulderArmor);
    plateShoulderArmorController.init(scalingStatValue.plateShoulderArmor);
    clothCloakArmorController.init(scalingStatValue.clothCloakArmor);
    clothChestArmorController.init(scalingStatValue.clothChestArmor);
    leatherChestArmorController.init(scalingStatValue.leatherChestArmor);
    mailChestArmorController.init(scalingStatValue.mailChestArmor);
    plateChestArmorController.init(scalingStatValue.plateChestArmor);
    weaponDPS1HController.init(scalingStatValue.weaponDPS1H);
    weaponDPS2HController.init(scalingStatValue.weaponDPS2H);
    spellcasterDPS1HController.init(scalingStatValue.spellcasterDPS1H);
    spellcasterDPS2HController.init(scalingStatValue.spellcasterDPS2H);
    rangedDPSController.init(scalingStatValue.rangedDPS);
    wandDPSController.init(scalingStatValue.wandDPS);
  }

  void _logActivity(ActivityActionType action, ScalingStatValueEntity t) {
    final log = ActivityLogEntity(
      module: 'scaling_stat_value',
      actionType: action,
      entityName: 'ScalingStatValue ${t.id}',
      createdAt: DateTime.now(),
    );
    _activityLogService.recordBestEffort(log);
  }

  void dispose() {
    disposeControllers();
  }
}
