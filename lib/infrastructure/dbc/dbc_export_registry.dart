import 'package:foxy/repository/achievement_repository.dart';
import 'package:foxy/repository/area_table_repository.dart';
import 'package:foxy/repository/char_title_repository.dart';
import 'package:foxy/repository/cinematic_sequence_repository.dart';
import 'package:foxy/repository/creature_display_info_repository.dart';
import 'package:foxy/repository/creature_model_data_repository.dart';
import 'package:foxy/repository/creature_movement_info_repository.dart';
import 'package:foxy/repository/creature_spell_data_repository.dart';
import 'package:foxy/repository/currency_type_repository.dart';
import 'package:foxy/repository/destructible_model_data_repository.dart';
import 'package:foxy/repository/dbc_faction_repository.dart';
import 'package:foxy/repository/dbc_faction_template_repository.dart';
import 'package:foxy/repository/dbc_emote_repository.dart';
import 'package:foxy/repository/dbc_item_repository.dart';
import 'package:foxy/repository/emote_text_data_repository.dart';
import 'package:foxy/repository/emote_text_repository.dart';
import 'package:foxy/repository/gem_property_repository.dart';
import 'package:foxy/repository/game_object_art_kit_repository.dart';
import 'package:foxy/repository/game_object_display_info_repository.dart';
import 'package:foxy/repository/glyph_property_repository.dart';
import 'package:foxy/repository/holiday_repository.dart';
import 'package:foxy/repository/item_display_info_repository.dart';
import 'package:foxy/repository/item_bag_family_repository.dart';
import 'package:foxy/repository/item_extended_cost_repository.dart';
import 'package:foxy/repository/item_purchase_group_repository.dart';
import 'package:foxy/repository/item_limit_category_repository.dart';
import 'package:foxy/repository/item_random_properties_repository.dart';
import 'package:foxy/repository/item_random_suffix_repository.dart';
import 'package:foxy/repository/item_set_repository.dart';
import 'package:foxy/repository/lock_repository.dart';
import 'package:foxy/repository/light_repository.dart';
import 'package:foxy/repository/liquid_type_repository.dart';
import 'package:foxy/repository/map_info_repository.dart';
import 'package:foxy/repository/mail_template_repository.dart';
import 'package:foxy/repository/quest_faction_reward_repository.dart';
import 'package:foxy/repository/quest_info_repository.dart';
import 'package:foxy/repository/quest_sort_repository.dart';
import 'package:foxy/repository/scaling_stat_distribution_solo_repository.dart';
import 'package:foxy/repository/scaling_stat_value_repository.dart';
import 'package:foxy/repository/spell_duration_repository.dart';
import 'package:foxy/repository/spell_focus_object_repository.dart';
import 'package:foxy/repository/spell_icon_repository.dart';
import 'package:foxy/repository/spell_item_enchantment_solo_repository.dart';
import 'package:foxy/repository/spell_range_repository.dart';
import 'package:foxy/repository/spell_repository.dart';
import 'package:foxy/repository/skill_line_repository.dart';
import 'package:foxy/repository/sound_ambience_repository.dart';
import 'package:foxy/repository/sound_provider_preferences_repository.dart';
import 'package:foxy/repository/talent_repository.dart';
import 'package:foxy/repository/taxi_path_repository.dart';
import 'package:foxy/repository/totem_category_repository.dart';
import 'package:foxy/repository/vehicle_repository.dart';
import 'package:foxy/repository/zone_intro_music_repository.dart';
import 'package:foxy/repository/zone_music_repository.dart';
import 'package:get_it/get_it.dart';

class DbcExportCountResult {
  final int? count;
  final Object? error;

  const DbcExportCountResult.success(int value) : count = value, error = null;
  const DbcExportCountResult.failure(Object value)
    : count = null,
      error = value;

  bool get success => error == null;
}

class DbcExportDelegate {
  final Future<List<Map<String, dynamic>>> Function() loadRows;
  final Future<int> Function() countRows;

  const DbcExportDelegate({required this.loadRows, required this.countRows});

  static DbcExportDelegate typed<T>({
    required Future<List<T>> Function() load,
    required Future<int> Function() count,
    required Map<String, dynamic> Function(T entity) toJson,
  }) {
    return DbcExportDelegate(
      loadRows: () async {
        final rows = (await load()).map(toJson).toList();
        rows.sort((left, right) {
          final leftId = left['ID'];
          final rightId = right['ID'];
          if (leftId is num && rightId is num) {
            return leftId.compareTo(rightId);
          }
          return leftId.toString().compareTo(rightId.toString());
        });
        return rows;
      },
      countRows: count,
    );
  }
}

