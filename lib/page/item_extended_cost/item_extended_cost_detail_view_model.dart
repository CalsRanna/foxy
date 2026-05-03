import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/item_extended_cost_entity.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/item_extended_cost_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class ItemExtendedCostDetailViewModel {
  final routerFacade = GetIt.instance.get<RouterFacade>();

  /// Basic
  final id = signal<int>(0);
  final honorPoints = signal<int>(0);
  final arenaPoints = signal<int>(0);
  final arenaBracket = signal<int>(0);
  final requiredArenaRating = signal<int>(0);
  final itemPurchaseGroup = signal<int>(0);

  /// ItemID
  final itemID0 = signal<int>(0);
  final itemID1 = signal<int>(0);
  final itemID2 = signal<int>(0);
  final itemID3 = signal<int>(0);
  final itemID4 = signal<int>(0);

  /// ItemCount
  final itemCount0 = signal<int>(0);
  final itemCount1 = signal<int>(0);
  final itemCount2 = signal<int>(0);
  final itemCount3 = signal<int>(0);
  final itemCount4 = signal<int>(0);

  final cost = signal(ItemExtendedCostEntity());
  /// 保存到数据库
  Future<void> save(BuildContext context) async {
    try {
      final t = _collectFromControllers();
      final repository = ItemExtendedCostRepository();
      if (t.id == 0) {
        await repository.storeItemExtendedCost(t);
      } else {
        await repository.updateItemExtendedCost(t);
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
      id: id.value,
      honorPoints: honorPoints.value,
      arenaPoints: arenaPoints.value,
      arenaBracket: arenaBracket.value,
      requiredArenaRating: requiredArenaRating.value,
      itemPurchaseGroup: itemPurchaseGroup.value,
      itemID0: itemID0.value,
      itemID1: itemID1.value,
      itemID2: itemID2.value,
      itemID3: itemID3.value,
      itemID4: itemID4.value,
      itemCount0: itemCount0.value,
      itemCount1: itemCount1.value,
      itemCount2: itemCount2.value,
      itemCount3: itemCount3.value,
      itemCount4: itemCount4.value,
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
    GetIt.instance.get<ActivityLogRepository>().storeActivityLog(log);
  }

  void dispose() {}

  Future<void> initSignals({int? id}) async {
    if (id == null) return;
    try {
      cost.value = (await ItemExtendedCostRepository().getItemExtendedCost(
        id,
      ))!;
      _initControllers(cost.value);
    } catch (e, s) {
      LoggerUtil.instance.e('加载扩展价格(id=$id)失败', error: e, stackTrace: s);
    }
  }

  void _initControllers(ItemExtendedCostEntity table) {
    /// Basic
    id.value = table.id;
    honorPoints.value = table.honorPoints;
    arenaPoints.value = table.arenaPoints;
    arenaBracket.value = table.arenaBracket;
    requiredArenaRating.value = table.requiredArenaRating;
    itemPurchaseGroup.value = table.itemPurchaseGroup;

    /// ItemID
    itemID0.value = table.itemID0;
    itemID1.value = table.itemID1;
    itemID2.value = table.itemID2;
    itemID3.value = table.itemID3;
    itemID4.value = table.itemID4;

    /// ItemCount
    itemCount0.value = table.itemCount0;
    itemCount1.value = table.itemCount1;
    itemCount2.value = table.itemCount2;
    itemCount3.value = table.itemCount3;
    itemCount4.value = table.itemCount4;
  }
}
