import 'package:foxy/widget/form/view_model_validation_mixin.dart';
import 'package:foxy/widget/form/validation/item_extended_cost_entity_validation_mixin.dart';
import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/item_extended_cost_entity.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/item_extended_cost_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class ItemExtendedCostDetailViewModel
    with
        ViewModelValidationMixin,
        ItemExtendedCostValidationMixin,
        FieldControllerMixin {
  final _repository = GetIt.instance.get<ItemExtendedCostRepository>();
  final routerFacade = GetIt.instance.get<RouterFacade>();

  /// Basic
  late final idController = registerController(IntFieldController());
  late final honorPointsController = registerController(IntFieldController());
  late final arenaPointsController = registerController(IntFieldController());
  late final arenaBracketController = registerController(IntFieldController());
  late final requiredArenaRatingController = registerController(
    IntFieldController(),
  );
  late final itemPurchaseGroupController = registerController(
    IntFieldController(),
  );

  /// ItemID
  late final itemID0Controller = registerController(IntFieldController());
  late final itemID1Controller = registerController(IntFieldController());
  late final itemID2Controller = registerController(IntFieldController());
  late final itemID3Controller = registerController(IntFieldController());
  late final itemID4Controller = registerController(IntFieldController());

  /// ItemCount
  late final itemCount0Controller = registerController(IntFieldController());
  late final itemCount1Controller = registerController(IntFieldController());
  late final itemCount2Controller = registerController(IntFieldController());
  late final itemCount3Controller = registerController(IntFieldController());
  late final itemCount4Controller = registerController(IntFieldController());

  final cost = signal(ItemExtendedCostEntity());

  Future<void> save(BuildContext context) async {
    try {
      var t = _collectFromControllers();
      validateItemExtendedCostFields(t);
      final existed = await _repository.getItemExtendedCost(t.id);
      final action = existed == null
          ? ActivityActionType.create
          : ActivityActionType.update;
      if (existed == null) {
        final id = await _repository.storeItemExtendedCost(t);
        idController.init(id);
        t = t.copyWith(id: id);
      } else {
        await _repository.updateItemExtendedCost(t);
      }
      cost.value = t;
      _logActivity(action, t);
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
    disposeControllers();
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
