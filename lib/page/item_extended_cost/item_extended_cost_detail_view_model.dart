import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/item_extended_cost_entity.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/item_extended_cost_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/field_controller.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class ItemExtendedCostDetailViewModel {
  final _repository = GetIt.instance.get<ItemExtendedCostRepository>();
  final routerFacade = GetIt.instance.get<RouterFacade>();

  /// Basic
  final idController = IntFieldController();
  final honorPointsController = IntFieldController();
  final arenaPointsController = IntFieldController();
  final arenaBracketController = IntFieldController();
  final requiredArenaRatingController = IntFieldController();
  final itemPurchaseGroupController = IntFieldController();

  /// ItemID
  final itemID0Controller = IntFieldController();
  final itemID1Controller = IntFieldController();
  final itemID2Controller = IntFieldController();
  final itemID3Controller = IntFieldController();
  final itemID4Controller = IntFieldController();

  /// ItemCount
  final itemCount0Controller = IntFieldController();
  final itemCount1Controller = IntFieldController();
  final itemCount2Controller = IntFieldController();
  final itemCount3Controller = IntFieldController();
  final itemCount4Controller = IntFieldController();

  late final _controllers = <FieldController>[
    idController,
    honorPointsController,
    arenaPointsController,
    arenaBracketController,
    requiredArenaRatingController,
    itemPurchaseGroupController,
    itemID0Controller,
    itemID1Controller,
    itemID2Controller,
    itemID3Controller,
    itemID4Controller,
    itemCount0Controller,
    itemCount1Controller,
    itemCount2Controller,
    itemCount3Controller,
    itemCount4Controller,
  ];

  final cost = signal(ItemExtendedCostEntity());

  Future<void> save(BuildContext context) async {
    try {
      final t = _collectFromControllers();
      final existed = await _repository.getItemExtendedCost(t.id);
      if (existed == null) {
        final id = await _repository.storeItemExtendedCost(t);
        idController.init(id);
      } else {
        await _repository.updateItemExtendedCost(t);
      }
      cost.value = t;
      _logActivity(
        t.id == 0 ? ActivityActionType.create : ActivityActionType.update,
        t,
      );
      if (!context.mounted) return;
      var toast = ShadToast(description: Text('扩展价格数据已保存'));
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

  /// 从所有 Controller 收集数据构建 ItemExtendedCost
  ItemExtendedCostEntity _collectFromControllers() {
    return ItemExtendedCostEntity(
      id: idController.collect(),
      honorPoints: honorPointsController.collect(),
      arenaPoints: arenaPointsController.collect(),
      arenaBracket: arenaBracketController.collect(),
      requiredArenaRating: requiredArenaRatingController.collect(),
      itemPurchaseGroup: itemPurchaseGroupController.collect(),
      itemID0: itemID0Controller.collect(),
      itemID1: itemID1Controller.collect(),
      itemID2: itemID2Controller.collect(),
      itemID3: itemID3Controller.collect(),
      itemID4: itemID4Controller.collect(),
      itemCount0: itemCount0Controller.collect(),
      itemCount1: itemCount1Controller.collect(),
      itemCount2: itemCount2Controller.collect(),
      itemCount3: itemCount3Controller.collect(),
      itemCount4: itemCount4Controller.collect(),
    );
  }

  void _logActivity(ActivityActionType action, ItemExtendedCostEntity t) {
    final log = ActivityLogEntity(
      module: 'item_extended_cost',
      actionType: action,
      entityId: t.id,
      entityName: '',
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().storeActivityLogBestEffort(log);
  }

  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
  }

  Future<void> initSignals({int? id}) async {
    try {
      if (id == null || id <= 0) {
        final blank = await _repository.createItemExtendedCost();
        cost.value = blank;
        _initControllers(blank);
        return;
      }
      cost.value = (await _repository.getItemExtendedCost(id))!;
      _initControllers(cost.value);
    } catch (e, s) {
      LoggerUtil.instance.e('加载扩展价格(id=$id)失败', error: e, stackTrace: s);
    }
  }

  void _initControllers(ItemExtendedCostEntity table) {
    idController.init(table.id);
    honorPointsController.init(table.honorPoints);
    arenaPointsController.init(table.arenaPoints);
    arenaBracketController.init(table.arenaBracket);
    requiredArenaRatingController.init(table.requiredArenaRating);
    itemPurchaseGroupController.init(table.itemPurchaseGroup);
    itemID0Controller.init(table.itemID0);
    itemID1Controller.init(table.itemID1);
    itemID2Controller.init(table.itemID2);
    itemID3Controller.init(table.itemID3);
    itemID4Controller.init(table.itemID4);
    itemCount0Controller.init(table.itemCount0);
    itemCount1Controller.init(table.itemCount1);
    itemCount2Controller.init(table.itemCount2);
    itemCount3Controller.init(table.itemCount3);
    itemCount4Controller.init(table.itemCount4);
  }
}
