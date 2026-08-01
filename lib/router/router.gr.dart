// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i58;
import 'package:flutter/material.dart' as _i59;
import 'package:foxy/entity/condition_entity.dart' as _i60;
import 'package:foxy/entity/gossip_menu_entity.dart' as _i61;
import 'package:foxy/entity/player_create_info_entity.dart' as _i62;
import 'package:foxy/entity/reference_loot_template_entity.dart' as _i63;
import 'package:foxy/entity/smart_script_entity.dart' as _i64;
import 'package:foxy/page/achievement/achievement_detail_page.dart' as _i1;
import 'package:foxy/page/achievement/achievement_list_page.dart' as _i2;
import 'package:foxy/page/area_table/area_table_detail_page.dart' as _i3;
import 'package:foxy/page/area_table/area_table_list_page.dart' as _i4;
import 'package:foxy/page/bootstrap/bootstrap_page.dart' as _i5;
import 'package:foxy/page/condition/condition_detail_page.dart' as _i6;
import 'package:foxy/page/condition/condition_list_page.dart' as _i7;
import 'package:foxy/page/creature_template/creature_template_detail_page.dart'
    as _i8;
import 'package:foxy/page/creature_template/creature_template_list_page.dart'
    as _i9;
import 'package:foxy/page/currency_type/currency_type_detail_page.dart' as _i10;
import 'package:foxy/page/currency_type/currency_type_list_page.dart' as _i11;
import 'package:foxy/page/dashboard/dashboard_page.dart' as _i12;
import 'package:foxy/page/emote_text/emote_text_detail_page.dart' as _i13;
import 'package:foxy/page/emote_text/emote_text_list_page.dart' as _i14;
import 'package:foxy/page/game_object/game_object_template_detail_page.dart'
    as _i15;
import 'package:foxy/page/game_object/game_object_template_list_page.dart'
    as _i16;
import 'package:foxy/page/gem_property/gem_property_detail_page.dart' as _i17;
import 'package:foxy/page/gem_property/gem_property_list_page.dart' as _i18;
import 'package:foxy/page/glyph_property/glyph_property_detail_page.dart'
    as _i19;
import 'package:foxy/page/glyph_property/glyph_property_list_page.dart' as _i20;
import 'package:foxy/page/gossip_menu/gossip_menu_detail_page.dart' as _i21;
import 'package:foxy/page/gossip_menu/gossip_menu_list_page.dart' as _i22;
import 'package:foxy/page/item/item_template_detail_page.dart' as _i27;
import 'package:foxy/page/item/item_template_list_page.dart' as _i28;
import 'package:foxy/page/item_extended_cost/item_extended_cost_detail_page.dart'
    as _i23;
import 'package:foxy/page/item_extended_cost/item_extended_cost_list_page.dart'
    as _i24;
import 'package:foxy/page/item_set/item_set_detail_page.dart' as _i25;
import 'package:foxy/page/item_set/item_set_list_page.dart' as _i26;
import 'package:foxy/page/more/more_page.dart' as _i29;
import 'package:foxy/page/page_text/page_text_detail_page.dart' as _i30;
import 'package:foxy/page/page_text/page_text_list_page.dart' as _i31;
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
    extends _i58.PageRouteInfo<AchievementDetailRouteArgs> {
  static const String name = 'AchievementDetailRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AchievementDetailRouteArgs>(
        orElse: () => const AchievementDetailRouteArgs(),
      );
      return _i1.AchievementDetailPage(
        key: args.key,
        achievementKey: args.achievementKey,
      );
    },
  );

  AchievementDetailRoute({
    _i59.Key? key,
    int? achievementKey,
    List<_i58.PageRouteInfo>? children,
  }) : super(
         AchievementDetailRoute.name,
         args: AchievementDetailRouteArgs(
           key: key,
           achievementKey: achievementKey,
         ),
         initialChildren: children,
       );
}

class AchievementDetailRouteArgs {
  final _i59.Key? key;

  final int? achievementKey;

  const AchievementDetailRouteArgs({this.key, this.achievementKey});

  @override
  int get hashCode => key.hashCode ^ achievementKey.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AchievementDetailRouteArgs) return false;
    return key == other.key && achievementKey == other.achievementKey;
  }

  @override
  String toString() {
    return 'AchievementDetailRouteArgs{key: $key, achievementKey: $achievementKey}';
  }
}

/// generated route for
/// [_i2.AchievementListPage]
class AchievementListRoute extends _i58.PageRouteInfo<void> {
  static const String name = 'AchievementListRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      return const _i2.AchievementListPage();
    },
  );

  const AchievementListRoute({List<_i58.PageRouteInfo>? children})
    : super(AchievementListRoute.name, initialChildren: children);
}

/// generated route for
/// [_i3.AreaTableDetailPage]
class AreaTableDetailRoute
    extends _i58.PageRouteInfo<AreaTableDetailRouteArgs> {
  static const String name = 'AreaTableDetailRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AreaTableDetailRouteArgs>(
        orElse: () => const AreaTableDetailRouteArgs(),
      );
      return _i3.AreaTableDetailPage(
        key: args.key,
        areaTableKey: args.areaTableKey,
      );
    },
  );

  AreaTableDetailRoute({
    _i59.Key? key,
    int? areaTableKey,
    List<_i58.PageRouteInfo>? children,
  }) : super(
         AreaTableDetailRoute.name,
         args: AreaTableDetailRouteArgs(key: key, areaTableKey: areaTableKey),
         initialChildren: children,
       );
}

class AreaTableDetailRouteArgs {
  final _i59.Key? key;

  final int? areaTableKey;

  const AreaTableDetailRouteArgs({this.key, this.areaTableKey});

  @override
  int get hashCode => key.hashCode ^ areaTableKey.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AreaTableDetailRouteArgs) return false;
    return key == other.key && areaTableKey == other.areaTableKey;
  }

  @override
  String toString() {
    return 'AreaTableDetailRouteArgs{key: $key, areaTableKey: $areaTableKey}';
  }
}

/// generated route for
/// [_i4.AreaTableListPage]
class AreaTableListRoute extends _i58.PageRouteInfo<void> {
  static const String name = 'AreaTableListRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      return const _i4.AreaTableListPage();
    },
  );

  const AreaTableListRoute({List<_i58.PageRouteInfo>? children})
    : super(AreaTableListRoute.name, initialChildren: children);
}

/// generated route for
/// [_i5.BootstrapPage]
class BootstrapRoute extends _i58.PageRouteInfo<void> {
  static const String name = 'BootstrapRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      return const _i5.BootstrapPage();
    },
  );

  const BootstrapRoute({List<_i58.PageRouteInfo>? children})
    : super(BootstrapRoute.name, initialChildren: children);
}

