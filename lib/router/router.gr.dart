// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i60;
import 'package:collection/collection.dart' as _i62;
import 'package:flutter/material.dart' as _i61;
import 'package:foxy/page/achievement/achievement_detail_page.dart' as _i1;
import 'package:foxy/page/achievement/achievement_list_page.dart' as _i2;
import 'package:foxy/page/area_table/area_table_detail_page.dart' as _i3;
import 'package:foxy/page/area_table/area_table_list_page.dart' as _i4;
import 'package:foxy/page/bootstrap/bootstrap_page.dart' as _i6;
import 'package:foxy/page/condition/condition_detail_page.dart' as _i7;
import 'package:foxy/page/condition/condition_list_page.dart' as _i8;
import 'package:foxy/page/creature_template/creature_template_detail_page.dart'
    as _i9;
import 'package:foxy/page/creature_template/creature_template_list_page.dart'
    as _i10;
import 'package:foxy/page/currency_type/currency_type_detail_page.dart' as _i11;
import 'package:foxy/page/currency_type/currency_type_list_page.dart' as _i12;
import 'package:foxy/page/dashboard/dashboard_page.dart' as _i13;
import 'package:foxy/page/emote_text/emote_text_detail_page.dart' as _i15;
import 'package:foxy/page/emote_text/emote_text_list_page.dart' as _i16;
import 'package:foxy/page/game_object/game_object_template_detail_page.dart'
    as _i17;
import 'package:foxy/page/game_object/game_object_template_list_page.dart'
    as _i18;
import 'package:foxy/page/gem_property/gem_property_detail_page.dart' as _i19;
import 'package:foxy/page/gem_property/gem_property_list_page.dart' as _i20;
import 'package:foxy/page/glyph_property/glyph_property_detail_page.dart'
    as _i21;
import 'package:foxy/page/glyph_property/glyph_property_list_page.dart' as _i22;
import 'package:foxy/page/gossip_menu/gossip_menu_detail_page.dart' as _i23;
import 'package:foxy/page/gossip_menu/gossip_menu_list_page.dart' as _i24;
import 'package:foxy/page/item/item_template_detail_page.dart' as _i29;
import 'package:foxy/page/item/item_template_list_page.dart' as _i30;
import 'package:foxy/page/item_extended_cost/item_extended_cost_detail_page.dart'
    as _i25;
import 'package:foxy/page/item_extended_cost/item_extended_cost_list_page.dart'
    as _i26;
import 'package:foxy/page/item_set/item_set_detail_page.dart' as _i27;
import 'package:foxy/page/item_set/item_set_list_page.dart' as _i28;
import 'package:foxy/page/more/more_page.dart' as _i31;
import 'package:foxy/page/page_text/page_text_detail_page.dart' as _i58;
import 'package:foxy/page/page_text/page_text_list_page.dart' as _i59;
import 'package:foxy/page/player_create_info/player_create_info_detail_page.dart'
    as _i32;
import 'package:foxy/page/player_create_info/player_create_info_list_page.dart'
    as _i33;
import 'package:foxy/page/quest/quest_template_detail_page.dart' as _i40;
import 'package:foxy/page/quest/quest_template_list_page.dart' as _i41;
import 'package:foxy/page/quest_faction_reward/quest_faction_reward_detail_page.dart'
    as _i34;
import 'package:foxy/page/quest_faction_reward/quest_faction_reward_list_page.dart'
    as _i35;
import 'package:foxy/page/quest_info/quest_info_detail_page.dart' as _i36;
import 'package:foxy/page/quest_info/quest_info_list_page.dart' as _i37;
import 'package:foxy/page/quest_sort/quest_sort_detail_page.dart' as _i38;
import 'package:foxy/page/quest_sort/quest_sort_list_page.dart' as _i39;
import 'package:foxy/page/reference_loot_template/reference_loot_template_detail_page.dart'
    as _i42;
import 'package:foxy/page/reference_loot_template/reference_loot_template_list_page.dart'
    as _i43;
import 'package:foxy/page/scaffold/scaffold_page.dart' as _i44;
import 'package:foxy/page/scaling_stat_distribution/scaling_stat_distribution_detail_page.dart'
    as _i45;
import 'package:foxy/page/scaling_stat_distribution/scaling_stat_distribution_list_page.dart'
    as _i46;
import 'package:foxy/page/scaling_stat_value/scaling_stat_value_detail_page.dart'
    as _i47;
import 'package:foxy/page/scaling_stat_value/scaling_stat_value_list_page.dart'
    as _i48;
import 'package:foxy/page/setting/basic_setting.dart' as _i5;
import 'package:foxy/page/setting/database_setting.dart' as _i14;
import 'package:foxy/page/setting/setting_page.dart' as _i49;
import 'package:foxy/page/smart_script/smart_script_detail_page.dart' as _i50;
import 'package:foxy/page/smart_script/smart_script_list_page.dart' as _i51;
import 'package:foxy/page/spell/spell_detail_page.dart' as _i52;
import 'package:foxy/page/spell/spell_list_page.dart' as _i55;
import 'package:foxy/page/spell_item_enchantment/spell_item_enchantment_detail_page.dart'
    as _i53;
import 'package:foxy/page/spell_item_enchantment/spell_item_enchantment_list_page.dart'
    as _i54;
import 'package:foxy/page/talent/talent_detail_page.dart' as _i56;
import 'package:foxy/page/talent/talent_list_page.dart' as _i57;

/// generated route for
/// [_i1.AchievementDetailPage]
class AchievementDetailRoute
    extends _i60.PageRouteInfo<AchievementDetailRouteArgs> {
  AchievementDetailRoute({
    _i61.Key? key,
    int? id,
    List<_i60.PageRouteInfo>? children,
  }) : super(
         AchievementDetailRoute.name,
         args: AchievementDetailRouteArgs(key: key, id: id),
         initialChildren: children,
       );

  static const String name = 'AchievementDetailRoute';

  static _i60.PageInfo page = _i60.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AchievementDetailRouteArgs>(
        orElse: () => const AchievementDetailRouteArgs(),
      );
      return _i1.AchievementDetailPage(key: args.key, id: args.id);
    },
  );
}

class AchievementDetailRouteArgs {
  const AchievementDetailRouteArgs({this.key, this.id});

