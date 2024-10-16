import 'package:auto_route/auto_route.dart';
import 'package:foxy/router/router.gr.dart';

final routerConfig = AppRouter().config();

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType {
    return RouteType.custom(
      durationInMilliseconds: 0,
      reverseDurationInMilliseconds: 0,
    );
  }

  @override
  List<AutoRoute> get routes {
    final children = [
      /// Scaffold
      AutoRoute(page: DashboardRoute.page),
      AutoRoute(page: CreatureTemplateListRoute.page),
      AutoRoute(page: ItemTemplateListRoute.page),
      AutoRoute(page: GameObjectTemplateListRoute.page),
      AutoRoute(page: QuestTemplateListRoute.page),
      AutoRoute(page: GossipMenuListRoute.page),
      AutoRoute(page: SmartScriptListRoute.page),
      AutoRoute(page: SettingRoute.page),

      /// Creature Template
      AutoRoute(page: CreatureTemplateRoute.page),
    ];
    return [
      AutoRoute(page: LoadingRoute.page, initial: true),
      AutoRoute(page: ScaffoldRoute.page, children: children),
    ];
  }
}
