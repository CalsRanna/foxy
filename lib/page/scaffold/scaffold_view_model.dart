import 'package:foxy/router/router_facade.dart';
import 'package:foxy/router/router_menu.dart';
import 'package:foxy/view_model/feature_view_model.dart';
import 'package:get_it/get_it.dart';

class ScaffoldViewModel {
  final routerFacade = GetIt.instance.get<RouterFacade>();
  final featureViewModel = GetIt.instance.get<FeatureViewModel>();

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

  RouterMenu get activeMenu => routerFacade.activeMenu;

  void navigatePage(RouterMenu menu) {
    routerFacade.navigateToMenu(menu);
  }
}
