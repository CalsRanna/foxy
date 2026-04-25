// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i16;
import 'package:flutter/material.dart' as _i17;
import 'package:foxy/page/bootstrap/bootstrap_page.dart' as _i2;
import 'package:foxy/page/creature_template/creature_template_detail_page.dart'
    as _i3;
import 'package:foxy/page/creature_template/creature_template_list_page.dart'
    as _i4;
import 'package:foxy/page/dashboard/dashboard_page.dart' as _i5;
import 'package:foxy/page/game_object/game_object_template_list.dart' as _i7;
import 'package:foxy/page/gossip_menu/gossip_menu_detail_page.dart' as _i8;
import 'package:foxy/page/gossip_menu/gossip_menu_list_page.dart' as _i9;
import 'package:foxy/page/item/item_template_list.dart' as _i10;
import 'package:foxy/page/quest/quest_template_detail_page.dart' as _i11;
import 'package:foxy/page/quest/quest_template_list_page.dart' as _i12;
import 'package:foxy/page/scaffold/scaffold_page.dart' as _i13;
import 'package:foxy/page/setting/basic_setting.dart' as _i1;
import 'package:foxy/page/setting/database_setting.dart' as _i6;
import 'package:foxy/page/setting/setting.dart' as _i14;
import 'package:foxy/page/smart_script/smart_script_list.dart' as _i15;

/// generated route for
/// [_i1.BasicSettingPage]
class BasicSettingRoute extends _i16.PageRouteInfo<void> {
  const BasicSettingRoute({List<_i16.PageRouteInfo>? children})
    : super(BasicSettingRoute.name, initialChildren: children);

  static const String name = 'BasicSettingRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i1.BasicSettingPage();
    },
  );
}

/// generated route for
/// [_i2.BootstrapPage]
class BootstrapRoute extends _i16.PageRouteInfo<void> {
  const BootstrapRoute({List<_i16.PageRouteInfo>? children})
    : super(BootstrapRoute.name, initialChildren: children);

  static const String name = 'BootstrapRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i2.BootstrapPage();
    },
  );
}

/// generated route for
/// [_i3.CreatureTemplateDetailPage]
class CreatureTemplateDetailRoute
    extends _i16.PageRouteInfo<CreatureTemplateDetailRouteArgs> {
  CreatureTemplateDetailRoute({
    _i17.Key? key,
    int? entry,
    String? name,
    List<_i16.PageRouteInfo>? children,
  }) : super(
         CreatureTemplateDetailRoute.name,
         args: CreatureTemplateDetailRouteArgs(
           key: key,
           entry: entry,
           name: name,
         ),
         initialChildren: children,
       );

  static const String name = 'CreatureTemplateDetailRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CreatureTemplateDetailRouteArgs>(
        orElse: () => const CreatureTemplateDetailRouteArgs(),
      );
      return _i3.CreatureTemplateDetailPage(
        key: args.key,
        entry: args.entry,
        name: args.name,
      );
    },
  );
}

class CreatureTemplateDetailRouteArgs {
  const CreatureTemplateDetailRouteArgs({this.key, this.entry, this.name});

  final _i17.Key? key;

  final int? entry;

  final String? name;

  @override
  String toString() {
    return 'CreatureTemplateDetailRouteArgs{key: $key, entry: $entry, name: $name}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CreatureTemplateDetailRouteArgs) return false;
    return key == other.key && entry == other.entry && name == other.name;
  }

  @override
  int get hashCode => key.hashCode ^ entry.hashCode ^ name.hashCode;
}

/// generated route for
/// [_i4.CreatureTemplateListPage]
class CreatureTemplateListRoute extends _i16.PageRouteInfo<void> {
  const CreatureTemplateListRoute({List<_i16.PageRouteInfo>? children})
    : super(CreatureTemplateListRoute.name, initialChildren: children);

  static const String name = 'CreatureTemplateListRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i4.CreatureTemplateListPage();
    },
  );
}

/// generated route for
/// [_i5.DashboardPage]
class DashboardRoute extends _i16.PageRouteInfo<void> {
  const DashboardRoute({List<_i16.PageRouteInfo>? children})
    : super(DashboardRoute.name, initialChildren: children);

  static const String name = 'DashboardRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i5.DashboardPage();
    },
  );
}

/// generated route for
/// [_i6.DatabaseSettingPage]
class DatabaseSettingRoute extends _i16.PageRouteInfo<void> {
  const DatabaseSettingRoute({List<_i16.PageRouteInfo>? children})
    : super(DatabaseSettingRoute.name, initialChildren: children);

  static const String name = 'DatabaseSettingRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i6.DatabaseSettingPage();
    },
  );
}

/// generated route for
/// [_i7.GameObjectTemplateListPage]
class GameObjectTemplateListRoute extends _i16.PageRouteInfo<void> {
  const GameObjectTemplateListRoute({List<_i16.PageRouteInfo>? children})
    : super(GameObjectTemplateListRoute.name, initialChildren: children);

  static const String name = 'GameObjectTemplateListRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i7.GameObjectTemplateListPage();
    },
  );
}