  final _i61.Key? key;

  final int? id;

  @override
  String toString() {
    return 'AchievementDetailRouteArgs{key: $key, id: $id}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AchievementDetailRouteArgs) return false;
    return key == other.key && id == other.id;
  }

  @override
  int get hashCode => key.hashCode ^ id.hashCode;
}

/// generated route for
/// [_i2.AchievementListPage]
class AchievementListRoute extends _i60.PageRouteInfo<void> {
  const AchievementListRoute({List<_i60.PageRouteInfo>? children})
    : super(AchievementListRoute.name, initialChildren: children);

  static const String name = 'AchievementListRoute';

  static _i60.PageInfo page = _i60.PageInfo(
    name,
    builder: (data) {
      return const _i2.AchievementListPage();
    },
  );
}

/// generated route for
/// [_i3.AreaTableDetailPage]
class AreaTableDetailRoute
    extends _i60.PageRouteInfo<AreaTableDetailRouteArgs> {
  AreaTableDetailRoute({
    _i61.Key? key,
    int? id,
    List<_i60.PageRouteInfo>? children,
  }) : super(
         AreaTableDetailRoute.name,
         args: AreaTableDetailRouteArgs(key: key, id: id),
         initialChildren: children,
       );

  static const String name = 'AreaTableDetailRoute';

  static _i60.PageInfo page = _i60.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AreaTableDetailRouteArgs>(
        orElse: () => const AreaTableDetailRouteArgs(),
      );
      return _i3.AreaTableDetailPage(key: args.key, id: args.id);
    },
  );
}

class AreaTableDetailRouteArgs {
  const AreaTableDetailRouteArgs({this.key, this.id});

  final _i61.Key? key;

  final int? id;

  @override
  String toString() {
    return 'AreaTableDetailRouteArgs{key: $key, id: $id}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AreaTableDetailRouteArgs) return false;
    return key == other.key && id == other.id;
  }

  @override
  int get hashCode => key.hashCode ^ id.hashCode;
}

/// generated route for
/// [_i4.AreaTableListPage]
class AreaTableListRoute extends _i60.PageRouteInfo<void> {
  const AreaTableListRoute({List<_i60.PageRouteInfo>? children})
    : super(AreaTableListRoute.name, initialChildren: children);

  static const String name = 'AreaTableListRoute';

  static _i60.PageInfo page = _i60.PageInfo(
    name,
    builder: (data) {
      return const _i4.AreaTableListPage();
    },
  );
}

/// generated route for
/// [_i5.BasicSettingPage]
class BasicSettingRoute extends _i60.PageRouteInfo<void> {
  const BasicSettingRoute({List<_i60.PageRouteInfo>? children})
    : super(BasicSettingRoute.name, initialChildren: children);

  static const String name = 'BasicSettingRoute';

  static _i60.PageInfo page = _i60.PageInfo(
    name,
    builder: (data) {
      return const _i5.BasicSettingPage();
    },
  );
}

/// generated route for
/// [_i6.BootstrapPage]
class BootstrapRoute extends _i60.PageRouteInfo<void> {
  const BootstrapRoute({List<_i60.PageRouteInfo>? children})
    : super(BootstrapRoute.name, initialChildren: children);

  static const String name = 'BootstrapRoute';

  static _i60.PageInfo page = _i60.PageInfo(
    name,
    builder: (data) {
      return const _i6.BootstrapPage();
    },
  );
}

/// generated route for
/// [_i7.ConditionDetailPage]
class ConditionDetailRoute
    extends _i60.PageRouteInfo<ConditionDetailRouteArgs> {
  ConditionDetailRoute({
    _i61.Key? key,
    Map<String, dynamic>? credential,
    List<_i60.PageRouteInfo>? children,
  }) : super(
         ConditionDetailRoute.name,
         args: ConditionDetailRouteArgs(key: key, credential: credential),
         initialChildren: children,
       );

  static const String name = 'ConditionDetailRoute';

  static _i60.PageInfo page = _i60.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ConditionDetailRouteArgs>(
        orElse: () => const ConditionDetailRouteArgs(),
      );
      return _i7.ConditionDetailPage(
        key: args.key,
        credential: args.credential,
      );
    },
  );
}

class ConditionDetailRouteArgs {
  const ConditionDetailRouteArgs({this.key, this.credential});

  final _i61.Key? key;

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
        const _i62.MapEquality<String, dynamic>().equals(
          credential,
          other.credential,
        );
  }

  @override
  int get hashCode =>
      key.hashCode ^ const _i62.MapEquality<String, dynamic>().hash(credential);
}

/// generated route for
/// [_i8.ConditionListPage]
class ConditionListRoute extends _i60.PageRouteInfo<void> {
  const ConditionListRoute({List<_i60.PageRouteInfo>? children})
    : super(ConditionListRoute.name, initialChildren: children);

  static const String name = 'ConditionListRoute';

  static _i60.PageInfo page = _i60.PageInfo(
    name,
    builder: (data) {
      return const _i8.ConditionListPage();
    },
  );
}

/// generated route for
/// [_i9.CreatureTemplateDetailPage]
class CreatureTemplateDetailRoute
    extends _i60.PageRouteInfo<CreatureTemplateDetailRouteArgs> {
  CreatureTemplateDetailRoute({
    _i61.Key? key,
    int? entry,
    String? name,
    List<_i60.PageRouteInfo>? children,
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

  static _i60.PageInfo page = _i60.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CreatureTemplateDetailRouteArgs>(
        orElse: () => const CreatureTemplateDetailRouteArgs(),
      );
      return _i9.CreatureTemplateDetailPage(
        key: args.key,
        entry: args.entry,
        name: args.name,
      );
    },
  );
}

class CreatureTemplateDetailRouteArgs {
  const CreatureTemplateDetailRouteArgs({this.key, this.entry, this.name});

  final _i61.Key? key;

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
/// [_i10.CreatureTemplateListPage]
class CreatureTemplateListRoute extends _i60.PageRouteInfo<void> {
  const CreatureTemplateListRoute({List<_i60.PageRouteInfo>? children})
    : super(CreatureTemplateListRoute.name, initialChildren: children);

  static const String name = 'CreatureTemplateListRoute';

