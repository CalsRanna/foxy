import 'package:foxy/router/router_facade.dart';
import 'package:foxy/router/router_menu.dart';
import 'package:get_it/get_it.dart';

class ScaffoldViewModel {
  final routerFacade = GetIt.instance.get<RouterFacade>();

  /// 侧边栏显示的菜单列表
  final menus = [
    RouterMenu.dashboard,
    RouterMenu.creatureTemplate,
    RouterMenu.itemTemplate,
    RouterMenu.questTemplate,
    RouterMenu.spell,
    RouterMenu.more,
    RouterMenu.setting,
  ];

  /// 获取当前激活的菜单（用于侧边栏高亮）
  RouterMenu get activeMenu => routerFacade.activeMenu;

  /// 侧边栏点击导航
  void navigatePage(RouterMenu menu) {
    routerFacade.navigateToMenu(menu);
  }
}
