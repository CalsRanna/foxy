import 'package:flutter/widgets.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/router/router_menu.dart';
import 'package:get_it/get_it.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:signals/signals.dart';

class MoreViewModel {
  final routerFacade = GetIt.instance.get<RouterFacade>();

  final searchController = TextEditingController();
  final filteredModules = signal(<ModuleItem>[]);

  final List<ModuleItem> _allModules = [
    ModuleItem(
      icon: LucideIcons.pawPrint,
      name: '生物',
      description: '所有生物的相关数据,包含NPC和怪物。',
      menu: RouterMenu.creatureTemplate,
      category: ModuleCategory.database,
    ),
    ModuleItem(
      icon: LucideIcons.swords,
      name: '物品',
      description: '包含装备，物品信息。',
      menu: RouterMenu.itemTemplate,
      category: ModuleCategory.database,
    ),
    ModuleItem(
      icon: LucideIcons.badgeQuestionMark,
      name: '任务',
      description: '任务模板及其它关联的数据，比如奖励，任务对话等等。',
      menu: RouterMenu.questTemplate,
      category: ModuleCategory.database,
    ),
    ModuleItem(
      icon: LucideIcons.mapPin,
      name: '游戏对象',
      description: '所有可交互的物体，比如陷阱，宝箱等等。',
      menu: RouterMenu.gameObjectTemplate,
      parentMenu: RouterMenu.more,
      category: ModuleCategory.database,
    ),
    ModuleItem(
      icon: LucideIcons.messageCircle,
      name: '对话',
      description: '和NPC交谈时，对话框中的面板内容及对话选项。',
      menu: RouterMenu.gossipMenu,
      parentMenu: RouterMenu.more,
      category: ModuleCategory.database,
    ),
    ModuleItem(
      icon: LucideIcons.code,
      name: '内建脚本',
      description: '主要是一些简单的脚本，不需要复杂的代码逻辑。',
      menu: RouterMenu.smartScript,
      parentMenu: RouterMenu.more,
      category: ModuleCategory.database,
    ),
    ModuleItem(
      icon: LucideIcons.shell,
      name: '法术',
      description: '角色拥有的法术技能。',
      menu: RouterMenu.spell,
      category: ModuleCategory.dbc,
    ),
  ];

  void initSignals() {
    filteredModules.value = List.of(_allModules);
  }

  void search() {
    final query = searchController.text.trim().toLowerCase();
    if (query.isEmpty) {
      filteredModules.value = List.of(_allModules);
    } else {
      filteredModules.value = _allModules
          .where((m) => m.name.toLowerCase().contains(query))
          .toList();
    }
  }

  void reset() {
    searchController.clear();
    filteredModules.value = List.of(_allModules);
  }

  void navigateToModule(ModuleItem module) {
    routerFacade.navigateToMenu(module.menu, parentMenu: module.parentMenu);
  }

  void dispose() {
    searchController.dispose();
  }
}

enum ModuleCategory { database, dbc }

class ModuleItem {
  final IconData icon;
  final String name;
  final String description;
  final RouterMenu menu;
  final RouterMenu? parentMenu;
  final ModuleCategory category;

  const ModuleItem({
    required this.icon,
    required this.name,
    required this.description,
    required this.menu,
    this.parentMenu,
    this.category = ModuleCategory.database,
  });
}
