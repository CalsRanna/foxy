// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:foxy/page/creature/creature_template_list.dart' as _i1;
import 'package:foxy/page/dashboard/dashboard.dart' as _i2;
import 'package:foxy/page/loading.dart' as _i3;
import 'package:foxy/scaffold.dart' as _i4;

/// generated route for
/// [_i1.CreatureTemplateListPage]
class CreatureTemplateListRoute extends _i5.PageRouteInfo<void> {
  const CreatureTemplateListRoute({List<_i5.PageRouteInfo>? children})
      : super(
          CreatureTemplateListRoute.name,
          initialChildren: children,
        );

  static const String name = 'CreatureTemplateListRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i1.CreatureTemplateListPage();
    },
  );
}

/// generated route for
/// [_i2.DashboardPage]
class DashboardRoute extends _i5.PageRouteInfo<void> {
  const DashboardRoute({List<_i5.PageRouteInfo>? children})
      : super(
          DashboardRoute.name,
          initialChildren: children,
        );

  static const String name = 'DashboardRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i2.DashboardPage();
    },
  );
}

/// generated route for
/// [_i3.LoadingPage]
class LoadingRoute extends _i5.PageRouteInfo<void> {
  const LoadingRoute({List<_i5.PageRouteInfo>? children})
      : super(
          LoadingRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoadingRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i3.LoadingPage();
    },
  );
}

/// generated route for
/// [_i4.ScaffoldPage]
class ScaffoldRoute extends _i5.PageRouteInfo<void> {
  const ScaffoldRoute({List<_i5.PageRouteInfo>? children})
      : super(
          ScaffoldRoute.name,
          initialChildren: children,
        );

  static const String name = 'ScaffoldRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i4.ScaffoldPage();
    },
  );
}
