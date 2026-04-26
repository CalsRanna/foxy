import 'package:flutter/widgets.dart';
import 'package:foxy/model/gossip_menu.dart';
import 'package:foxy/model/gossip_menu_filter_entity.dart';
import 'package:foxy/repository/gossip_menu_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:foxy/router/router_menu.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

/// 对话菜单列表 ViewModel（LazySingleton，保留搜索状态）
class GossipMenuListViewModel {
  final _routerFacade = GetIt.instance.get<RouterFacade>();
  final _repository = GossipMenuRepository();

  final menuIdController = TextEditingController();
  final textController = TextEditingController();

  final templates = signal<List<BriefGossipMenu>>([]);
  final page = signal(1);
  final total = signal(0);

  Future<void> initSignals() async {
    await _refresh();
  }

  void dispose() {
    menuIdController.dispose();
    textController.dispose();
  }

  Future<void> search() async {
    page.value = 1;
    await _refresh();
  }

  Future<void> paginate(int newPage) async {
    page.value = newPage;
    await _refresh();
  }

  Future<void> reset() async {
    menuIdController.clear();
    textController.clear();
    page.value = 1;
    await _refresh();
  }

  Future<void> onCopy(int menuId, int textId) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认复制',
        description: '此操作不会复制关联表（npc_text / gossip_menu_option）数据，确认继续？',
        confirmText: '复制',
      );
      if (!confirmed) return;
      DialogUtil.instance.loading();
      await _repository.copyGossipMenu({'MenuID': menuId, 'TextID': textId});
      await DialogUtil.instance.dismiss();
      DialogUtil.instance.success('复制成功');
      await _refresh();
    } catch (e) {
      logger.e(e.toString());
      DialogUtil.instance.error('复制失败: ${e.toString()}');
    }
  }

  Future<void> onDestroy(int menuId, int textId) async {
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
      DialogUtil.instance.loading();
      await _repository.destroyGossipMenu({'MenuID': menuId, 'TextID': textId});
      await DialogUtil.instance.dismiss();
      DialogUtil.instance.success('删除成功');
      await _refresh();
    } catch (e) {
      logger.e(e.toString());
      DialogUtil.instance.error('删除失败: ${e.toString()}');
    }
  }

  /// 导航到详情页（null 表示新建）
  void navigateToDetail({int? menuId, int? textId}) {
    _routerFacade.navigateToDetail(
      id: menuId?.toString() ?? 'new',
      label: menuId != null ? '对话 $menuId' : '新建对话',
      route: GossipMenuDetailRoute(menuId: menuId, textId: textId),
      parentMenu: RouterMenu.gossipMenu,
    );
  }

  Future<void> _refresh() async {
    final filter = _buildFilter();
    templates.value = await _repository.getBriefGossipMenus(
      filter: filter,
      page: page.value,
    );
    total.value = await _repository.count(filter: filter);
  }

  GossipMenuFilterEntity _buildFilter() {
    return GossipMenuFilterEntity()
      ..menuId = menuIdController.text
      ..text = textController.text;
  }
}
