import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/gossip_menu_entity.dart';
import 'package:foxy/entity/gossip_menu_filter_entity.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/gossip_menu_repository.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/router/router_menu.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

class GossipMenuListViewModel with FieldControllerMixin {
  int _refreshToken = 0;
  final _repository = GetIt.instance.get<GossipMenuRepository>();

  late final menuIdController = registerController(StringFieldController());
  late final textController = registerController(StringFieldController());

  final menus = signal<List<BriefGossipMenuEntity>>([]);
  final page = signal(1);
  final total = signal(0);

  Future<void> initSignals() async {
    final token = ++_refreshToken;
    try {
      final (items, count) = await (
        _repository.getBriefGossipMenus(),
        _repository.countGossipMenus(),
      ).wait;
      if (token != _refreshToken) return;
      menus.value = items;
      total.value = count;
    } catch (e) {
      LoggerUtil.instance.e('加载对话菜单列表失败: $e');
      DialogUtil.instance.error('加载对话菜单列表失败: $e');
    }
  }

  void dispose() {
    disposeControllers();
  }

  Future<void> search() async {
    page.value = 1;
    await _refresh();
  }

  Future<void> paginate(int page) async {
    this.page.value = page;
    await _refresh();
  }

  Future<void> reset() async {
    menuIdController.init('');
    textController.init('');
    page.value = 1;
    await _refresh();
  }

  Future<void> copyGossipMenu(int menuId, int textId) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认复制',
        description: '此操作不会复制关联表（npc_text / gossip_menu_option）数据，确认继续？',
        confirmText: '复制',
      );
      if (!confirmed) return;
      await _repository.copyGossipMenu(menuId, textId);
      _logActivity(ActivityActionType.copy, menuId, textId);
      DialogUtil.instance.success('复制成功');
      await _refresh();
    } catch (e) {
      LoggerUtil.instance.e(e.toString());
      DialogUtil.instance.error('复制失败: ${e.toString()}');
    }
  }

  Future<void> deleteGossipMenu(int menuId, int textId) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认删除',
        description:
            '将永久删除 MenuID=$menuId / TextID=$textId 的对话主记录。\n'
            '为避免误操作，不会级联删除 npc_text / gossip_menu_option。',
        confirmText: '删除',
        destructive: true,
      );
      if (!confirmed) return;
      await _repository.destroyGossipMenu(menuId, textId);
      _logActivity(ActivityActionType.delete, menuId, textId);
      DialogUtil.instance.success('删除成功');
      await _refresh();
    } catch (e) {
      LoggerUtil.instance.e(e.toString());
      DialogUtil.instance.error('删除失败: ${e.toString()}');
    }
  }

  /// 导航到详情页（null 表示新建）
  void navigateToDetail({int? menuId, int? textId}) {
    final routerFacade = GetIt.instance.get<RouterFacade>();
    routerFacade.navigateToDetail(
      id: menuId?.toString() ?? 'new',
      label: menuId != null ? '对话 $menuId' : '新建对话',
      route: GossipMenuDetailRoute(menuId: menuId, textId: textId),
      parentMenu: RouterMenu.gossipMenu,
    );
  }

  Future<void> _refresh() async {
    final token = ++_refreshToken;
    try {
      final filter = _buildFilter();
      final (items, count) = await (
        _repository.getBriefGossipMenus(filter: filter, page: page.value),
        _repository.countGossipMenus(filter: filter),
      ).wait;
      if (token != _refreshToken) return;
      menus.value = items;
      total.value = count;
    } catch (e) {
      LoggerUtil.instance.e('刷新对话菜单列表失败: $e');
      DialogUtil.instance.error('刷新对话菜单列表失败: $e');
    }
  }

  GossipMenuFilterEntity _buildFilter() {
    return GossipMenuFilterEntity(
      menuId: menuIdController.collect(),
      text: textController.collect(),
    );
  }

  void _logActivity(ActivityActionType action, int menuId, int textId) {
    final templates = menus.value;
    final template = templates
        .where((t) => t.menuId == menuId && t.textId == textId)
        .firstOrNull;
    final name = template?.text ?? '';
    final log = ActivityLogEntity(
      module: 'gossip_menu',
      actionType: action,
      entityId: menuId,
      entityName: name,
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().storeActivityLogBestEffort(log);
  }
}
