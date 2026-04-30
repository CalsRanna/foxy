import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/gem_property_entity.dart';
import 'package:foxy/entity/gem_property_filter_entity.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/gem_property_repository.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/router/router_menu.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

class GemPropertyListViewModel {
  final entryController = TextEditingController();
  final repository = GemPropertyRepository();

  final page = signal(1);
  final properties = signal(<GemPropertyEntity>[]);
  final total = signal(0);

  Future<void> copyGemProperty(int id) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认复制',
        description: '是否复制编号为 $id 的宝石属性？',
        confirmText: '复制',
      );
      if (!confirmed) return;
      DialogUtil.instance.loading();
      await repository.copyGemProperty(id);
      _logActivity(ActivityActionType.copy, id);
      await DialogUtil.instance.dismiss();
      DialogUtil.instance.success('复制成功');
      await _refresh();
    } catch (e) {
      LoggerUtil.instance.e(e.toString());
      DialogUtil.instance.error('复制失败: ${e.toString()}');
    }
  }

  Future<void> deleteGemProperty(int id) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认删除',
        description: '是否删除编号为 $id 的宝石属性？此操作不可撤销。',
        confirmText: '删除',
        destructive: true,
      );
      if (!confirmed) return;
      DialogUtil.instance.loading();
      await repository.destroyGemProperty(id);
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
  }

  Future<void> initSignals() async {
    properties.value = await repository.getGemProperties();
    total.value = await repository.countGemProperties();
  }

  void navigateToDetail({int? id}) {
    final label = id != null ? '宝石属性 #$id' : '新建宝石属性';
    final routeId = id != null ? 'gem_property_$id' : 'gem_property_new';
    final routerFacade = GetIt.instance.get<RouterFacade>();
    routerFacade.navigateToDetail(
      id: routeId,
      label: label,
      route: GemPropertyDetailRoute(id: id),
      parentMenu: RouterMenu.gemProperty,
    );
  }

  GemPropertyFilterEntity _buildFilter() {
    return GemPropertyFilterEntity(id: entryController.text);
  }

  Future<void> paginate(int page) async {
    this.page.value = page;
    await _refresh();
  }

  Future<void> reset() async {
    entryController.clear();
    page.value = 1;
    properties.value = await repository.getGemProperties();
    total.value = await repository.countGemProperties();
  }

  Future<void> search() async {
    page.value = 1;
    await _refresh();
  }

  Future<void> _refresh() async {
    final filter = _buildFilter();
    properties.value = await repository.getGemProperties(
      page: page.value,
      filter: filter,
    );
    total.value = await repository.countGemProperties(filter: filter);
  }

  void _logActivity(ActivityActionType action, int id) {
    final log = ActivityLogEntity(
      module: 'gem_property',
      actionType: action,
      entityId: id,
      entityName: id.toString(),
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().storeActivityLog(log);
  }
}
