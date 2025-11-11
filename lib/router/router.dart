import 'package:auto_route/auto_route.dart';
import 'package:foxy/router/router.gr.dart';

@AutoRouterConfig()
class FoxyRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType {
    return RouteType.custom(
      duration: Duration.zero,
      reverseDuration: Duration.zero,
    );
  }

  @override
  List<AutoRoute> get routes {
    final settingChildren = [AutoRoute(page: BasicSettingRoute.page)];
    final children = [
      /// Scaffold
      AutoRoute(page: DashboardRoute.page),
      AutoRoute(page: CreatureTemplateListRoute.page),
      AutoRoute(page: ItemTemplateListRoute.page),
      AutoRoute(page: GameObjectTemplateListRoute.page),
      AutoRoute(page: QuestTemplateListRoute.page),
      AutoRoute(page: GossipMenuListRoute.page),
      AutoRoute(page: SmartScriptListRoute.page),
      AutoRoute(page: SettingRoute.page, children: settingChildren),

      /// Creature Template
      AutoRoute(page: CreatureTemplateDetailRoute.page),
    ];
    return [
      AutoRoute(page: BootstrapRoute.page, initial: true),
      AutoRoute(page: ScaffoldRoute.page, children: children),
    ];
  }
}

final router = FoxyRouter();
