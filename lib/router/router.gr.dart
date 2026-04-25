// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i19;
import 'package:flutter/material.dart' as _i20;
import 'package:foxy/page/bootstrap/bootstrap_page.dart' as _i2;
import 'package:foxy/page/creature_template/creature_template_detail_page.dart'
    as _i3;
import 'package:foxy/page/creature_template/creature_template_list_page.dart'
    as _i4;
import 'package:foxy/page/dashboard/dashboard_page.dart' as _i5;
import 'package:foxy/page/game_object/game_object_template_detail_page.dart'
    as _i7;
import 'package:foxy/page/game_object/game_object_template_list_page.dart'
    as _i8;
import 'package:foxy/page/gossip_menu/gossip_menu_detail_page.dart' as _i9;
import 'package:foxy/page/gossip_menu/gossip_menu_list_page.dart' as _i10;
import 'package:foxy/page/item/item_template_detail_page.dart' as _i11;
import 'package:foxy/page/item/item_template_list.dart' as _i12;
import 'package:foxy/page/quest/quest_template_detail_page.dart' as _i13;
import 'package:foxy/page/quest/quest_template_list_page.dart' as _i14;
import 'package:foxy/page/scaffold/scaffold_page.dart' as _i15;
import 'package:foxy/page/setting/basic_setting.dart' as _i1;
import 'package:foxy/page/setting/database_setting.dart' as _i6;
import 'package:foxy/page/setting/setting.dart' as _i16;
import 'package:foxy/page/smart_script/smart_script_detail_page.dart' as _i17;
import 'package:foxy/page/smart_script/smart_script_list.dart' as _i18;

/// generated route for
/// [_i1.BasicSettingPage]
class BasicSettingRoute extends _i19.PageRouteInfo<void> {
  const BasicSettingRoute({List<_i19.PageRouteInfo>? children})
    : super(BasicSettingRoute.name, initialChildren: children);

  static const String name = 'BasicSettingRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i1.BasicSettingPage();
    },
  );
}

/// generated route for
/// [_i2.BootstrapPage]
class BootstrapRoute extends _i19.PageRouteInfo<void> {
  const BootstrapRoute({List<_i19.PageRouteInfo>? children})
    : super(BootstrapRoute.name, initialChildren: children);

  static const String name = 'BootstrapRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i2.BootstrapPage();
    },
  );
}

/// generated route for
/// [_i3.CreatureTemplateDetailPage]
class CreatureTemplateDetailRoute
    extends _i19.PageRouteInfo<CreatureTemplateDetailRouteArgs> {
  CreatureTemplateDetailRoute({
    _i20.Key? key,
    int? entry,
    String? name,
    List<_i19.PageRouteInfo>? children,
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

  static _i19.PageInfo page = _i19.PageInfo(
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

  final _i20.Key? key;

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
class CreatureTemplateListRoute extends _i19.PageRouteInfo<void> {
  const CreatureTemplateListRoute({List<_i19.PageRouteInfo>? children})
    : super(CreatureTemplateListRoute.name, initialChildren: children);

  static const String name = 'CreatureTemplateListRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i4.CreatureTemplateListPage();
    },
  );
}

/// generated route for
/// [_i5.DashboardPage]
class DashboardRoute extends _i19.PageRouteInfo<void> {
  const DashboardRoute({List<_i19.PageRouteInfo>? children})
    : super(DashboardRoute.name, initialChildren: children);

  static const String name = 'DashboardRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i5.DashboardPage();
    },
  );
}

/// generated route for
/// [_i6.DatabaseSettingPage]
class DatabaseSettingRoute extends _i19.PageRouteInfo<void> {
  const DatabaseSettingRoute({List<_i19.PageRouteInfo>? children})
    : super(DatabaseSettingRoute.name, initialChildren: children);

  static const String name = 'DatabaseSettingRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i6.DatabaseSettingPage();
    },
  );
}

