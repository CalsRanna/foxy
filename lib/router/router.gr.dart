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
import 'package:foxy/page/page_text/page_text_detail_page.dart' as _i56;
import 'package:foxy/page/page_text/page_text_list_page.dart' as _i57;
import 'package:foxy/page/player_create_info/player_create_info_detail_page.dart'
    as _i30;
import 'package:foxy/page/player_create_info/player_create_info_list_page.dart'
    as _i31;
import 'package:foxy/page/quest/quest_template_detail_page.dart' as _i38;
import 'package:foxy/page/quest/quest_template_list_page.dart' as _i39;
import 'package:foxy/page/quest_faction_reward/quest_faction_reward_detail_page.dart'
    as _i32;
import 'package:foxy/page/quest_faction_reward/quest_faction_reward_list_page.dart'
    as _i33;
import 'package:foxy/page/quest_info/quest_info_detail_page.dart' as _i34;
import 'package:foxy/page/quest_info/quest_info_list_page.dart' as _i35;
import 'package:foxy/page/quest_sort/quest_sort_detail_page.dart' as _i36;
import 'package:foxy/page/quest_sort/quest_sort_list_page.dart' as _i37;
import 'package:foxy/page/reference_loot_template/reference_loot_template_detail_page.dart'
    as _i40;
import 'package:foxy/page/reference_loot_template/reference_loot_template_list_page.dart'
    as _i41;
import 'package:foxy/page/scaffold/scaffold_page.dart' as _i42;
import 'package:foxy/page/scaling_stat_distribution/scaling_stat_distribution_detail_page.dart'
    as _i43;
import 'package:foxy/page/scaling_stat_distribution/scaling_stat_distribution_list_page.dart'
    as _i44;
import 'package:foxy/page/scaling_stat_value/scaling_stat_value_detail_page.dart'
    as _i45;
import 'package:foxy/page/scaling_stat_value/scaling_stat_value_list_page.dart'
    as _i46;
import 'package:foxy/page/setting/setting_page.dart' as _i47;
import 'package:foxy/page/smart_script/smart_script_detail_page.dart' as _i48;
import 'package:foxy/page/smart_script/smart_script_list_page.dart' as _i49;
import 'package:foxy/page/spell/spell_detail_page.dart' as _i50;
import 'package:foxy/page/spell/spell_list_page.dart' as _i53;
import 'package:foxy/page/spell_item_enchantment/spell_item_enchantment_detail_page.dart'
    as _i51;
import 'package:foxy/page/spell_item_enchantment/spell_item_enchantment_list_page.dart'
    as _i52;
import 'package:foxy/page/talent/talent_detail_page.dart' as _i54;
import 'package:foxy/page/talent/talent_list_page.dart' as _i55;

/// generated route for
/// [_i1.AchievementDetailPage]
class AchievementDetailRoute
    extends _i58.PageRouteInfo<AchievementDetailRouteArgs> {
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
}

class AchievementDetailRouteArgs {
  const AchievementDetailRouteArgs({this.key, this.achievementKey});

  final _i59.Key? key;

  final int? achievementKey;

  @override
  String toString() {
    return 'AchievementDetailRouteArgs{key: $key, achievementKey: $achievementKey}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AchievementDetailRouteArgs) return false;
    return key == other.key && achievementKey == other.achievementKey;
  }

  @override
  int get hashCode => key.hashCode ^ achievementKey.hashCode;
}

/// generated route for
/// [_i2.AchievementListPage]
class AchievementListRoute extends _i58.PageRouteInfo<void> {
  const AchievementListRoute({List<_i58.PageRouteInfo>? children})
    : super(AchievementListRoute.name, initialChildren: children);

  static const String name = 'AchievementListRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      return const _i2.AchievementListPage();
    },
  );
}

/// generated route for
/// [_i3.AreaTableDetailPage]
class AreaTableDetailRoute
    extends _i58.PageRouteInfo<AreaTableDetailRouteArgs> {
  AreaTableDetailRoute({
    _i59.Key? key,
    int? areaTableKey,
    List<_i58.PageRouteInfo>? children,
  }) : super(
         AreaTableDetailRoute.name,
         args: AreaTableDetailRouteArgs(key: key, areaTableKey: areaTableKey),
         initialChildren: children,
       );

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
}

class AreaTableDetailRouteArgs {
  const AreaTableDetailRouteArgs({this.key, this.areaTableKey});

  final _i59.Key? key;

  final int? areaTableKey;

  @override
  String toString() {
    return 'AreaTableDetailRouteArgs{key: $key, areaTableKey: $areaTableKey}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AreaTableDetailRouteArgs) return false;
    return key == other.key && areaTableKey == other.areaTableKey;
  }

  @override
  int get hashCode => key.hashCode ^ areaTableKey.hashCode;
}

/// generated route for
/// [_i4.AreaTableListPage]
class AreaTableListRoute extends _i58.PageRouteInfo<void> {
  const AreaTableListRoute({List<_i58.PageRouteInfo>? children})
    : super(AreaTableListRoute.name, initialChildren: children);

  static const String name = 'AreaTableListRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      return const _i4.AreaTableListPage();
    },
  );
}

/// generated route for
/// [_i5.BootstrapPage]
class BootstrapRoute extends _i58.PageRouteInfo<void> {
  const BootstrapRoute({List<_i58.PageRouteInfo>? children})
    : super(BootstrapRoute.name, initialChildren: children);

