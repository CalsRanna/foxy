// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i30;
import 'package:collection/collection.dart' as _i32;
import 'package:flutter/material.dart' as _i31;
import 'package:foxy/page/bootstrap/bootstrap_page.dart' as _i2;
import 'package:foxy/page/condition/condition_detail_page.dart' as _i3;
import 'package:foxy/page/condition/condition_list_page.dart' as _i4;
import 'package:foxy/page/creature_template/creature_template_detail_page.dart'
    as _i5;
import 'package:foxy/page/creature_template/creature_template_list_page.dart'
    as _i6;
import 'package:foxy/page/dashboard/dashboard_page.dart' as _i7;
import 'package:foxy/page/game_object/game_object_template_detail_page.dart'
    as _i9;
import 'package:foxy/page/game_object/game_object_template_list_page.dart'
    as _i10;
import 'package:foxy/page/gossip_menu/gossip_menu_detail_page.dart' as _i11;
import 'package:foxy/page/gossip_menu/gossip_menu_list_page.dart' as _i12;
import 'package:foxy/page/item/item_template_detail_page.dart' as _i13;
import 'package:foxy/page/item/item_template_list_page.dart' as _i14;
import 'package:foxy/page/more/more_page.dart' as _i15;
import 'package:foxy/page/page_text/page_text_detail_page.dart' as _i28;
import 'package:foxy/page/page_text/page_text_list_page.dart' as _i29;
import 'package:foxy/page/player_create_info/player_create_info_detail_page.dart'
    as _i16;
import 'package:foxy/page/player_create_info/player_create_info_list_page.dart'
    as _i17;
import 'package:foxy/page/quest/quest_template_detail_page.dart' as _i18;
import 'package:foxy/page/quest/quest_template_list_page.dart' as _i19;
import 'package:foxy/page/reference_loot_template/reference_loot_template_detail_page.dart'
    as _i20;
import 'package:foxy/page/reference_loot_template/reference_loot_template_list_page.dart'
    as _i21;
import 'package:foxy/page/scaffold/scaffold_page.dart' as _i22;
import 'package:foxy/page/setting/basic_setting.dart' as _i1;
import 'package:foxy/page/setting/database_setting.dart' as _i8;
import 'package:foxy/page/setting/setting_page.dart' as _i23;
import 'package:foxy/page/smart_script/smart_script_detail_page.dart' as _i24;
import 'package:foxy/page/smart_script/smart_script_list_page.dart' as _i25;
import 'package:foxy/page/spell/spell_detail_page.dart' as _i26;
import 'package:foxy/page/spell/spell_list_page.dart' as _i27;

/// generated route for
/// [_i1.BasicSettingPage]
class BasicSettingRoute extends _i30.PageRouteInfo<void> {
  const BasicSettingRoute({List<_i30.PageRouteInfo>? children})
    : super(BasicSettingRoute.name, initialChildren: children);

  static const String name = 'BasicSettingRoute';

  static _i30.PageInfo page = _i30.PageInfo(
    name,
    builder: (data) {
      return const _i1.BasicSettingPage();
    },
  );
}

/// generated route for
/// [_i2.BootstrapPage]
class BootstrapRoute extends _i30.PageRouteInfo<void> {
  const BootstrapRoute({List<_i30.PageRouteInfo>? children})
    : super(BootstrapRoute.name, initialChildren: children);

  static const String name = 'BootstrapRoute';

  static _i30.PageInfo page = _i30.PageInfo(
    name,
    builder: (data) {
      return const _i2.BootstrapPage();
    },
  );
}

/// generated route for
/// [_i3.ConditionDetailPage]
class ConditionDetailRoute
    extends _i30.PageRouteInfo<ConditionDetailRouteArgs> {
  ConditionDetailRoute({
    _i31.Key? key,
    Map<String, dynamic>? credential,
    List<_i30.PageRouteInfo>? children,
  }) : super(
         ConditionDetailRoute.name,
         args: ConditionDetailRouteArgs(key: key, credential: credential),
         initialChildren: children,
       );

  static const String name = 'ConditionDetailRoute';

  static _i30.PageInfo page = _i30.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ConditionDetailRouteArgs>(
        orElse: () => const ConditionDetailRouteArgs(),
      );
      return _i3.ConditionDetailPage(
        key: args.key,
        credential: args.credential,
      );
    },
  );
}

