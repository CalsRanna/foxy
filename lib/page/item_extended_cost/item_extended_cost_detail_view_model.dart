import 'package:flutter/widgets.dart';
import 'package:foxy/model/item_extended_cost.dart';
import 'package:foxy/repository/item_extended_cost_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class ItemExtendedCostDetailViewModel {
  final routerFacade = GetIt.instance.get<RouterFacade>();

  /// Basic
  final idController = TextEditingController();
  final honorPointsController = TextEditingController();
  final arenaPointsController = TextEditingController();
  final arenaBracketController = TextEditingController();
  final requiredArenaRatingController = TextEditingController();
  final itemPurchaseGroupController = TextEditingController();

  /// ItemID
  final itemID0Controller = TextEditingController();
  final itemID1Controller = TextEditingController();
  final itemID2Controller = TextEditingController();
  final itemID3Controller = TextEditingController();
  final itemID4Controller = TextEditingController();

  /// ItemCount
  final itemCount0Controller = TextEditingController();
  final itemCount1Controller = TextEditingController();
  final itemCount2Controller = TextEditingController();
  final itemCount3Controller = TextEditingController();
  final itemCount4Controller = TextEditingController();

  final table = signal(ItemExtendedCost());

  /// 保存到数据库
  Future<void> save(BuildContext context) async {
    try {
      final t = _collectFromControllers();
      final repository = ItemExtendedCostRepository();
      if (t.id == 0) {
        await repository.store(t);
      } else {
        await repository.update(t);
      }
      table.value = t;
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
  ItemExtendedCost _collectFromControllers() {
    final t = ItemExtendedCost();

    /// Basic
    t.id = _parseInt(idController.text);
    t.honorPoints = _parseInt(honorPointsController.text);
    t.arenaPoints = _parseInt(arenaPointsController.text);
    t.arenaBracket = _parseInt(arenaBracketController.text);
    t.requiredArenaRating = _parseInt(requiredArenaRatingController.text);
    t.itemPurchaseGroup = _parseInt(itemPurchaseGroupController.text);

    /// ItemID
    t.itemID0 = _parseInt(itemID0Controller.text);
    t.itemID1 = _parseInt(itemID1Controller.text);
    t.itemID2 = _parseInt(itemID2Controller.text);
    t.itemID3 = _parseInt(itemID3Controller.text);
    t.itemID4 = _parseInt(itemID4Controller.text);

    /// ItemCount
    t.itemCount0 = _parseInt(itemCount0Controller.text);
    t.itemCount1 = _parseInt(itemCount1Controller.text);
    t.itemCount2 = _parseInt(itemCount2Controller.text);
    t.itemCount3 = _parseInt(itemCount3Controller.text);
    t.itemCount4 = _parseInt(itemCount4Controller.text);

    return t;
  }

  int _parseInt(String text) => text.isEmpty ? 0 : int.parse(text);

  void dispose() {
    /// Basic
    idController.dispose();
    honorPointsController.dispose();
    arenaPointsController.dispose();
    arenaBracketController.dispose();
    requiredArenaRatingController.dispose();
    itemPurchaseGroupController.dispose();

    /// ItemID
    itemID0Controller.dispose();
    itemID1Controller.dispose();
    itemID2Controller.dispose();
    itemID3Controller.dispose();
    itemID4Controller.dispose();

    /// ItemCount
    itemCount0Controller.dispose();
    itemCount1Controller.dispose();
    itemCount2Controller.dispose();
    itemCount3Controller.dispose();
    itemCount4Controller.dispose();
  }

  Future<void> initSignals({int? id}) async {
    if (id == null) return;
    try {
      table.value = (await ItemExtendedCostRepository().find(id))!;
      _initControllers(table.value);
    } catch (e, s) {
      logger.e('加载扩展价格(id=$id)失败', error: e, stackTrace: s);
    }
  }

  void _initControllers(ItemExtendedCost table) {
    /// Basic
    idController.text = table.id.toString();
    honorPointsController.text = table.honorPoints.toString();
    arenaPointsController.text = table.arenaPoints.toString();
    arenaBracketController.text = table.arenaBracket.toString();
    requiredArenaRatingController.text = table.requiredArenaRating.toString();
    itemPurchaseGroupController.text = table.itemPurchaseGroup.toString();

    /// ItemID
    itemID0Controller.text = table.itemID0.toString();
    itemID1Controller.text = table.itemID1.toString();
    itemID2Controller.text = table.itemID2.toString();
    itemID3Controller.text = table.itemID3.toString();
    itemID4Controller.text = table.itemID4.toString();

    /// ItemCount
    itemCount0Controller.text = table.itemCount0.toString();
    itemCount1Controller.text = table.itemCount1.toString();
    itemCount2Controller.text = table.itemCount2.toString();
    itemCount3Controller.text = table.itemCount3.toString();
    itemCount4Controller.text = table.itemCount4.toString();
  }
}