/// generated route for
/// [_i6.ConditionDetailPage]
class ConditionDetailRoute
    extends _i58.PageRouteInfo<ConditionDetailRouteArgs> {
  static const String name = 'ConditionDetailRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ConditionDetailRouteArgs>(
        orElse: () => const ConditionDetailRouteArgs(),
      );
      return _i6.ConditionDetailPage(
        key: args.key,
        conditionKey: args.conditionKey,
      );
    },
  );

  ConditionDetailRoute({
    _i59.Key? key,
    _i60.ConditionKey? conditionKey,
    List<_i58.PageRouteInfo>? children,
  }) : super(
         ConditionDetailRoute.name,
         args: ConditionDetailRouteArgs(key: key, conditionKey: conditionKey),
         initialChildren: children,
       );
}

class ConditionDetailRouteArgs {
  final _i59.Key? key;

  final _i60.ConditionKey? conditionKey;

  const ConditionDetailRouteArgs({this.key, this.conditionKey});

  @override
  int get hashCode => key.hashCode ^ conditionKey.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ConditionDetailRouteArgs) return false;
    return key == other.key && conditionKey == other.conditionKey;
  }

  @override
  String toString() {
    return 'ConditionDetailRouteArgs{key: $key, conditionKey: $conditionKey}';
  }
}

/// generated route for
/// [_i7.ConditionListPage]
class ConditionListRoute extends _i58.PageRouteInfo<void> {
  static const String name = 'ConditionListRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      return const _i7.ConditionListPage();
    },
  );

  const ConditionListRoute({List<_i58.PageRouteInfo>? children})
    : super(ConditionListRoute.name, initialChildren: children);
}

/// generated route for
/// [_i8.CreatureTemplateDetailPage]
class CreatureTemplateDetailRoute
    extends _i58.PageRouteInfo<CreatureTemplateDetailRouteArgs> {
  static const String name = 'CreatureTemplateDetailRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CreatureTemplateDetailRouteArgs>(
        orElse: () => const CreatureTemplateDetailRouteArgs(),
      );
      return _i8.CreatureTemplateDetailPage(
        key: args.key,
        creatureTemplateKey: args.creatureTemplateKey,
      );
    },
  );

  CreatureTemplateDetailRoute({
    _i59.Key? key,
    int? creatureTemplateKey,
    List<_i58.PageRouteInfo>? children,
  }) : super(
         CreatureTemplateDetailRoute.name,
         args: CreatureTemplateDetailRouteArgs(
           key: key,
           creatureTemplateKey: creatureTemplateKey,
         ),
         initialChildren: children,
       );
}

class CreatureTemplateDetailRouteArgs {
  final _i59.Key? key;

  final int? creatureTemplateKey;

  const CreatureTemplateDetailRouteArgs({this.key, this.creatureTemplateKey});

  @override
  int get hashCode => key.hashCode ^ creatureTemplateKey.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CreatureTemplateDetailRouteArgs) return false;
    return key == other.key && creatureTemplateKey == other.creatureTemplateKey;
  }

  @override
  String toString() {
    return 'CreatureTemplateDetailRouteArgs{key: $key, creatureTemplateKey: $creatureTemplateKey}';
  }
}

/// generated route for
/// [_i9.CreatureTemplateListPage]
class CreatureTemplateListRoute extends _i58.PageRouteInfo<void> {
  static const String name = 'CreatureTemplateListRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      return const _i9.CreatureTemplateListPage();
    },
  );

  const CreatureTemplateListRoute({List<_i58.PageRouteInfo>? children})
    : super(CreatureTemplateListRoute.name, initialChildren: children);
}

/// generated route for
/// [_i10.CurrencyTypeDetailPage]
class CurrencyTypeDetailRoute
    extends _i58.PageRouteInfo<CurrencyTypeDetailRouteArgs> {
  static const String name = 'CurrencyTypeDetailRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CurrencyTypeDetailRouteArgs>(
        orElse: () => const CurrencyTypeDetailRouteArgs(),
      );
      return _i10.CurrencyTypeDetailPage(
        key: args.key,
        currencyTypeKey: args.currencyTypeKey,
      );
    },
  );

  CurrencyTypeDetailRoute({
    _i59.Key? key,
    int? currencyTypeKey,
    List<_i58.PageRouteInfo>? children,
  }) : super(
         CurrencyTypeDetailRoute.name,
         args: CurrencyTypeDetailRouteArgs(
           key: key,
           currencyTypeKey: currencyTypeKey,
         ),
         initialChildren: children,
       );
}

class CurrencyTypeDetailRouteArgs {
  final _i59.Key? key;

  final int? currencyTypeKey;

  const CurrencyTypeDetailRouteArgs({this.key, this.currencyTypeKey});

  @override
  int get hashCode => key.hashCode ^ currencyTypeKey.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CurrencyTypeDetailRouteArgs) return false;
    return key == other.key && currencyTypeKey == other.currencyTypeKey;
  }

  @override
  String toString() {
    return 'CurrencyTypeDetailRouteArgs{key: $key, currencyTypeKey: $currencyTypeKey}';
  }
}

/// generated route for
/// [_i11.CurrencyTypeListPage]
class CurrencyTypeListRoute extends _i58.PageRouteInfo<void> {
  static const String name = 'CurrencyTypeListRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      return const _i11.CurrencyTypeListPage();
    },
  );

  const CurrencyTypeListRoute({List<_i58.PageRouteInfo>? children})
    : super(CurrencyTypeListRoute.name, initialChildren: children);
}

/// generated route for
/// [_i12.DashboardPage]
class DashboardRoute extends _i58.PageRouteInfo<void> {
  static const String name = 'DashboardRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      return const _i12.DashboardPage();
    },
  );

  const DashboardRoute({List<_i58.PageRouteInfo>? children})
    : super(DashboardRoute.name, initialChildren: children);
}

/// generated route for
/// [_i13.EmoteTextDetailPage]
class EmoteTextDetailRoute
    extends _i58.PageRouteInfo<EmoteTextDetailRouteArgs> {
  static const String name = 'EmoteTextDetailRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EmoteTextDetailRouteArgs>(
        orElse: () => const EmoteTextDetailRouteArgs(),
      );
      return _i13.EmoteTextDetailPage(
        key: args.key,
        emoteTextKey: args.emoteTextKey,
      );
    },
  );

  EmoteTextDetailRoute({
    _i59.Key? key,
    int? emoteTextKey,
    List<_i58.PageRouteInfo>? children,
  }) : super(
         EmoteTextDetailRoute.name,
         args: EmoteTextDetailRouteArgs(key: key, emoteTextKey: emoteTextKey),
         initialChildren: children,
       );
}

