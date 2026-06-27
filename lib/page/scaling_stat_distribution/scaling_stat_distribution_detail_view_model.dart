import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/scaling_stat_distribution_entity.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/scaling_stat_distribution_solo_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class ScalingStatDistributionDetailViewModel {
  final _repository = GetIt.instance.get<ScalingStatDistributionSoloRepository>();
  final routerFacade = GetIt.instance.get<RouterFacade>();

  /// Basic
  final idController = TextEditingController();
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
  final maxlevelController = TextEditingController();

  final distribution = signal(ScalingStatDistributionEntity());
  /// 保存到数据库
  String _fmt(num v) {
    if (v is double) {
      final s = v.toString();
      if (s.contains('.') && s.endsWith('0')) {
        return s.replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '');
      }
      return s;
    }
    return v.toString();
  }

  int _pi(String t) => int.tryParse(t) ?? 0;

  Future<void> save(BuildContext context) async {
    try {
      final t = _collectFromControllers();
      if (t.id == 0) {
        await _repository.storeScalingStatDistribution(t);
      } else {
        await _repository.updateScalingStatDistribution(t);
      }
      distribution.value = t;
      _logActivity(
        t.id == 0 ? ActivityActionType.create : ActivityActionType.update,
        t,
      );
      if (!context.mounted) return;
      var toast = ShadToast(description: Text('属性缩放分布数据已保存'));
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

  /// 从所有 Controller 收集数据构建 ScalingStatDistribution
  ScalingStatDistributionEntity _collectFromControllers() {
    return ScalingStatDistributionEntity(
      id: _pi(idController.text),
      statId0: _pi(statId0Controller.text),
      statId1: _pi(statId1Controller.text),
      statId2: _pi(statId2Controller.text),
      statId3: _pi(statId3Controller.text),
      statId4: _pi(statId4Controller.text),
      statId5: _pi(statId5Controller.text),
      statId6: _pi(statId6Controller.text),
      statId7: _pi(statId7Controller.text),
      statId8: _pi(statId8Controller.text),
      statId9: _pi(statId9Controller.text),
      bonus0: _pi(bonus0Controller.text),
      bonus1: _pi(bonus1Controller.text),
      bonus2: _pi(bonus2Controller.text),
      bonus3: _pi(bonus3Controller.text),
      bonus4: _pi(bonus4Controller.text),
      bonus5: _pi(bonus5Controller.text),
      bonus6: _pi(bonus6Controller.text),
      bonus7: _pi(bonus7Controller.text),
      bonus8: _pi(bonus8Controller.text),
      bonus9: _pi(bonus9Controller.text),
      maxlevel: _pi(maxlevelController.text),
    );
  }

  void dispose() {
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
    idController.dispose();
    maxlevelController.dispose();
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
  }

  void _logActivity(
    ActivityActionType action,
    ScalingStatDistributionEntity t,
  ) {
    final log = ActivityLogEntity(
      module: 'scaling_stat_distribution',
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
      distribution.value = (await _repository.getScalingStatDistribution(id))!;
      _initControllers(distribution.value);
    } catch (e, s) {
      LoggerUtil.instance.e('加载属性缩放分布(id=$id)失败', error: e, stackTrace: s);
    }
  }

  void _initControllers(ScalingStatDistributionEntity item) {
    idController.text = _fmt(item.id);
    statId0Controller.text = _fmt(item.statId0);
    statId1Controller.text = _fmt(item.statId1);
    statId2Controller.text = _fmt(item.statId2);
    statId3Controller.text = _fmt(item.statId3);
    statId4Controller.text = _fmt(item.statId4);
    statId5Controller.text = _fmt(item.statId5);
    statId6Controller.text = _fmt(item.statId6);
    statId7Controller.text = _fmt(item.statId7);
    statId8Controller.text = _fmt(item.statId8);
    statId9Controller.text = _fmt(item.statId9);
    bonus0Controller.text = _fmt(item.bonus0);
    bonus1Controller.text = _fmt(item.bonus1);
    bonus2Controller.text = _fmt(item.bonus2);
    bonus3Controller.text = _fmt(item.bonus3);
    bonus4Controller.text = _fmt(item.bonus4);
    bonus5Controller.text = _fmt(item.bonus5);
    bonus6Controller.text = _fmt(item.bonus6);
    bonus7Controller.text = _fmt(item.bonus7);
    bonus8Controller.text = _fmt(item.bonus8);
    bonus9Controller.text = _fmt(item.bonus9);
    maxlevelController.text = _fmt(item.maxlevel);
  }
}