/// generated route for
/// [_i7.GameObjectTemplateDetailPage]
class GameObjectTemplateDetailRoute
    extends _i19.PageRouteInfo<GameObjectTemplateDetailRouteArgs> {
  GameObjectTemplateDetailRoute({
    _i20.Key? key,
    int? entry,
    String? name,
    List<_i19.PageRouteInfo>? children,
  }) : super(
         GameObjectTemplateDetailRoute.name,
         args: GameObjectTemplateDetailRouteArgs(
           key: key,
           entry: entry,
           name: name,
         ),
         initialChildren: children,
       );

  static const String name = 'GameObjectTemplateDetailRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<GameObjectTemplateDetailRouteArgs>(
        orElse: () => const GameObjectTemplateDetailRouteArgs(),
      );
      return _i7.GameObjectTemplateDetailPage(
        key: args.key,
        entry: args.entry,
        name: args.name,
      );
    },
  );
}

class GameObjectTemplateDetailRouteArgs {
  const GameObjectTemplateDetailRouteArgs({this.key, this.entry, this.name});

  final _i20.Key? key;

  final int? entry;

  final String? name;

  @override
  String toString() {
    return 'GameObjectTemplateDetailRouteArgs{key: $key, entry: $entry, name: $name}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! GameObjectTemplateDetailRouteArgs) return false;
    return key == other.key && entry == other.entry && name == other.name;
  }

  @override
  int get hashCode => key.hashCode ^ entry.hashCode ^ name.hashCode;
}

/// generated route for
/// [_i8.GameObjectTemplateListPage]
class GameObjectTemplateListRoute extends _i19.PageRouteInfo<void> {
  const GameObjectTemplateListRoute({List<_i19.PageRouteInfo>? children})
    : super(GameObjectTemplateListRoute.name, initialChildren: children);

  static const String name = 'GameObjectTemplateListRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i8.GameObjectTemplateListPage();
    },
  );
}

/// generated route for
/// [_i9.GossipMenuDetailPage]
class GossipMenuDetailRoute
    extends _i19.PageRouteInfo<GossipMenuDetailRouteArgs> {
  GossipMenuDetailRoute({
    _i20.Key? key,
    int? menuId,
    int? textId,
    List<_i19.PageRouteInfo>? children,
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

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<GossipMenuDetailRouteArgs>(
        orElse: () => const GossipMenuDetailRouteArgs(),
      );
      return _i9.GossipMenuDetailPage(
        key: args.key,
        menuId: args.menuId,
        textId: args.textId,
      );
    },
  );
}

class GossipMenuDetailRouteArgs {
  const GossipMenuDetailRouteArgs({this.key, this.menuId, this.textId});

  final _i20.Key? key;

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
/// [_i10.GossipMenuListPage]
class GossipMenuListRoute extends _i19.PageRouteInfo<void> {
  const GossipMenuListRoute({List<_i19.PageRouteInfo>? children})
    : super(GossipMenuListRoute.name, initialChildren: children);

  static const String name = 'GossipMenuListRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i10.GossipMenuListPage();
    },
  );
}

/// generated route for
/// [_i11.ItemTemplateDetailPage]
class ItemTemplateDetailRoute
    extends _i19.PageRouteInfo<ItemTemplateDetailRouteArgs> {
  ItemTemplateDetailRoute({
    _i20.Key? key,
    int? entry,
    String? name,
    List<_i19.PageRouteInfo>? children,
  }) : super(
         ItemTemplateDetailRoute.name,
         args: ItemTemplateDetailRouteArgs(key: key, entry: entry, name: name),
         initialChildren: children,
       );

  static const String name = 'ItemTemplateDetailRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ItemTemplateDetailRouteArgs>(
        orElse: () => const ItemTemplateDetailRouteArgs(),
      );
      return _i11.ItemTemplateDetailPage(
        key: args.key,
        entry: args.entry,
        name: args.name,
      );
    },
  );
}

class ItemTemplateDetailRouteArgs {
  const ItemTemplateDetailRouteArgs({this.key, this.entry, this.name});

  final _i20.Key? key;

  final int? entry;

  final String? name;

  @override
  String toString() {
    return 'ItemTemplateDetailRouteArgs{key: $key, entry: $entry, name: $name}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ItemTemplateDetailRouteArgs) return false;
    return key == other.key && entry == other.entry && name == other.name;
  }

  @override
  int get hashCode => key.hashCode ^ entry.hashCode ^ name.hashCode;
}

/// generated route for
/// [_i12.ItemTemplateListPage]
class ItemTemplateListRoute extends _i19.PageRouteInfo<void> {
  const ItemTemplateListRoute({List<_i19.PageRouteInfo>? children})
    : super(ItemTemplateListRoute.name, initialChildren: children);