class EmoteTextDetailRouteArgs {
  final _i59.Key? key;

  final int? emoteTextKey;

  const EmoteTextDetailRouteArgs({this.key, this.emoteTextKey});

  @override
  int get hashCode => key.hashCode ^ emoteTextKey.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! EmoteTextDetailRouteArgs) return false;
    return key == other.key && emoteTextKey == other.emoteTextKey;
  }

  @override
  String toString() {
    return 'EmoteTextDetailRouteArgs{key: $key, emoteTextKey: $emoteTextKey}';
  }
}

/// generated route for
/// [_i14.EmoteTextListPage]
class EmoteTextListRoute extends _i58.PageRouteInfo<void> {
  static const String name = 'EmoteTextListRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      return const _i14.EmoteTextListPage();
    },
  );

  const EmoteTextListRoute({List<_i58.PageRouteInfo>? children})
    : super(EmoteTextListRoute.name, initialChildren: children);
}

/// generated route for
/// [_i15.GameObjectTemplateDetailPage]
class GameObjectTemplateDetailRoute
    extends _i58.PageRouteInfo<GameObjectTemplateDetailRouteArgs> {
  static const String name = 'GameObjectTemplateDetailRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<GameObjectTemplateDetailRouteArgs>(
        orElse: () => const GameObjectTemplateDetailRouteArgs(),
      );
      return _i15.GameObjectTemplateDetailPage(
        key: args.key,
        gameObjectTemplateKey: args.gameObjectTemplateKey,
      );
    },
  );

  GameObjectTemplateDetailRoute({
    _i59.Key? key,
    int? gameObjectTemplateKey,
    List<_i58.PageRouteInfo>? children,
  }) : super(
         GameObjectTemplateDetailRoute.name,
         args: GameObjectTemplateDetailRouteArgs(
           key: key,
           gameObjectTemplateKey: gameObjectTemplateKey,
         ),
         initialChildren: children,
       );
}

class GameObjectTemplateDetailRouteArgs {
  final _i59.Key? key;

  final int? gameObjectTemplateKey;

  const GameObjectTemplateDetailRouteArgs({
    this.key,
    this.gameObjectTemplateKey,
  });

  @override
  int get hashCode => key.hashCode ^ gameObjectTemplateKey.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! GameObjectTemplateDetailRouteArgs) return false;
    return key == other.key &&
        gameObjectTemplateKey == other.gameObjectTemplateKey;
  }

  @override
  String toString() {
    return 'GameObjectTemplateDetailRouteArgs{key: $key, gameObjectTemplateKey: $gameObjectTemplateKey}';
  }
}

/// generated route for
/// [_i16.GameObjectTemplateListPage]
class GameObjectTemplateListRoute extends _i58.PageRouteInfo<void> {
  static const String name = 'GameObjectTemplateListRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      return const _i16.GameObjectTemplateListPage();
    },
  );

  const GameObjectTemplateListRoute({List<_i58.PageRouteInfo>? children})
    : super(GameObjectTemplateListRoute.name, initialChildren: children);
}

/// generated route for
/// [_i17.GemPropertyDetailPage]
class GemPropertyDetailRoute
    extends _i58.PageRouteInfo<GemPropertyDetailRouteArgs> {
  static const String name = 'GemPropertyDetailRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<GemPropertyDetailRouteArgs>(
        orElse: () => const GemPropertyDetailRouteArgs(),
      );
      return _i17.GemPropertyDetailPage(
        key: args.key,
        gemPropertyKey: args.gemPropertyKey,
      );
    },
  );

  GemPropertyDetailRoute({
    _i59.Key? key,
    int? gemPropertyKey,
    List<_i58.PageRouteInfo>? children,
  }) : super(
         GemPropertyDetailRoute.name,
         args: GemPropertyDetailRouteArgs(
           key: key,
           gemPropertyKey: gemPropertyKey,
         ),
         initialChildren: children,
       );
}

class GemPropertyDetailRouteArgs {
  final _i59.Key? key;

  final int? gemPropertyKey;

  const GemPropertyDetailRouteArgs({this.key, this.gemPropertyKey});

  @override
  int get hashCode => key.hashCode ^ gemPropertyKey.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! GemPropertyDetailRouteArgs) return false;
    return key == other.key && gemPropertyKey == other.gemPropertyKey;
  }

  @override
  String toString() {
    return 'GemPropertyDetailRouteArgs{key: $key, gemPropertyKey: $gemPropertyKey}';
  }
}

/// generated route for
/// [_i18.GemPropertyListPage]
class GemPropertyListRoute extends _i58.PageRouteInfo<void> {
  static const String name = 'GemPropertyListRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      return const _i18.GemPropertyListPage();
    },
  );

  const GemPropertyListRoute({List<_i58.PageRouteInfo>? children})
    : super(GemPropertyListRoute.name, initialChildren: children);
}

/// generated route for
/// [_i19.GlyphPropertyDetailPage]
class GlyphPropertyDetailRoute
    extends _i58.PageRouteInfo<GlyphPropertyDetailRouteArgs> {
  static const String name = 'GlyphPropertyDetailRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<GlyphPropertyDetailRouteArgs>(
        orElse: () => const GlyphPropertyDetailRouteArgs(),
      );
      return _i19.GlyphPropertyDetailPage(
        key: args.key,
        glyphPropertyKey: args.glyphPropertyKey,
      );
    },
  );

  GlyphPropertyDetailRoute({
    _i59.Key? key,
    int? glyphPropertyKey,
    List<_i58.PageRouteInfo>? children,
  }) : super(
         GlyphPropertyDetailRoute.name,
         args: GlyphPropertyDetailRouteArgs(
           key: key,
           glyphPropertyKey: glyphPropertyKey,
         ),
         initialChildren: children,
       );
}

class GlyphPropertyDetailRouteArgs {
  final _i59.Key? key;

  final int? glyphPropertyKey;

  const GlyphPropertyDetailRouteArgs({this.key, this.glyphPropertyKey});

  @override
  int get hashCode => key.hashCode ^ glyphPropertyKey.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! GlyphPropertyDetailRouteArgs) return false;
    return key == other.key && glyphPropertyKey == other.glyphPropertyKey;
  }

  @override
  String toString() {
    return 'GlyphPropertyDetailRouteArgs{key: $key, glyphPropertyKey: $glyphPropertyKey}';
  }
}