  static _i60.PageInfo page = _i60.PageInfo(
    name,
    builder: (data) {
      return const _i10.CreatureTemplateListPage();
    },
  );
}

/// generated route for
/// [_i11.CurrencyTypeDetailPage]
class CurrencyTypeDetailRoute
    extends _i60.PageRouteInfo<CurrencyTypeDetailRouteArgs> {
  CurrencyTypeDetailRoute({
    _i61.Key? key,
    int? id,
    List<_i60.PageRouteInfo>? children,
  }) : super(
         CurrencyTypeDetailRoute.name,
         args: CurrencyTypeDetailRouteArgs(key: key, id: id),
         initialChildren: children,
       );

  static const String name = 'CurrencyTypeDetailRoute';

  static _i60.PageInfo page = _i60.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CurrencyTypeDetailRouteArgs>(
        orElse: () => const CurrencyTypeDetailRouteArgs(),
      );
      return _i11.CurrencyTypeDetailPage(key: args.key, id: args.id);
    },
  );
}

class CurrencyTypeDetailRouteArgs {
  const CurrencyTypeDetailRouteArgs({this.key, this.id});

  final _i61.Key? key;

  final int? id;

  @override
  String toString() {
    return 'CurrencyTypeDetailRouteArgs{key: $key, id: $id}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CurrencyTypeDetailRouteArgs) return false;
    return key == other.key && id == other.id;
  }

  @override
  int get hashCode => key.hashCode ^ id.hashCode;
}

/// generated route for
/// [_i12.CurrencyTypeListPage]
class CurrencyTypeListRoute extends _i60.PageRouteInfo<void> {
  const CurrencyTypeListRoute({List<_i60.PageRouteInfo>? children})
    : super(CurrencyTypeListRoute.name, initialChildren: children);

  static const String name = 'CurrencyTypeListRoute';

  static _i60.PageInfo page = _i60.PageInfo(
    name,
    builder: (data) {
      return const _i12.CurrencyTypeListPage();
    },
  );
}

/// generated route for
/// [_i13.DashboardPage]
class DashboardRoute extends _i60.PageRouteInfo<void> {
  const DashboardRoute({List<_i60.PageRouteInfo>? children})
    : super(DashboardRoute.name, initialChildren: children);

  static const String name = 'DashboardRoute';

  static _i60.PageInfo page = _i60.PageInfo(
    name,
    builder: (data) {
      return const _i13.DashboardPage();
    },
  );
}

/// generated route for
/// [_i14.DatabaseSettingPage]
class DatabaseSettingRoute extends _i60.PageRouteInfo<void> {
  const DatabaseSettingRoute({List<_i60.PageRouteInfo>? children})
    : super(DatabaseSettingRoute.name, initialChildren: children);

  static const String name = 'DatabaseSettingRoute';

  static _i60.PageInfo page = _i60.PageInfo(
    name,
    builder: (data) {
      return const _i14.DatabaseSettingPage();
    },
  );
}

/// generated route for
/// [_i15.EmoteTextDetailPage]
class EmoteTextDetailRoute
    extends _i60.PageRouteInfo<EmoteTextDetailRouteArgs> {
  EmoteTextDetailRoute({
    _i61.Key? key,
    int? id,
    List<_i60.PageRouteInfo>? children,
  }) : super(
         EmoteTextDetailRoute.name,
         args: EmoteTextDetailRouteArgs(key: key, id: id),
         initialChildren: children,
       );

  static const String name = 'EmoteTextDetailRoute';

  static _i60.PageInfo page = _i60.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EmoteTextDetailRouteArgs>(
        orElse: () => const EmoteTextDetailRouteArgs(),
      );
      return _i15.EmoteTextDetailPage(key: args.key, id: args.id);
    },
  );
}

class EmoteTextDetailRouteArgs {
  const EmoteTextDetailRouteArgs({this.key, this.id});

  final _i61.Key? key;

  final int? id;

  @override
  String toString() {
    return 'EmoteTextDetailRouteArgs{key: $key, id: $id}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! EmoteTextDetailRouteArgs) return false;
    return key == other.key && id == other.id;
  }

  @override
  int get hashCode => key.hashCode ^ id.hashCode;
}

/// generated route for
/// [_i16.EmoteTextListPage]
class EmoteTextListRoute extends _i60.PageRouteInfo<void> {
  const EmoteTextListRoute({List<_i60.PageRouteInfo>? children})
    : super(EmoteTextListRoute.name, initialChildren: children);

  static const String name = 'EmoteTextListRoute';

  static _i60.PageInfo page = _i60.PageInfo(
    name,
    builder: (data) {
      return const _i16.EmoteTextListPage();
    },
  );
}

/// generated route for
/// [_i17.GameObjectTemplateDetailPage]
class GameObjectTemplateDetailRoute
    extends _i60.PageRouteInfo<GameObjectTemplateDetailRouteArgs> {
  GameObjectTemplateDetailRoute({
    _i61.Key? key,
    int? entry,
    String? name,
    List<_i60.PageRouteInfo>? children,
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

  static _i60.PageInfo page = _i60.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<GameObjectTemplateDetailRouteArgs>(
        orElse: () => const GameObjectTemplateDetailRouteArgs(),
      );
      return _i17.GameObjectTemplateDetailPage(
        key: args.key,
        entry: args.entry,
        name: args.name,
      );
    },
  );
}

class GameObjectTemplateDetailRouteArgs {
  const GameObjectTemplateDetailRouteArgs({this.key, this.entry, this.name});

  final _i61.Key? key;

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
/// [_i18.GameObjectTemplateListPage]
class GameObjectTemplateListRoute extends _i60.PageRouteInfo<void> {
  const GameObjectTemplateListRoute({List<_i60.PageRouteInfo>? children})
    : super(GameObjectTemplateListRoute.name, initialChildren: children);

  static const String name = 'GameObjectTemplateListRoute';

