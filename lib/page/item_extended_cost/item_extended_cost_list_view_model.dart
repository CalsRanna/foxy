import 'package:flutter/widgets.dart';
import 'package:foxy/model/item_extended_cost.dart';
import 'package:foxy/model/item_extended_cost_filter_entity.dart';
import 'package:foxy/repository/item_extended_cost_repository.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/router/router_menu.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

class ItemExtendedCostListViewModel {
  final entryController = TextEditingController();
  final repository = ItemExtendedCostRepository();

  final page = signal(1);
  final costs = signal(<ItemExtendedCost>[]);
  final total = signal(0);
  final selectedRowIndex = signal(-1);

  Future<void> copyItemExtendedCost(int id) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认复制',
        description: '是否复制编号为 $id 的扩展价格？',
        confirmText: '复制',
      );
      if (!confirmed) return;
      DialogUtil.instance.loading();
      await repository.copyItemExtendedCost(id);
      await DialogUtil.instance.dismiss();
      DialogUtil.instance.success('复制成功');
      await _refresh();
    } catch (e) {
      logger.e(e.toString());
      DialogUtil.instance.error('复制失败: ${e.toString()}');
    }
  }

  Future<void> deleteItemExtendedCost(int id) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认删除',
        description: '是否删除编号为 $id 的扩展价格？此操作不可撤销。',
        confirmText: '删除',
        destructive: true,
      );
      if (!confirmed) return;
      DialogUtil.instance.loading();
      await repository.destroyItemExtendedCost(id);
      await DialogUtil.instance.dismiss();
      DialogUtil.instance.success('删除成功');
      await _refresh();
    } catch (e) {
      logger.e(e.toString());
      DialogUtil.instance.error('删除失败: ${e.toString()}');
    }
  }

  void dispose() {
    entryController.dispose();
  }

  Future<void> initSignals() async {
    final filter = ItemExtendedCostFilterEntity();
    costs.value = await repository.getItemExtendedCosts(page: 1, filter: filter);
    total.value = await repository.countItemExtendedCosts(filter: filter);
  }

  void navigateToDetail(BuildContext context, {int? id}) {
    final label = id != null ? '扩展价格 #$id' : '新建扩展价格';
    final routeId = id != null ? 'item_extended_cost_$id' : 'item_extended_cost_new';
    final routerFacade = GetIt.instance.get<RouterFacade>();
    routerFacade.navigateToDetail(
      id: routeId,
      label: label,
      route: ItemExtendedCostDetailRoute(id: id),
      parentMenu: RouterMenu.itemExtendedCost,
    );
  }

  ItemExtendedCostFilterEntity _buildFilter() {
    return ItemExtendedCostFilterEntity()
      ..id = entryController.text;
  }

  Future<void> paginate(int page) async {
    this.page.value = page;
    await _refresh();
  }

  Future<void> reset() async {
    entryController.clear();
    page.value = 1;
    final filter = ItemExtendedCostFilterEntity();
    costs.value = await repository.getItemExtendedCosts(page: 1, filter: filter);
    total.value = await repository.countItemExtendedCosts(filter: filter);
  }

  Future<void> search() async {
    page.value = 1;
    await _refresh();
  }

  Future<void> _refresh() async {
    final filter = _buildFilter();
    costs.value = await repository.getItemExtendedCosts(page: page.value, filter: filter);
    total.value = await repository.countItemExtendedCosts(filter: filter);
  }
}
