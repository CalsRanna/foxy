import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/item_set_entity.dart';
import 'package:foxy/entity/item_set_filter_entity.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/item_set_repository.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/router/router_menu.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

class ItemSetListViewModel {
  final entryController = TextEditingController();
  final nameController = TextEditingController();
  final repository = ItemSetRepository();

  final page = signal(1);
  final itemSets = signal(<BriefItemSetEntity>[]);
  final total = signal(0);

  Future<void> copyItemSet(int id) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认复制',
        description: '是否复制编号为 $id 的套装？',
        confirmText: '复制',
      );
      if (!confirmed) return;
      await repository.copyItemSet(id);
      _logActivity(ActivityActionType.copy, id);
      DialogUtil.instance.success('复制成功');
      await _refresh();
    } catch (e) {
      LoggerUtil.instance.e(e.toString());
      DialogUtil.instance.error('复制失败: ${e.toString()}');
    }
  }

  Future<void> deleteItemSet(int id) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认删除',
        description: '是否删除编号为 $id 的套装？此操作不可撤销。',
        confirmText: '删除',
        destructive: true,
      );
      if (!confirmed) return;
      await repository.destroyItemSet(id);
      _logActivity(ActivityActionType.delete, id);
      DialogUtil.instance.success('删除成功');
      await _refresh();
    } catch (e) {
      LoggerUtil.instance.e(e.toString());
      DialogUtil.instance.error('删除失败: ${e.toString()}');
    }
  }

  void dispose() {
    entryController.dispose();
    nameController.dispose();
  }

  Future<void> initSignals() async {
    try {
      itemSets.value = await repository.getBriefItemSets();
      total.value = await repository.countItemSets();
    } catch (e) {
      LoggerUtil.instance.e('加载套装列表失败: $e');
      DialogUtil.instance.error('加载套装列表失败: $e');
    }
  }

  void navigateToDetail({int? id}) {
    final label = id != null ? '套装 #$id' : '新建套装';
    final routeId = id != null ? 'item_set_$id' : 'item_set_new';
    final routerFacade = GetIt.instance.get<RouterFacade>();
    routerFacade.navigateToDetail(
      id: routeId,
      label: label,
      route: ItemSetDetailRoute(id: id),
      parentMenu: RouterMenu.itemSet,
    );
  }

  ItemSetFilterEntity _buildFilter() {
    return ItemSetFilterEntity(
      id: entryController.text,
      name: nameController.text,
    );
  }

  Future<void> paginate(int page) async {
    this.page.value = page;
    await _refresh();
  }

  Future<void> reset() async {
    entryController.clear();
    nameController.clear();
    page.value = 1;
    await _refresh();
  }

  Future<void> search() async {
    page.value = 1;
    await _refresh();
  }

  Future<void> _refresh() async {
    try {
      final filter = _buildFilter();
      itemSets.value = await repository.getBriefItemSets(
        page: page.value,
        filter: filter,
      );
      total.value = await repository.countItemSets(filter: filter);
    } catch (e) {
      LoggerUtil.instance.e('刷新套装列表失败: $e');
      DialogUtil.instance.error('刷新套装列表失败: $e');
    }
  }

  void _logActivity(ActivityActionType action, int id) {
    final log = ActivityLogEntity(
      module: 'item_set',
      actionType: action,
      entityId: id,
      entityName: id.toString(),
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().storeActivityLog(log);
  }
}
