// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $scaffoldRoute,
      $loadingRoute,
    ];

RouteBase get $scaffoldRoute => ShellRouteData.$route(
      navigatorKey: ScaffoldRoute.$navigatorKey,
      factory: $ScaffoldRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: '/dashboard',
          factory: $DashboardRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: '/creature-templates',
          factory: $CreatureTemplatesRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: '/setting',
          factory: $SettingRouteExtension._fromState,
        ),
      ],
    );

extension $ScaffoldRouteExtension on ScaffoldRoute {
  static ScaffoldRoute _fromState(GoRouterState state) => const ScaffoldRoute();
}

extension $DashboardRouteExtension on DashboardRoute {
  static DashboardRoute _fromState(GoRouterState state) =>
      const DashboardRoute();

  String get location => GoRouteData.$location(
        '/dashboard',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $CreatureTemplatesRouteExtension on CreatureTemplatesRoute {
  static CreatureTemplatesRoute _fromState(GoRouterState state) =>
      const CreatureTemplatesRoute();

  String get location => GoRouteData.$location(
        '/creature-templates',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $SettingRouteExtension on SettingRoute {
  static SettingRoute _fromState(GoRouterState state) => const SettingRoute();

  String get location => GoRouteData.$location(
        '/setting',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $loadingRoute => GoRouteData.$route(
      path: '/loading',
      factory: $LoadingRouteExtension._fromState,
    );

extension $LoadingRouteExtension on LoadingRoute {
  static LoadingRoute _fromState(GoRouterState state) => const LoadingRoute();

  String get location => GoRouteData.$location(
        '/loading',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