class ConditionDetailRouteArgs {
  const ConditionDetailRouteArgs({this.key, this.credential});

  final _i31.Key? key;

  final Map<String, dynamic>? credential;

  @override
  String toString() {
    return 'ConditionDetailRouteArgs{key: $key, credential: $credential}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ConditionDetailRouteArgs) return false;
    return key == other.key &&
        const _i32.MapEquality<String, dynamic>().equals(
          credential,
          other.credential,
        );
  }

  @override
  int get hashCode =>
      key.hashCode ^ const _i32.MapEquality<String, dynamic>().hash(credential);
}

/// generated route for
/// [_i4.ConditionListPage]
class ConditionListRoute extends _i30.PageRouteInfo<void> {
  const ConditionListRoute({List<_i30.PageRouteInfo>? children})
    : super(ConditionListRoute.name, initialChildren: children);

  static const String name = 'ConditionListRoute';

  static _i30.PageInfo page = _i30.PageInfo(
    name,
    builder: (data) {
      return const _i4.ConditionListPage();
    },
  );
}

/// generated route for
/// [_i5.CreatureTemplateDetailPage]
class CreatureTemplateDetailRoute
    extends _i30.PageRouteInfo<CreatureTemplateDetailRouteArgs> {
  CreatureTemplateDetailRoute({
    _i31.Key? key,
    int? entry,
    String? name,
    List<_i30.PageRouteInfo>? children,
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

  static _i30.PageInfo page = _i30.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CreatureTemplateDetailRouteArgs>(
        orElse: () => const CreatureTemplateDetailRouteArgs(),
      );
      return _i5.CreatureTemplateDetailPage(
        key: args.key,
        entry: args.entry,
        name: args.name,
      );
    },
  );
}

class CreatureTemplateDetailRouteArgs {
  const CreatureTemplateDetailRouteArgs({this.key, this.entry, this.name});

  final _i31.Key? key;

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
/// [_i6.CreatureTemplateListPage]
class CreatureTemplateListRoute extends _i30.PageRouteInfo<void> {
  const CreatureTemplateListRoute({List<_i30.PageRouteInfo>? children})
    : super(CreatureTemplateListRoute.name, initialChildren: children);

  static const String name = 'CreatureTemplateListRoute';

  static _i30.PageInfo page = _i30.PageInfo(
    name,
    builder: (data) {
      return const _i6.CreatureTemplateListPage();
    },
  );
}

/// generated route for
/// [_i7.DashboardPage]
class DashboardRoute extends _i30.PageRouteInfo<void> {
  const DashboardRoute({List<_i30.PageRouteInfo>? children})
    : super(DashboardRoute.name, initialChildren: children);

  static const String name = 'DashboardRoute';

  static _i30.PageInfo page = _i30.PageInfo(
    name,
    builder: (data) {
      return const _i7.DashboardPage();
    },
  );
}

/// generated route for
/// [_i8.DatabaseSettingPage]
class DatabaseSettingRoute extends _i30.PageRouteInfo<void> {
  const DatabaseSettingRoute({List<_i30.PageRouteInfo>? children})
    : super(DatabaseSettingRoute.name, initialChildren: children);

  static const String name = 'DatabaseSettingRoute';

  static _i30.PageInfo page = _i30.PageInfo(
    name,
    builder: (data) {
      return const _i8.DatabaseSettingPage();
    },
  );
}

/// generated route for
/// [_i9.GameObjectTemplateDetailPage]
class GameObjectTemplateDetailRoute
    extends _i30.PageRouteInfo<GameObjectTemplateDetailRouteArgs> {
  GameObjectTemplateDetailRoute({
    _i31.Key? key,
    int? entry,
    String? name,
    List<_i30.PageRouteInfo>? children,
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

  static _i30.PageInfo page = _i30.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<GameObjectTemplateDetailRouteArgs>(
        orElse: () => const GameObjectTemplateDetailRouteArgs(),
      );
      return _i9.GameObjectTemplateDetailPage(
        key: args.key,
        entry: args.entry,
        name: args.name,
      );
    },
  );
}

class GameObjectTemplateDetailRouteArgs {
  const GameObjectTemplateDetailRouteArgs({this.key, this.entry, this.name});