  static _i60.PageInfo page = _i60.PageInfo(
    name,
    builder: (data) {
      return const _i18.GameObjectTemplateListPage();
    },
  );
}

/// generated route for
/// [_i19.GemPropertyDetailPage]
class GemPropertyDetailRoute
    extends _i60.PageRouteInfo<GemPropertyDetailRouteArgs> {
  GemPropertyDetailRoute({
    _i61.Key? key,
    int? id,
    List<_i60.PageRouteInfo>? children,
  }) : super(
         GemPropertyDetailRoute.name,
         args: GemPropertyDetailRouteArgs(key: key, id: id),
         initialChildren: children,
       );

  static const String name = 'GemPropertyDetailRoute';

  static _i60.PageInfo page = _i60.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<GemPropertyDetailRouteArgs>(
        orElse: () => const GemPropertyDetailRouteArgs(),
      );
      return _i19.GemPropertyDetailPage(key: args.key, id: args.id);
    },
  );
}

class GemPropertyDetailRouteArgs {
  const GemPropertyDetailRouteArgs({this.key, this.id});

  final _i61.Key? key;

  final int? id;

  @override
  String toString() {
    return 'GemPropertyDetailRouteArgs{key: $key, id: $id}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! GemPropertyDetailRouteArgs) return false;
    return key == other.key && id == other.id;
  }

  @override
  int get hashCode => key.hashCode ^ id.hashCode;
}

/// generated route for
/// [_i20.GemPropertyListPage]
class GemPropertyListRoute extends _i60.PageRouteInfo<void> {
  const GemPropertyListRoute({List<_i60.PageRouteInfo>? children})
    : super(GemPropertyListRoute.name, initialChildren: children);

  static const String name = 'GemPropertyListRoute';

  static _i60.PageInfo page = _i60.PageInfo(
    name,
    builder: (data) {
      return const _i20.GemPropertyListPage();
    },
  );
}

/// generated route for
/// [_i21.GlyphPropertyDetailPage]
class GlyphPropertyDetailRoute
    extends _i60.PageRouteInfo<GlyphPropertyDetailRouteArgs> {
  GlyphPropertyDetailRoute({
    _i61.Key? key,
    int? id,
    List<_i60.PageRouteInfo>? children,
  }) : super(
         GlyphPropertyDetailRoute.name,
         args: GlyphPropertyDetailRouteArgs(key: key, id: id),
         initialChildren: children,
       );

  static const String name = 'GlyphPropertyDetailRoute';

  static _i60.PageInfo page = _i60.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<GlyphPropertyDetailRouteArgs>(
        orElse: () => const GlyphPropertyDetailRouteArgs(),
      );
      return _i21.GlyphPropertyDetailPage(key: args.key, id: args.id);
    },
  );
}

class GlyphPropertyDetailRouteArgs {
  const GlyphPropertyDetailRouteArgs({this.key, this.id});

  final _i61.Key? key;

  final int? id;

  @override
  String toString() {
    return 'GlyphPropertyDetailRouteArgs{key: $key, id: $id}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! GlyphPropertyDetailRouteArgs) return false;
    return key == other.key && id == other.id;
  }

  @override
  int get hashCode => key.hashCode ^ id.hashCode;
}

/// generated route for
/// [_i22.GlyphPropertyListPage]
class GlyphPropertyListRoute extends _i60.PageRouteInfo<void> {
  const GlyphPropertyListRoute({List<_i60.PageRouteInfo>? children})
    : super(GlyphPropertyListRoute.name, initialChildren: children);

  static const String name = 'GlyphPropertyListRoute';

  static _i60.PageInfo page = _i60.PageInfo(
    name,
    builder: (data) {
      return const _i22.GlyphPropertyListPage();
    },
  );
}

/// generated route for
/// [_i23.GossipMenuDetailPage]
class GossipMenuDetailRoute
    extends _i60.PageRouteInfo<GossipMenuDetailRouteArgs> {
  GossipMenuDetailRoute({
    _i61.Key? key,
    int? menuId,
    int? textId,
    List<_i60.PageRouteInfo>? children,
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

  static _i60.PageInfo page = _i60.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<GossipMenuDetailRouteArgs>(
        orElse: () => const GossipMenuDetailRouteArgs(),
      );
      return _i23.GossipMenuDetailPage(
        key: args.key,
        menuId: args.menuId,
        textId: args.textId,
      );
    },
  );
}

class GossipMenuDetailRouteArgs {
  const GossipMenuDetailRouteArgs({this.key, this.menuId, this.textId});

  final _i61.Key? key;

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
/// [_i24.GossipMenuListPage]
class GossipMenuListRoute extends _i60.PageRouteInfo<void> {
  const GossipMenuListRoute({List<_i60.PageRouteInfo>? children})
    : super(GossipMenuListRoute.name, initialChildren: children);

  static const String name = 'GossipMenuListRoute';

  static _i60.PageInfo page = _i60.PageInfo(
    name,
    builder: (data) {
      return const _i24.GossipMenuListPage();
    },
  );
}

/// generated route for
/// [_i25.ItemExtendedCostDetailPage]
class ItemExtendedCostDetailRoute
    extends _i60.PageRouteInfo<ItemExtendedCostDetailRouteArgs> {
  ItemExtendedCostDetailRoute({
    _i61.Key? key,
    int? id,
    List<_i60.PageRouteInfo>? children,
  }) : super(
         ItemExtendedCostDetailRoute.name,
         args: ItemExtendedCostDetailRouteArgs(key: key, id: id),
         initialChildren: children,
       );

  static const String name = 'ItemExtendedCostDetailRoute';

  static _i60.PageInfo page = _i60.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ItemExtendedCostDetailRouteArgs>(
        orElse: () => const ItemExtendedCostDetailRouteArgs(),
      );
      return _i25.ItemExtendedCostDetailPage(key: args.key, id: args.id);
    },
  );
}

class ItemExtendedCostDetailRouteArgs {
  const ItemExtendedCostDetailRouteArgs({this.key, this.id});

  final _i61.Key? key;

  final int? id;

  @override
  String toString() {
    return 'ItemExtendedCostDetailRouteArgs{key: $key, id: $id}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ItemExtendedCostDetailRouteArgs) return false;
    return key == other.key && id == other.id;
  }

  @override
  int get hashCode => key.hashCode ^ id.hashCode;
}

/// generated route for
/// [_i26.ItemExtendedCostListPage]
class ItemExtendedCostListRoute extends _i60.PageRouteInfo<void> {
  const ItemExtendedCostListRoute({List<_i60.PageRouteInfo>? children})
    : super(ItemExtendedCostListRoute.name, initialChildren: children);

  static const String name = 'ItemExtendedCostListRoute';

