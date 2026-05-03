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
  final id = signal<int>(0);
  final charlevel = signal<int>(0);
  final shoulderBudget = signal<int>(0);
  final trinketBudget = signal<int>(0);
  final weaponBudget1H = signal<int>(0);
  final rangedBudget = signal<int>(0);
  final primaryBudget = signal<int>(0);
  final tertiaryBudget = signal<int>(0);
  final spellPower = signal<int>(0);
  final clothShoulderArmor = signal<int>(0);
  final leatherShoulderArmor = signal<int>(0);
  final mailShoulderArmor = signal<int>(0);
  final plateShoulderArmor = signal<int>(0);
  final clothCloakArmor = signal<int>(0);
  final clothChestArmor = signal<int>(0);
  final leatherChestArmor = signal<int>(0);
  final mailChestArmor = signal<int>(0);
  final plateChestArmor = signal<int>(0);
  final weaponDPS1H = signal<int>(0);
  final weaponDPS2H = signal<int>(0);
  final spellcasterDPS1H = signal<int>(0);
  final spellcasterDPS2H = signal<int>(0);
  final rangedDPS = signal<int>(0);
  final wandDPS = signal<int>(0);

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
      id: id.value,
      charlevel: charlevel.value,
      shoulderBudget: shoulderBudget.value,
      trinketBudget: trinketBudget.value,
      weaponBudget1H: weaponBudget1H.value,
      rangedBudget: rangedBudget.value,
      clothShoulderArmor: clothShoulderArmor.value,
      leatherShoulderArmor: leatherShoulderArmor.value,
      mailShoulderArmor: mailShoulderArmor.value,
      plateShoulderArmor: plateShoulderArmor.value,
      weaponDPS1H: weaponDPS1H.value,
      weaponDPS2H: weaponDPS2H.value,
      spellcasterDPS1H: spellcasterDPS1H.value,
      spellcasterDPS2H: spellcasterDPS2H.value,
      rangedDPS: rangedDPS.value,
      wandDPS: wandDPS.value,
      spellPower: spellPower.value,
      primaryBudget: primaryBudget.value,
      tertiaryBudget: tertiaryBudget.value,
      clothCloakArmor: clothCloakArmor.value,
      clothChestArmor: clothChestArmor.value,
      leatherChestArmor: leatherChestArmor.value,
      mailChestArmor: mailChestArmor.value,
      plateChestArmor: plateChestArmor.value,
    );
  }

  void dispose() {}

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
      scalingStatValue.value =
          (await ScalingStatValueRepository().getScalingStatValue(id))!;
      _initControllers(scalingStatValue.value);
    } catch (e, s) {
      LoggerUtil.instance.e('加载缩放属性值(id=$id)失败', error: e, stackTrace: s);
    }
  }

  void _initControllers(ScalingStatValueEntity scalingStatValue) {
    id.value = scalingStatValue.id;
    charlevel.value = scalingStatValue.charlevel;
    shoulderBudget.value = scalingStatValue.shoulderBudget;
    trinketBudget.value = scalingStatValue.trinketBudget;
    weaponBudget1H.value = scalingStatValue.weaponBudget1H;
    rangedBudget.value = scalingStatValue.rangedBudget;
    primaryBudget.value = scalingStatValue.primaryBudget;
    tertiaryBudget.value = scalingStatValue.tertiaryBudget;
    spellPower.value = scalingStatValue.spellPower;
    clothShoulderArmor.value = scalingStatValue.clothShoulderArmor;
    leatherShoulderArmor.value = scalingStatValue.leatherShoulderArmor;
    mailShoulderArmor.value = scalingStatValue.mailShoulderArmor;
    plateShoulderArmor.value = scalingStatValue.plateShoulderArmor;
    clothCloakArmor.value = scalingStatValue.clothCloakArmor;
    clothChestArmor.value = scalingStatValue.clothChestArmor;
    leatherChestArmor.value = scalingStatValue.leatherChestArmor;
    mailChestArmor.value = scalingStatValue.mailChestArmor;
    plateChestArmor.value = scalingStatValue.plateChestArmor;
    weaponDPS1H.value = scalingStatValue.weaponDPS1H;
    weaponDPS2H.value = scalingStatValue.weaponDPS2H;
    spellcasterDPS1H.value = scalingStatValue.spellcasterDPS1H;
    spellcasterDPS2H.value = scalingStatValue.spellcasterDPS2H;
    rangedDPS.value = scalingStatValue.rangedDPS;
    wandDPS.value = scalingStatValue.wandDPS;
  }
}