/// generated route for
/// [_i20.GlyphPropertyListPage]
class GlyphPropertyListRoute extends _i58.PageRouteInfo<void> {
  static const String name = 'GlyphPropertyListRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      return const _i20.GlyphPropertyListPage();
    },
  );

  const GlyphPropertyListRoute({List<_i58.PageRouteInfo>? children})
    : super(GlyphPropertyListRoute.name, initialChildren: children);
}

/// generated route for
/// [_i21.GossipMenuDetailPage]
class GossipMenuDetailRoute
    extends _i58.PageRouteInfo<GossipMenuDetailRouteArgs> {
  static const String name = 'GossipMenuDetailRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<GossipMenuDetailRouteArgs>(
        orElse: () => const GossipMenuDetailRouteArgs(),
      );
      return _i21.GossipMenuDetailPage(
        key: args.key,
        gossipMenuKey: args.gossipMenuKey,
      );
    },
  );

  GossipMenuDetailRoute({
    _i59.Key? key,
    _i61.GossipMenuKey? gossipMenuKey,
    List<_i58.PageRouteInfo>? children,
  }) : super(
         GossipMenuDetailRoute.name,
         args: GossipMenuDetailRouteArgs(
           key: key,
           gossipMenuKey: gossipMenuKey,
         ),
         initialChildren: children,
       );
}

class GossipMenuDetailRouteArgs {
  final _i59.Key? key;

  final _i61.GossipMenuKey? gossipMenuKey;

  const GossipMenuDetailRouteArgs({this.key, this.gossipMenuKey});

  @override
  int get hashCode => key.hashCode ^ gossipMenuKey.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! GossipMenuDetailRouteArgs) return false;
    return key == other.key && gossipMenuKey == other.gossipMenuKey;
  }

  @override
  String toString() {
    return 'GossipMenuDetailRouteArgs{key: $key, gossipMenuKey: $gossipMenuKey}';
  }
}

/// generated route for
/// [_i22.GossipMenuListPage]
class GossipMenuListRoute extends _i58.PageRouteInfo<void> {
  static const String name = 'GossipMenuListRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      return const _i22.GossipMenuListPage();
    },
  );

  const GossipMenuListRoute({List<_i58.PageRouteInfo>? children})
    : super(GossipMenuListRoute.name, initialChildren: children);
}

/// generated route for
/// [_i23.ItemExtendedCostDetailPage]
class ItemExtendedCostDetailRoute
    extends _i58.PageRouteInfo<ItemExtendedCostDetailRouteArgs> {
  static const String name = 'ItemExtendedCostDetailRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ItemExtendedCostDetailRouteArgs>(
        orElse: () => const ItemExtendedCostDetailRouteArgs(),
      );
      return _i23.ItemExtendedCostDetailPage(
        key: args.key,
        itemExtendedCostKey: args.itemExtendedCostKey,
      );
    },
  );

  ItemExtendedCostDetailRoute({
    _i59.Key? key,
    int? itemExtendedCostKey,
    List<_i58.PageRouteInfo>? children,
  }) : super(
         ItemExtendedCostDetailRoute.name,
         args: ItemExtendedCostDetailRouteArgs(
           key: key,
           itemExtendedCostKey: itemExtendedCostKey,
         ),
         initialChildren: children,
       );
}

class ItemExtendedCostDetailRouteArgs {
  final _i59.Key? key;

  final int? itemExtendedCostKey;

  const ItemExtendedCostDetailRouteArgs({this.key, this.itemExtendedCostKey});

  @override
  int get hashCode => key.hashCode ^ itemExtendedCostKey.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ItemExtendedCostDetailRouteArgs) return false;
    return key == other.key && itemExtendedCostKey == other.itemExtendedCostKey;
  }

  @override
  String toString() {
    return 'ItemExtendedCostDetailRouteArgs{key: $key, itemExtendedCostKey: $itemExtendedCostKey}';
  }
}

/// generated route for
/// [_i24.ItemExtendedCostListPage]
class ItemExtendedCostListRoute extends _i58.PageRouteInfo<void> {
  static const String name = 'ItemExtendedCostListRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      return const _i24.ItemExtendedCostListPage();
    },
  );

  const ItemExtendedCostListRoute({List<_i58.PageRouteInfo>? children})
    : super(ItemExtendedCostListRoute.name, initialChildren: children);
}

/// generated route for
/// [_i25.ItemSetDetailPage]
class ItemSetDetailRoute extends _i58.PageRouteInfo<ItemSetDetailRouteArgs> {
  static const String name = 'ItemSetDetailRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ItemSetDetailRouteArgs>(
        orElse: () => const ItemSetDetailRouteArgs(),
      );
      return _i25.ItemSetDetailPage(key: args.key, itemSetKey: args.itemSetKey);
    },
  );

  ItemSetDetailRoute({
    _i59.Key? key,
    int? itemSetKey,
    List<_i58.PageRouteInfo>? children,
  }) : super(
         ItemSetDetailRoute.name,
         args: ItemSetDetailRouteArgs(key: key, itemSetKey: itemSetKey),
         initialChildren: children,
       );
}

class ItemSetDetailRouteArgs {
  final _i59.Key? key;

  final int? itemSetKey;

  const ItemSetDetailRouteArgs({this.key, this.itemSetKey});

  @override
  int get hashCode => key.hashCode ^ itemSetKey.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ItemSetDetailRouteArgs) return false;
    return key == other.key && itemSetKey == other.itemSetKey;
  }

  @override
  String toString() {
    return 'ItemSetDetailRouteArgs{key: $key, itemSetKey: $itemSetKey}';
  }
}

/// generated route for
/// [_i26.ItemSetListPage]
class ItemSetListRoute extends _i58.PageRouteInfo<void> {
  static const String name = 'ItemSetListRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      return const _i26.ItemSetListPage();
    },
  );

  const ItemSetListRoute({List<_i58.PageRouteInfo>? children})
    : super(ItemSetListRoute.name, initialChildren: children);
}

/// generated route for
/// [_i27.ItemTemplateDetailPage]
class ItemTemplateDetailRoute
    extends _i58.PageRouteInfo<ItemTemplateDetailRouteArgs> {
  static const String name = 'ItemTemplateDetailRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ItemTemplateDetailRouteArgs>(
        orElse: () => const ItemTemplateDetailRouteArgs(),
      );
      return _i27.ItemTemplateDetailPage(
        key: args.key,
        itemTemplateKey: args.itemTemplateKey,
      );
    },
  );

  ItemTemplateDetailRoute({
    _i59.Key? key,
    int? itemTemplateKey,
    List<_i58.PageRouteInfo>? children,
  }) : super(
         ItemTemplateDetailRoute.name,
         args: ItemTemplateDetailRouteArgs(
           key: key,
           itemTemplateKey: itemTemplateKey,
         ),
         initialChildren: children,
       );
}