  static _i60.PageInfo page = _i60.PageInfo(
    name,
    builder: (data) {
      return const _i26.ItemExtendedCostListPage();
    },
  );
}

/// generated route for
/// [_i27.ItemSetDetailPage]
class ItemSetDetailRoute extends _i60.PageRouteInfo<ItemSetDetailRouteArgs> {
  ItemSetDetailRoute({
    _i61.Key? key,
    int? id,
    List<_i60.PageRouteInfo>? children,
  }) : super(
         ItemSetDetailRoute.name,
         args: ItemSetDetailRouteArgs(key: key, id: id),
         initialChildren: children,
       );

  static const String name = 'ItemSetDetailRoute';

  static _i60.PageInfo page = _i60.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ItemSetDetailRouteArgs>(
        orElse: () => const ItemSetDetailRouteArgs(),
      );
      return _i27.ItemSetDetailPage(key: args.key, id: args.id);
    },
  );
}

class ItemSetDetailRouteArgs {
  const ItemSetDetailRouteArgs({this.key, this.id});

  final _i61.Key? key;

  final int? id;

  @override
  String toString() {
    return 'ItemSetDetailRouteArgs{key: $key, id: $id}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ItemSetDetailRouteArgs) return false;
    return key == other.key && id == other.id;
  }

  @override
  int get hashCode => key.hashCode ^ id.hashCode;
}

/// generated route for
/// [_i28.ItemSetListPage]
class ItemSetListRoute extends _i60.PageRouteInfo<void> {
  const ItemSetListRoute({List<_i60.PageRouteInfo>? children})
    : super(ItemSetListRoute.name, initialChildren: children);

  static const String name = 'ItemSetListRoute';

  static _i60.PageInfo page = _i60.PageInfo(
    name,
    builder: (data) {
      return const _i28.ItemSetListPage();
    },
  );
}

/// generated route for
/// [_i29.ItemTemplateDetailPage]
class ItemTemplateDetailRoute
    extends _i60.PageRouteInfo<ItemTemplateDetailRouteArgs> {
  ItemTemplateDetailRoute({
    _i61.Key? key,
    int? entry,
    String? name,
    List<_i60.PageRouteInfo>? children,
  }) : super(
         ItemTemplateDetailRoute.name,
         args: ItemTemplateDetailRouteArgs(key: key, entry: entry, name: name),
         initialChildren: children,
       );

  static const String name = 'ItemTemplateDetailRoute';

  static _i60.PageInfo page = _i60.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ItemTemplateDetailRouteArgs>(
        orElse: () => const ItemTemplateDetailRouteArgs(),
      );
      return _i29.ItemTemplateDetailPage(
        key: args.key,
        entry: args.entry,
        name: args.name,
      );
    },
  );
}

class ItemTemplateDetailRouteArgs {
  const ItemTemplateDetailRouteArgs({this.key, this.entry, this.name});

  final _i61.Key? key;

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
/// [_i30.ItemTemplateListPage]
class ItemTemplateListRoute extends _i60.PageRouteInfo<void> {
  const ItemTemplateListRoute({List<_i60.PageRouteInfo>? children})
    : super(ItemTemplateListRoute.name, initialChildren: children);

  static const String name = 'ItemTemplateListRoute';

  static _i60.PageInfo page = _i60.PageInfo(
    name,
    builder: (data) {
      return const _i30.ItemTemplateListPage();
    },
  );
}

/// generated route for
/// [_i31.MorePage]
class MoreRoute extends _i60.PageRouteInfo<void> {
  const MoreRoute({List<_i60.PageRouteInfo>? children})
    : super(MoreRoute.name, initialChildren: children);

  static const String name = 'MoreRoute';

  static _i60.PageInfo page = _i60.PageInfo(
    name,
    builder: (data) {
      return const _i31.MorePage();
    },
  );
}

/// generated route for
/// [_i32.PlayerCreateInfoDetailPage]
class PlayerCreateInfoDetailRoute
    extends _i60.PageRouteInfo<PlayerCreateInfoDetailRouteArgs> {
  PlayerCreateInfoDetailRoute({
    _i61.Key? key,
    int? race,
    int? playerClass,
    String? label,
    List<_i60.PageRouteInfo>? children,
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

  static _i60.PageInfo page = _i60.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PlayerCreateInfoDetailRouteArgs>(
        orElse: () => const PlayerCreateInfoDetailRouteArgs(),
      );
      return _i32.PlayerCreateInfoDetailPage(
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

  final _i61.Key? key;

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
/// [_i33.PlayerCreateInfoListPage]
class PlayerCreateInfoListRoute extends _i60.PageRouteInfo<void> {
  const PlayerCreateInfoListRoute({List<_i60.PageRouteInfo>? children})
    : super(PlayerCreateInfoListRoute.name, initialChildren: children);

  static const String name = 'PlayerCreateInfoListRoute';

  static _i60.PageInfo page = _i60.PageInfo(
    name,
    builder: (data) {
      return const _i33.PlayerCreateInfoListPage();
    },
  );
}

/// generated route for
/// [_i34.QuestFactionRewardDetailPage]
class QuestFactionRewardDetailRoute
    extends _i60.PageRouteInfo<QuestFactionRewardDetailRouteArgs> {
  QuestFactionRewardDetailRoute({
    _i61.Key? key,
    int? id,
    List<_i60.PageRouteInfo>? children,
  }) : super(
         QuestFactionRewardDetailRoute.name,
         args: QuestFactionRewardDetailRouteArgs(key: key, id: id),
         initialChildren: children,
       );

  static const String name = 'QuestFactionRewardDetailRoute';

  static _i60.PageInfo page = _i60.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<QuestFactionRewardDetailRouteArgs>(
        orElse: () => const QuestFactionRewardDetailRouteArgs(),
      );
      return _i34.QuestFactionRewardDetailPage(key: args.key, id: args.id);
    },
  );
}

class QuestFactionRewardDetailRouteArgs {
  const QuestFactionRewardDetailRouteArgs({this.key, this.id});

  final _i61.Key? key;

  final int? id;

  @override
  String toString() {
    return 'QuestFactionRewardDetailRouteArgs{key: $key, id: $id}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! QuestFactionRewardDetailRouteArgs) return false;
    return key == other.key && id == other.id;
  }

  @override
  int get hashCode => key.hashCode ^ id.hashCode;
}

/// generated route for
/// [_i35.QuestFactionRewardListPage]
class QuestFactionRewardListRoute extends _i60.PageRouteInfo<void> {
  const QuestFactionRewardListRoute({List<_i60.PageRouteInfo>? children})
    : super(QuestFactionRewardListRoute.name, initialChildren: children);

  static const String name = 'QuestFactionRewardListRoute';

  static _i60.PageInfo page = _i60.PageInfo(
    name,
    builder: (data) {
      return const _i35.QuestFactionRewardListPage();
    },
  );
}

/// generated route for
/// [_i36.QuestInfoDetailPage]
class QuestInfoDetailRoute
    extends _i60.PageRouteInfo<QuestInfoDetailRouteArgs> {
  QuestInfoDetailRoute({
    _i61.Key? key,
    int? id,
    List<_i60.PageRouteInfo>? children,
  }) : super(
         QuestInfoDetailRoute.name,
         args: QuestInfoDetailRouteArgs(key: key, id: id),
         initialChildren: children,
       );

  static const String name = 'QuestInfoDetailRoute';

  static _i60.PageInfo page = _i60.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<QuestInfoDetailRouteArgs>(
        orElse: () => const QuestInfoDetailRouteArgs(),
      );
      return _i36.QuestInfoDetailPage(key: args.key, id: args.id);
    },
  );
}

class QuestInfoDetailRouteArgs {
  const QuestInfoDetailRouteArgs({this.key, this.id});

