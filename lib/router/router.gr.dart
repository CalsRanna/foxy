// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i12;
import 'package:flutter/material.dart' as _i13;
import 'package:foxy/page/creature/creature_template.dart' as _i2;
import 'package:foxy/page/creature/creature_template_list.dart' as _i1;
import 'package:foxy/page/dashboard/dashboard.dart' as _i3;
import 'package:foxy/page/game_object/game_object_template_list.dart' as _i4;
import 'package:foxy/page/gossip_menu/gossip_menu_list.dart' as _i5;
import 'package:foxy/page/item/item_template_list.dart' as _i6;
import 'package:foxy/page/loading.dart' as _i7;
import 'package:foxy/page/quest/quest_template_list.dart' as _i8;
import 'package:foxy/page/script_smart/smart_script_list.dart' as _i11;
import 'package:foxy/page/setting/setting.dart' as _i10;
import 'package:foxy/scaffold.dart' as _i9;

/// generated route for
/// [_i1.CreatureTemplateListPage]
class CreatureTemplateListRoute extends _i12.PageRouteInfo<void> {
  const CreatureTemplateListRoute({List<_i12.PageRouteInfo>? children})
      : super(
          CreatureTemplateListRoute.name,
          initialChildren: children,
        );

  static const String name = 'CreatureTemplateListRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i1.CreatureTemplateListPage();
    },
  );
}

/// generated route for
/// [_i2.CreatureTemplatePage]
class CreatureTemplateRoute
    extends _i12.PageRouteInfo<CreatureTemplateRouteArgs> {
  CreatureTemplateRoute({
    required int? entry,
    _i13.Key? key,
    List<_i12.PageRouteInfo>? children,
  }) : super(
          CreatureTemplateRoute.name,
          args: CreatureTemplateRouteArgs(
            entry: entry,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'CreatureTemplateRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CreatureTemplateRouteArgs>();
      return _i2.CreatureTemplatePage(
        args.entry,
        key: args.key,
      );
    },
  );
}

class CreatureTemplateRouteArgs {
  const CreatureTemplateRouteArgs({
    required this.entry,
    this.key,
  });

  final int? entry;

  final _i13.Key? key;

  @override
  String toString() {
    return 'CreatureTemplateRouteArgs{entry: $entry, key: $key}';
  }
}

/// generated route for
/// [_i3.DashboardPage]
class DashboardRoute extends _i12.PageRouteInfo<void> {
  const DashboardRoute({List<_i12.PageRouteInfo>? children})
      : super(
          DashboardRoute.name,
          initialChildren: children,
        );

  static const String name = 'DashboardRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i3.DashboardPage();
    },
  );
}

/// generated route for
/// [_i4.GameObjectTemplateListPage]
class GameObjectTemplateListRoute extends _i12.PageRouteInfo<void> {
  const GameObjectTemplateListRoute({List<_i12.PageRouteInfo>? children})
      : super(
          GameObjectTemplateListRoute.name,
          initialChildren: children,
        );

  static const String name = 'GameObjectTemplateListRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i4.GameObjectTemplateListPage();
    },
  );
}

/// generated route for
/// [_i5.GossipMenuListPage]
class GossipMenuListRoute extends _i12.PageRouteInfo<void> {
  const GossipMenuListRoute({List<_i12.PageRouteInfo>? children})
      : super(
          GossipMenuListRoute.name,
          initialChildren: children,
        );

  static const String name = 'GossipMenuListRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i5.GossipMenuListPage();
    },
  );
}

/// generated route for
/// [_i6.ItemTemplateListPage]
class ItemTemplateListRoute extends _i12.PageRouteInfo<void> {
  const ItemTemplateListRoute({List<_i12.PageRouteInfo>? children})
      : super(
          ItemTemplateListRoute.name,
          initialChildren: children,
        );

  static const String name = 'ItemTemplateListRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i6.ItemTemplateListPage();
    },
  );
}

/// generated route for
/// [_i7.LoadingPage]
class LoadingRoute extends _i12.PageRouteInfo<void> {
  const LoadingRoute({List<_i12.PageRouteInfo>? children})
      : super(
          LoadingRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoadingRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i7.LoadingPage();
    },
  );
}

/// generated route for
/// [_i8.QuestTemplateListPage]
class QuestTemplateListRoute extends _i12.PageRouteInfo<void> {
  const QuestTemplateListRoute({List<_i12.PageRouteInfo>? children})
      : super(
          QuestTemplateListRoute.name,
          initialChildren: children,
        );

  static const String name = 'QuestTemplateListRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i8.QuestTemplateListPage();
    },
  );
}

/// generated route for
/// [_i9.ScaffoldPage]
class ScaffoldRoute extends _i12.PageRouteInfo<void> {
  const ScaffoldRoute({List<_i12.PageRouteInfo>? children})
      : super(
          ScaffoldRoute.name,
          initialChildren: children,
        );

  static const String name = 'ScaffoldRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i9.ScaffoldPage();
    },
  );
}

/// generated route for
/// [_i10.SettingPage]
class SettingRoute extends _i12.PageRouteInfo<void> {
  const SettingRoute({List<_i12.PageRouteInfo>? children})
      : super(
          SettingRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i10.SettingPage();
    },
  );
}

/// generated route for
/// [_i11.SmartScriptListPage]
class SmartScriptListRoute extends _i12.PageRouteInfo<void> {
  const SmartScriptListRoute({List<_i12.PageRouteInfo>? children})
      : super(
          SmartScriptListRoute.name,
          initialChildren: children,
        );

  static const String name = 'SmartScriptListRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i11.SmartScriptListPage();
    },
  );
}
