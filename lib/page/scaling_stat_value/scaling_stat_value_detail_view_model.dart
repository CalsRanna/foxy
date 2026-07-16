import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/scaling_stat_value_entity.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/scaling_stat_value_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/form/validation/scaling_stat_value_entity_validation_mixin.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class ScalingStatValueDetailViewModel
    with
        ViewModelValidationMixin,
        ScalingStatValueValidationMixin,
        FieldControllerMixin {
  final _repository = GetIt.instance.get<ScalingStatValueRepository>();
  final routerFacade = GetIt.instance.get<RouterFacade>();

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

  final scalingStatValue = signal(ScalingStatValueEntity());

  void dispose() {
    disposeControllers();
  }

  Future<void> initSignals({int? id}) async {
    try {
      if (id == null || id <= 0) {
        final blank = await _repository.createScalingStatValue();
        scalingStatValue.value = blank;
        _initControllers(blank);
        return;
      }
      scalingStatValue.value = (await _repository.getScalingStatValue(id))!;
      _initControllers(scalingStatValue.value);
    } catch (e, s) {
      LoggerUtil.instance.e('加载缩放属性值(id=$id)失败', error: e, stackTrace: s);
    }
  }

  /// 退出页面
  void pop() {
    routerFacade.goBack();
  }

  Future<void> save(BuildContext context) async {
    try {
      final t = _collectFromControllers();
      validateScalingStatValueFields(t);
      final existed = await _repository.getScalingStatValue(t.id);
      if (existed == null) {
        final id = await _repository.storeScalingStatValue(t);
        idController.init(id);
      } else {
        await _repository.updateScalingStatValue(t);
      }
      final isCreate = existed == null;
      scalingStatValue.value = isCreate
          ? t.copyWith(id: idController.collect())
          : t;
      _logActivity(
        isCreate ? ActivityActionType.create : ActivityActionType.update,
        scalingStatValue.value,
      );
      if (!context.mounted) return;
      var toast = ShadToast(description: Text('缩放属性值数据已保存'));
      ShadSonner.of(context).show(toast);
    } catch (e) {
      if (!context.mounted) return;
      var toast = ShadToast(description: Text(e.toString()));
      ShadSonner.of(context).show(toast);
    }
  }

  /// 从所有 Controller 收集数据构建 ScalingStatValue
  ScalingStatValueEntity _collectFromControllers() {
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

  void _initControllers(ScalingStatValueEntity scalingStatValue) {
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
      entityId: t.id,
      entityName: '',
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().storeActivityLogBestEffort(log);
  }
}