/// 将 DBC 表名映射到对应的单表 Repository。
///
/// Registry 只负责选择 Repository 和将强类型 Entity 转成 JSON，
/// 不参与 DBC 文件写入。
class DbcExportRegistry {
  DbcExportRegistry() : _delegates = _buildDelegates(GetIt.instance);

  final Map<String, DbcExportDelegate> _delegates;

  Future<List<Map<String, dynamic>>> loadRows(String tableName) async {
    final delegate = _delegates[tableName];
    if (delegate == null) {
      throw StateError('未注册的 DBC 导出表: $tableName');
    }
    return delegate.loadRows();
  }

  Future<DbcExportCountResult> countRows(String tableName) async {
    final delegate = _delegates[tableName];
    if (delegate == null) {
      return DbcExportCountResult.failure(
        StateError('未注册的 DBC 导出表: $tableName'),
      );
    }
    try {
      return DbcExportCountResult.success(await delegate.countRows());
    } catch (error) {
      return DbcExportCountResult.failure(error);
    }
  }

  bool contains(String tableName) => _delegates.containsKey(tableName);

  static Map<String, DbcExportDelegate> _buildDelegates(GetIt getIt) {
    final achievement = getIt.get<AchievementRepository>();
    final areaTable = getIt.get<AreaTableRepository>();
    final charTitle = getIt.get<CharTitleRepository>();
    final cinematicSequence = getIt.get<CinematicSequenceRepository>();
    final creatureDisplayInfo = getIt.get<CreatureDisplayInfoRepository>();
    final creatureModelData = getIt.get<CreatureModelDataRepository>();
    final creatureMovementInfo = getIt.get<CreatureMovementInfoRepository>();
    final creatureSpellData = getIt.get<CreatureSpellDataRepository>();
    final currencyType = getIt.get<CurrencyTypeRepository>();
    final destructibleModelData = getIt.get<DestructibleModelDataRepository>();
    final faction = getIt.get<DbcFactionRepository>();
    final factionTemplate = getIt.get<DbcFactionTemplateRepository>();
    final emote = getIt.get<DbcEmoteRepository>();
    final dbcItem = getIt.get<DbcItemRepository>();
    final emoteTextData = getIt.get<EmoteTextDataRepository>();
    final emoteText = getIt.get<EmoteTextRepository>();
    final gemProperty = getIt.get<GemPropertyRepository>();
    final gameObjectArtKit = getIt.get<GameObjectArtKitRepository>();
    final gameObjectDisplayInfo = getIt.get<GameObjectDisplayInfoRepository>();
    final glyphProperty = getIt.get<GlyphPropertyRepository>();
    final holiday = getIt.get<HolidayRepository>();
    final itemDisplayInfo = getIt.get<ItemDisplayInfoRepository>();
    final itemBagFamily = getIt.get<ItemBagFamilyRepository>();
    final itemExtendedCost = getIt.get<ItemExtendedCostRepository>();
    final itemPurchaseGroup = getIt.get<ItemPurchaseGroupRepository>();
    final itemLimitCategory = getIt.get<ItemLimitCategoryRepository>();
    final itemRandomProperties = getIt.get<ItemRandomPropertiesRepository>();
    final itemRandomSuffix = getIt.get<ItemRandomSuffixRepository>();
    final itemSet = getIt.get<ItemSetRepository>();
    final lock = getIt.get<LockRepository>();
    final light = getIt.get<LightRepository>();
    final liquidType = getIt.get<LiquidTypeRepository>();
    final map = getIt.get<MapInfoRepository>();
    final mailTemplate = getIt.get<MailTemplateRepository>();
    final questFactionReward = getIt.get<QuestFactionRewardRepository>();
    final questInfo = getIt.get<QuestInfoRepository>();
    final questSort = getIt.get<QuestSortRepository>();
    final scalingDistribution = getIt
        .get<ScalingStatDistributionSoloRepository>();
    final scalingValue = getIt.get<ScalingStatValueRepository>();
    final spell = getIt.get<SpellRepository>();
    final skillLine = getIt.get<SkillLineRepository>();
    final soundAmbience = getIt.get<SoundAmbienceRepository>();
    final soundProviderPreferences = getIt
        .get<SoundProviderPreferencesRepository>();
    final spellDuration = getIt.get<SpellDurationRepository>();
    final spellFocusObject = getIt.get<SpellFocusObjectRepository>();
    final spellIcon = getIt.get<SpellIconRepository>();
    final spellItemEnchantment = getIt
        .get<SpellItemEnchantmentSoloRepository>();
    final spellRange = getIt.get<SpellRangeRepository>();
    final talent = getIt.get<TalentRepository>();
    final taxiPath = getIt.get<TaxiPathRepository>();
    final totemCategory = getIt.get<TotemCategoryRepository>();
    final vehicle = getIt.get<VehicleRepository>();
    final zoneIntroMusic = getIt.get<ZoneIntroMusicRepository>();
    final zoneMusic = getIt.get<ZoneMusicRepository>();

    return {
      'dbc_achievement': DbcExportDelegate.typed(
        load: achievement.getAchievements,
        count: () => achievement.countAchievements(),
        toJson: (entity) => entity.toJson(),
      ),
      'dbc_area_table': DbcExportDelegate.typed(
        load: areaTable.getAreaTables,
        count: () => areaTable.countAreaTables(),
        toJson: (entity) => entity.toJson(),
      ),
      'dbc_char_titles': DbcExportDelegate.typed(
        load: charTitle.getCharTitles,
        count: () => charTitle.countCharTitles(),
        toJson: (entity) => entity.toJson(),
      ),
      'dbc_cinematic_sequences': DbcExportDelegate.typed(
        load: cinematicSequence.getCinematicSequences,
        count: () => cinematicSequence.countCinematicSequences(),
        toJson: (entity) => entity.toJson(),
      ),
      'dbc_creature_display_info': DbcExportDelegate.typed(
        load: creatureDisplayInfo.getCreatureDisplayInfos,
        count: () => creatureDisplayInfo.countCreatureDisplayInfos(),
        toJson: (entity) => entity.toJson(),
      ),
      'dbc_creature_model_data': DbcExportDelegate.typed(
        load: creatureModelData.getCreatureModelDatas,
        count: () => creatureModelData.countCreatureModelDatas(),
        toJson: (entity) => entity.toJson(),
      ),
      'dbc_creature_movement_info': DbcExportDelegate.typed(
        load: creatureMovementInfo.getCreatureMovementInfos,
        count: () => creatureMovementInfo.countCreatureMovementInfos(),
        toJson: (entity) => entity.toJson(),
      ),
      'dbc_creature_spell_data': DbcExportDelegate.typed(
        load: creatureSpellData.getCreatureSpellDatas,
        count: () => creatureSpellData.countCreatureSpellDatas(),
        toJson: (entity) => entity.toJson(),
      ),
      'dbc_currency_types': DbcExportDelegate.typed(
        load: currencyType.getCurrencyTypes,
        count: () => currencyType.countCurrencyTypes(),
        toJson: (entity) => entity.toJson(),
      ),
      'dbc_destructible_model_data': DbcExportDelegate.typed(
        load: destructibleModelData.getDestructibleModelDatas,
        count: () => destructibleModelData.countDestructibleModelDatas(),
        toJson: (entity) => entity.toJson(),
      ),
      'dbc_emotes_text': DbcExportDelegate.typed(
        load: emoteText.getEmoteTexts,
        count: () => emoteText.countEmoteTexts(),
        toJson: (entity) => entity.toJson(),
      ),
      'dbc_emotes_text_data': DbcExportDelegate.typed(
        load: emoteTextData.getEmoteTextDatas,
        count: () => emoteTextData.countEmoteTextDatas(),
        toJson: (entity) => entity.toJson(),
      ),
      'dbc_emotes': DbcExportDelegate.typed(
        load: emote.getDbcEmotes,
        count: () => emote.countDbcEmotes(),
        toJson: (entity) => entity.toJson(),
      ),
      'dbc_faction': DbcExportDelegate.typed(
        load: faction.getDbcFactions,
        count: () => faction.countDbcFactions(),
        toJson: (entity) => entity.toJson(),
      ),
      'dbc_faction_template': DbcExportDelegate.typed(
        load: factionTemplate.getDbcFactionTemplates,
        count: () => factionTemplate.countDbcFactionTemplates(),
        toJson: (entity) => entity.toJson(),
      ),
      'dbc_gem_properties': DbcExportDelegate.typed(
        load: gemProperty.getGemProperties,
        count: () => gemProperty.countGemProperties(),
        toJson: (entity) => entity.toJson(),
      ),
      'dbc_glyph_properties': DbcExportDelegate.typed(
        load: glyphProperty.getGlyphProperties,
        count: () => glyphProperty.countGlyphProperties(),
        toJson: (entity) => entity.toJson(),
      ),
      'dbc_game_object_art_kit': DbcExportDelegate.typed(
        load: gameObjectArtKit.getGameObjectArtKits,
        count: () => gameObjectArtKit.countGameObjectArtKits(),
        toJson: (entity) => entity.toJson(),
      ),
      'dbc_game_object_display_info': DbcExportDelegate.typed(
        load: gameObjectDisplayInfo.getGameObjectDisplayInfos,
        count: () => gameObjectDisplayInfo.countGameObjectDisplayInfos(),
        toJson: (entity) => entity.toJson(),
      ),
      'dbc_holidays': DbcExportDelegate.typed(
        load: holiday.getHolidays,
        count: () => holiday.countHolidays(),
        toJson: (entity) => entity.toJson(),
      ),
      'dbc_item_display_info': DbcExportDelegate.typed(
        load: itemDisplayInfo.getItemDisplayInfos,
        count: () => itemDisplayInfo.countItemDisplayInfos(),
        toJson: (entity) => entity.toJson(),
      ),
      'dbc_item': DbcExportDelegate.typed(
        load: dbcItem.getDbcItems,
        count: () => dbcItem.countDbcItems(),
        toJson: (entity) => entity.toJson(),
      ),
      'dbc_item_bag_family': DbcExportDelegate.typed(
        load: itemBagFamily.getItemBagFamilies,
        count: itemBagFamily.countItemBagFamilies,
        toJson: (entity) => entity.toJson(),
      ),
      'dbc_item_extended_cost': DbcExportDelegate.typed(
        load: itemExtendedCost.getItemExtendedCosts,
        count: () => itemExtendedCost.countItemExtendedCosts(),
        toJson: (entity) => entity.toJson(),
      ),
      'dbc_item_purchase_group': DbcExportDelegate.typed(
        load: itemPurchaseGroup.getItemPurchaseGroups,
        count: () => itemPurchaseGroup.countItemPurchaseGroups(),
        toJson: (entity) => entity.toJson(),
      ),
      'dbc_item_limit_category': DbcExportDelegate.typed(
        load: itemLimitCategory.getItemLimitCategories,
        count: () => itemLimitCategory.countItemLimitCategories(),
        toJson: (entity) => entity.toJson(),
      ),
      'dbc_item_random_properties': DbcExportDelegate.typed(
        load: itemRandomProperties.getItemRandomProperties,
        count: () => itemRandomProperties.countItemRandomProperties(),
        toJson: (entity) => entity.toJson(),
      ),
      'dbc_item_random_suffix': DbcExportDelegate.typed(
        load: itemRandomSuffix.getItemRandomSuffixes,
        count: () => itemRandomSuffix.countItemRandomSuffixes(),
        toJson: (entity) => entity.toJson(),
      ),
      'dbc_item_set': DbcExportDelegate.typed(
        load: itemSet.getItemSets,
        count: () => itemSet.countItemSets(),
        toJson: (entity) => entity.toJson(),
      ),
      'dbc_lock': DbcExportDelegate.typed(
        load: lock.getLocks,
        count: () => lock.countLocks(),
        toJson: (entity) => entity.toJson(),
      ),
      'dbc_light': DbcExportDelegate.typed(
        load: light.getLights,
        count: () => light.countLights(),
        toJson: (entity) => entity.toJson(),
      ),
      'dbc_liquid_type': DbcExportDelegate.typed(
        load: liquidType.getLiquidTypes,
        count: () => liquidType.countLiquidTypes(),
        toJson: (entity) => entity.toJson(),
      ),
      'dbc_mail_template': DbcExportDelegate.typed(
        load: mailTemplate.getMailTemplates,
        count: () => mailTemplate.countMailTemplates(),
        toJson: (entity) => entity.toJson(),
      ),
      'dbc_map': DbcExportDelegate.typed(
        load: map.getMapInfos,
        count: () => map.countMapInfos(),
        toJson: (entity) => entity.toJson(),
      ),
      'dbc_quest_faction_reward': DbcExportDelegate.typed(
        load: questFactionReward.getQuestFactionRewards,
        count: () => questFactionReward.countQuestFactionRewards(),
        toJson: (entity) => entity.toJson(),
      ),
      'dbc_quest_info': DbcExportDelegate.typed(
        load: questInfo.getQuestInfos,
        count: () => questInfo.countQuestInfos(),
        toJson: (entity) => entity.toJson(),
      ),
      'dbc_quest_sort': DbcExportDelegate.typed(
        load: questSort.getQuestSorts,
        count: () => questSort.countQuestSorts(),
        toJson: (entity) => entity.toJson(),
      ),
      'dbc_scaling_stat_distribution': DbcExportDelegate.typed(
        load: scalingDistribution.getScalingStatDistributions,
        count: () => scalingDistribution.countScalingStatDistributions(),
        toJson: (entity) => entity.toJson(),
      ),
      'dbc_scaling_stat_values': DbcExportDelegate.typed(
        load: scalingValue.getScalingStatValues,
        count: () => scalingValue.countScalingStatValues(),
        toJson: (entity) => entity.toJson(),
      ),
      'dbc_spell': DbcExportDelegate.typed(
        load: spell.getSpells,
        count: () => spell.countSpells(),
        toJson: (entity) => entity.toJson(),
      ),
      'dbc_spell_focus_object': DbcExportDelegate.typed(
        load: spellFocusObject.getSpellFocusObjects,
        count: () => spellFocusObject.countSpellFocusObjects(),
        toJson: (entity) => entity.toJson(),
      ),
      'dbc_skill_line': DbcExportDelegate.typed(
        load: skillLine.getSkillLines,
        count: () => skillLine.countSkillLines(),
        toJson: (entity) => entity.toJson(),
      ),
      'dbc_sound_ambience': DbcExportDelegate.typed(
        load: soundAmbience.getSoundAmbiences,
        count: () => soundAmbience.countSoundAmbiences(),
        toJson: (entity) => entity.toJson(),
      ),
      'dbc_sound_provider_preferences': DbcExportDelegate.typed(
        load: soundProviderPreferences.getSoundProviderPreferences,
        count: () => soundProviderPreferences.countSoundProviderPreferences(),
        toJson: (entity) => entity.toJson(),
      ),
      'dbc_spell_duration': DbcExportDelegate.typed(
        load: spellDuration.getSpellDurations,
        count: () => spellDuration.countSpellDurations(),
        toJson: (entity) => entity.toJson(),
      ),
      'dbc_spell_icon': DbcExportDelegate.typed(
        load: spellIcon.getSpellIcons,
        count: () => spellIcon.countSpellIcons(),
        toJson: (entity) => entity.toJson(),
      ),
      'dbc_spell_item_enchantment': DbcExportDelegate.typed(
        load: spellItemEnchantment.getSpellItemEnchantments,
        count: () => spellItemEnchantment.countSpellItemEnchantments(),
        toJson: (entity) => entity.toJson(),
      ),
      'dbc_spell_range': DbcExportDelegate.typed(
        load: spellRange.getSpellRanges,
        count: () => spellRange.countSpellRanges(),
        toJson: (entity) => entity.toJson(),
      ),
      'dbc_talent': DbcExportDelegate.typed(
        load: talent.getTalents,
        count: () => talent.countTalents(),
        toJson: (entity) => entity.toJson(),
      ),
      'dbc_taxi_path': DbcExportDelegate.typed(
        load: taxiPath.getTaxiPaths,
        count: () => taxiPath.countTaxiPaths(),
        toJson: (entity) => entity.toJson(),
      ),
      'dbc_totem_category': DbcExportDelegate.typed(
        load: totemCategory.getTotemCategories,
        count: () => totemCategory.countTotemCategories(),
        toJson: (entity) => entity.toJson(),
      ),
      'dbc_vehicle': DbcExportDelegate.typed(
        load: vehicle.getVehicles,
        count: () => vehicle.countVehicles(),
        toJson: (entity) => entity.toJson(),
      ),
      'dbc_zone_intro_music_table': DbcExportDelegate.typed(
        load: zoneIntroMusic.getZoneIntroMusics,
        count: () => zoneIntroMusic.countZoneIntroMusics(),
        toJson: (entity) => entity.toJson(),
      ),
      'dbc_zone_music': DbcExportDelegate.typed(
        load: zoneMusic.getZoneMusics,
        count: () => zoneMusic.countZoneMusics(),
        toJson: (entity) => entity.toJson(),
      ),
    };
  }
}