  final _i61.Key? key;

  final int? id;

  @override
  String toString() {
    return 'QuestInfoDetailRouteArgs{key: $key, id: $id}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! QuestInfoDetailRouteArgs) return false;
    return key == other.key && id == other.id;
  }

  @override
  int get hashCode => key.hashCode ^ id.hashCode;
}

/// generated route for
/// [_i37.QuestInfoListPage]
class QuestInfoListRoute extends _i60.PageRouteInfo<void> {
  const QuestInfoListRoute({List<_i60.PageRouteInfo>? children})
    : super(QuestInfoListRoute.name, initialChildren: children);

  static const String name = 'QuestInfoListRoute';

  static _i60.PageInfo page = _i60.PageInfo(
    name,
    builder: (data) {
      return const _i37.QuestInfoListPage();
    },
  );
}

/// generated route for
/// [_i38.QuestSortDetailPage]
class QuestSortDetailRoute
    extends _i60.PageRouteInfo<QuestSortDetailRouteArgs> {
  QuestSortDetailRoute({
    _i61.Key? key,
    int? id,
    List<_i60.PageRouteInfo>? children,
  }) : super(
         QuestSortDetailRoute.name,
         args: QuestSortDetailRouteArgs(key: key, id: id),
         initialChildren: children,
       );

  static const String name = 'QuestSortDetailRoute';

  static _i60.PageInfo page = _i60.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<QuestSortDetailRouteArgs>(
        orElse: () => const QuestSortDetailRouteArgs(),
      );
      return _i38.QuestSortDetailPage(key: args.key, id: args.id);
    },
  );
}

class QuestSortDetailRouteArgs {
  const QuestSortDetailRouteArgs({this.key, this.id});

  final _i61.Key? key;

  final int? id;

  @override
  String toString() {
    return 'QuestSortDetailRouteArgs{key: $key, id: $id}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! QuestSortDetailRouteArgs) return false;
    return key == other.key && id == other.id;
  }

  @override
  int get hashCode => key.hashCode ^ id.hashCode;
}

/// generated route for
/// [_i39.QuestSortListPage]
class QuestSortListRoute extends _i60.PageRouteInfo<void> {
  const QuestSortListRoute({List<_i60.PageRouteInfo>? children})
    : super(QuestSortListRoute.name, initialChildren: children);

  static const String name = 'QuestSortListRoute';

  static _i60.PageInfo page = _i60.PageInfo(
    name,
    builder: (data) {
      return const _i39.QuestSortListPage();
    },
  );
}

/// generated route for
/// [_i40.QuestTemplateDetailPage]
class QuestTemplateDetailRoute
    extends _i60.PageRouteInfo<QuestTemplateDetailRouteArgs> {
  QuestTemplateDetailRoute({
    _i61.Key? key,
    int? entry,
    String? name,
    List<_i60.PageRouteInfo>? children,
  }) : super(
         QuestTemplateDetailRoute.name,
         args: QuestTemplateDetailRouteArgs(key: key, entry: entry, name: name),
         initialChildren: children,
       );

  static const String name = 'QuestTemplateDetailRoute';

  static _i60.PageInfo page = _i60.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<QuestTemplateDetailRouteArgs>(
        orElse: () => const QuestTemplateDetailRouteArgs(),
      );
      return _i40.QuestTemplateDetailPage(
        key: args.key,
        entry: args.entry,
        name: args.name,
      );
    },
  );
}

class QuestTemplateDetailRouteArgs {
  const QuestTemplateDetailRouteArgs({this.key, this.entry, this.name});

  final _i61.Key? key;

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
/// [_i41.QuestTemplateListPage]
class QuestTemplateListRoute extends _i60.PageRouteInfo<void> {
  const QuestTemplateListRoute({List<_i60.PageRouteInfo>? children})
    : super(QuestTemplateListRoute.name, initialChildren: children);

  static const String name = 'QuestTemplateListRoute';