  final _i31.Key? key;

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
/// [_i10.GameObjectTemplateListPage]
class GameObjectTemplateListRoute extends _i30.PageRouteInfo<void> {
  const GameObjectTemplateListRoute({List<_i30.PageRouteInfo>? children})
    : super(GameObjectTemplateListRoute.name, initialChildren: children);

  static const String name = 'GameObjectTemplateListRoute';

  static _i30.PageInfo page = _i30.PageInfo(
    name,
    builder: (data) {
      return const _i10.GameObjectTemplateListPage();
    },
  );
}

/// generated route for
/// [_i11.GossipMenuDetailPage]
class GossipMenuDetailRoute
    extends _i30.PageRouteInfo<GossipMenuDetailRouteArgs> {
  GossipMenuDetailRoute({
    _i31.Key? key,
    int? menuId,
    int? textId,
    List<_i30.PageRouteInfo>? children,
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

  static _i30.PageInfo page = _i30.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<GossipMenuDetailRouteArgs>(
        orElse: () => const GossipMenuDetailRouteArgs(),
      );
      return _i11.GossipMenuDetailPage(
        key: args.key,
        menuId: args.menuId,
        textId: args.textId,
      );
    },
  );
}

class GossipMenuDetailRouteArgs {
  const GossipMenuDetailRouteArgs({this.key, this.menuId, this.textId});

  final _i31.Key? key;

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
/// [_i12.GossipMenuListPage]
class GossipMenuListRoute extends _i30.PageRouteInfo<void> {
  const GossipMenuListRoute({List<_i30.PageRouteInfo>? children})
    : super(GossipMenuListRoute.name, initialChildren: children);

  static const String name = 'GossipMenuListRoute';

  static _i30.PageInfo page = _i30.PageInfo(
    name,
    builder: (data) {
      return const _i12.GossipMenuListPage();
    },
  );
}

/// generated route for
/// [_i13.ItemTemplateDetailPage]
class ItemTemplateDetailRoute
    extends _i30.PageRouteInfo<ItemTemplateDetailRouteArgs> {
  ItemTemplateDetailRoute({
    _i31.Key? key,
    int? entry,
    String? name,
    List<_i30.PageRouteInfo>? children,
  }) : super(
         ItemTemplateDetailRoute.name,
         args: ItemTemplateDetailRouteArgs(key: key, entry: entry, name: name),
         initialChildren: children,
       );

  static const String name = 'ItemTemplateDetailRoute';

  static _i30.PageInfo page = _i30.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ItemTemplateDetailRouteArgs>(
        orElse: () => const ItemTemplateDetailRouteArgs(),
      );
      return _i13.ItemTemplateDetailPage(
        key: args.key,
        entry: args.entry,
        name: args.name,
      );
    },
  );
}

class ItemTemplateDetailRouteArgs {
  const ItemTemplateDetailRouteArgs({this.key, this.entry, this.name});

  final _i31.Key? key;

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
/// [_i14.ItemTemplateListPage]
class ItemTemplateListRoute extends _i30.PageRouteInfo<void> {
  const ItemTemplateListRoute({List<_i30.PageRouteInfo>? children})
    : super(ItemTemplateListRoute.name, initialChildren: children);

  static const String name = 'ItemTemplateListRoute';

  static _i30.PageInfo page = _i30.PageInfo(
    name,
    builder: (data) {
      return const _i14.ItemTemplateListPage();
    },
  );
}

/// generated route for
/// [_i15.MorePage]
class MoreRoute extends _i30.PageRouteInfo<void> {
  const MoreRoute({List<_i30.PageRouteInfo>? children})
    : super(MoreRoute.name, initialChildren: children);

  static const String name = 'MoreRoute';

