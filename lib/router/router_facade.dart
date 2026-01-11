import 'package:auto_route/auto_route.dart';
import 'package:foxy/router/router.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:foxy/router/router_menu.dart';
import 'package:foxy/router/router_node.dart';
import 'package:signals/signals.dart';

/// 路由门面，为复杂的路由子系统提供简单统一的接口
///
/// 隐藏的复杂性：
/// - Signal 状态管理
/// - AutoRoute 路由操作
/// - 路径计算逻辑
/// - 节点创建逻辑
class RouterFacade {
  /// 当前导航路径
  final path = signal<List<RouterNode>>([RouterMenu.dashboard.toNode()]);

  /// 获取当前激活的菜单（用于侧边栏高亮）
  RouterMenu get activeMenu {
    final nodes = path.value;
    // 从后向前查找第一个有 parentMenu 的节点，或返回节点自身 menu
    for (var i = nodes.length - 1; i >= 0; i--) {
      final parent = nodes[i].parentMenu;
      if (parent != null) return parent;
      // 如果是顶级菜单，返回其 menu
      final menu = nodes[i].menu;
      if (menu != null) return menu;
    }
    return RouterMenu.dashboard;
  }

  /// 获取 Scaffold 内部的路由器
  StackRouter? get _router {
    return router.innerRouterOf<StackRouter>(ScaffoldRoute.name);
  }

  /// 返回上一页
  void goBack() {
    if (path.value.length <= 1) return;

    final newNodes = path.value.take(path.value.length - 1).toList();
    path.value = newNodes;
    _router?.maybePop();
  }

  /// 点击面包屑跳转
  void navigateToBreadcrumb(int index) {
    final currentPath = path.value;
    if (index >= currentPath.length) return;
    if (index == currentPath.length - 1) return; // 点击当前页面，不做任何操作

    final targetNode = currentPath[index];

    // 截取路径到目标节点
    final newNodes = currentPath.take(index + 1).toList();
    path.value = newNodes;

    // 直接导航到目标路由，navigate 会自动处理路由栈
    _router?.navigate(targetNode.route);
  }

  /// 导航到详情页面（列表页跳转）
  void navigateToDetail({
    required String id,
    required String label,
    required PageRouteInfo route,
    required RouterMenu parentMenu,
  }) {
    final currentPath = path.value;
    final detailNode = RouterNode(
      id: id,
      label: label,
      route: route,
      parentMenu: parentMenu,
    );

    // 查找父级菜单在路径中的位置
    final parentIndex = currentPath.indexWhere((n) => n.menu == parentMenu);

    List<RouterNode> newNodes;
    if (parentIndex >= 0) {
      // 截取到父级，然后添加详情页
      newNodes = [...currentPath.take(parentIndex + 1), detailNode];
    } else {
      // 父级不在路径中，构建完整路径
      newNodes = [
        RouterMenu.dashboard.toNode(),
        parentMenu.toNode(),
        detailNode,
      ];
    }

    path.value = newNodes;
    _router?.push(route);
  }

  /// 导航到顶级菜单页面（侧边栏点击）
  void navigateToMenu(RouterMenu menu) {
    final node = menu.toNode();

    // 构建路径：dashboard (如果不是 dashboard) + 当前菜单
    final nodes = menu == RouterMenu.dashboard
        ? [node]
        : [RouterMenu.dashboard.toNode(), node];

    path.value = nodes;
    _router?.navigate(node.route);
  }

  /// 更新当前详情页名称（用于异步加载数据后更新）
  void updateCurrentLabel(String newLabel) {
    final currentPath = path.value;
    if (currentPath.isEmpty) return;

    final newNodes = [...currentPath];
    final lastNode = newNodes.last;
    newNodes[newNodes.length - 1] = lastNode.copyWith(label: newLabel);

    path.value = newNodes;
  }
}
