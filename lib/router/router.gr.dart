// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i13;
import 'package:flutter/material.dart' as _i14;
import 'package:foxy/page/bootstrap/bootstrap_page.dart' as _i2;
import 'package:foxy/page/creature/creature_template.dart' as _i4;
import 'package:foxy/page/creature/creature_template_list.dart' as _i3;
import 'package:foxy/page/dashboard/dashboard.dart' as _i5;
import 'package:foxy/page/game_object/game_object_template_list.dart' as _i6;
import 'package:foxy/page/gossip_menu/gossip_menu_list.dart' as _i7;
import 'package:foxy/page/item/item_template_list.dart' as _i8;
import 'package:foxy/page/quest/quest_template_list.dart' as _i9;
import 'package:foxy/page/scaffold/scaffold.dart' as _i10;
import 'package:foxy/page/setting/basic_setting.dart' as _i1;
import 'package:foxy/page/setting/setting.dart' as _i11;
import 'package:foxy/page/smart_script/smart_script_list.dart' as _i12;

/// generated route for
/// [_i1.BasicSettingPage]
class BasicSettingRoute extends _i13.PageRouteInfo<void> {
  const BasicSettingRoute({List<_i13.PageRouteInfo>? children})
      : super(
          BasicSettingRoute.name,
          initialChildren: children,
        );

  static const String name = 'BasicSettingRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i1.BasicSettingPage();
    },
  );
}

/// generated route for
/// [_i2.BootstrapPage]
class BootstrapRoute extends _i13.PageRouteInfo<void> {
  const BootstrapRoute({List<_i13.PageRouteInfo>? children})
      : super(
          BootstrapRoute.name,
          initialChildren: children,
        );

  static const String name = 'BootstrapRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i2.BootstrapPage();
    },
  );
}

/// generated route for
/// [_i3.CreatureTemplateListPage]
class CreatureTemplateListRoute extends _i13.PageRouteInfo<void> {
  const CreatureTemplateListRoute({List<_i13.PageRouteInfo>? children})
      : super(
          CreatureTemplateListRoute.name,
          initialChildren: children,
        );

  static const String name = 'CreatureTemplateListRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i3.CreatureTemplateListPage();
    },
  );
}

/// generated route for
/// [_i4.CreatureTemplatePage]
class CreatureTemplateRoute
    extends _i13.PageRouteInfo<CreatureTemplateRouteArgs> {
  CreatureTemplateRoute({
    _i14.Key? key,
    int? entry,
    List<_i13.PageRouteInfo>? children,
  }) : super(
          CreatureTemplateRoute.name,
          args: CreatureTemplateRouteArgs(
            key: key,
            entry: entry,
          ),
          initialChildren: children,
        );

  static const String name = 'CreatureTemplateRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CreatureTemplateRouteArgs>(
          orElse: () => const CreatureTemplateRouteArgs());
      return _i4.CreatureTemplatePage(
        key: args.key,
        entry: args.entry,
      );
    },
  );
}

class CreatureTemplateRouteArgs {
  const CreatureTemplateRouteArgs({
    this.key,
    this.entry,
  });

  final _i14.Key? key;

  final int? entry;

  @override
  String toString() {
    return 'CreatureTemplateRouteArgs{key: $key, entry: $entry}';
  }
}

/// generated route for
/// [_i5.DashboardPage]
class DashboardRoute extends _i13.PageRouteInfo<void> {
  const DashboardRoute({List<_i13.PageRouteInfo>? children})
      : super(
          DashboardRoute.name,
          initialChildren: children,
        );

  static const String name = 'DashboardRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i5.DashboardPage();
    },
  );
}

/// generated route for
/// [_i6.GameObjectTemplateListPage]
class GameObjectTemplateListRoute extends _i13.PageRouteInfo<void> {
  const GameObjectTemplateListRoute({List<_i13.PageRouteInfo>? children})
      : super(
          GameObjectTemplateListRoute.name,
          initialChildren: children,
        );

  static const String name = 'GameObjectTemplateListRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i6.GameObjectTemplateListPage();
    },
  );
}

/// generated route for
/// [_i7.GossipMenuListPage]
class GossipMenuListRoute extends _i13.PageRouteInfo<void> {
  const GossipMenuListRoute({List<_i13.PageRouteInfo>? children})
      : super(
          GossipMenuListRoute.name,
          initialChildren: children,
        );

  static const String name = 'GossipMenuListRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i7.GossipMenuListPage();
    },
  );
}

/// generated route for
/// [_i8.ItemTemplateListPage]
class ItemTemplateListRoute extends _i13.PageRouteInfo<void> {
  const ItemTemplateListRoute({List<_i13.PageRouteInfo>? children})
      : super(
          ItemTemplateListRoute.name,
          initialChildren: children,
        );

  static const String name = 'ItemTemplateListRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i8.ItemTemplateListPage();
    },
  );
}

/// generated route for
/// [_i9.QuestTemplateListPage]
class QuestTemplateListRoute extends _i13.PageRouteInfo<void> {
  const QuestTemplateListRoute({List<_i13.PageRouteInfo>? children})
      : super(
          QuestTemplateListRoute.name,
          initialChildren: children,
        );

  static const String name = 'QuestTemplateListRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i9.QuestTemplateListPage();
    },
  );
}

/// generated route for
/// [_i10.ScaffoldPage]
class ScaffoldRoute extends _i13.PageRouteInfo<void> {
  const ScaffoldRoute({List<_i13.PageRouteInfo>? children})
      : super(
          ScaffoldRoute.name,
          initialChildren: children,
        );

  static const String name = 'ScaffoldRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i10.ScaffoldPage();
    },
  );
}

/// generated route for
/// [_i11.SettingPage]
class SettingRoute extends _i13.PageRouteInfo<void> {
  const SettingRoute({List<_i13.PageRouteInfo>? children})
      : super(
          SettingRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i11.SettingPage();
    },
  );
}

/// generated route for
/// [_i12.SmartScriptListPage]
class SmartScriptListRoute extends _i13.PageRouteInfo<void> {
  const SmartScriptListRoute({List<_i13.PageRouteInfo>? children})
      : super(
          SmartScriptListRoute.name,
          initialChildren: children,
        );

  static const String name = 'SmartScriptListRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i12.SmartScriptListPage();
    },
  );
}