  static _i30.PageInfo page = _i30.PageInfo(
    name,
    builder: (data) {
      return const _i15.MorePage();
    },
  );
}

/// generated route for
/// [_i16.PlayerCreateInfoDetailPage]
class PlayerCreateInfoDetailRoute
    extends _i30.PageRouteInfo<PlayerCreateInfoDetailRouteArgs> {
  PlayerCreateInfoDetailRoute({
    _i31.Key? key,
    int? race,
    int? playerClass,
    String? label,
    List<_i30.PageRouteInfo>? children,
  }) : super(
         PlayerCreateInfoDetailRoute.name,
         args: PlayerCreateInfoDetailRouteArgs(
           key: key,
           race: race,
           playerClass: playerClass,
           label: label,
         ),
         initialChildren: children,
       );

  static const String name = 'PlayerCreateInfoDetailRoute';

  static _i30.PageInfo page = _i30.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PlayerCreateInfoDetailRouteArgs>(
        orElse: () => const PlayerCreateInfoDetailRouteArgs(),
      );
      return _i16.PlayerCreateInfoDetailPage(
        key: args.key,
        race: args.race,
        playerClass: args.playerClass,
        label: args.label,
      );
    },
  );
}

class PlayerCreateInfoDetailRouteArgs {
  const PlayerCreateInfoDetailRouteArgs({
    this.key,
    this.race,
    this.playerClass,
    this.label,
  });

  final _i31.Key? key;

  final int? race;

  final int? playerClass;

  final String? label;

  @override
  String toString() {
    return 'PlayerCreateInfoDetailRouteArgs{key: $key, race: $race, playerClass: $playerClass, label: $label}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PlayerCreateInfoDetailRouteArgs) return false;
    return key == other.key &&
        race == other.race &&
        playerClass == other.playerClass &&
        label == other.label;
  }

  @override
  int get hashCode =>
      key.hashCode ^ race.hashCode ^ playerClass.hashCode ^ label.hashCode;
}

/// generated route for
/// [_i17.PlayerCreateInfoListPage]
class PlayerCreateInfoListRoute extends _i30.PageRouteInfo<void> {
  const PlayerCreateInfoListRoute({List<_i30.PageRouteInfo>? children})
    : super(PlayerCreateInfoListRoute.name, initialChildren: children);

  static const String name = 'PlayerCreateInfoListRoute';

  static _i30.PageInfo page = _i30.PageInfo(
    name,
    builder: (data) {
      return const _i17.PlayerCreateInfoListPage();
    },
  );
}

/// generated route for
/// [_i18.QuestTemplateDetailPage]
class QuestTemplateDetailRoute
    extends _i30.PageRouteInfo<QuestTemplateDetailRouteArgs> {
  QuestTemplateDetailRoute({
    _i31.Key? key,
    int? entry,
    String? name,
    List<_i30.PageRouteInfo>? children,
  }) : super(
         QuestTemplateDetailRoute.name,
         args: QuestTemplateDetailRouteArgs(key: key, entry: entry, name: name),
         initialChildren: children,
       );

  static const String name = 'QuestTemplateDetailRoute';

  static _i30.PageInfo page = _i30.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<QuestTemplateDetailRouteArgs>(
        orElse: () => const QuestTemplateDetailRouteArgs(),
      );
      return _i18.QuestTemplateDetailPage(
        key: args.key,
        entry: args.entry,
        name: args.name,
      );
    },
  );
}

class QuestTemplateDetailRouteArgs {
  const QuestTemplateDetailRouteArgs({this.key, this.entry, this.name});

  final _i31.Key? key;

  final int? entry;

  final String? name;

  @override
  String toString() {
    return 'QuestTemplateDetailRouteArgs{key: $key, entry: $entry, name: $name}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! QuestTemplateDetailRouteArgs) return false;
    return key == other.key && entry == other.entry && name == other.name;
  }

  @override
  int get hashCode => key.hashCode ^ entry.hashCode ^ name.hashCode;
}

/// generated route for
/// [_i19.QuestTemplateListPage]
class QuestTemplateListRoute extends _i30.PageRouteInfo<void> {
  const QuestTemplateListRoute({List<_i30.PageRouteInfo>? children})
    : super(QuestTemplateListRoute.name, initialChildren: children);

