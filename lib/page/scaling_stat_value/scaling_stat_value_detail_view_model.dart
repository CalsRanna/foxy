import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/util/format_util.dart';
import 'package:foxy/entity/scaling_stat_value_entity.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/scaling_stat_value_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class ScalingStatValueDetailViewModel {
  final _repository = GetIt.instance.get<ScalingStatValueRepository>();
  final routerFacade = GetIt.instance.get<RouterFacade>();

  /// Basic
  final idController = TextEditingController();
  final charlevelController = TextEditingController();
  final shoulderBudgetController = TextEditingController();
  final trinketBudgetController = TextEditingController();
  final weaponBudget1HController = TextEditingController();
  final rangedBudgetController = TextEditingController();
  final primaryBudgetController = TextEditingController();
  final tertiaryBudgetController = TextEditingController();
  final spellPowerController = TextEditingController();
  final clothShoulderArmorController = TextEditingController();
  final leatherShoulderArmorController = TextEditingController();
  final mailShoulderArmorController = TextEditingController();
  final plateShoulderArmorController = TextEditingController();
  final clothCloakArmorController = TextEditingController();
  final clothChestArmorController = TextEditingController();
  final leatherChestArmorController = TextEditingController();
  final mailChestArmorController = TextEditingController();
  final plateChestArmorController = TextEditingController();
  final weaponDPS1HController = TextEditingController();
  final weaponDPS2HController = TextEditingController();
  final spellcasterDPS1HController = TextEditingController();
  final spellcasterDPS2HController = TextEditingController();
  final rangedDPSController = TextEditingController();
  final wandDPSController = TextEditingController();

  final scalingStatValue = signal(ScalingStatValueEntity());

  /// 保存到数据库
  String _fmt(num v) => formatNum(v);

  int _pi(String t) => int.tryParse(t) ?? 0;

  Future<void> save(BuildContext context) async {
    try {
      final t = _collectFromControllers();
      if (t.id == 0) {
        await _repository.storeScalingStatValue(t);
      } else {
        await _repository.updateScalingStatValue(t);
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
      id: _pi(idController.text),
      charlevel: _pi(charlevelController.text),
      shoulderBudget: _pi(shoulderBudgetController.text),
      trinketBudget: _pi(trinketBudgetController.text),
      weaponBudget1H: _pi(weaponBudget1HController.text),
      rangedBudget: _pi(rangedBudgetController.text),
      clothShoulderArmor: _pi(clothShoulderArmorController.text),
      leatherShoulderArmor: _pi(leatherShoulderArmorController.text),
      mailShoulderArmor: _pi(mailShoulderArmorController.text),
      plateShoulderArmor: _pi(plateShoulderArmorController.text),
      weaponDPS1H: _pi(weaponDPS1HController.text),
      weaponDPS2H: _pi(weaponDPS2HController.text),
      spellcasterDPS1H: _pi(spellcasterDPS1HController.text),
      spellcasterDPS2H: _pi(spellcasterDPS2HController.text),
      rangedDPS: _pi(rangedDPSController.text),
      wandDPS: _pi(wandDPSController.text),
      spellPower: _pi(spellPowerController.text),
      primaryBudget: _pi(primaryBudgetController.text),
      tertiaryBudget: _pi(tertiaryBudgetController.text),
      clothCloakArmor: _pi(clothCloakArmorController.text),
      clothChestArmor: _pi(clothChestArmorController.text),
      leatherChestArmor: _pi(leatherChestArmorController.text),
      mailChestArmor: _pi(mailChestArmorController.text),
      plateChestArmor: _pi(plateChestArmorController.text),
    );
  }

  void dispose() {
    charlevelController.dispose();
    clothChestArmorController.dispose();
    clothCloakArmorController.dispose();
    clothShoulderArmorController.dispose();
    idController.dispose();
    leatherChestArmorController.dispose();
    leatherShoulderArmorController.dispose();
    mailChestArmorController.dispose();
    mailShoulderArmorController.dispose();
    plateChestArmorController.dispose();
    plateShoulderArmorController.dispose();
    primaryBudgetController.dispose();
    rangedBudgetController.dispose();
    rangedDPSController.dispose();
    shoulderBudgetController.dispose();
    spellPowerController.dispose();
    spellcasterDPS1HController.dispose();
    spellcasterDPS2HController.dispose();
    tertiaryBudgetController.dispose();
    trinketBudgetController.dispose();
    wandDPSController.dispose();
    weaponBudget1HController.dispose();
    weaponDPS1HController.dispose();
    weaponDPS2HController.dispose();
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

  Future<void> initSignals({int? id}) async {
    if (id == null) return;
    try {
      scalingStatValue.value = (await _repository.getScalingStatValue(id))!;
      _initControllers(scalingStatValue.value);
    } catch (e, s) {
      LoggerUtil.instance.e('加载缩放属性值(id=$id)失败', error: e, stackTrace: s);
    }
  }

  void _initControllers(ScalingStatValueEntity scalingStatValue) {
    idController.text = _fmt(scalingStatValue.id);
    charlevelController.text = _fmt(scalingStatValue.charlevel);
    shoulderBudgetController.text = _fmt(scalingStatValue.shoulderBudget);
    trinketBudgetController.text = _fmt(scalingStatValue.trinketBudget);
    weaponBudget1HController.text = _fmt(scalingStatValue.weaponBudget1H);
    rangedBudgetController.text = _fmt(scalingStatValue.rangedBudget);
    primaryBudgetController.text = _fmt(scalingStatValue.primaryBudget);
    tertiaryBudgetController.text = _fmt(scalingStatValue.tertiaryBudget);
    spellPowerController.text = _fmt(scalingStatValue.spellPower);
    clothShoulderArmorController.text = _fmt(
      scalingStatValue.clothShoulderArmor,
    );
    leatherShoulderArmorController.text = _fmt(
      scalingStatValue.leatherShoulderArmor,
    );
    mailShoulderArmorController.text = _fmt(scalingStatValue.mailShoulderArmor);
    plateShoulderArmorController.text = _fmt(
      scalingStatValue.plateShoulderArmor,
    );
    clothCloakArmorController.text = _fmt(scalingStatValue.clothCloakArmor);
    clothChestArmorController.text = _fmt(scalingStatValue.clothChestArmor);
    leatherChestArmorController.text = _fmt(scalingStatValue.leatherChestArmor);
    mailChestArmorController.text = _fmt(scalingStatValue.mailChestArmor);
    plateChestArmorController.text = _fmt(scalingStatValue.plateChestArmor);
    weaponDPS1HController.text = _fmt(scalingStatValue.weaponDPS1H);
    weaponDPS2HController.text = _fmt(scalingStatValue.weaponDPS2H);
    spellcasterDPS1HController.text = _fmt(scalingStatValue.spellcasterDPS1H);
    spellcasterDPS2HController.text = _fmt(scalingStatValue.spellcasterDPS2H);
    rangedDPSController.text = _fmt(scalingStatValue.rangedDPS);
    wandDPSController.text = _fmt(scalingStatValue.wandDPS);
  }
}
