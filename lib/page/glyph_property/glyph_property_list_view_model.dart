import 'package:flutter/widgets.dart';
import 'package:foxy/model/activity_log.dart';
import 'package:foxy/model/glyph_property.dart';
import 'package:foxy/model/glyph_property_filter_entity.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/glyph_property_repository.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/router/router_menu.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

class GlyphPropertyListViewModel {
  final entryController = TextEditingController();
  final repository = GlyphPropertyRepository();

  final page = signal(1);
  final properties = signal(<GlyphProperty>[]);
  final total = signal(0);

  Future<void> copyGlyphProperty(int id) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认复制',
        description: '是否复制编号为 $id 的雕文属性？',
        confirmText: '复制',
      );
      if (!confirmed) return;
      DialogUtil.instance.loading();
      await repository.copyGlyphProperty(id);
      _logActivity(ActivityActionType.copy, id);
      await DialogUtil.instance.dismiss();
      DialogUtil.instance.success('复制成功');
      await _refresh();
    } catch (e) {
      logger.e(e.toString());
      DialogUtil.instance.error('复制失败: ${e.toString()}');
    }
  }

  Future<void> deleteGlyphProperty(int id) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认删除',
        description: '是否删除编号为 $id 的雕文属性？此操作不可撤销。',
        confirmText: '删除',
        destructive: true,
      );
      if (!confirmed) return;
      DialogUtil.instance.loading();
      await repository.destroyGlyphProperty(id);
      _logActivity(ActivityActionType.delete, id);
      await DialogUtil.instance.dismiss();
      DialogUtil.instance.success('删除成功');
      await _refresh();
    } catch (e) {
      logger.e(e.toString());
      DialogUtil.instance.error('删除失败: ${e.toString()}');
    }
  }

  void _logActivity(ActivityActionType action, int id) {
    final log = ActivityLog(
      module: 'glyph_property',
      actionType: action,
      entityId: id,
      entityName: '',
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().storeActivityLog(log);
  }

  void dispose() {
    entryController.dispose();
  }

  Future<void> initSignals() async {
    final filter = GlyphPropertyFilterEntity();
    properties.value = await repository.getGlyphProperties(page: 1, filter: filter);
    total.value = await repository.countGlyphProperties(filter: filter);
  }

  void navigateToDetail({int? id}) {
    final label = id != null ? '雕文属性 #$id' : '新建雕文属性';
    final routeId = id != null ? 'glyph_property_$id' : 'glyph_property_new';
    final routerFacade = GetIt.instance.get<RouterFacade>();
    routerFacade.navigateToDetail(
      id: routeId,
      label: label,
      route: GlyphPropertyDetailRoute(id: id),
      parentMenu: RouterMenu.glyphProperty,
    );
  }

  GlyphPropertyFilterEntity _buildFilter() {
    return GlyphPropertyFilterEntity()
      ..id = entryController.text;
  }

  Future<void> paginate(int page) async {
    this.page.value = page;
    await _refresh();
  }

  Future<void> reset() async {
    entryController.clear();
    page.value = 1;
    final filter = GlyphPropertyFilterEntity();
    properties.value = await repository.getGlyphProperties(page: 1, filter: filter);
    total.value = await repository.countGlyphProperties(filter: filter);
  }

  Future<void> search() async {
    page.value = 1;
    await _refresh();
  }

  Future<void> _refresh() async {
    final filter = _buildFilter();
    properties.value = await repository.getGlyphProperties(page: page.value, filter: filter);
    total.value = await repository.countGlyphProperties(filter: filter);
  }
}