  static const String name = 'QuestTemplateListRoute';

  static _i30.PageInfo page = _i30.PageInfo(
    name,
    builder: (data) {
      return const _i19.QuestTemplateListPage();
    },
  );
}

/// generated route for
/// [_i20.ReferenceLootTemplateDetailPage]
class ReferenceLootTemplateDetailRoute
    extends _i30.PageRouteInfo<ReferenceLootTemplateDetailRouteArgs> {
  ReferenceLootTemplateDetailRoute({
    _i31.Key? key,
    int? entry,
    int? item,
    String? label,
    List<_i30.PageRouteInfo>? children,
  }) : super(
         ReferenceLootTemplateDetailRoute.name,
         args: ReferenceLootTemplateDetailRouteArgs(
           key: key,
           entry: entry,
           item: item,
           label: label,
         ),
         initialChildren: children,
       );

  static const String name = 'ReferenceLootTemplateDetailRoute';

  static _i30.PageInfo page = _i30.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ReferenceLootTemplateDetailRouteArgs>(
        orElse: () => const ReferenceLootTemplateDetailRouteArgs(),
      );
      return _i20.ReferenceLootTemplateDetailPage(
        key: args.key,
        entry: args.entry,
        item: args.item,
        label: args.label,
      );
    },
  );
}

class ReferenceLootTemplateDetailRouteArgs {
  const ReferenceLootTemplateDetailRouteArgs({
    this.key,
    this.entry,
    this.item,
    this.label,
  });

  final _i31.Key? key;

  final int? entry;

  final int? item;

  final String? label;

  @override
  String toString() {
    return 'ReferenceLootTemplateDetailRouteArgs{key: $key, entry: $entry, item: $item, label: $label}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ReferenceLootTemplateDetailRouteArgs) return false;
    return key == other.key &&
        entry == other.entry &&
        item == other.item &&
        label == other.label;
  }

  @override
  int get hashCode =>
      key.hashCode ^ entry.hashCode ^ item.hashCode ^ label.hashCode;
}

/// generated route for
/// [_i21.ReferenceLootTemplateListPage]
class ReferenceLootTemplateListRoute extends _i30.PageRouteInfo<void> {
  const ReferenceLootTemplateListRoute({List<_i30.PageRouteInfo>? children})
    : super(ReferenceLootTemplateListRoute.name, initialChildren: children);

  static const String name = 'ReferenceLootTemplateListRoute';

  static _i30.PageInfo page = _i30.PageInfo(
    name,
    builder: (data) {
      return const _i21.ReferenceLootTemplateListPage();
    },
  );
}

/// generated route for
/// [_i22.ScaffoldPage]
class ScaffoldRoute extends _i30.PageRouteInfo<void> {
  const ScaffoldRoute({List<_i30.PageRouteInfo>? children})
    : super(ScaffoldRoute.name, initialChildren: children);

  static const String name = 'ScaffoldRoute';

  static _i30.PageInfo page = _i30.PageInfo(
    name,
    builder: (data) {
      return const _i22.ScaffoldPage();
    },
  );
}

/// generated route for
/// [_i23.SettingPage]
class SettingRoute extends _i30.PageRouteInfo<void> {
  const SettingRoute({List<_i30.PageRouteInfo>? children})
    : super(SettingRoute.name, initialChildren: children);

  static const String name = 'SettingRoute';

  static _i30.PageInfo page = _i30.PageInfo(
    name,
    builder: (data) {
      return const _i23.SettingPage();
    },
  );
}