  static const String name = 'ItemTemplateListRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i12.ItemTemplateListPage();
    },
  );
}

/// generated route for
/// [_i13.QuestTemplateDetailPage]
class QuestTemplateDetailRoute
    extends _i19.PageRouteInfo<QuestTemplateDetailRouteArgs> {
  QuestTemplateDetailRoute({
    _i20.Key? key,
    int? questId,
    String? name,
    List<_i19.PageRouteInfo>? children,
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

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<QuestTemplateDetailRouteArgs>(
        orElse: () => const QuestTemplateDetailRouteArgs(),
      );
      return _i13.QuestTemplateDetailPage(
        key: args.key,
        questId: args.questId,
        name: args.name,
      );
    },
  );
}

class QuestTemplateDetailRouteArgs {
  const QuestTemplateDetailRouteArgs({this.key, this.questId, this.name});

  final _i20.Key? key;

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
/// [_i14.QuestTemplateListPage]
class QuestTemplateListRoute extends _i19.PageRouteInfo<void> {
  const QuestTemplateListRoute({List<_i19.PageRouteInfo>? children})
    : super(QuestTemplateListRoute.name, initialChildren: children);

  static const String name = 'QuestTemplateListRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i14.QuestTemplateListPage();
    },
  );
}

/// generated route for
/// [_i15.ScaffoldPage]
class ScaffoldRoute extends _i19.PageRouteInfo<void> {
  const ScaffoldRoute({List<_i19.PageRouteInfo>? children})
    : super(ScaffoldRoute.name, initialChildren: children);

  static const String name = 'ScaffoldRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i15.ScaffoldPage();
    },
  );
}

/// generated route for
/// [_i16.SettingPage]
class SettingRoute extends _i19.PageRouteInfo<void> {
  const SettingRoute({List<_i19.PageRouteInfo>? children})
    : super(SettingRoute.name, initialChildren: children);

  static const String name = 'SettingRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i16.SettingPage();
    },
  );
}

/// generated route for
/// [_i17.SmartScriptDetailPage]
class SmartScriptDetailRoute
    extends _i19.PageRouteInfo<SmartScriptDetailRouteArgs> {
  SmartScriptDetailRoute({
    _i20.Key? key,
    int? entryOrGuid,
    int? sourceType,
    int? id,
    int? link,
    List<_i19.PageRouteInfo>? children,
  }) : super(
         SmartScriptDetailRoute.name,
         args: SmartScriptDetailRouteArgs(
           key: key,
           entryOrGuid: entryOrGuid,
           sourceType: sourceType,
           id: id,
           link: link,
         ),
         initialChildren: children,
       );

  static const String name = 'SmartScriptDetailRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SmartScriptDetailRouteArgs>(
        orElse: () => const SmartScriptDetailRouteArgs(),
      );
      return _i17.SmartScriptDetailPage(
        key: args.key,
        entryOrGuid: args.entryOrGuid,
        sourceType: args.sourceType,
        id: args.id,
        link: args.link,
      );
    },
  );
}

class SmartScriptDetailRouteArgs {
  const SmartScriptDetailRouteArgs({
    this.key,
    this.entryOrGuid,
    this.sourceType,
    this.id,
    this.link,
  });

  final _i20.Key? key;

  final int? entryOrGuid;

  final int? sourceType;

  final int? id;

  final int? link;

  @override
  String toString() {
    return 'SmartScriptDetailRouteArgs{key: $key, entryOrGuid: $entryOrGuid, sourceType: $sourceType, id: $id, link: $link}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SmartScriptDetailRouteArgs) return false;
    return key == other.key &&
        entryOrGuid == other.entryOrGuid &&
        sourceType == other.sourceType &&
        id == other.id &&
        link == other.link;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      entryOrGuid.hashCode ^
      sourceType.hashCode ^
      id.hashCode ^
      link.hashCode;
}

/// generated route for
/// [_i18.SmartScriptListPage]
class SmartScriptListRoute extends _i19.PageRouteInfo<void> {
  const SmartScriptListRoute({List<_i19.PageRouteInfo>? children})
    : super(SmartScriptListRoute.name, initialChildren: children);

  static const String name = 'SmartScriptListRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i18.SmartScriptListPage();
    },
  );
}
