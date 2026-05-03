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
  final routerFacade = GetIt.instance.get<RouterFacade>();

  /// Basic
  final id = signal<int>(0);
  final statId0 = signal<int>(0);
  final statId1 = signal<int>(0);
  final statId2 = signal<int>(0);
  final statId3 = signal<int>(0);
  final statId4 = signal<int>(0);
  final statId5 = signal<int>(0);
  final statId6 = signal<int>(0);
  final statId7 = signal<int>(0);
  final statId8 = signal<int>(0);
  final statId9 = signal<int>(0);
  final bonus0 = signal<int>(0);
  final bonus1 = signal<int>(0);
  final bonus2 = signal<int>(0);
  final bonus3 = signal<int>(0);
  final bonus4 = signal<int>(0);
  final bonus5 = signal<int>(0);
  final bonus6 = signal<int>(0);
  final bonus7 = signal<int>(0);
  final bonus8 = signal<int>(0);
  final bonus9 = signal<int>(0);
  final maxlevel = signal<int>(0);

  final distribution = signal(ScalingStatDistributionEntity());
  /// 保存到数据库
  Future<void> save(BuildContext context) async {
    try {
      final t = _collectFromControllers();
      final repository = ScalingStatDistributionSoloRepository();
      if (t.id == 0) {
        await repository.storeScalingStatDistribution(t);
      } else {
        await repository.updateScalingStatDistribution(t);
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
      id: id.value,
      statId0: statId0.value,
      statId1: statId1.value,
      statId2: statId2.value,
      statId3: statId3.value,
      statId4: statId4.value,
      statId5: statId5.value,
      statId6: statId6.value,
      statId7: statId7.value,
      statId8: statId8.value,
      statId9: statId9.value,
      bonus0: bonus0.value,
      bonus1: bonus1.value,
      bonus2: bonus2.value,
      bonus3: bonus3.value,
      bonus4: bonus4.value,
      bonus5: bonus5.value,
      bonus6: bonus6.value,
      bonus7: bonus7.value,
      bonus8: bonus8.value,
      bonus9: bonus9.value,
      maxlevel: maxlevel.value,
    );
  }

  void dispose() {}

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
      distribution.value = (await ScalingStatDistributionSoloRepository()
          .getScalingStatDistribution(id))!;
      _initControllers(distribution.value);
    } catch (e, s) {
      LoggerUtil.instance.e('加载属性缩放分布(id=$id)失败', error: e, stackTrace: s);
    }
  }

  void _initControllers(ScalingStatDistributionEntity item) {
    id.value = item.id;
    statId0.value = item.statId0;
    statId1.value = item.statId1;
    statId2.value = item.statId2;
    statId3.value = item.statId3;
    statId4.value = item.statId4;
    statId5.value = item.statId5;
    statId6.value = item.statId6;
    statId7.value = item.statId7;
    statId8.value = item.statId8;
    statId9.value = item.statId9;
    bonus0.value = item.bonus0;
    bonus1.value = item.bonus1;
    bonus2.value = item.bonus2;
    bonus3.value = item.bonus3;
    bonus4.value = item.bonus4;
    bonus5.value = item.bonus5;
    bonus6.value = item.bonus6;
    bonus7.value = item.bonus7;
    bonus8.value = item.bonus8;
    bonus9.value = item.bonus9;
    maxlevel.value = item.maxlevel;
  }
}
