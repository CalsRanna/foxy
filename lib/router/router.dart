import 'package:flutter/material.dart';
import 'package:foxy/page/creature_template.dart';
import 'package:foxy/page/dashboard/dashboard.dart';
import 'package:foxy/page/loading.dart';
import 'package:foxy/scaffold.dart';
import 'package:go_router/go_router.dart';

part 'router.g.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> shellNavigatorKey = GlobalKey<NavigatorState>();

@TypedShellRoute<ScaffoldRoute>(
  routes: [
    TypedGoRoute<DashboardRoute>(path: '/dashboard'),
    TypedGoRoute<CreatureTemplatesRoute>(path: '/creature-templates'),
  ],
)
class ScaffoldRoute extends ShellRouteData {
  const ScaffoldRoute();

  static final GlobalKey<NavigatorState> $navigatorKey = shellNavigatorKey;

  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) {
    return ScaffoldPage(child: navigator);
  }
}

class DashboardRoute extends GoRouteData {
  const DashboardRoute();

  @override
  Page buildPage(BuildContext context, GoRouterState state) {
    return const NoTransitionPage(child: DashboardPage());
  }
}

class CreatureTemplatesRoute extends GoRouteData {
  const CreatureTemplatesRoute();

  @override
  Page buildPage(BuildContext context, GoRouterState state) {
    return const NoTransitionPage(child: CreatureTemplatesPage());
  }
}

@TypedGoRoute<LoadingRoute>(path: '/loading')
class LoadingRoute extends GoRouteData {
  const LoadingRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const LoadingPage();
  }
}

final router = GoRouter(
  initialLocation: '/loading',
  navigatorKey: rootNavigatorKey,
  routes: $appRoutes,
);