  static const String name = 'BootstrapRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      return const _i5.BootstrapPage();
    },
  );
}

/// generated route for
/// [_i6.ConditionDetailPage]
class ConditionDetailRoute
    extends _i58.PageRouteInfo<ConditionDetailRouteArgs> {
  ConditionDetailRoute({
    _i59.Key? key,
    _i60.ConditionKey? conditionKey,
    List<_i58.PageRouteInfo>? children,
  }) : super(
         ConditionDetailRoute.name,
         args: ConditionDetailRouteArgs(key: key, conditionKey: conditionKey),
         initialChildren: children,
       );

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
}

class ConditionDetailRouteArgs {
  const ConditionDetailRouteArgs({this.key, this.conditionKey});

  final _i59.Key? key;

  final _i60.ConditionKey? conditionKey;

  @override
  String toString() {
    return 'ConditionDetailRouteArgs{key: $key, conditionKey: $conditionKey}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ConditionDetailRouteArgs) return false;
    return key == other.key && conditionKey == other.conditionKey;
  }

  @override
  int get hashCode => key.hashCode ^ conditionKey.hashCode;
}

/// generated route for
/// [_i7.ConditionListPage]
class ConditionListRoute extends _i58.PageRouteInfo<void> {
  const ConditionListRoute({List<_i58.PageRouteInfo>? children})
    : super(ConditionListRoute.name, initialChildren: children);

  static const String name = 'ConditionListRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      return const _i7.ConditionListPage();
    },
  );
}

/// generated route for
/// [_i8.CreatureTemplateDetailPage]
class CreatureTemplateDetailRoute
    extends _i58.PageRouteInfo<CreatureTemplateDetailRouteArgs> {
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
}

class CreatureTemplateDetailRouteArgs {
  const CreatureTemplateDetailRouteArgs({this.key, this.creatureTemplateKey});

  final _i59.Key? key;

  final int? creatureTemplateKey;

  @override
  String toString() {
    return 'CreatureTemplateDetailRouteArgs{key: $key, creatureTemplateKey: $creatureTemplateKey}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CreatureTemplateDetailRouteArgs) return false;
    return key == other.key && creatureTemplateKey == other.creatureTemplateKey;
  }

  @override
  int get hashCode => key.hashCode ^ creatureTemplateKey.hashCode;
}

/// generated route for
/// [_i9.CreatureTemplateListPage]
class CreatureTemplateListRoute extends _i58.PageRouteInfo<void> {
  const CreatureTemplateListRoute({List<_i58.PageRouteInfo>? children})
    : super(CreatureTemplateListRoute.name, initialChildren: children);

  static const String name = 'CreatureTemplateListRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      return const _i9.CreatureTemplateListPage();
    },
  );
}

/// generated route for
/// [_i10.CurrencyTypeDetailPage]
class CurrencyTypeDetailRoute
    extends _i58.PageRouteInfo<CurrencyTypeDetailRouteArgs> {
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
}

class CurrencyTypeDetailRouteArgs {
  const CurrencyTypeDetailRouteArgs({this.key, this.currencyTypeKey});

  final _i59.Key? key;

  final int? currencyTypeKey;

  @override
  String toString() {
    return 'CurrencyTypeDetailRouteArgs{key: $key, currencyTypeKey: $currencyTypeKey}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CurrencyTypeDetailRouteArgs) return false;
    return key == other.key && currencyTypeKey == other.currencyTypeKey;
  }

  @override
  int get hashCode => key.hashCode ^ currencyTypeKey.hashCode;
}

/// generated route for
/// [_i11.CurrencyTypeListPage]
class CurrencyTypeListRoute extends _i58.PageRouteInfo<void> {
  const CurrencyTypeListRoute({List<_i58.PageRouteInfo>? children})
    : super(CurrencyTypeListRoute.name, initialChildren: children);

  static const String name = 'CurrencyTypeListRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      return const _i11.CurrencyTypeListPage();
    },
  );
}

/// generated route for
/// [_i12.DashboardPage]
class DashboardRoute extends _i58.PageRouteInfo<void> {
  const DashboardRoute({List<_i58.PageRouteInfo>? children})
    : super(DashboardRoute.name, initialChildren: children);

  static const String name = 'DashboardRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      return const _i12.DashboardPage();
    },
  );
}

/// generated route for
/// [_i13.EmoteTextDetailPage]
class EmoteTextDetailRoute
    extends _i58.PageRouteInfo<EmoteTextDetailRouteArgs> {
  EmoteTextDetailRoute({
    _i59.Key? key,
    int? emoteTextKey,
    List<_i58.PageRouteInfo>? children,
  }) : super(
         EmoteTextDetailRoute.name,
         args: EmoteTextDetailRouteArgs(key: key, emoteTextKey: emoteTextKey),
         initialChildren: children,
       );

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
}

class EmoteTextDetailRouteArgs {
  const EmoteTextDetailRouteArgs({this.key, this.emoteTextKey});

  final _i59.Key? key;

  final int? emoteTextKey;

  @override
  String toString() {
    return 'EmoteTextDetailRouteArgs{key: $key, emoteTextKey: $emoteTextKey}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! EmoteTextDetailRouteArgs) return false;
    return key == other.key && emoteTextKey == other.emoteTextKey;
  }