  static _i60.PageInfo page = _i60.PageInfo(
    name,
    builder: (data) {
      return const _i41.QuestTemplateListPage();
    },
  );
}

/// generated route for
/// [_i42.ReferenceLootTemplateDetailPage]
class ReferenceLootTemplateDetailRoute
    extends _i60.PageRouteInfo<ReferenceLootTemplateDetailRouteArgs> {
  ReferenceLootTemplateDetailRoute({
    _i61.Key? key,
    int? entry,
    int? item,
    String? label,
    List<_i60.PageRouteInfo>? children,
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

  static _i60.PageInfo page = _i60.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ReferenceLootTemplateDetailRouteArgs>(
        orElse: () => const ReferenceLootTemplateDetailRouteArgs(),
      );
      return _i42.ReferenceLootTemplateDetailPage(
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

  final _i61.Key? key;

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
/// [_i43.ReferenceLootTemplateListPage]
class ReferenceLootTemplateListRoute extends _i60.PageRouteInfo<void> {
  const ReferenceLootTemplateListRoute({List<_i60.PageRouteInfo>? children})
    : super(ReferenceLootTemplateListRoute.name, initialChildren: children);

  static const String name = 'ReferenceLootTemplateListRoute';

  static _i60.PageInfo page = _i60.PageInfo(
    name,
    builder: (data) {
      return const _i43.ReferenceLootTemplateListPage();
    },
  );
}

/// generated route for
/// [_i44.ScaffoldPage]
class ScaffoldRoute extends _i60.PageRouteInfo<void> {
  const ScaffoldRoute({List<_i60.PageRouteInfo>? children})
    : super(ScaffoldRoute.name, initialChildren: children);

  static const String name = 'ScaffoldRoute';

  static _i60.PageInfo page = _i60.PageInfo(
    name,
    builder: (data) {
      return const _i44.ScaffoldPage();
    },
  );
}

/// generated route for
/// [_i45.ScalingStatDistributionDetailPage]
class ScalingStatDistributionDetailRoute
    extends _i60.PageRouteInfo<ScalingStatDistributionDetailRouteArgs> {
  ScalingStatDistributionDetailRoute({
    _i61.Key? key,
    int? id,
    List<_i60.PageRouteInfo>? children,
  }) : super(
         ScalingStatDistributionDetailRoute.name,
         args: ScalingStatDistributionDetailRouteArgs(key: key, id: id),
         initialChildren: children,
       );

  static const String name = 'ScalingStatDistributionDetailRoute';

  static _i60.PageInfo page = _i60.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ScalingStatDistributionDetailRouteArgs>(
        orElse: () => const ScalingStatDistributionDetailRouteArgs(),
      );
      return _i45.ScalingStatDistributionDetailPage(key: args.key, id: args.id);
    },
  );
}

class ScalingStatDistributionDetailRouteArgs {
  const ScalingStatDistributionDetailRouteArgs({this.key, this.id});

  final _i61.Key? key;

  final int? id;

  @override
  String toString() {
    return 'ScalingStatDistributionDetailRouteArgs{key: $key, id: $id}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ScalingStatDistributionDetailRouteArgs) return false;
    return key == other.key && id == other.id;
  }

  @override
  int get hashCode => key.hashCode ^ id.hashCode;
}

/// generated route for
/// [_i46.ScalingStatDistributionListPage]
class ScalingStatDistributionListRoute extends _i60.PageRouteInfo<void> {
  const ScalingStatDistributionListRoute({List<_i60.PageRouteInfo>? children})
    : super(ScalingStatDistributionListRoute.name, initialChildren: children);

  static const String name = 'ScalingStatDistributionListRoute';

  static _i60.PageInfo page = _i60.PageInfo(
    name,
    builder: (data) {
      return const _i46.ScalingStatDistributionListPage();
    },
  );
}

/// generated route for
/// [_i47.ScalingStatValueDetailPage]
class ScalingStatValueDetailRoute
    extends _i60.PageRouteInfo<ScalingStatValueDetailRouteArgs> {
  ScalingStatValueDetailRoute({
    _i61.Key? key,
    int? id,
    List<_i60.PageRouteInfo>? children,
  }) : super(
         ScalingStatValueDetailRoute.name,
         args: ScalingStatValueDetailRouteArgs(key: key, id: id),
         initialChildren: children,
       );

  static const String name = 'ScalingStatValueDetailRoute';

  static _i60.PageInfo page = _i60.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ScalingStatValueDetailRouteArgs>(
        orElse: () => const ScalingStatValueDetailRouteArgs(),
      );
      return _i47.ScalingStatValueDetailPage(key: args.key, id: args.id);
    },
  );
}

class ScalingStatValueDetailRouteArgs {
  const ScalingStatValueDetailRouteArgs({this.key, this.id});

  final _i61.Key? key;

  final int? id;

  @override
  String toString() {
    return 'ScalingStatValueDetailRouteArgs{key: $key, id: $id}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ScalingStatValueDetailRouteArgs) return false;
    return key == other.key && id == other.id;
  }

  @override
  int get hashCode => key.hashCode ^ id.hashCode;
}

/// generated route for
/// [_i48.ScalingStatValueListPage]
class ScalingStatValueListRoute extends _i60.PageRouteInfo<void> {
  const ScalingStatValueListRoute({List<_i60.PageRouteInfo>? children})
    : super(ScalingStatValueListRoute.name, initialChildren: children);

  static const String name = 'ScalingStatValueListRoute';

  static _i60.PageInfo page = _i60.PageInfo(
    name,
    builder: (data) {
      return const _i48.ScalingStatValueListPage();
    },
  );
}

/// generated route for
/// [_i49.SettingPage]
class SettingRoute extends _i60.PageRouteInfo<void> {
  const SettingRoute({List<_i60.PageRouteInfo>? children})
    : super(SettingRoute.name, initialChildren: children);

  static const String name = 'SettingRoute';

