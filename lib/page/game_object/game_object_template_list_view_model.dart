import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/game_object_template_entity.dart';
import 'package:foxy/entity/game_object_template_filter_entity.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/game_object_template_repository.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/router/router_menu.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

class GameObjectTemplateListViewModel with FieldControllerMixin {
  int _refreshToken = 0;
  late final entryController = registerController(StringFieldController());
  late final nameController = registerController(StringFieldController());

  final _repository = GetIt.instance.get<GameObjectTemplateRepository>();

  final page = signal(1);
  final templates = signal(<BriefGameObjectTemplateEntity>[]);
  final total = signal(0);

  Future<void> copyGameObjectTemplate(int entry) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认复制',
        description: '是否复制编号为 $entry 的游戏对象模板？',
        confirmText: '复制',
      );
      if (!confirmed) return;
      await _repository.copyGameObjectTemplate(entry);
      DialogUtil.instance.success('复制成功');
      _logActivity(ActivityActionType.copy, entry);
      await _refresh();
    } catch (e) {
      LoggerUtil.instance.e(e.toString());
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
      await _repository.destroyGameObjectTemplate(entry);
      DialogUtil.instance.success('删除成功');
      _logActivity(ActivityActionType.delete, entry);
      await _refresh();
    } catch (e) {
      LoggerUtil.instance.e(e.toString());
      DialogUtil.instance.error('删除失败: ${e.toString()}');
    }
  }

  void dispose() {
    disposeControllers();
  }

  Future<void> initSignals() async {
    final token = ++_refreshToken;
    try {
      final (items, count) = await (
        _repository.getBriefGameObjectTemplates(),
        _repository.countGameObjectTemplates(),
      ).wait;
      if (token != _refreshToken) return;
      templates.value = items;
      total.value = count;
    } catch (e) {
      LoggerUtil.instance.e('加载游戏对象列表失败: $e');
      DialogUtil.instance.error('加载游戏对象列表失败: $e');
    }
  }

  void navigateToDetail(BuildContext context, {int? entry, String? name}) {
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

  Future<void> paginate(int page) async {
    this.page.value = page;
    await _refresh();
  }

  Future<void> reset() async {
    entryController.init('');
    nameController.init('');
    page.value = 1;
    await _refresh();
  }

  Future<void> search() async {
    page.value = 1;
    await _refresh();
  }

  GameObjectTemplateFilterEntity _buildFilter() {
    return GameObjectTemplateFilterEntity(
      entry: entryController.collect(),
      name: nameController.collect(),
    );
  }

  void _logActivity(ActivityActionType action, int entry) {
    final all = templates.value;
    final template = all.where((t) => t.entry == entry).firstOrNull;
    final name = template?.name ?? '';
    final log = ActivityLogEntity(
      module: 'gameobject_template',
      actionType: action,
      entityId: entry,
      entityName: name,
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().storeActivityLogBestEffort(log);
  }

  Future<void> _refresh() async {
    final token = ++_refreshToken;
    try {
      final filter = _buildFilter();
      final (items, count) = await (
        _repository.getBriefGameObjectTemplates(
          page: page.value,
          filter: filter,
        ),
        _repository.countGameObjectTemplates(filter: filter),
      ).wait;
      if (token != _refreshToken) return;
      templates.value = items;
      total.value = count;
    } catch (e) {
      LoggerUtil.instance.e('刷新游戏对象列表失败: $e');
      DialogUtil.instance.error('刷新游戏对象列表失败: $e');
    }
  }
}