  @override
  int get hashCode => key.hashCode ^ emoteTextKey.hashCode;
}

/// generated route for
/// [_i14.EmoteTextListPage]
class EmoteTextListRoute extends _i58.PageRouteInfo<void> {
  const EmoteTextListRoute({List<_i58.PageRouteInfo>? children})
    : super(EmoteTextListRoute.name, initialChildren: children);

  static const String name = 'EmoteTextListRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      return const _i14.EmoteTextListPage();
    },
  );
}

/// generated route for
/// [_i15.GameObjectTemplateDetailPage]
class GameObjectTemplateDetailRoute
    extends _i58.PageRouteInfo<GameObjectTemplateDetailRouteArgs> {
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
}

class GameObjectTemplateDetailRouteArgs {
  const GameObjectTemplateDetailRouteArgs({
    this.key,
    this.gameObjectTemplateKey,
  });

  final _i59.Key? key;

  final int? gameObjectTemplateKey;

  @override
  String toString() {
    return 'GameObjectTemplateDetailRouteArgs{key: $key, gameObjectTemplateKey: $gameObjectTemplateKey}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! GameObjectTemplateDetailRouteArgs) return false;
    return key == other.key &&
        gameObjectTemplateKey == other.gameObjectTemplateKey;
  }

  @override
  int get hashCode => key.hashCode ^ gameObjectTemplateKey.hashCode;
}

/// generated route for
/// [_i16.GameObjectTemplateListPage]
class GameObjectTemplateListRoute extends _i58.PageRouteInfo<void> {
  const GameObjectTemplateListRoute({List<_i58.PageRouteInfo>? children})
    : super(GameObjectTemplateListRoute.name, initialChildren: children);

  static const String name = 'GameObjectTemplateListRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      return const _i16.GameObjectTemplateListPage();
    },
  );
}

/// generated route for
/// [_i17.GemPropertyDetailPage]
class GemPropertyDetailRoute
    extends _i58.PageRouteInfo<GemPropertyDetailRouteArgs> {
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
}

class GemPropertyDetailRouteArgs {
  const GemPropertyDetailRouteArgs({this.key, this.gemPropertyKey});

  final _i59.Key? key;

  final int? gemPropertyKey;

  @override
  String toString() {
    return 'GemPropertyDetailRouteArgs{key: $key, gemPropertyKey: $gemPropertyKey}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! GemPropertyDetailRouteArgs) return false;
    return key == other.key && gemPropertyKey == other.gemPropertyKey;
  }

  @override
  int get hashCode => key.hashCode ^ gemPropertyKey.hashCode;
}

/// generated route for
/// [_i18.GemPropertyListPage]
class GemPropertyListRoute extends _i58.PageRouteInfo<void> {
  const GemPropertyListRoute({List<_i58.PageRouteInfo>? children})
    : super(GemPropertyListRoute.name, initialChildren: children);

  static const String name = 'GemPropertyListRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      return const _i18.GemPropertyListPage();
    },
  );
}

/// generated route for
/// [_i19.GlyphPropertyDetailPage]
class GlyphPropertyDetailRoute
    extends _i58.PageRouteInfo<GlyphPropertyDetailRouteArgs> {
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
}

class GlyphPropertyDetailRouteArgs {
  const GlyphPropertyDetailRouteArgs({this.key, this.glyphPropertyKey});

  final _i59.Key? key;

  final int? glyphPropertyKey;

  @override
  String toString() {
    return 'GlyphPropertyDetailRouteArgs{key: $key, glyphPropertyKey: $glyphPropertyKey}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! GlyphPropertyDetailRouteArgs) return false;
    return key == other.key && glyphPropertyKey == other.glyphPropertyKey;
  }

  @override
  int get hashCode => key.hashCode ^ glyphPropertyKey.hashCode;
}

/// generated route for
/// [_i20.GlyphPropertyListPage]
class GlyphPropertyListRoute extends _i58.PageRouteInfo<void> {
  const GlyphPropertyListRoute({List<_i58.PageRouteInfo>? children})
    : super(GlyphPropertyListRoute.name, initialChildren: children);

  static const String name = 'GlyphPropertyListRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      return const _i20.GlyphPropertyListPage();
    },
  );
}

/// generated route for
/// [_i21.GossipMenuDetailPage]
class GossipMenuDetailRoute
    extends _i58.PageRouteInfo<GossipMenuDetailRouteArgs> {
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
}

class GossipMenuDetailRouteArgs {
  const GossipMenuDetailRouteArgs({this.key, this.gossipMenuKey});

  final _i59.Key? key;

  final _i61.GossipMenuKey? gossipMenuKey;

  @override
  String toString() {
    return 'GossipMenuDetailRouteArgs{key: $key, gossipMenuKey: $gossipMenuKey}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! GossipMenuDetailRouteArgs) return false;
    return key == other.key && gossipMenuKey == other.gossipMenuKey;
  }

  @override
  int get hashCode => key.hashCode ^ gossipMenuKey.hashCode;
}

/// generated route for
/// [_i22.GossipMenuListPage]
class GossipMenuListRoute extends _i58.PageRouteInfo<void> {
  const GossipMenuListRoute({List<_i58.PageRouteInfo>? children})
    : super(GossipMenuListRoute.name, initialChildren: children);

