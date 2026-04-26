import 'package:foxy/router/router_facade.dart';
import 'package:foxy/router/router_menu.dart';
import 'package:foxy/view_model/feature_view_model.dart';
import 'package:get_it/get_it.dart';

class ScaffoldViewModel {
  final routerFacade = GetIt.instance.get<RouterFacade>();
  final featureViewModel = GetIt.instance.get<FeatureViewModel>();

  /// 侧边栏显示的菜单列表（动态拼装：工作台 + 已固定的功能 + 更多 + 设置）
  List<RouterMenu> get menus {
    final pinnedRouterMenus = featureViewModel.pinnedFeatures.map((f) {
      return RouterMenu.values.byName(f.routerMenu);
    }).toList();

    return [
      RouterMenu.dashboard,
      ...pinnedRouterMenus,
      RouterMenu.more,
      RouterMenu.setting,
    ];
  }

  /// 获取当前激活的菜单（用于侧边栏高亮）
  RouterMenu get activeMenu => routerFacade.activeMenu;

  /// 侧边栏点击导航
  void navigatePage(RouterMenu menu) {
    routerFacade.navigateToMenu(menu);
  }
}
