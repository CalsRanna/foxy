import 'package:auto_route/auto_route.dart';
import 'package:foxy/router/router_menu.dart';

/// 导航节点，表示面包屑中的一个层级
class RouterNode {
  /// 节点唯一标识符（详情页使用）
  final String? id;

  /// 关联的菜单（顶级菜单使用）
  final RouterMenu? menu;

  /// 显示名称（面包屑中显示的文字）
  final String label;

  /// 对应的 auto_route 路由
  final PageRouteInfo route;

  /// 父级菜单（用于侧边栏高亮）
  final RouterMenu? parentMenu;

  const RouterNode({
    this.id,
    this.menu,
    required this.label,
    required this.route,
    this.parentMenu,
  });

  RouterNode copyWith({
    String? id,
    RouterMenu? menu,
    String? label,
    PageRouteInfo? route,
    RouterMenu? parentMenu,
  }) {
    return RouterNode(
      id: id ?? this.id,
      menu: menu ?? this.menu,
      label: label ?? this.label,
      route: route ?? this.route,
      parentMenu: parentMenu ?? this.parentMenu,
    );
  }
}