  static _i60.PageInfo page = _i60.PageInfo(
    name,
    builder: (data) {
      return const _i49.SettingPage();
    },
  );
}

/// generated route for
/// [_i50.SmartScriptDetailPage]
class SmartScriptDetailRoute
    extends _i60.PageRouteInfo<SmartScriptDetailRouteArgs> {
  SmartScriptDetailRoute({
    _i61.Key? key,
    int? entryOrGuid,
    int? sourceType,
    int? id,
    int? link,
    List<_i60.PageRouteInfo>? children,
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

  static _i60.PageInfo page = _i60.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SmartScriptDetailRouteArgs>(
        orElse: () => const SmartScriptDetailRouteArgs(),
      );
      return _i50.SmartScriptDetailPage(
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

  final _i61.Key? key;

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
/// [_i51.SmartScriptListPage]
class SmartScriptListRoute extends _i60.PageRouteInfo<void> {
  const SmartScriptListRoute({List<_i60.PageRouteInfo>? children})
    : super(SmartScriptListRoute.name, initialChildren: children);

  static const String name = 'SmartScriptListRoute';

  static _i60.PageInfo page = _i60.PageInfo(
    name,
    builder: (data) {
      return const _i51.SmartScriptListPage();
    },
  );
}

/// generated route for
/// [_i52.SpellDetailPage]
class SpellDetailRoute extends _i60.PageRouteInfo<SpellDetailRouteArgs> {
  SpellDetailRoute({
    _i61.Key? key,
    int? id,
    String? name,
    List<_i60.PageRouteInfo>? children,
  }) : super(
         SpellDetailRoute.name,
         args: SpellDetailRouteArgs(key: key, id: id, name: name),
         initialChildren: children,
       );

  static const String name = 'SpellDetailRoute';

  static _i60.PageInfo page = _i60.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SpellDetailRouteArgs>(
        orElse: () => const SpellDetailRouteArgs(),
      );
      return _i52.SpellDetailPage(key: args.key, id: args.id, name: args.name);
    },
  );
}

class SpellDetailRouteArgs {
  const SpellDetailRouteArgs({this.key, this.id, this.name});

  final _i61.Key? key;

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
/// [_i53.SpellItemEnchantmentDetailPage]
class SpellItemEnchantmentDetailRoute
    extends _i60.PageRouteInfo<SpellItemEnchantmentDetailRouteArgs> {
  SpellItemEnchantmentDetailRoute({
    _i61.Key? key,
    int? id,
    List<_i60.PageRouteInfo>? children,
  }) : super(
         SpellItemEnchantmentDetailRoute.name,
         args: SpellItemEnchantmentDetailRouteArgs(key: key, id: id),
         initialChildren: children,
       );

  static const String name = 'SpellItemEnchantmentDetailRoute';

  static _i60.PageInfo page = _i60.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SpellItemEnchantmentDetailRouteArgs>(
        orElse: () => const SpellItemEnchantmentDetailRouteArgs(),
      );
      return _i53.SpellItemEnchantmentDetailPage(key: args.key, id: args.id);
    },
  );
}

class SpellItemEnchantmentDetailRouteArgs {
  const SpellItemEnchantmentDetailRouteArgs({this.key, this.id});

  final _i61.Key? key;

  final int? id;

  @override
  String toString() {
    return 'SpellItemEnchantmentDetailRouteArgs{key: $key, id: $id}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SpellItemEnchantmentDetailRouteArgs) return false;
    return key == other.key && id == other.id;
  }

  @override
  int get hashCode => key.hashCode ^ id.hashCode;
}

/// generated route for
/// [_i54.SpellItemEnchantmentListPage]
class SpellItemEnchantmentListRoute extends _i60.PageRouteInfo<void> {
  const SpellItemEnchantmentListRoute({List<_i60.PageRouteInfo>? children})
    : super(SpellItemEnchantmentListRoute.name, initialChildren: children);

  static const String name = 'SpellItemEnchantmentListRoute';

  static _i60.PageInfo page = _i60.PageInfo(
    name,
    builder: (data) {
      return const _i54.SpellItemEnchantmentListPage();
    },
  );
}

/// generated route for
/// [_i55.SpellListPage]
class SpellListRoute extends _i60.PageRouteInfo<void> {
  const SpellListRoute({List<_i60.PageRouteInfo>? children})
    : super(SpellListRoute.name, initialChildren: children);

  static const String name = 'SpellListRoute';

  static _i60.PageInfo page = _i60.PageInfo(
    name,
    builder: (data) {
      return const _i55.SpellListPage();
    },
  );
}

/// generated route for
/// [_i56.TalentDetailPage]
class TalentDetailRoute extends _i60.PageRouteInfo<TalentDetailRouteArgs> {
  TalentDetailRoute({
    _i61.Key? key,
    int? id,
    List<_i60.PageRouteInfo>? children,
  }) : super(
         TalentDetailRoute.name,
         args: TalentDetailRouteArgs(key: key, id: id),
         initialChildren: children,
       );

  static const String name = 'TalentDetailRoute';

  static _i60.PageInfo page = _i60.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TalentDetailRouteArgs>(
        orElse: () => const TalentDetailRouteArgs(),
      );
      return _i56.TalentDetailPage(key: args.key, id: args.id);
    },
  );
}

class TalentDetailRouteArgs {
  const TalentDetailRouteArgs({this.key, this.id});

  final _i61.Key? key;

  final int? id;

  @override
  String toString() {
    return 'TalentDetailRouteArgs{key: $key, id: $id}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! TalentDetailRouteArgs) return false;
    return key == other.key && id == other.id;
  }

  @override
  int get hashCode => key.hashCode ^ id.hashCode;
}

/// generated route for
/// [_i57.TalentListPage]
class TalentListRoute extends _i60.PageRouteInfo<void> {
  const TalentListRoute({List<_i60.PageRouteInfo>? children})
    : super(TalentListRoute.name, initialChildren: children);

  static const String name = 'TalentListRoute';

  static _i60.PageInfo page = _i60.PageInfo(
    name,
    builder: (data) {
      return const _i57.TalentListPage();
    },
  );
}

/// generated route for
/// [_i58.TextContentDetailPage]
class TextContentDetailRoute
    extends _i60.PageRouteInfo<TextContentDetailRouteArgs> {
  TextContentDetailRoute({
    _i61.Key? key,
    int? id,
    String? label,
    List<_i60.PageRouteInfo>? children,
  }) : super(
         TextContentDetailRoute.name,
         args: TextContentDetailRouteArgs(key: key, id: id, label: label),
         initialChildren: children,
       );

  static const String name = 'TextContentDetailRoute';

  static _i60.PageInfo page = _i60.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TextContentDetailRouteArgs>(
        orElse: () => const TextContentDetailRouteArgs(),
      );
      return _i58.TextContentDetailPage(
        key: args.key,
        id: args.id,
        label: args.label,
      );
    },
  );
}

class TextContentDetailRouteArgs {
  const TextContentDetailRouteArgs({this.key, this.id, this.label});

  final _i61.Key? key;

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
/// [_i59.TextContentListPage]
class TextContentListRoute extends _i60.PageRouteInfo<void> {
  const TextContentListRoute({List<_i60.PageRouteInfo>? children})
    : super(TextContentListRoute.name, initialChildren: children);

  static const String name = 'TextContentListRoute';

  static _i60.PageInfo page = _i60.PageInfo(
    name,
    builder: (data) {
      return const _i59.TextContentListPage();
    },
  );
}