class ItemTemplateDetailRouteArgs {
  final _i59.Key? key;

  final int? itemTemplateKey;

  const ItemTemplateDetailRouteArgs({this.key, this.itemTemplateKey});

  @override
  int get hashCode => key.hashCode ^ itemTemplateKey.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ItemTemplateDetailRouteArgs) return false;
    return key == other.key && itemTemplateKey == other.itemTemplateKey;
  }

  @override
  String toString() {
    return 'ItemTemplateDetailRouteArgs{key: $key, itemTemplateKey: $itemTemplateKey}';
  }
}

/// generated route for
/// [_i28.ItemTemplateListPage]
class ItemTemplateListRoute extends _i58.PageRouteInfo<void> {
  static const String name = 'ItemTemplateListRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      return const _i28.ItemTemplateListPage();
    },
  );

  const ItemTemplateListRoute({List<_i58.PageRouteInfo>? children})
    : super(ItemTemplateListRoute.name, initialChildren: children);
}

/// generated route for
/// [_i29.MorePage]
class MoreRoute extends _i58.PageRouteInfo<void> {
  static const String name = 'MoreRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      return const _i29.MorePage();
    },
  );

  const MoreRoute({List<_i58.PageRouteInfo>? children})
    : super(MoreRoute.name, initialChildren: children);
}

/// generated route for
/// [_i32.PlayerCreateInfoDetailPage]
class PlayerCreateInfoDetailRoute
    extends _i58.PageRouteInfo<PlayerCreateInfoDetailRouteArgs> {
  static const String name = 'PlayerCreateInfoDetailRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PlayerCreateInfoDetailRouteArgs>(
        orElse: () => const PlayerCreateInfoDetailRouteArgs(),
      );
      return _i32.PlayerCreateInfoDetailPage(
        key: args.key,
        playerCreateInfoKey: args.playerCreateInfoKey,
      );
    },
  );

  PlayerCreateInfoDetailRoute({
    _i59.Key? key,
    _i62.PlayerCreateInfoKey? playerCreateInfoKey,
    List<_i58.PageRouteInfo>? children,
  }) : super(
         PlayerCreateInfoDetailRoute.name,
         args: PlayerCreateInfoDetailRouteArgs(
           key: key,
           playerCreateInfoKey: playerCreateInfoKey,
         ),
         initialChildren: children,
       );
}

class PlayerCreateInfoDetailRouteArgs {
  final _i59.Key? key;

  final _i62.PlayerCreateInfoKey? playerCreateInfoKey;

  const PlayerCreateInfoDetailRouteArgs({this.key, this.playerCreateInfoKey});

  @override
  int get hashCode => key.hashCode ^ playerCreateInfoKey.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PlayerCreateInfoDetailRouteArgs) return false;
    return key == other.key && playerCreateInfoKey == other.playerCreateInfoKey;
  }

  @override
  String toString() {
    return 'PlayerCreateInfoDetailRouteArgs{key: $key, playerCreateInfoKey: $playerCreateInfoKey}';
  }
}

/// generated route for
/// [_i33.PlayerCreateInfoListPage]
class PlayerCreateInfoListRoute extends _i58.PageRouteInfo<void> {
  static const String name = 'PlayerCreateInfoListRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      return const _i33.PlayerCreateInfoListPage();
    },
  );

  const PlayerCreateInfoListRoute({List<_i58.PageRouteInfo>? children})
    : super(PlayerCreateInfoListRoute.name, initialChildren: children);
}

/// generated route for
/// [_i34.QuestFactionRewardDetailPage]
class QuestFactionRewardDetailRoute
    extends _i58.PageRouteInfo<QuestFactionRewardDetailRouteArgs> {
  static const String name = 'QuestFactionRewardDetailRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<QuestFactionRewardDetailRouteArgs>(
        orElse: () => const QuestFactionRewardDetailRouteArgs(),
      );
      return _i34.QuestFactionRewardDetailPage(
        key: args.key,
        questFactionRewardKey: args.questFactionRewardKey,
      );
    },
  );

  QuestFactionRewardDetailRoute({
    _i59.Key? key,
    int? questFactionRewardKey,
    List<_i58.PageRouteInfo>? children,
  }) : super(
         QuestFactionRewardDetailRoute.name,
         args: QuestFactionRewardDetailRouteArgs(
           key: key,
           questFactionRewardKey: questFactionRewardKey,
         ),
         initialChildren: children,
       );
}

class QuestFactionRewardDetailRouteArgs {
  final _i59.Key? key;

  final int? questFactionRewardKey;

  const QuestFactionRewardDetailRouteArgs({
    this.key,
    this.questFactionRewardKey,
  });

  @override
  int get hashCode => key.hashCode ^ questFactionRewardKey.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! QuestFactionRewardDetailRouteArgs) return false;
    return key == other.key &&
        questFactionRewardKey == other.questFactionRewardKey;
  }

  @override
  String toString() {
    return 'QuestFactionRewardDetailRouteArgs{key: $key, questFactionRewardKey: $questFactionRewardKey}';
  }
}

/// generated route for
/// [_i35.QuestFactionRewardListPage]
class QuestFactionRewardListRoute extends _i58.PageRouteInfo<void> {
  static const String name = 'QuestFactionRewardListRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      return const _i35.QuestFactionRewardListPage();
    },
  );

  const QuestFactionRewardListRoute({List<_i58.PageRouteInfo>? children})
    : super(QuestFactionRewardListRoute.name, initialChildren: children);
}

/// generated route for
/// [_i36.QuestInfoDetailPage]
class QuestInfoDetailRoute
    extends _i58.PageRouteInfo<QuestInfoDetailRouteArgs> {
  static const String name = 'QuestInfoDetailRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<QuestInfoDetailRouteArgs>(
        orElse: () => const QuestInfoDetailRouteArgs(),
      );
      return _i36.QuestInfoDetailPage(
        key: args.key,
        questInfoKey: args.questInfoKey,
      );
    },
  );

  QuestInfoDetailRoute({
    _i59.Key? key,
    int? questInfoKey,
    List<_i58.PageRouteInfo>? children,
  }) : super(
         QuestInfoDetailRoute.name,
         args: QuestInfoDetailRouteArgs(key: key, questInfoKey: questInfoKey),
         initialChildren: children,
       );
}

class QuestInfoDetailRouteArgs {
  final _i59.Key? key;

  final int? questInfoKey;

  const QuestInfoDetailRouteArgs({this.key, this.questInfoKey});