  static const String name = 'GossipMenuListRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      return const _i22.GossipMenuListPage();
    },
  );
}

/// generated route for
/// [_i23.ItemExtendedCostDetailPage]
class ItemExtendedCostDetailRoute
    extends _i58.PageRouteInfo<ItemExtendedCostDetailRouteArgs> {
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
}

class ItemExtendedCostDetailRouteArgs {
  const ItemExtendedCostDetailRouteArgs({this.key, this.itemExtendedCostKey});

  final _i59.Key? key;

  final int? itemExtendedCostKey;

  @override
  String toString() {
    return 'ItemExtendedCostDetailRouteArgs{key: $key, itemExtendedCostKey: $itemExtendedCostKey}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ItemExtendedCostDetailRouteArgs) return false;
    return key == other.key && itemExtendedCostKey == other.itemExtendedCostKey;
  }

  @override
  int get hashCode => key.hashCode ^ itemExtendedCostKey.hashCode;
}

/// generated route for
/// [_i24.ItemExtendedCostListPage]
class ItemExtendedCostListRoute extends _i58.PageRouteInfo<void> {
  const ItemExtendedCostListRoute({List<_i58.PageRouteInfo>? children})
    : super(ItemExtendedCostListRoute.name, initialChildren: children);

  static const String name = 'ItemExtendedCostListRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      return const _i24.ItemExtendedCostListPage();
    },
  );
}

/// generated route for
/// [_i25.ItemSetDetailPage]
class ItemSetDetailRoute extends _i58.PageRouteInfo<ItemSetDetailRouteArgs> {
  ItemSetDetailRoute({
    _i59.Key? key,
    int? itemSetKey,
    List<_i58.PageRouteInfo>? children,
  }) : super(
         ItemSetDetailRoute.name,
         args: ItemSetDetailRouteArgs(key: key, itemSetKey: itemSetKey),
         initialChildren: children,
       );

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
}

class ItemSetDetailRouteArgs {
  const ItemSetDetailRouteArgs({this.key, this.itemSetKey});

  final _i59.Key? key;

  final int? itemSetKey;

  @override
  String toString() {
    return 'ItemSetDetailRouteArgs{key: $key, itemSetKey: $itemSetKey}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ItemSetDetailRouteArgs) return false;
    return key == other.key && itemSetKey == other.itemSetKey;
  }

  @override
  int get hashCode => key.hashCode ^ itemSetKey.hashCode;
}

/// generated route for
/// [_i26.ItemSetListPage]
class ItemSetListRoute extends _i58.PageRouteInfo<void> {
  const ItemSetListRoute({List<_i58.PageRouteInfo>? children})
    : super(ItemSetListRoute.name, initialChildren: children);

  static const String name = 'ItemSetListRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      return const _i26.ItemSetListPage();
    },
  );
}

/// generated route for
/// [_i27.ItemTemplateDetailPage]
class ItemTemplateDetailRoute
    extends _i58.PageRouteInfo<ItemTemplateDetailRouteArgs> {
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
}

class ItemTemplateDetailRouteArgs {
  const ItemTemplateDetailRouteArgs({this.key, this.itemTemplateKey});

  final _i59.Key? key;

  final int? itemTemplateKey;

  @override
  String toString() {
    return 'ItemTemplateDetailRouteArgs{key: $key, itemTemplateKey: $itemTemplateKey}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ItemTemplateDetailRouteArgs) return false;
    return key == other.key && itemTemplateKey == other.itemTemplateKey;
  }

  @override
  int get hashCode => key.hashCode ^ itemTemplateKey.hashCode;
}

/// generated route for
/// [_i28.ItemTemplateListPage]
class ItemTemplateListRoute extends _i58.PageRouteInfo<void> {
  const ItemTemplateListRoute({List<_i58.PageRouteInfo>? children})
    : super(ItemTemplateListRoute.name, initialChildren: children);

  static const String name = 'ItemTemplateListRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      return const _i28.ItemTemplateListPage();
    },
  );
}

/// generated route for
/// [_i29.MorePage]
class MoreRoute extends _i58.PageRouteInfo<void> {
  const MoreRoute({List<_i58.PageRouteInfo>? children})
    : super(MoreRoute.name, initialChildren: children);

  static const String name = 'MoreRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      return const _i29.MorePage();
    },
  );
}

/// generated route for
/// [_i30.PlayerCreateInfoDetailPage]
class PlayerCreateInfoDetailRoute
    extends _i58.PageRouteInfo<PlayerCreateInfoDetailRouteArgs> {
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

  static const String name = 'PlayerCreateInfoDetailRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PlayerCreateInfoDetailRouteArgs>(
        orElse: () => const PlayerCreateInfoDetailRouteArgs(),
      );
      return _i30.PlayerCreateInfoDetailPage(
        key: args.key,
        playerCreateInfoKey: args.playerCreateInfoKey,
      );
    },
  );
}

class PlayerCreateInfoDetailRouteArgs {
  const PlayerCreateInfoDetailRouteArgs({this.key, this.playerCreateInfoKey});

  final _i59.Key? key;

  final _i62.PlayerCreateInfoKey? playerCreateInfoKey;

  @override
  String toString() {
    return 'PlayerCreateInfoDetailRouteArgs{key: $key, playerCreateInfoKey: $playerCreateInfoKey}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PlayerCreateInfoDetailRouteArgs) return false;
    return key == other.key && playerCreateInfoKey == other.playerCreateInfoKey;
  }

