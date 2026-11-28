import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:foxy/router/router.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:foxy/router/router_menu.dart';
import 'package:foxy/router/router_node.dart';
import 'package:foxy/router/setting_section.dart';
import 'package:signals/signals.dart';

/// Routing facade: a simple, uniform interface over the complex routing
/// subsystem
///
/// Hidden complexity:
/// - Signal state management
/// - AutoRoute routing operations
/// - Path-computation logic
/// - Node-creation logic
class RouterFacade {
  /// Current navigation path
  final path = signal<List<RouterNode>>([RouterMenu.dashboard.toNode()]);

  /// Prompt shown before leaving a page with unsaved changes.
  Future<bool> Function()? confirmLeave;

  final _dirtyChecks = <bool Function()>[];
  bool _confirmingLeave = false;

  RouterFacade({this.confirmLeave});

  /// Returns the currently active menu (for sidebar highlighting)
  RouterMenu get activeMenu {
    final nodes = path.value;
    // Walk backward to the first node with a parentMenu, or fall back to
    // the node's own menu
    for (var i = nodes.length - 1; i >= 0; i--) {
      final parent = nodes[i].parentMenu;
      if (parent != null) return parent;
      // For a top-level menu, return its own menu
      final menu = nodes[i].menu;
      if (menu != null) return menu;
    }
    return RouterMenu.dashboard;
  }

  /// Whether any active detail form reports unsaved edits.
  bool get hasUnsavedChanges => _dirtyChecks.any((check) => check());

  /// Returns the router inside the Scaffold
  StackRouter? get _router {
    return FoxyRouter.router.innerRouterOf<StackRouter>(ScaffoldRoute.name);
  }

  /// Goes back one page
  void goBack() {
    if (path.value.length <= 1) return;

    _runWithLeaveGuard(() {
      if (path.value.length <= 1) return;
      final newNodes = path.value.take(path.value.length - 1).toList();
      path.value = newNodes;
      _router?.maybePop();
    });
  }

  /// Jumps on breadcrumb click
  void navigateToBreadcrumb(int index) {
    final currentPath = path.value;
    if (index >= currentPath.length) return;
    if (index == currentPath.length - 1) {
      return; // clicking the current page is a no-op
    }

    _runWithLeaveGuard(() {
      final latestPath = path.value;
      if (index >= latestPath.length || index == latestPath.length - 1) return;
      final targetNode = latestPath[index];
      // Truncate the path at the target node
      final newNodes = latestPath.take(index + 1).toList();
      path.value = newNodes;
      // Navigate straight to the target route; navigate manages the stack
      // automatically
      _router?.navigate(targetNode.route);
    });
  }

  /// Navigates to a detail page (from a list page)
  ///
  /// Detail-page breadcrumb labels are uniformly "XXX details", generated
  /// from the parent menu label.
  void navigateToDetail({
    required PageRouteInfo route,
    required RouterMenu parentMenu,
  }) {
    final currentPath = path.value;

    // The parent is the last list-page node in the path, so breadcrumbs and
    // highlighting follow the actual navigation stack (list pages can be
    // reached via the sidebar or "More"; a hard-coded parent would misalign
    // breadcrumbs with the route)
    final parentIndex = currentPath.lastIndexWhere((n) => n.menu != null);

    // Inherit the list page's highlight parent: null for pinned modules,
    // "More" for unpinned ones
    final detailNode = RouterNode(
      label: parentMenu.detailLabel,
      route: route,
      parentMenu: parentIndex >= 0
          ? currentPath[parentIndex].parentMenu
          : parentMenu,
    );

    List<RouterNode> newNodes;
    if (parentIndex >= 0) {
      // Truncate to the list page, then append the detail page
      newNodes = [...currentPath.take(parentIndex + 1), detailNode];
    } else {
      // No list page in the path; build the full path
      newNodes = [
        RouterMenu.dashboard.toNode(),
        parentMenu.toNode(),
        detailNode,
      ];
    }

    path.value = newNodes;
    _router?.push(route);
  }

  /// Navigates to a top-level menu page (sidebar click)
  void navigateToMenu(RouterMenu menu, {RouterMenu? parentMenu}) {
    _navigateToMenuNode(menu.toNode().copyWith(parentMenu: parentMenu));
  }

  void navigateToSettings(SettingSection section) {
    _navigateToMenuNode(
      RouterMenu.setting.toNode().copyWith(
        route: SettingRoute(initialSection: section),
      ),
    );
  }

  /// Registers a dirty-state predicate for an active form; returns an
  /// unregister callback to call from `dispose`.
  VoidCallback registerDirtyCheck(bool Function() check) {
    _dirtyChecks.add(check);
    return () => _dirtyChecks.remove(check);
  }

  Future<void> _confirmAndRun(VoidCallback navigate) async {
    _confirmingLeave = true;
    try {
      final confirm = confirmLeave;
      final allowed = confirm == null ? true : await confirm();
      if (allowed) navigate();
    } finally {
      _confirmingLeave = false;
    }
  }

  void _navigateToMenuNode(RouterNode node) {
    _runWithLeaveGuard(() {
      final parentMenu = node.parentMenu;
      // Build the path: dashboard + [parent menu] + current menu
      final List<RouterNode> nodes;
      if (node.menu == RouterMenu.dashboard) {
        nodes = [node];
      } else if (parentMenu != null) {
        nodes = [RouterMenu.dashboard.toNode(), parentMenu.toNode(), node];
      } else {
        nodes = [RouterMenu.dashboard.toNode(), node];
      }

      path.value = nodes;
      _router?.navigate(node.route);
    });
  }

  void _runWithLeaveGuard(VoidCallback navigate) {
    if (!hasUnsavedChanges) {
      navigate();
      return;
    }
    if (_confirmingLeave) return;
    unawaited(_confirmAndRun(navigate));
  }
}
