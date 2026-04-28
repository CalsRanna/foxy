import 'package:flutter/widgets.dart';
import 'package:foxy/model/activity_log.dart';
import 'package:foxy/model/scaling_stat_distribution.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/scaling_stat_distribution_solo_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class ScalingStatDistributionDetailViewModel {
  final routerFacade = GetIt.instance.get<RouterFacade>();

  /// Basic
  final idController = TextEditingController();

  /// StatID
  final statId0Controller = TextEditingController();
  final statId1Controller = TextEditingController();
  final statId2Controller = TextEditingController();
  final statId3Controller = TextEditingController();
  final statId4Controller = TextEditingController();
  final statId5Controller = TextEditingController();
  final statId6Controller = TextEditingController();
  final statId7Controller = TextEditingController();
  final statId8Controller = TextEditingController();
  final statId9Controller = TextEditingController();

  /// Bonus
  final bonus0Controller = TextEditingController();
  final bonus1Controller = TextEditingController();
  final bonus2Controller = TextEditingController();
  final bonus3Controller = TextEditingController();
  final bonus4Controller = TextEditingController();
  final bonus5Controller = TextEditingController();
  final bonus6Controller = TextEditingController();
  final bonus7Controller = TextEditingController();
  final bonus8Controller = TextEditingController();
  final bonus9Controller = TextEditingController();

  /// Other
  final maxlevelController = TextEditingController();

  final distribution = signal(ScalingStatDistribution());
  final saving = signal(false);

  /// 保存到数据库
  Future<void> save(BuildContext context) async {
    saving.value = true;
    try {
      final t = _collectFromControllers();
      final repository = ScalingStatDistributionSoloRepository();
      if (t.id == 0) {
        await repository.storeScalingStatDistribution(t);
      } else {
        await repository.updateScalingStatDistribution(t);
      }
      distribution.value = t;
      _logActivity(t.id == 0 ? ActivityActionType.create : ActivityActionType.update, t);
      if (!context.mounted) return;
      var toast = ShadToast(description: Text('属性缩放分布数据已保存'));
      ShadSonner.of(context).show(toast);
    } catch (e) {
      if (!context.mounted) return;
      var toast = ShadToast(description: Text(e.toString()));
      ShadSonner.of(context).show(toast);
    } finally {
      saving.value = false;
    }
  }

  /// 退出页面
  void pop() {
    routerFacade.goBack();
  }

  /// 从所有 Controller 收集数据构建 ScalingStatDistribution
  ScalingStatDistribution _collectFromControllers() {
    final t = ScalingStatDistribution();

    t.id = _parseInt(idController.text);
    t.statId0 = _parseInt(statId0Controller.text);
    t.statId1 = _parseInt(statId1Controller.text);
    t.statId2 = _parseInt(statId2Controller.text);
    t.statId3 = _parseInt(statId3Controller.text);
    t.statId4 = _parseInt(statId4Controller.text);
    t.statId5 = _parseInt(statId5Controller.text);
    t.statId6 = _parseInt(statId6Controller.text);
    t.statId7 = _parseInt(statId7Controller.text);
    t.statId8 = _parseInt(statId8Controller.text);
    t.statId9 = _parseInt(statId9Controller.text);
    t.bonus0 = _parseInt(bonus0Controller.text);
    t.bonus1 = _parseInt(bonus1Controller.text);
    t.bonus2 = _parseInt(bonus2Controller.text);
    t.bonus3 = _parseInt(bonus3Controller.text);
    t.bonus4 = _parseInt(bonus4Controller.text);
    t.bonus5 = _parseInt(bonus5Controller.text);
    t.bonus6 = _parseInt(bonus6Controller.text);
    t.bonus7 = _parseInt(bonus7Controller.text);
    t.bonus8 = _parseInt(bonus8Controller.text);
    t.bonus9 = _parseInt(bonus9Controller.text);
    t.maxlevel = _parseInt(maxlevelController.text);

    return t;
  }

  int _parseInt(String text) {
    if (text.isEmpty) return 0;
    final value = int.tryParse(text);
    if (value == null) throw Exception('输入值 "$text" 不是有效数字');
    return value;
  }

  void _logActivity(ActivityActionType action, ScalingStatDistribution t) {
    final log = ActivityLog(
      module: 'scaling_stat_distribution',
      actionType: action,
      entityId: t.id,
      entityName: '',
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().storeActivityLog(log);
  }

  void dispose() {
    idController.dispose();
    statId0Controller.dispose();
    statId1Controller.dispose();
    statId2Controller.dispose();
    statId3Controller.dispose();
    statId4Controller.dispose();
    statId5Controller.dispose();
    statId6Controller.dispose();
    statId7Controller.dispose();
    statId8Controller.dispose();
    statId9Controller.dispose();
    bonus0Controller.dispose();
    bonus1Controller.dispose();
    bonus2Controller.dispose();
    bonus3Controller.dispose();
    bonus4Controller.dispose();
    bonus5Controller.dispose();
    bonus6Controller.dispose();
    bonus7Controller.dispose();
    bonus8Controller.dispose();
    bonus9Controller.dispose();
    maxlevelController.dispose();
  }

  Future<void> initSignals({int? id}) async {
    if (id == null) return;
    try {
      distribution.value = (await ScalingStatDistributionSoloRepository().getScalingStatDistribution(id))!;
      _initControllers(distribution.value);
    } catch (e, s) {
      logger.e('加载属性缩放分布(id=$id)失败', error: e, stackTrace: s);
    }
  }

  void _initControllers(ScalingStatDistribution item) {
    idController.text = item.id.toString();
    statId0Controller.text = item.statId0.toString();
    statId1Controller.text = item.statId1.toString();
    statId2Controller.text = item.statId2.toString();
    statId3Controller.text = item.statId3.toString();
    statId4Controller.text = item.statId4.toString();
    statId5Controller.text = item.statId5.toString();
    statId6Controller.text = item.statId6.toString();
    statId7Controller.text = item.statId7.toString();
    statId8Controller.text = item.statId8.toString();
    statId9Controller.text = item.statId9.toString();
    bonus0Controller.text = item.bonus0.toString();
    bonus1Controller.text = item.bonus1.toString();
    bonus2Controller.text = item.bonus2.toString();
    bonus3Controller.text = item.bonus3.toString();
    bonus4Controller.text = item.bonus4.toString();
    bonus5Controller.text = item.bonus5.toString();
    bonus6Controller.text = item.bonus6.toString();
    bonus7Controller.text = item.bonus7.toString();
    bonus8Controller.text = item.bonus8.toString();
    bonus9Controller.text = item.bonus9.toString();
    maxlevelController.text = item.maxlevel.toString();
  }
}
