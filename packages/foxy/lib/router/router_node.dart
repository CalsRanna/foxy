import 'package:auto_route/auto_route.dart';
import 'package:foxy/router/router_menu.dart';

/// Navigation node, representing one level in the breadcrumb
class RouterNode {
  /// Associated menu (used by top-level menus)
  final RouterMenu? menu;

  /// Display name (the text shown in the breadcrumb)
  final String label;

  /// Corresponding auto_route route
  final PageRouteInfo route;

  /// Parent menu (used for sidebar highlighting)
  final RouterMenu? parentMenu;

  const RouterNode({
    this.menu,
    required this.label,
    required this.route,
    this.parentMenu,
  });

  RouterNode copyWith({
    RouterMenu? menu,
    String? label,
    PageRouteInfo? route,
    RouterMenu? parentMenu,
  }) {
    return RouterNode(
      menu: menu ?? this.menu,
      label: label ?? this.label,
      route: route ?? this.route,
      parentMenu: parentMenu ?? this.parentMenu,
    );
  }
}