  @override
  int get hashCode => key.hashCode ^ questInfoKey.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! QuestInfoDetailRouteArgs) return false;
    return key == other.key && questInfoKey == other.questInfoKey;
  }

  @override
  String toString() {
    return 'QuestInfoDetailRouteArgs{key: $key, questInfoKey: $questInfoKey}';
  }
}

/// generated route for
/// [_i37.QuestInfoListPage]
class QuestInfoListRoute extends _i58.PageRouteInfo<void> {
  static const String name = 'QuestInfoListRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      return const _i37.QuestInfoListPage();
    },
  );

  const QuestInfoListRoute({List<_i58.PageRouteInfo>? children})
    : super(QuestInfoListRoute.name, initialChildren: children);
}

/// generated route for
/// [_i38.QuestSortDetailPage]
class QuestSortDetailRoute
    extends _i58.PageRouteInfo<QuestSortDetailRouteArgs> {
  static const String name = 'QuestSortDetailRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<QuestSortDetailRouteArgs>(
        orElse: () => const QuestSortDetailRouteArgs(),
      );
      return _i38.QuestSortDetailPage(
        key: args.key,
        questSortKey: args.questSortKey,
      );
    },
  );

  QuestSortDetailRoute({
    _i59.Key? key,
    int? questSortKey,
    List<_i58.PageRouteInfo>? children,
  }) : super(
         QuestSortDetailRoute.name,
         args: QuestSortDetailRouteArgs(key: key, questSortKey: questSortKey),
         initialChildren: children,
       );
}

class QuestSortDetailRouteArgs {
  final _i59.Key? key;

  final int? questSortKey;

  const QuestSortDetailRouteArgs({this.key, this.questSortKey});

  @override
  int get hashCode => key.hashCode ^ questSortKey.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! QuestSortDetailRouteArgs) return false;
    return key == other.key && questSortKey == other.questSortKey;
  }

  @override
  String toString() {
    return 'QuestSortDetailRouteArgs{key: $key, questSortKey: $questSortKey}';
  }
}

/// generated route for
/// [_i39.QuestSortListPage]
class QuestSortListRoute extends _i58.PageRouteInfo<void> {
  static const String name = 'QuestSortListRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      return const _i39.QuestSortListPage();
    },
  );

  const QuestSortListRoute({List<_i58.PageRouteInfo>? children})
    : super(QuestSortListRoute.name, initialChildren: children);
}

/// generated route for
/// [_i40.QuestTemplateDetailPage]
class QuestTemplateDetailRoute
    extends _i58.PageRouteInfo<QuestTemplateDetailRouteArgs> {
  static const String name = 'QuestTemplateDetailRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<QuestTemplateDetailRouteArgs>(
        orElse: () => const QuestTemplateDetailRouteArgs(),
      );
      return _i40.QuestTemplateDetailPage(
        key: args.key,
        questTemplateKey: args.questTemplateKey,
      );
    },
  );

  QuestTemplateDetailRoute({
    _i59.Key? key,
    int? questTemplateKey,
    List<_i58.PageRouteInfo>? children,
  }) : super(
         QuestTemplateDetailRoute.name,
         args: QuestTemplateDetailRouteArgs(
           key: key,
           questTemplateKey: questTemplateKey,
         ),
         initialChildren: children,
       );
}

class QuestTemplateDetailRouteArgs {
  final _i59.Key? key;

  final int? questTemplateKey;

  const QuestTemplateDetailRouteArgs({this.key, this.questTemplateKey});

  @override
  int get hashCode => key.hashCode ^ questTemplateKey.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! QuestTemplateDetailRouteArgs) return false;
    return key == other.key && questTemplateKey == other.questTemplateKey;
  }

  @override
  String toString() {
    return 'QuestTemplateDetailRouteArgs{key: $key, questTemplateKey: $questTemplateKey}';
  }
}

/// generated route for
/// [_i41.QuestTemplateListPage]
class QuestTemplateListRoute extends _i58.PageRouteInfo<void> {
  static const String name = 'QuestTemplateListRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      return const _i41.QuestTemplateListPage();
    },
  );

  const QuestTemplateListRoute({List<_i58.PageRouteInfo>? children})
    : super(QuestTemplateListRoute.name, initialChildren: children);
}

/// generated route for
/// [_i42.ReferenceLootTemplateDetailPage]
class ReferenceLootTemplateDetailRoute
    extends _i58.PageRouteInfo<ReferenceLootTemplateDetailRouteArgs> {
  static const String name = 'ReferenceLootTemplateDetailRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ReferenceLootTemplateDetailRouteArgs>(
        orElse: () => const ReferenceLootTemplateDetailRouteArgs(),
      );
      return _i42.ReferenceLootTemplateDetailPage(
        key: args.key,
        referenceLootTemplateKey: args.referenceLootTemplateKey,
      );
    },
  );

  ReferenceLootTemplateDetailRoute({
    _i59.Key? key,
    _i63.ReferenceLootTemplateKey? referenceLootTemplateKey,
    List<_i58.PageRouteInfo>? children,
  }) : super(
         ReferenceLootTemplateDetailRoute.name,
         args: ReferenceLootTemplateDetailRouteArgs(
           key: key,
           referenceLootTemplateKey: referenceLootTemplateKey,
         ),
         initialChildren: children,
       );
}

class ReferenceLootTemplateDetailRouteArgs {
  final _i59.Key? key;

  final _i63.ReferenceLootTemplateKey? referenceLootTemplateKey;

  const ReferenceLootTemplateDetailRouteArgs({
    this.key,
    this.referenceLootTemplateKey,
  });

  @override
  int get hashCode => key.hashCode ^ referenceLootTemplateKey.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ReferenceLootTemplateDetailRouteArgs) return false;
    return key == other.key &&
        referenceLootTemplateKey == other.referenceLootTemplateKey;
  }

  @override
  String toString() {
    return 'ReferenceLootTemplateDetailRouteArgs{key: $key, referenceLootTemplateKey: $referenceLootTemplateKey}';
  }
}

/// generated route for
/// [_i43.ReferenceLootTemplateListPage]
class ReferenceLootTemplateListRoute extends _i58.PageRouteInfo<void> {
  static const String name = 'ReferenceLootTemplateListRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      return const _i43.ReferenceLootTemplateListPage();
    },
  );

  const ReferenceLootTemplateListRoute({List<_i58.PageRouteInfo>? children})
    : super(ReferenceLootTemplateListRoute.name, initialChildren: children);
}

