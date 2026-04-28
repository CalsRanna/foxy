import 'package:flutter/widgets.dart';
import 'package:foxy/model/activity_log.dart';
import 'package:foxy/model/game_object_template.dart';
import 'package:foxy/model/game_object_template_filter_entity.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/game_object_template_repository.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/router/router_menu.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

class GameObjectTemplateListViewModel {
  final entryController = TextEditingController();
  final nameController = TextEditingController();
  final repository = GameObjectTemplateRepository();

  final page = signal(1);
  final templates = signal(<BriefGameObjectTemplate>[]);
  final total = signal(0);
  final selectedRowIndex = signal(-1);

  Future<void> copyGameObjectTemplate(int entry) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认复制',
        description: '是否复制编号为 $entry 的游戏对象模板？',
        confirmText: '复制',
      );
      if (!confirmed) return;
      DialogUtil.instance.loading();
      await repository.copyGameObjectTemplate(entry);
      await DialogUtil.instance.dismiss();
      DialogUtil.instance.success('复制成功');
      _logActivity(ActivityActionType.copy, entry);
      await _refresh();
    } catch (e) {
      logger.e(e.toString());
      DialogUtil.instance.error('复制失败: ${e.toString()}');
    }
  }

  Future<void> deleteGameObjectTemplate(int entry) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认删除',
        description: '是否删除编号为 $entry 的游戏对象模板？此操作不可撤销。',
        confirmText: '删除',
        destructive: true,
      );
      if (!confirmed) return;
      DialogUtil.instance.loading();
      await repository.destroyGameObjectTemplate(entry);
      await DialogUtil.instance.dismiss();
      DialogUtil.instance.success('删除成功');
      _logActivity(ActivityActionType.delete, entry);
      await _refresh();
    } catch (e) {
      logger.e(e.toString());
      DialogUtil.instance.error('删除失败: ${e.toString()}');
    }
  }

  void dispose() {
    entryController.dispose();
    nameController.dispose();
  }

  Future<void> initSignals() async {
    templates.value = await repository.getBriefGameObjectTemplates();
    total.value = await repository.countGameObjectTemplates();
  }

  void navigateGameObjectTemplateDetailPage(
    BuildContext context, {
    int? entry,
    String? name,
  }) {
    final label = name?.isNotEmpty == true ? name! : '新建游戏对象';
    final id = entry != null ? 'gameobject_$entry' : 'gameobject_new';
    final routerFacade = GetIt.instance.get<RouterFacade>();
    routerFacade.navigateToDetail(
      id: id,
      label: label,
      route: GameObjectTemplateDetailRoute(entry: entry, name: name),
      parentMenu: RouterMenu.gameObjectTemplate,
    );
  }

  GameObjectTemplateFilterEntity _buildFilter() {
    return GameObjectTemplateFilterEntity()
      ..entry = entryController.text
      ..name = nameController.text;
  }

  Future<void> paginate(int page) async {
    this.page.value = page;
    await _refresh();
  }

  Future<void> reset() async {
    entryController.clear();
    nameController.clear();
    page.value = 1;
    templates.value = await repository.getBriefGameObjectTemplates();
    total.value = await repository.countGameObjectTemplates();
  }

  Future<void> search() async {
    page.value = 1;
    await _refresh();
  }

  Future<void> _refresh() async {
    final filter = _buildFilter();
    templates.value = await repository.getBriefGameObjectTemplates(
      page: page.value,
      filter: filter,
    );
    total.value = await repository.countGameObjectTemplates(filter: filter);
  }

  void _logActivity(ActivityActionType action, int entry) {
    final all = templates.value;
    final template = all.where((t) => t.entry == entry).firstOrNull;
    final name = template?.name ?? '';
    final log = ActivityLog(
      module: 'gameobject_template',
      actionType: action,
      entityId: entry,
      entityName: name,
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().storeActivityLog(log);
  }
}