  @override
  int get hashCode => key.hashCode ^ playerCreateInfoKey.hashCode;
}

/// generated route for
/// [_i31.PlayerCreateInfoListPage]
class PlayerCreateInfoListRoute extends _i58.PageRouteInfo<void> {
  const PlayerCreateInfoListRoute({List<_i58.PageRouteInfo>? children})
    : super(PlayerCreateInfoListRoute.name, initialChildren: children);

  static const String name = 'PlayerCreateInfoListRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      return const _i31.PlayerCreateInfoListPage();
    },
  );
}

/// generated route for
/// [_i32.QuestFactionRewardDetailPage]
class QuestFactionRewardDetailRoute
    extends _i58.PageRouteInfo<QuestFactionRewardDetailRouteArgs> {
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

  static const String name = 'QuestFactionRewardDetailRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<QuestFactionRewardDetailRouteArgs>(
        orElse: () => const QuestFactionRewardDetailRouteArgs(),
      );
      return _i32.QuestFactionRewardDetailPage(
        key: args.key,
        questFactionRewardKey: args.questFactionRewardKey,
      );
    },
  );
}

class QuestFactionRewardDetailRouteArgs {
  const QuestFactionRewardDetailRouteArgs({
    this.key,
    this.questFactionRewardKey,
  });

  final _i59.Key? key;

  final int? questFactionRewardKey;

  @override
  String toString() {
    return 'QuestFactionRewardDetailRouteArgs{key: $key, questFactionRewardKey: $questFactionRewardKey}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! QuestFactionRewardDetailRouteArgs) return false;
    return key == other.key &&
        questFactionRewardKey == other.questFactionRewardKey;
  }

  @override
  int get hashCode => key.hashCode ^ questFactionRewardKey.hashCode;
}

/// generated route for
/// [_i33.QuestFactionRewardListPage]
class QuestFactionRewardListRoute extends _i58.PageRouteInfo<void> {
  const QuestFactionRewardListRoute({List<_i58.PageRouteInfo>? children})
    : super(QuestFactionRewardListRoute.name, initialChildren: children);

  static const String name = 'QuestFactionRewardListRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      return const _i33.QuestFactionRewardListPage();
    },
  );
}

/// generated route for
/// [_i34.QuestInfoDetailPage]
class QuestInfoDetailRoute
    extends _i58.PageRouteInfo<QuestInfoDetailRouteArgs> {
  QuestInfoDetailRoute({
    _i59.Key? key,
    int? questInfoKey,
    List<_i58.PageRouteInfo>? children,
  }) : super(
         QuestInfoDetailRoute.name,
         args: QuestInfoDetailRouteArgs(key: key, questInfoKey: questInfoKey),
         initialChildren: children,
       );

  static const String name = 'QuestInfoDetailRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<QuestInfoDetailRouteArgs>(
        orElse: () => const QuestInfoDetailRouteArgs(),
      );
      return _i34.QuestInfoDetailPage(
        key: args.key,
        questInfoKey: args.questInfoKey,
      );
    },
  );
}

class QuestInfoDetailRouteArgs {
  const QuestInfoDetailRouteArgs({this.key, this.questInfoKey});

  final _i59.Key? key;

  final int? questInfoKey;

  @override
  String toString() {
    return 'QuestInfoDetailRouteArgs{key: $key, questInfoKey: $questInfoKey}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! QuestInfoDetailRouteArgs) return false;
    return key == other.key && questInfoKey == other.questInfoKey;
  }

  @override
  int get hashCode => key.hashCode ^ questInfoKey.hashCode;
}

/// generated route for
/// [_i35.QuestInfoListPage]
class QuestInfoListRoute extends _i58.PageRouteInfo<void> {
  const QuestInfoListRoute({List<_i58.PageRouteInfo>? children})
    : super(QuestInfoListRoute.name, initialChildren: children);

  static const String name = 'QuestInfoListRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      return const _i35.QuestInfoListPage();
    },
  );
}

/// generated route for
/// [_i36.QuestSortDetailPage]
class QuestSortDetailRoute
    extends _i58.PageRouteInfo<QuestSortDetailRouteArgs> {
  QuestSortDetailRoute({
    _i59.Key? key,
    int? questSortKey,
    List<_i58.PageRouteInfo>? children,
  }) : super(
         QuestSortDetailRoute.name,
         args: QuestSortDetailRouteArgs(key: key, questSortKey: questSortKey),
         initialChildren: children,
       );

  static const String name = 'QuestSortDetailRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<QuestSortDetailRouteArgs>(
        orElse: () => const QuestSortDetailRouteArgs(),
      );
      return _i36.QuestSortDetailPage(
        key: args.key,
        questSortKey: args.questSortKey,
      );
    },
  );
}

class QuestSortDetailRouteArgs {
  const QuestSortDetailRouteArgs({this.key, this.questSortKey});

  final _i59.Key? key;

  final int? questSortKey;

  @override
  String toString() {
    return 'QuestSortDetailRouteArgs{key: $key, questSortKey: $questSortKey}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! QuestSortDetailRouteArgs) return false;
    return key == other.key && questSortKey == other.questSortKey;
  }

  @override
  int get hashCode => key.hashCode ^ questSortKey.hashCode;
}

