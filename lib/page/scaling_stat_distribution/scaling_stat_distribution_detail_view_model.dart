import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/scaling_stat_distribution_entity.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/scaling_stat_distribution_solo_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/field_controller.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class ScalingStatDistributionDetailViewModel {
  final _repository = GetIt.instance
      .get<ScalingStatDistributionSoloRepository>();
  final routerFacade = GetIt.instance.get<RouterFacade>();

  /// Basic
  final idController = IntFieldController();
  final statId0Controller = IntFieldController();
  final statId1Controller = IntFieldController();
  final statId2Controller = IntFieldController();
  final statId3Controller = IntFieldController();
  final statId4Controller = IntFieldController();
  final statId5Controller = IntFieldController();
  final statId6Controller = IntFieldController();
  final statId7Controller = IntFieldController();
  final statId8Controller = IntFieldController();
  final statId9Controller = IntFieldController();
  final bonus0Controller = IntFieldController();
  final bonus1Controller = IntFieldController();
  final bonus2Controller = IntFieldController();
  final bonus3Controller = IntFieldController();
  final bonus4Controller = IntFieldController();
  final bonus5Controller = IntFieldController();
  final bonus6Controller = IntFieldController();
  final bonus7Controller = IntFieldController();
  final bonus8Controller = IntFieldController();
  final bonus9Controller = IntFieldController();
  final maxlevelController = IntFieldController();

  late final _controllers = <FieldController>[
    idController,
    statId0Controller,
    statId1Controller,
    statId2Controller,
    statId3Controller,
    statId4Controller,
    statId5Controller,
    statId6Controller,
    statId7Controller,
    statId8Controller,
    statId9Controller,
    bonus0Controller,
    bonus1Controller,
    bonus2Controller,
    bonus3Controller,
    bonus4Controller,
    bonus5Controller,
    bonus6Controller,
    bonus7Controller,
    bonus8Controller,
    bonus9Controller,
    maxlevelController,
  ];

  final distribution = signal(ScalingStatDistributionEntity());

  Future<void> save(BuildContext context) async {
    try {
      final t = _collectFromControllers();
      final existed = await _repository.getScalingStatDistribution(t.id);
      if (existed == null) {
        final id = await _repository.storeScalingStatDistribution(t);
        idController.init(id);
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
      id: idController.collect(),
      statId0: statId0Controller.collect(),
      statId1: statId1Controller.collect(),
      statId2: statId2Controller.collect(),
      statId3: statId3Controller.collect(),
      statId4: statId4Controller.collect(),
      statId5: statId5Controller.collect(),
      statId6: statId6Controller.collect(),
      statId7: statId7Controller.collect(),
      statId8: statId8Controller.collect(),
      statId9: statId9Controller.collect(),
      bonus0: bonus0Controller.collect(),
      bonus1: bonus1Controller.collect(),
      bonus2: bonus2Controller.collect(),
      bonus3: bonus3Controller.collect(),
      bonus4: bonus4Controller.collect(),
      bonus5: bonus5Controller.collect(),
      bonus6: bonus6Controller.collect(),
      bonus7: bonus7Controller.collect(),
      bonus8: bonus8Controller.collect(),
      bonus9: bonus9Controller.collect(),
      maxlevel: maxlevelController.collect(),
    );
  }

  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
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
    GetIt.instance.get<ActivityLogRepository>().storeActivityLogBestEffort(log);
  }

  Future<void> initSignals({int? id}) async {
    try {
      if (id == null || id <= 0) {
        final blank = await _repository.createScalingStatDistribution();
        distribution.value = blank;
        _initControllers(blank);
        return;
      }
      distribution.value = (await _repository.getScalingStatDistribution(id))!;
      _initControllers(distribution.value);
    } catch (e, s) {
      LoggerUtil.instance.e('加载属性缩放分布(id=$id)失败', error: e, stackTrace: s);
    }
  }

  void _initControllers(ScalingStatDistributionEntity item) {
    idController.init(item.id);
    statId0Controller.init(item.statId0);
    statId1Controller.init(item.statId1);
    statId2Controller.init(item.statId2);
    statId3Controller.init(item.statId3);
    statId4Controller.init(item.statId4);
    statId5Controller.init(item.statId5);
    statId6Controller.init(item.statId6);
    statId7Controller.init(item.statId7);
    statId8Controller.init(item.statId8);
    statId9Controller.init(item.statId9);
    bonus0Controller.init(item.bonus0);
    bonus1Controller.init(item.bonus1);
    bonus2Controller.init(item.bonus2);
    bonus3Controller.init(item.bonus3);
    bonus4Controller.init(item.bonus4);
    bonus5Controller.init(item.bonus5);
    bonus6Controller.init(item.bonus6);
    bonus7Controller.init(item.bonus7);
    bonus8Controller.init(item.bonus8);
    bonus9Controller.init(item.bonus9);
    maxlevelController.init(item.maxlevel);
  }
}
