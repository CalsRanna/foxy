import 'package:flutter/widgets.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:signals/signals.dart';

class ScaffoldViewModel {
  final menus = [
    'dashboard',
    'creatureTemplate',
    'itemTemplate',
    'questTemplate',
    'spell',
    'more',
    'setting',
  ];
  final localPages = signal({
    'dashboard': '工作台',
    'creatureTemplate': '生物列表',
    'itemTemplate': '物品列表',
    'questTemplate': '任务列表',
    'spell': '法术列表',
    'more': '更多',
    'setting': '设置',
  });

  final pages = signal(['dashboard']);

  IconData getIcon(String menu) {
    return switch (menu) {
      'dashboard' => HugeIcons.strokeRoundedDashboardCircle,
      'creatureTemplate' => HugeIcons.strokeRoundedUserMultiple,
      'itemTemplate' => HugeIcons.strokeRoundedBodyArmor,
      'questTemplate' => HugeIcons.strokeRoundedCursorInfo01,
      'spell' => HugeIcons.strokeRoundedSolarSystem,
      'more' => HugeIcons.strokeRoundedMoreHorizontal,
      'setting' => HugeIcons.strokeRoundedSettings01,
      _ => HugeIcons.strokeRoundedDashboardCircle,
    };
  }

  void navigatePage(BuildContext context, String menu) {
    var route = switch (menu) {
      'dashboard' => const DashboardRoute(),
      'creatureTemplate' => const CreatureTemplateListRoute(),
      'itemTemplate' => const ItemTemplateListRoute(),
      'questTemplate' => const QuestTemplateListRoute(),
      // 'spell' => const SpellListRoute(),
      // 'more' => const MoreRoute(),
      'setting' => const SettingRoute(),
      _ => const DashboardRoute(),
    };
    route.navigate(context);
    pages.value = ['dashboard', if (menu != 'dashboard') menu];
  }

  void updateLocalPages(String page, String localPage) {
    if (localPages.value.containsKey(page)) return;
    localPages.value.putIfAbsent(page, () => localPage);
    localPages.value = {...localPages.value};
  }
}