/// generated route for
/// [_i37.QuestSortListPage]
class QuestSortListRoute extends _i58.PageRouteInfo<void> {
  const QuestSortListRoute({List<_i58.PageRouteInfo>? children})
    : super(QuestSortListRoute.name, initialChildren: children);

  static const String name = 'QuestSortListRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      return const _i37.QuestSortListPage();
    },
  );
}

/// generated route for
/// [_i38.QuestTemplateDetailPage]
class QuestTemplateDetailRoute
    extends _i58.PageRouteInfo<QuestTemplateDetailRouteArgs> {
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

  static const String name = 'QuestTemplateDetailRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<QuestTemplateDetailRouteArgs>(
        orElse: () => const QuestTemplateDetailRouteArgs(),
      );
      return _i38.QuestTemplateDetailPage(
        key: args.key,
        questTemplateKey: args.questTemplateKey,
      );
    },
  );
}

class QuestTemplateDetailRouteArgs {
  const QuestTemplateDetailRouteArgs({this.key, this.questTemplateKey});

  final _i59.Key? key;

  final int? questTemplateKey;

  @override
  String toString() {
    return 'QuestTemplateDetailRouteArgs{key: $key, questTemplateKey: $questTemplateKey}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! QuestTemplateDetailRouteArgs) return false;
    return key == other.key && questTemplateKey == other.questTemplateKey;
  }

  @override
  int get hashCode => key.hashCode ^ questTemplateKey.hashCode;
}

/// generated route for
/// [_i39.QuestTemplateListPage]
class QuestTemplateListRoute extends _i58.PageRouteInfo<void> {
  const QuestTemplateListRoute({List<_i58.PageRouteInfo>? children})
    : super(QuestTemplateListRoute.name, initialChildren: children);

  static const String name = 'QuestTemplateListRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      return const _i39.QuestTemplateListPage();
    },
  );
}

/// generated route for
/// [_i40.ReferenceLootTemplateDetailPage]
class ReferenceLootTemplateDetailRoute
    extends _i58.PageRouteInfo<ReferenceLootTemplateDetailRouteArgs> {
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

  static const String name = 'ReferenceLootTemplateDetailRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ReferenceLootTemplateDetailRouteArgs>(
        orElse: () => const ReferenceLootTemplateDetailRouteArgs(),
      );
      return _i40.ReferenceLootTemplateDetailPage(
        key: args.key,
        referenceLootTemplateKey: args.referenceLootTemplateKey,
      );
    },
  );
}

class ReferenceLootTemplateDetailRouteArgs {
  const ReferenceLootTemplateDetailRouteArgs({
    this.key,
    this.referenceLootTemplateKey,
  });

  final _i59.Key? key;

  final _i63.ReferenceLootTemplateKey? referenceLootTemplateKey;

  @override
  String toString() {
    return 'ReferenceLootTemplateDetailRouteArgs{key: $key, referenceLootTemplateKey: $referenceLootTemplateKey}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ReferenceLootTemplateDetailRouteArgs) return false;
    return key == other.key &&
        referenceLootTemplateKey == other.referenceLootTemplateKey;
  }

  @override
  int get hashCode => key.hashCode ^ referenceLootTemplateKey.hashCode;
}

/// generated route for
/// [_i41.ReferenceLootTemplateListPage]
class ReferenceLootTemplateListRoute extends _i58.PageRouteInfo<void> {
  const ReferenceLootTemplateListRoute({List<_i58.PageRouteInfo>? children})
    : super(ReferenceLootTemplateListRoute.name, initialChildren: children);

  static const String name = 'ReferenceLootTemplateListRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      return const _i41.ReferenceLootTemplateListPage();
    },
  );
}

/// generated route for
/// [_i42.ScaffoldPage]
class ScaffoldRoute extends _i58.PageRouteInfo<void> {
  const ScaffoldRoute({List<_i58.PageRouteInfo>? children})
    : super(ScaffoldRoute.name, initialChildren: children);

  static const String name = 'ScaffoldRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      return const _i42.ScaffoldPage();
    },
  );
}

/// generated route for
/// [_i43.ScalingStatDistributionDetailPage]
class ScalingStatDistributionDetailRoute
    extends _i58.PageRouteInfo<ScalingStatDistributionDetailRouteArgs> {
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

  static const String name = 'ScalingStatDistributionDetailRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ScalingStatDistributionDetailRouteArgs>(
        orElse: () => const ScalingStatDistributionDetailRouteArgs(),
      );
      return _i43.ScalingStatDistributionDetailPage(
        key: args.key,
        scalingStatDistributionKey: args.scalingStatDistributionKey,
      );
    },
  );
}

class ScalingStatDistributionDetailRouteArgs {
  const ScalingStatDistributionDetailRouteArgs({
    this.key,
    this.scalingStatDistributionKey,
  });

  final _i59.Key? key;

  final int? scalingStatDistributionKey;

  @override
  String toString() {
    return 'ScalingStatDistributionDetailRouteArgs{key: $key, scalingStatDistributionKey: $scalingStatDistributionKey}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ScalingStatDistributionDetailRouteArgs) return false;
    return key == other.key &&
        scalingStatDistributionKey == other.scalingStatDistributionKey;
  }

  @override
  int get hashCode => key.hashCode ^ scalingStatDistributionKey.hashCode;
}