/// generated route for
/// [_i8.GossipMenuDetailPage]
class GossipMenuDetailRoute
    extends _i16.PageRouteInfo<GossipMenuDetailRouteArgs> {
  GossipMenuDetailRoute({
    _i17.Key? key,
    int? menuId,
    int? textId,
    List<_i16.PageRouteInfo>? children,
  }) : super(
         GossipMenuDetailRoute.name,
         args: GossipMenuDetailRouteArgs(
           key: key,
           menuId: menuId,
           textId: textId,
         ),
         initialChildren: children,
       );

  static const String name = 'GossipMenuDetailRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<GossipMenuDetailRouteArgs>(
        orElse: () => const GossipMenuDetailRouteArgs(),
      );
      return _i8.GossipMenuDetailPage(
        key: args.key,
        menuId: args.menuId,
        textId: args.textId,
      );
    },
  );
}

class GossipMenuDetailRouteArgs {
  const GossipMenuDetailRouteArgs({this.key, this.menuId, this.textId});

  final _i17.Key? key;

  final int? menuId;

  final int? textId;

  @override
  String toString() {
    return 'GossipMenuDetailRouteArgs{key: $key, menuId: $menuId, textId: $textId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! GossipMenuDetailRouteArgs) return false;
    return key == other.key && menuId == other.menuId && textId == other.textId;
  }

  @override
  int get hashCode => key.hashCode ^ menuId.hashCode ^ textId.hashCode;
}

/// generated route for
/// [_i9.GossipMenuListPage]
class GossipMenuListRoute extends _i16.PageRouteInfo<void> {
  const GossipMenuListRoute({List<_i16.PageRouteInfo>? children})
    : super(GossipMenuListRoute.name, initialChildren: children);

  static const String name = 'GossipMenuListRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i9.GossipMenuListPage();
    },
  );
}

/// generated route for
/// [_i10.ItemTemplateListPage]
class ItemTemplateListRoute extends _i16.PageRouteInfo<void> {
  const ItemTemplateListRoute({List<_i16.PageRouteInfo>? children})
    : super(ItemTemplateListRoute.name, initialChildren: children);

  static const String name = 'ItemTemplateListRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i10.ItemTemplateListPage();
    },
  );
}

/// generated route for
/// [_i11.QuestTemplateDetailPage]
class QuestTemplateDetailRoute
    extends _i16.PageRouteInfo<QuestTemplateDetailRouteArgs> {
  QuestTemplateDetailRoute({
    _i17.Key? key,
    int? questId,
    String? name,
    List<_i16.PageRouteInfo>? children,
  }) : super(
         QuestTemplateDetailRoute.name,
         args: QuestTemplateDetailRouteArgs(
           key: key,
           questId: questId,
           name: name,
         ),
         initialChildren: children,
       );

  static const String name = 'QuestTemplateDetailRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<QuestTemplateDetailRouteArgs>(
        orElse: () => const QuestTemplateDetailRouteArgs(),
      );
      return _i11.QuestTemplateDetailPage(
        key: args.key,
        questId: args.questId,
        name: args.name,
      );
    },
  );
}

class QuestTemplateDetailRouteArgs {
  const QuestTemplateDetailRouteArgs({this.key, this.questId, this.name});

  final _i17.Key? key;

  final int? questId;

  final String? name;

  @override
  String toString() {
    return 'QuestTemplateDetailRouteArgs{key: $key, questId: $questId, name: $name}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! QuestTemplateDetailRouteArgs) return false;
    return key == other.key && questId == other.questId && name == other.name;
  }

  @override
  int get hashCode => key.hashCode ^ questId.hashCode ^ name.hashCode;
}

/// generated route for
/// [_i12.QuestTemplateListPage]
class QuestTemplateListRoute extends _i16.PageRouteInfo<void> {
  const QuestTemplateListRoute({List<_i16.PageRouteInfo>? children})
    : super(QuestTemplateListRoute.name, initialChildren: children);

  static const String name = 'QuestTemplateListRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i12.QuestTemplateListPage();
    },
  );
}

/// generated route for
/// [_i13.ScaffoldPage]
class ScaffoldRoute extends _i16.PageRouteInfo<void> {
  const ScaffoldRoute({List<_i16.PageRouteInfo>? children})
    : super(ScaffoldRoute.name, initialChildren: children);

  static const String name = 'ScaffoldRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i13.ScaffoldPage();
    },
  );
}

/// generated route for
/// [_i14.SettingPage]
class SettingRoute extends _i16.PageRouteInfo<void> {
  const SettingRoute({List<_i16.PageRouteInfo>? children})
    : super(SettingRoute.name, initialChildren: children);

  static const String name = 'SettingRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i14.SettingPage();
    },
  );
}

/// generated route for
/// [_i15.SmartScriptListPage]
class SmartScriptListRoute extends _i16.PageRouteInfo<void> {
  const SmartScriptListRoute({List<_i16.PageRouteInfo>? children})
    : super(SmartScriptListRoute.name, initialChildren: children);

  static const String name = 'SmartScriptListRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i15.SmartScriptListPage();
    },
  );
}
