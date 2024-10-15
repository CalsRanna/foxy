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
      AutoRoute(page: DashboardRoute.page),
      AutoRoute(page: CreatureTemplateListRoute.page),
    ];
    return [
      AutoRoute(page: LoadingRoute.page, initial: true),
      AutoRoute(page: ScaffoldRoute.page, children: children),
    ];
  }
}