/// generated route for
/// [_i30.PageTextDetailPage]
class RouteTextDetailRoute
    extends _i58.PageRouteInfo<RouteTextDetailRouteArgs> {
  static const String name = 'RouteTextDetailRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<RouteTextDetailRouteArgs>(
        orElse: () => const RouteTextDetailRouteArgs(),
      );
      return _i30.PageTextDetailPage(
        key: args.key,
        pageTextKey: args.pageTextKey,
      );
    },
  );

  RouteTextDetailRoute({
    _i59.Key? key,
    int? pageTextKey,
    List<_i58.PageRouteInfo>? children,
  }) : super(
         RouteTextDetailRoute.name,
         args: RouteTextDetailRouteArgs(key: key, pageTextKey: pageTextKey),
         initialChildren: children,
       );
}

class RouteTextDetailRouteArgs {
  final _i59.Key? key;

  final int? pageTextKey;

  const RouteTextDetailRouteArgs({this.key, this.pageTextKey});

  @override
  int get hashCode => key.hashCode ^ pageTextKey.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! RouteTextDetailRouteArgs) return false;
    return key == other.key && pageTextKey == other.pageTextKey;
  }

  @override
  String toString() {
    return 'RouteTextDetailRouteArgs{key: $key, pageTextKey: $pageTextKey}';
  }
}

/// generated route for
/// [_i31.PageTextListPage]
class RouteTextListRoute extends _i58.PageRouteInfo<void> {
  static const String name = 'RouteTextListRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      return const _i31.PageTextListPage();
    },
  );

  const RouteTextListRoute({List<_i58.PageRouteInfo>? children})
    : super(RouteTextListRoute.name, initialChildren: children);
}

/// generated route for
/// [_i44.ScaffoldPage]
class ScaffoldRoute extends _i58.PageRouteInfo<void> {
  static const String name = 'ScaffoldRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      return const _i44.ScaffoldPage();
    },
  );

  const ScaffoldRoute({List<_i58.PageRouteInfo>? children})
    : super(ScaffoldRoute.name, initialChildren: children);
}

/// generated route for
/// [_i45.ScalingStatDistributionDetailPage]
class ScalingStatDistributionDetailRoute
    extends _i58.PageRouteInfo<ScalingStatDistributionDetailRouteArgs> {
  static const String name = 'ScalingStatDistributionDetailRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ScalingStatDistributionDetailRouteArgs>(
        orElse: () => const ScalingStatDistributionDetailRouteArgs(),
      );
      return _i45.ScalingStatDistributionDetailPage(
        key: args.key,
        scalingStatDistributionKey: args.scalingStatDistributionKey,
      );
    },
  );

  ScalingStatDistributionDetailRoute({
    _i59.Key? key,
    int? scalingStatDistributionKey,
    List<_i58.PageRouteInfo>? children,
  }) : super(
         ScalingStatDistributionDetailRoute.name,
         args: ScalingStatDistributionDetailRouteArgs(
           key: key,
           scalingStatDistributionKey: scalingStatDistributionKey,
         ),
         initialChildren: children,
       );
}

class ScalingStatDistributionDetailRouteArgs {
  final _i59.Key? key;

  final int? scalingStatDistributionKey;

  const ScalingStatDistributionDetailRouteArgs({
    this.key,
    this.scalingStatDistributionKey,
  });

  @override
  int get hashCode => key.hashCode ^ scalingStatDistributionKey.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ScalingStatDistributionDetailRouteArgs) return false;
    return key == other.key &&
        scalingStatDistributionKey == other.scalingStatDistributionKey;
  }

  @override
  String toString() {
    return 'ScalingStatDistributionDetailRouteArgs{key: $key, scalingStatDistributionKey: $scalingStatDistributionKey}';
  }
}

/// generated route for
/// [_i46.ScalingStatDistributionListPage]
class ScalingStatDistributionListRoute extends _i58.PageRouteInfo<void> {
  static const String name = 'ScalingStatDistributionListRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      return const _i46.ScalingStatDistributionListPage();
    },
  );

  const ScalingStatDistributionListRoute({List<_i58.PageRouteInfo>? children})
    : super(ScalingStatDistributionListRoute.name, initialChildren: children);
}

/// generated route for
/// [_i47.ScalingStatValueDetailPage]
class ScalingStatValueDetailRoute
    extends _i58.PageRouteInfo<ScalingStatValueDetailRouteArgs> {
  static const String name = 'ScalingStatValueDetailRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ScalingStatValueDetailRouteArgs>(
        orElse: () => const ScalingStatValueDetailRouteArgs(),
      );
      return _i47.ScalingStatValueDetailPage(
        key: args.key,
        scalingStatValueKey: args.scalingStatValueKey,
      );
    },
  );

  ScalingStatValueDetailRoute({
    _i59.Key? key,
    int? scalingStatValueKey,
    List<_i58.PageRouteInfo>? children,
  }) : super(
         ScalingStatValueDetailRoute.name,
         args: ScalingStatValueDetailRouteArgs(
           key: key,
           scalingStatValueKey: scalingStatValueKey,
         ),
         initialChildren: children,
       );
}

class ScalingStatValueDetailRouteArgs {
  final _i59.Key? key;

  final int? scalingStatValueKey;

  const ScalingStatValueDetailRouteArgs({this.key, this.scalingStatValueKey});

  @override
  int get hashCode => key.hashCode ^ scalingStatValueKey.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ScalingStatValueDetailRouteArgs) return false;
    return key == other.key && scalingStatValueKey == other.scalingStatValueKey;
  }

  @override
  String toString() {
    return 'ScalingStatValueDetailRouteArgs{key: $key, scalingStatValueKey: $scalingStatValueKey}';
  }
}

/// generated route for
/// [_i48.ScalingStatValueListPage]
class ScalingStatValueListRoute extends _i58.PageRouteInfo<void> {
  static const String name = 'ScalingStatValueListRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      return const _i48.ScalingStatValueListPage();
    },
  );

  const ScalingStatValueListRoute({List<_i58.PageRouteInfo>? children})
    : super(ScalingStatValueListRoute.name, initialChildren: children);
}

/// generated route for
/// [_i49.SettingPage]
class SettingRoute extends _i58.PageRouteInfo<void> {
  static const String name = 'SettingRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      return const _i49.SettingPage();
    },
  );

  const SettingRoute({List<_i58.PageRouteInfo>? children})
    : super(SettingRoute.name, initialChildren: children);
}