/// generated route for
/// [_i44.ScalingStatDistributionListPage]
class ScalingStatDistributionListRoute extends _i58.PageRouteInfo<void> {
  const ScalingStatDistributionListRoute({List<_i58.PageRouteInfo>? children})
    : super(ScalingStatDistributionListRoute.name, initialChildren: children);

  static const String name = 'ScalingStatDistributionListRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      return const _i44.ScalingStatDistributionListPage();
    },
  );
}

/// generated route for
/// [_i45.ScalingStatValueDetailPage]
class ScalingStatValueDetailRoute
    extends _i58.PageRouteInfo<ScalingStatValueDetailRouteArgs> {
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

  static const String name = 'ScalingStatValueDetailRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ScalingStatValueDetailRouteArgs>(
        orElse: () => const ScalingStatValueDetailRouteArgs(),
      );
      return _i45.ScalingStatValueDetailPage(
        key: args.key,
        scalingStatValueKey: args.scalingStatValueKey,
      );
    },
  );
}

class ScalingStatValueDetailRouteArgs {
  const ScalingStatValueDetailRouteArgs({this.key, this.scalingStatValueKey});

  final _i59.Key? key;

  final int? scalingStatValueKey;

  @override
  String toString() {
    return 'ScalingStatValueDetailRouteArgs{key: $key, scalingStatValueKey: $scalingStatValueKey}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ScalingStatValueDetailRouteArgs) return false;
    return key == other.key && scalingStatValueKey == other.scalingStatValueKey;
  }

  @override
  int get hashCode => key.hashCode ^ scalingStatValueKey.hashCode;
}

/// generated route for
/// [_i46.ScalingStatValueListPage]
class ScalingStatValueListRoute extends _i58.PageRouteInfo<void> {
  const ScalingStatValueListRoute({List<_i58.PageRouteInfo>? children})
    : super(ScalingStatValueListRoute.name, initialChildren: children);

  static const String name = 'ScalingStatValueListRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      return const _i46.ScalingStatValueListPage();
    },
  );
}

/// generated route for
/// [_i47.SettingPage]
class SettingRoute extends _i58.PageRouteInfo<void> {
  const SettingRoute({List<_i58.PageRouteInfo>? children})
    : super(SettingRoute.name, initialChildren: children);

  static const String name = 'SettingRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      return const _i47.SettingPage();
    },
  );
}

/// generated route for
/// [_i48.SmartScriptDetailPage]
class SmartScriptDetailRoute
    extends _i58.PageRouteInfo<SmartScriptDetailRouteArgs> {
  SmartScriptDetailRoute({
    _i59.Key? key,
    _i64.SmartScriptKey? scriptKey,
    List<_i58.PageRouteInfo>? children,
  }) : super(
         SmartScriptDetailRoute.name,
         args: SmartScriptDetailRouteArgs(key: key, scriptKey: scriptKey),
         initialChildren: children,
       );

  static const String name = 'SmartScriptDetailRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SmartScriptDetailRouteArgs>(
        orElse: () => const SmartScriptDetailRouteArgs(),
      );
      return _i48.SmartScriptDetailPage(
        key: args.key,
        scriptKey: args.scriptKey,
      );
    },
  );
}

class SmartScriptDetailRouteArgs {
  const SmartScriptDetailRouteArgs({this.key, this.scriptKey});

  final _i59.Key? key;

  final _i64.SmartScriptKey? scriptKey;

  @override
  String toString() {
    return 'SmartScriptDetailRouteArgs{key: $key, scriptKey: $scriptKey}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SmartScriptDetailRouteArgs) return false;
    return key == other.key && scriptKey == other.scriptKey;
  }

  @override
  int get hashCode => key.hashCode ^ scriptKey.hashCode;
}

/// generated route for
/// [_i49.SmartScriptListPage]
class SmartScriptListRoute extends _i58.PageRouteInfo<void> {
  const SmartScriptListRoute({List<_i58.PageRouteInfo>? children})
    : super(SmartScriptListRoute.name, initialChildren: children);

  static const String name = 'SmartScriptListRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      return const _i49.SmartScriptListPage();
    },
  );
}

/// generated route for
/// [_i50.SpellDetailPage]
class SpellDetailRoute extends _i58.PageRouteInfo<SpellDetailRouteArgs> {
  SpellDetailRoute({
    _i59.Key? key,
    int? spellKey,
    List<_i58.PageRouteInfo>? children,
  }) : super(
         SpellDetailRoute.name,
         args: SpellDetailRouteArgs(key: key, spellKey: spellKey),
         initialChildren: children,
       );

  static const String name = 'SpellDetailRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SpellDetailRouteArgs>(
        orElse: () => const SpellDetailRouteArgs(),
      );
      return _i50.SpellDetailPage(key: args.key, spellKey: args.spellKey);
    },
  );
}

class SpellDetailRouteArgs {
  const SpellDetailRouteArgs({this.key, this.spellKey});

  final _i59.Key? key;

  final int? spellKey;

  @override
  String toString() {
    return 'SpellDetailRouteArgs{key: $key, spellKey: $spellKey}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SpellDetailRouteArgs) return false;
    return key == other.key && spellKey == other.spellKey;
  }

  @override
  int get hashCode => key.hashCode ^ spellKey.hashCode;
}

