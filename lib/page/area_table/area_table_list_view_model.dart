import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/area_table_entity.dart';
import 'package:foxy/entity/area_table_filter_entity.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/area_table_repository.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/router/router_menu.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

class AreaTableListViewModel {
  final entryController = TextEditingController();
  final nameController = TextEditingController();
  final repository = AreaTableRepository();

  final page = signal(1);
  final areas = signal(<BriefAreaTableEntity>[]);
  final total = signal(0);

  Future<void> copyAreaTable(int id) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认复制',
        description: '是否复制编号为 $id 的区域？',
        confirmText: '复制',
      );
      if (!confirmed) return;
      DialogUtil.instance.loading();
      await repository.copyAreaTable(id);
      _logActivity(ActivityActionType.copy, id);
      await DialogUtil.instance.dismiss();
      DialogUtil.instance.success('复制成功');
      await _refresh();
    } catch (e) {
      LoggerUtil.instance.e(e.toString());
      DialogUtil.instance.error('复制失败: ${e.toString()}');
    }
  }

  Future<void> deleteAreaTable(int id) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认删除',
        description: '是否删除编号为 $id 的区域？此操作不可撤销。',
        confirmText: '删除',
        destructive: true,
      );
      if (!confirmed) return;
      DialogUtil.instance.loading();
      await repository.destroyAreaTable(id);
      _logActivity(ActivityActionType.delete, id);
      await DialogUtil.instance.dismiss();
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
      areas.value = await repository.getBriefAreaTables();
      total.value = await repository.countAreaTables();
    } catch (e) {
      LoggerUtil.instance.e('加载区域表列表失败: $e');
      DialogUtil.instance.error('加载区域表列表失败: $e');
    }
  }

  void navigateToDetail({int? id, String? name}) {
    final label = name?.isNotEmpty == true ? name! : '新建区域';
    final routeId = id != null ? 'area_$id' : 'area_new';
    final routerFacade = GetIt.instance.get<RouterFacade>();
    routerFacade.navigateToDetail(
      id: routeId,
      label: label,
      route: AreaTableDetailRoute(id: id),
      parentMenu: RouterMenu.areaTable,
    );
  }

  AreaTableFilterEntity _buildFilter() {
    return AreaTableFilterEntity(
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
      areas.value = await repository.getBriefAreaTables(
        page: page.value,
        filter: filter,
      );
      total.value = await repository.countAreaTables(filter: filter);
    } catch (e) {
      LoggerUtil.instance.e('刷新区域表列表失败: $e');
      DialogUtil.instance.error('刷新区域表列表失败: $e');
    }
  }

  void _logActivity(ActivityActionType action, int id) {
    final areas = this.areas.value;
    final area = areas.where((a) => a.id == id).firstOrNull;
    final name = area?.areaNameLangZhCn ?? '';
    final log = ActivityLogEntity(
      module: 'area_table',
      actionType: action,
      entityId: id,
      entityName: name,
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().storeActivityLog(log);
  }
}
