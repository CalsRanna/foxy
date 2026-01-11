import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:foxy/router/router_node.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

/// 顶级菜单枚举
enum RouterMenu {
  dashboard(label: '工作台', icon: LucideIcons.layoutDashboard),
  creatureTemplate(label: '生物列表', icon: LucideIcons.pawPrint),
  itemTemplate(label: '物品列表', icon: LucideIcons.swords),
  questTemplate(label: '任务列表', icon: LucideIcons.badgeQuestionMark),
  gameObjectTemplate(label: '游戏对象列表', icon: LucideIcons.mapPin),
  gossipMenu(label: '对话列表', icon: LucideIcons.messageCircle),
  smartScript(label: '内建脚本', icon: LucideIcons.code),
  spell(label: '法术列表', icon: LucideIcons.shell),
  more(label: '更多', icon: LucideIcons.ellipsis),
  setting(label: '设置', icon: LucideIcons.settings);

  final String label;
  final IconData icon;

  const RouterMenu({required this.label, required this.icon});

  /// 获取菜单对应的路由
  PageRouteInfo get route {
    return switch (this) {
      RouterMenu.dashboard => const DashboardRoute(),
      RouterMenu.creatureTemplate => const CreatureTemplateListRoute(),
      RouterMenu.itemTemplate => const ItemTemplateListRoute(),
      RouterMenu.questTemplate => const QuestTemplateListRoute(),
      RouterMenu.gameObjectTemplate => const GameObjectTemplateListRoute(),
      RouterMenu.gossipMenu => const GossipMenuListRoute(),
      RouterMenu.smartScript => const SmartScriptListRoute(),
      RouterMenu.setting => const SettingRoute(),
      // 以下菜单暂未实现路由
      RouterMenu.spell => const DashboardRoute(),
      RouterMenu.more => const DashboardRoute(),
    };
  }

  /// 创建导航节点
  RouterNode toNode() {
    return RouterNode(menu: this, label: label, route: route);
  }
}
