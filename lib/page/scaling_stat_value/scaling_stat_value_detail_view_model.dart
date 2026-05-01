import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/scaling_stat_value_entity.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/scaling_stat_value_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class ScalingStatValueDetailViewModel {
  final routerFacade = GetIt.instance.get<RouterFacade>();

  /// Basic
  final idController = TextEditingController();
  final charlevelController = TextEditingController();

  /// Budget
  final shoulderBudgetController = TextEditingController();
  final trinketBudgetController = TextEditingController();
  final weaponBudget1HController = TextEditingController();
  final rangedBudgetController = TextEditingController();
  final primaryBudgetController = TextEditingController();
  final tertiaryBudgetController = TextEditingController();
  final spellPowerController = TextEditingController();

  /// Armor
  final clothShoulderArmorController = TextEditingController();
  final leatherShoulderArmorController = TextEditingController();
  final mailShoulderArmorController = TextEditingController();
  final plateShoulderArmorController = TextEditingController();
  final clothCloakArmorController = TextEditingController();
  final clothChestArmorController = TextEditingController();
  final leatherChestArmorController = TextEditingController();
  final mailChestArmorController = TextEditingController();
  final plateChestArmorController = TextEditingController();

  /// DPS
  final weaponDPS1HController = TextEditingController();
  final weaponDPS2HController = TextEditingController();
  final spellcasterDPS1HController = TextEditingController();
  final spellcasterDPS2HController = TextEditingController();
  final rangedDPSController = TextEditingController();
  final wandDPSController = TextEditingController();

  final scalingStatValue = signal(ScalingStatValueEntity());

  /// 保存到数据库
  Future<void> save(BuildContext context) async {
    try {
      final t = _collectFromControllers();
      final repository = ScalingStatValueRepository();
      if (t.id == 0) {
        await repository.storeScalingStatValue(t);
      } else {
        await repository.updateScalingStatValue(t);
      }
      scalingStatValue.value = t;
      _logActivity(
        t.id == 0 ? ActivityActionType.create : ActivityActionType.update,
        t,
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

  /// 退出页面
  void pop() {
    routerFacade.goBack();
  }

  /// 从所有 Controller 收集数据构建 ScalingStatValue
  ScalingStatValueEntity _collectFromControllers() {
    return ScalingStatValueEntity(
      id: _parseInt(idController.text),
      charlevel: _parseInt(charlevelController.text),
      shoulderBudget: _parseInt(shoulderBudgetController.text),
      trinketBudget: _parseInt(trinketBudgetController.text),
      weaponBudget1H: _parseInt(weaponBudget1HController.text),
      rangedBudget: _parseInt(rangedBudgetController.text),
      clothShoulderArmor: _parseInt(clothShoulderArmorController.text),
      leatherShoulderArmor: _parseInt(leatherShoulderArmorController.text),
      mailShoulderArmor: _parseInt(mailShoulderArmorController.text),
      plateShoulderArmor: _parseInt(plateShoulderArmorController.text),
      weaponDPS1H: _parseInt(weaponDPS1HController.text),
      weaponDPS2H: _parseInt(weaponDPS2HController.text),
      spellcasterDPS1H: _parseInt(spellcasterDPS1HController.text),
      spellcasterDPS2H: _parseInt(spellcasterDPS2HController.text),
      rangedDPS: _parseInt(rangedDPSController.text),
      wandDPS: _parseInt(wandDPSController.text),
      spellPower: _parseInt(spellPowerController.text),
      primaryBudget: _parseInt(primaryBudgetController.text),
      tertiaryBudget: _parseInt(tertiaryBudgetController.text),
      clothCloakArmor: _parseInt(clothCloakArmorController.text),
      clothChestArmor: _parseInt(clothChestArmorController.text),
      leatherChestArmor: _parseInt(leatherChestArmorController.text),
      mailChestArmor: _parseInt(mailChestArmorController.text),
      plateChestArmor: _parseInt(plateChestArmorController.text),
    );
  }

  int _parseInt(String text) {
    if (text.isEmpty) return 0;
    final value = int.tryParse(text);
    if (value == null) throw Exception('输入值 "$text" 不是有效数字');
    return value;
  }

  void _logActivity(ActivityActionType action, ScalingStatValueEntity t) {
    final log = ActivityLogEntity(
      module: 'scaling_stat_value',
      actionType: action,
      entityId: t.id,
      entityName: '',
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().storeActivityLog(log);
  }

  void dispose() {
    idController.dispose();
    charlevelController.dispose();
    shoulderBudgetController.dispose();
    trinketBudgetController.dispose();
    weaponBudget1HController.dispose();
    rangedBudgetController.dispose();
    primaryBudgetController.dispose();
    tertiaryBudgetController.dispose();
    spellPowerController.dispose();
    clothShoulderArmorController.dispose();
    leatherShoulderArmorController.dispose();
    mailShoulderArmorController.dispose();
    plateShoulderArmorController.dispose();
    clothCloakArmorController.dispose();
    clothChestArmorController.dispose();
    leatherChestArmorController.dispose();
    mailChestArmorController.dispose();
    plateChestArmorController.dispose();
    weaponDPS1HController.dispose();
    weaponDPS2HController.dispose();
    spellcasterDPS1HController.dispose();
    spellcasterDPS2HController.dispose();
    rangedDPSController.dispose();
    wandDPSController.dispose();
  }

  Future<void> initSignals({int? id}) async {
    if (id == null) return;
    try {
      scalingStatValue.value =
          (await ScalingStatValueRepository().getScalingStatValue(id))!;
      _initControllers(scalingStatValue.value);
    } catch (e, s) {
      LoggerUtil.instance.e('加载缩放属性值(id=$id)失败', error: e, stackTrace: s);
    }
  }

  void _initControllers(ScalingStatValueEntity scalingStatValue) {
    idController.text = scalingStatValue.id.toString();
    charlevelController.text = scalingStatValue.charlevel.toString();
    shoulderBudgetController.text =
        scalingStatValue.shoulderBudget.toString();
    trinketBudgetController.text =
        scalingStatValue.trinketBudget.toString();
    weaponBudget1HController.text =
        scalingStatValue.weaponBudget1H.toString();
    rangedBudgetController.text =
        scalingStatValue.rangedBudget.toString();
    primaryBudgetController.text =
        scalingStatValue.primaryBudget.toString();
    tertiaryBudgetController.text =
        scalingStatValue.tertiaryBudget.toString();
    spellPowerController.text = scalingStatValue.spellPower.toString();
    clothShoulderArmorController.text =
        scalingStatValue.clothShoulderArmor.toString();
    leatherShoulderArmorController.text =
        scalingStatValue.leatherShoulderArmor.toString();
    mailShoulderArmorController.text =
        scalingStatValue.mailShoulderArmor.toString();
    plateShoulderArmorController.text =
        scalingStatValue.plateShoulderArmor.toString();
    clothCloakArmorController.text =
        scalingStatValue.clothCloakArmor.toString();
    clothChestArmorController.text =
        scalingStatValue.clothChestArmor.toString();
    leatherChestArmorController.text =
        scalingStatValue.leatherChestArmor.toString();
    mailChestArmorController.text =
        scalingStatValue.mailChestArmor.toString();
    plateChestArmorController.text =
        scalingStatValue.plateChestArmor.toString();
    weaponDPS1HController.text = scalingStatValue.weaponDPS1H.toString();
    weaponDPS2HController.text = scalingStatValue.weaponDPS2H.toString();
    spellcasterDPS1HController.text =
        scalingStatValue.spellcasterDPS1H.toString();
    spellcasterDPS2HController.text =
        scalingStatValue.spellcasterDPS2H.toString();
    rangedDPSController.text = scalingStatValue.rangedDPS.toString();
    wandDPSController.text = scalingStatValue.wandDPS.toString();
  }
}
