import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/scaling_stat_distribution_entity.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/scaling_stat_distribution_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class ScalingStatDistributionDetailViewModel with FieldControllerMixin {
  final _repository = GetIt.instance.get<ScalingStatDistributionRepository>();
  final routerFacade = GetIt.instance.get<RouterFacade>();

  /// Basic
  late final idController = registerController(IntFieldController());
  late final statId0Controller = registerController(IntFieldController());
  late final statId1Controller = registerController(IntFieldController());
  late final statId2Controller = registerController(IntFieldController());
  late final statId3Controller = registerController(IntFieldController());
  late final statId4Controller = registerController(IntFieldController());
  late final statId5Controller = registerController(IntFieldController());
  late final statId6Controller = registerController(IntFieldController());
  late final statId7Controller = registerController(IntFieldController());
  late final statId8Controller = registerController(IntFieldController());
  late final statId9Controller = registerController(IntFieldController());
  late final bonus0Controller = registerController(IntFieldController());
  late final bonus1Controller = registerController(IntFieldController());
  late final bonus2Controller = registerController(IntFieldController());
  late final bonus3Controller = registerController(IntFieldController());
  late final bonus4Controller = registerController(IntFieldController());
  late final bonus5Controller = registerController(IntFieldController());
  late final bonus6Controller = registerController(IntFieldController());
  late final bonus7Controller = registerController(IntFieldController());
  late final bonus8Controller = registerController(IntFieldController());
  late final bonus9Controller = registerController(IntFieldController());
  late final maxlevelController = registerController(IntFieldController());

  final distribution = signal(ScalingStatDistributionEntity());

  Future<void> save(BuildContext context) async {
    try {
      final t = _collectFromControllers();
      final existed = await _repository.getScalingStatDistribution(t.id);
      final isCreate = existed == null;
      var saved = t;
      if (existed == null) {
        final id = await _repository.storeScalingStatDistribution(t);
        idController.init(id);
        saved = t.copyWith(id: id);
      } else {
        await _repository.updateScalingStatDistribution(t);
      }
      distribution.value = saved;
      _logActivity(
        isCreate ? ActivityActionType.create : ActivityActionType.update,
        saved,
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
    disposeControllers();
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