/// generated route for
/// [_i50.SmartScriptDetailPage]
class SmartScriptDetailRoute
    extends _i58.PageRouteInfo<SmartScriptDetailRouteArgs> {
  static const String name = 'SmartScriptDetailRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SmartScriptDetailRouteArgs>(
        orElse: () => const SmartScriptDetailRouteArgs(),
      );
      return _i50.SmartScriptDetailPage(
        key: args.key,
        scriptKey: args.scriptKey,
      );
    },
  );

  SmartScriptDetailRoute({
    _i59.Key? key,
    _i64.SmartScriptKey? scriptKey,
    List<_i58.PageRouteInfo>? children,
  }) : super(
         SmartScriptDetailRoute.name,
         args: SmartScriptDetailRouteArgs(key: key, scriptKey: scriptKey),
         initialChildren: children,
       );
}

class SmartScriptDetailRouteArgs {
  final _i59.Key? key;

  final _i64.SmartScriptKey? scriptKey;

  const SmartScriptDetailRouteArgs({this.key, this.scriptKey});

  @override
  int get hashCode => key.hashCode ^ scriptKey.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SmartScriptDetailRouteArgs) return false;
    return key == other.key && scriptKey == other.scriptKey;
  }

  @override
  String toString() {
    return 'SmartScriptDetailRouteArgs{key: $key, scriptKey: $scriptKey}';
  }
}

/// generated route for
/// [_i51.SmartScriptListPage]
class SmartScriptListRoute extends _i58.PageRouteInfo<void> {
  static const String name = 'SmartScriptListRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      return const _i51.SmartScriptListPage();
    },
  );

  const SmartScriptListRoute({List<_i58.PageRouteInfo>? children})
    : super(SmartScriptListRoute.name, initialChildren: children);
}

/// generated route for
/// [_i52.SpellDetailPage]
class SpellDetailRoute extends _i58.PageRouteInfo<SpellDetailRouteArgs> {
  static const String name = 'SpellDetailRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SpellDetailRouteArgs>(
        orElse: () => const SpellDetailRouteArgs(),
      );
      return _i52.SpellDetailPage(key: args.key, spellKey: args.spellKey);
    },
  );

  SpellDetailRoute({
    _i59.Key? key,
    int? spellKey,
    List<_i58.PageRouteInfo>? children,
  }) : super(
         SpellDetailRoute.name,
         args: SpellDetailRouteArgs(key: key, spellKey: spellKey),
         initialChildren: children,
       );
}

class SpellDetailRouteArgs {
  final _i59.Key? key;

  final int? spellKey;

  const SpellDetailRouteArgs({this.key, this.spellKey});

  @override
  int get hashCode => key.hashCode ^ spellKey.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SpellDetailRouteArgs) return false;
    return key == other.key && spellKey == other.spellKey;
  }

  @override
  String toString() {
    return 'SpellDetailRouteArgs{key: $key, spellKey: $spellKey}';
  }
}

/// generated route for
/// [_i53.SpellItemEnchantmentDetailPage]
class SpellItemEnchantmentDetailRoute
    extends _i58.PageRouteInfo<SpellItemEnchantmentDetailRouteArgs> {
  static const String name = 'SpellItemEnchantmentDetailRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SpellItemEnchantmentDetailRouteArgs>(
        orElse: () => const SpellItemEnchantmentDetailRouteArgs(),
      );
      return _i53.SpellItemEnchantmentDetailPage(
        key: args.key,
        spellItemEnchantmentKey: args.spellItemEnchantmentKey,
      );
    },
  );

  SpellItemEnchantmentDetailRoute({
    _i59.Key? key,
    int? spellItemEnchantmentKey,
    List<_i58.PageRouteInfo>? children,
  }) : super(
         SpellItemEnchantmentDetailRoute.name,
         args: SpellItemEnchantmentDetailRouteArgs(
           key: key,
           spellItemEnchantmentKey: spellItemEnchantmentKey,
         ),
         initialChildren: children,
       );
}

class SpellItemEnchantmentDetailRouteArgs {
  final _i59.Key? key;

  final int? spellItemEnchantmentKey;

  const SpellItemEnchantmentDetailRouteArgs({
    this.key,
    this.spellItemEnchantmentKey,
  });

  @override
  int get hashCode => key.hashCode ^ spellItemEnchantmentKey.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SpellItemEnchantmentDetailRouteArgs) return false;
    return key == other.key &&
        spellItemEnchantmentKey == other.spellItemEnchantmentKey;
  }

  @override
  String toString() {
    return 'SpellItemEnchantmentDetailRouteArgs{key: $key, spellItemEnchantmentKey: $spellItemEnchantmentKey}';
  }
}

/// generated route for
/// [_i54.SpellItemEnchantmentListPage]
class SpellItemEnchantmentListRoute extends _i58.PageRouteInfo<void> {
  static const String name = 'SpellItemEnchantmentListRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      return const _i54.SpellItemEnchantmentListPage();
    },
  );

  const SpellItemEnchantmentListRoute({List<_i58.PageRouteInfo>? children})
    : super(SpellItemEnchantmentListRoute.name, initialChildren: children);
}

/// generated route for
/// [_i55.SpellListPage]
class SpellListRoute extends _i58.PageRouteInfo<void> {
  static const String name = 'SpellListRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      return const _i55.SpellListPage();
    },
  );

  const SpellListRoute({List<_i58.PageRouteInfo>? children})
    : super(SpellListRoute.name, initialChildren: children);
}

/// generated route for
/// [_i56.TalentDetailPage]
class TalentDetailRoute extends _i58.PageRouteInfo<TalentDetailRouteArgs> {
  static const String name = 'TalentDetailRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TalentDetailRouteArgs>(
        orElse: () => const TalentDetailRouteArgs(),
      );
      return _i56.TalentDetailPage(key: args.key, talentKey: args.talentKey);
    },
  );

  TalentDetailRoute({
    _i59.Key? key,
    int? talentKey,
    List<_i58.PageRouteInfo>? children,
  }) : super(
         TalentDetailRoute.name,
         args: TalentDetailRouteArgs(key: key, talentKey: talentKey),
         initialChildren: children,
       );
}

class TalentDetailRouteArgs {
  final _i59.Key? key;

  final int? talentKey;

  const TalentDetailRouteArgs({this.key, this.talentKey});

  @override
  int get hashCode => key.hashCode ^ talentKey.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! TalentDetailRouteArgs) return false;
    return key == other.key && talentKey == other.talentKey;
  }

  @override
  String toString() {
    return 'TalentDetailRouteArgs{key: $key, talentKey: $talentKey}';
  }
}

/// generated route for
/// [_i57.TalentListPage]
class TalentListRoute extends _i58.PageRouteInfo<void> {
  static const String name = 'TalentListRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      return const _i57.TalentListPage();
    },
  );

  const TalentListRoute({List<_i58.PageRouteInfo>? children})
    : super(TalentListRoute.name, initialChildren: children);
}