/// generated route for
/// [_i24.SmartScriptDetailPage]
class SmartScriptDetailRoute
    extends _i30.PageRouteInfo<SmartScriptDetailRouteArgs> {
  SmartScriptDetailRoute({
    _i31.Key? key,
    int? entryOrGuid,
    int? sourceType,
    int? id,
    int? link,
    List<_i30.PageRouteInfo>? children,
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

  static _i30.PageInfo page = _i30.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SmartScriptDetailRouteArgs>(
        orElse: () => const SmartScriptDetailRouteArgs(),
      );
      return _i24.SmartScriptDetailPage(
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

  final _i31.Key? key;

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
/// [_i25.SmartScriptListPage]
class SmartScriptListRoute extends _i30.PageRouteInfo<void> {
  const SmartScriptListRoute({List<_i30.PageRouteInfo>? children})
    : super(SmartScriptListRoute.name, initialChildren: children);

  static const String name = 'SmartScriptListRoute';

  static _i30.PageInfo page = _i30.PageInfo(
    name,
    builder: (data) {
      return const _i25.SmartScriptListPage();
    },
  );
}

/// generated route for
/// [_i26.SpellDetailPage]
class SpellDetailRoute extends _i30.PageRouteInfo<SpellDetailRouteArgs> {
  SpellDetailRoute({
    _i31.Key? key,
    int? id,
    String? name,
    List<_i30.PageRouteInfo>? children,
  }) : super(
         SpellDetailRoute.name,
         args: SpellDetailRouteArgs(key: key, id: id, name: name),
         initialChildren: children,
       );

  static const String name = 'SpellDetailRoute';

  static _i30.PageInfo page = _i30.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SpellDetailRouteArgs>(
        orElse: () => const SpellDetailRouteArgs(),
      );
      return _i26.SpellDetailPage(key: args.key, id: args.id, name: args.name);
    },
  );
}

class SpellDetailRouteArgs {
  const SpellDetailRouteArgs({this.key, this.id, this.name});

  final _i31.Key? key;

  final int? id;

  final String? name;

  @override
  String toString() {
    return 'SpellDetailRouteArgs{key: $key, id: $id, name: $name}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SpellDetailRouteArgs) return false;
    return key == other.key && id == other.id && name == other.name;
  }

  @override
  int get hashCode => key.hashCode ^ id.hashCode ^ name.hashCode;
}

/// generated route for
/// [_i27.SpellListPage]
class SpellListRoute extends _i30.PageRouteInfo<void> {
  const SpellListRoute({List<_i30.PageRouteInfo>? children})
    : super(SpellListRoute.name, initialChildren: children);

  static const String name = 'SpellListRoute';

  static _i30.PageInfo page = _i30.PageInfo(
    name,
    builder: (data) {
      return const _i27.SpellListPage();
    },
  );
}

/// generated route for
/// [_i28.TextContentDetailPage]
class TextContentDetailRoute
    extends _i30.PageRouteInfo<TextContentDetailRouteArgs> {
  TextContentDetailRoute({
    _i31.Key? key,
    int? id,
    String? label,
    List<_i30.PageRouteInfo>? children,
  }) : super(
         TextContentDetailRoute.name,
         args: TextContentDetailRouteArgs(key: key, id: id, label: label),
         initialChildren: children,
       );

  static const String name = 'TextContentDetailRoute';

  static _i30.PageInfo page = _i30.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TextContentDetailRouteArgs>(
        orElse: () => const TextContentDetailRouteArgs(),
      );
      return _i28.TextContentDetailPage(
        key: args.key,
        id: args.id,
        label: args.label,
      );
    },
  );
}

class TextContentDetailRouteArgs {
  const TextContentDetailRouteArgs({this.key, this.id, this.label});

  final _i31.Key? key;

  final int? id;

  final String? label;

  @override
  String toString() {
    return 'TextContentDetailRouteArgs{key: $key, id: $id, label: $label}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! TextContentDetailRouteArgs) return false;
    return key == other.key && id == other.id && label == other.label;
  }

  @override
  int get hashCode => key.hashCode ^ id.hashCode ^ label.hashCode;
}

/// generated route for
/// [_i29.TextContentListPage]
class TextContentListRoute extends _i30.PageRouteInfo<void> {
  const TextContentListRoute({List<_i30.PageRouteInfo>? children})
    : super(TextContentListRoute.name, initialChildren: children);

  static const String name = 'TextContentListRoute';

  static _i30.PageInfo page = _i30.PageInfo(
    name,
    builder: (data) {
      return const _i29.TextContentListPage();
    },
  );
}
