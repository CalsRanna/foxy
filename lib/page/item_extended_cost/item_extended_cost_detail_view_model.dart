import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/util/format_util.dart';
import 'package:foxy/entity/item_extended_cost_entity.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/item_extended_cost_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class ItemExtendedCostDetailViewModel {
  final _repository = GetIt.instance.get<ItemExtendedCostRepository>();
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

  final cost = signal(ItemExtendedCostEntity());

  /// 保存到数据库
  String _fmt(num v) => formatNum(v);

  int _pi(String t) => int.tryParse(t) ?? 0;

  Future<void> save(BuildContext context) async {
    try {
      final t = _collectFromControllers();
      if (t.id == 0) {
        await _repository.storeItemExtendedCost(t);
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
      id: _pi(idController.text),
      honorPoints: _pi(honorPointsController.text),
      arenaPoints: _pi(arenaPointsController.text),
      arenaBracket: _pi(arenaBracketController.text),
      requiredArenaRating: _pi(requiredArenaRatingController.text),
      itemPurchaseGroup: _pi(itemPurchaseGroupController.text),
      itemID0: _pi(itemID0Controller.text),
      itemID1: _pi(itemID1Controller.text),
      itemID2: _pi(itemID2Controller.text),
      itemID3: _pi(itemID3Controller.text),
      itemID4: _pi(itemID4Controller.text),
      itemCount0: _pi(itemCount0Controller.text),
      itemCount1: _pi(itemCount1Controller.text),
      itemCount2: _pi(itemCount2Controller.text),
      itemCount3: _pi(itemCount3Controller.text),
      itemCount4: _pi(itemCount4Controller.text),
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

  void dispose() {
    arenaBracketController.dispose();
    arenaPointsController.dispose();
    honorPointsController.dispose();
    idController.dispose();
    itemCount0Controller.dispose();
    itemCount1Controller.dispose();
    itemCount2Controller.dispose();
    itemCount3Controller.dispose();
    itemCount4Controller.dispose();
    itemID0Controller.dispose();
    itemID1Controller.dispose();
    itemID2Controller.dispose();
    itemID3Controller.dispose();
    itemID4Controller.dispose();
    itemPurchaseGroupController.dispose();
    requiredArenaRatingController.dispose();
  }

  Future<void> initSignals({int? id}) async {
    if (id == null) return;
    try {
      cost.value = (await _repository.getItemExtendedCost(id))!;
      _initControllers(cost.value);
    } catch (e, s) {
      LoggerUtil.instance.e('加载扩展价格(id=$id)失败', error: e, stackTrace: s);
    }
  }

  void _initControllers(ItemExtendedCostEntity table) {
    /// Basic
    idController.text = _fmt(table.id);
    honorPointsController.text = _fmt(table.honorPoints);
    arenaPointsController.text = _fmt(table.arenaPoints);
    arenaBracketController.text = _fmt(table.arenaBracket);
    requiredArenaRatingController.text = _fmt(table.requiredArenaRating);
    itemPurchaseGroupController.text = _fmt(table.itemPurchaseGroup);

    /// ItemID
    itemID0Controller.text = _fmt(table.itemID0);
    itemID1Controller.text = _fmt(table.itemID1);
    itemID2Controller.text = _fmt(table.itemID2);
    itemID3Controller.text = _fmt(table.itemID3);
    itemID4Controller.text = _fmt(table.itemID4);

    /// ItemCount
    itemCount0Controller.text = _fmt(table.itemCount0);
    itemCount1Controller.text = _fmt(table.itemCount1);
    itemCount2Controller.text = _fmt(table.itemCount2);
    itemCount3Controller.text = _fmt(table.itemCount3);
    itemCount4Controller.text = _fmt(table.itemCount4);
  }
}