/// generated route for
/// [_i51.SpellItemEnchantmentDetailPage]
class SpellItemEnchantmentDetailRoute
    extends _i58.PageRouteInfo<SpellItemEnchantmentDetailRouteArgs> {
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

  static const String name = 'SpellItemEnchantmentDetailRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SpellItemEnchantmentDetailRouteArgs>(
        orElse: () => const SpellItemEnchantmentDetailRouteArgs(),
      );
      return _i51.SpellItemEnchantmentDetailPage(
        key: args.key,
        spellItemEnchantmentKey: args.spellItemEnchantmentKey,
      );
    },
  );
}

class SpellItemEnchantmentDetailRouteArgs {
  const SpellItemEnchantmentDetailRouteArgs({
    this.key,
    this.spellItemEnchantmentKey,
  });

  final _i59.Key? key;

  final int? spellItemEnchantmentKey;

  @override
  String toString() {
    return 'SpellItemEnchantmentDetailRouteArgs{key: $key, spellItemEnchantmentKey: $spellItemEnchantmentKey}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SpellItemEnchantmentDetailRouteArgs) return false;
    return key == other.key &&
        spellItemEnchantmentKey == other.spellItemEnchantmentKey;
  }

  @override
  int get hashCode => key.hashCode ^ spellItemEnchantmentKey.hashCode;
}

/// generated route for
/// [_i52.SpellItemEnchantmentListPage]
class SpellItemEnchantmentListRoute extends _i58.PageRouteInfo<void> {
  const SpellItemEnchantmentListRoute({List<_i58.PageRouteInfo>? children})
    : super(SpellItemEnchantmentListRoute.name, initialChildren: children);

  static const String name = 'SpellItemEnchantmentListRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      return const _i52.SpellItemEnchantmentListPage();
    },
  );
}

/// generated route for
/// [_i53.SpellListPage]
class SpellListRoute extends _i58.PageRouteInfo<void> {
  const SpellListRoute({List<_i58.PageRouteInfo>? children})
    : super(SpellListRoute.name, initialChildren: children);

  static const String name = 'SpellListRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      return const _i53.SpellListPage();
    },
  );
}

/// generated route for
/// [_i54.TalentDetailPage]
class TalentDetailRoute extends _i58.PageRouteInfo<TalentDetailRouteArgs> {
  TalentDetailRoute({
    _i59.Key? key,
    int? talentKey,
    List<_i58.PageRouteInfo>? children,
  }) : super(
         TalentDetailRoute.name,
         args: TalentDetailRouteArgs(key: key, talentKey: talentKey),
         initialChildren: children,
       );

  static const String name = 'TalentDetailRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TalentDetailRouteArgs>(
        orElse: () => const TalentDetailRouteArgs(),
      );
      return _i54.TalentDetailPage(key: args.key, talentKey: args.talentKey);
    },
  );
}

class TalentDetailRouteArgs {
  const TalentDetailRouteArgs({this.key, this.talentKey});

  final _i59.Key? key;

  final int? talentKey;

  @override
  String toString() {
    return 'TalentDetailRouteArgs{key: $key, talentKey: $talentKey}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! TalentDetailRouteArgs) return false;
    return key == other.key && talentKey == other.talentKey;
  }

  @override
  int get hashCode => key.hashCode ^ talentKey.hashCode;
}

/// generated route for
/// [_i55.TalentListPage]
class TalentListRoute extends _i58.PageRouteInfo<void> {
  const TalentListRoute({List<_i58.PageRouteInfo>? children})
    : super(TalentListRoute.name, initialChildren: children);

  static const String name = 'TalentListRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      return const _i55.TalentListPage();
    },
  );
}

/// generated route for
/// [_i56.TextContentDetailPage]
class TextContentDetailRoute
    extends _i58.PageRouteInfo<TextContentDetailRouteArgs> {
  TextContentDetailRoute({
    _i59.Key? key,
    int? pageTextKey,
    List<_i58.PageRouteInfo>? children,
  }) : super(
         TextContentDetailRoute.name,
         args: TextContentDetailRouteArgs(key: key, pageTextKey: pageTextKey),
         initialChildren: children,
       );

  static const String name = 'TextContentDetailRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TextContentDetailRouteArgs>(
        orElse: () => const TextContentDetailRouteArgs(),
      );
      return _i56.TextContentDetailPage(
        key: args.key,
        pageTextKey: args.pageTextKey,
      );
    },
  );
}

class TextContentDetailRouteArgs {
  const TextContentDetailRouteArgs({this.key, this.pageTextKey});

  final _i59.Key? key;

  final int? pageTextKey;

  @override
  String toString() {
    return 'TextContentDetailRouteArgs{key: $key, pageTextKey: $pageTextKey}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! TextContentDetailRouteArgs) return false;
    return key == other.key && pageTextKey == other.pageTextKey;
  }

  @override
  int get hashCode => key.hashCode ^ pageTextKey.hashCode;
}

/// generated route for
/// [_i57.TextContentListPage]
class TextContentListRoute extends _i58.PageRouteInfo<void> {
  const TextContentListRoute({List<_i58.PageRouteInfo>? children})
    : super(TextContentListRoute.name, initialChildren: children);

  static const String name = 'TextContentListRoute';

  static _i58.PageInfo page = _i58.PageInfo(
    name,
    builder: (data) {
      return const _i57.TextContentListPage();
    },
  );
}
