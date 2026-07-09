import 'package:foxy/database/database.dart';
import 'package:foxy/repository/achievement_repository.dart';
import 'package:foxy/repository/area_table_repository.dart';
import 'package:foxy/repository/char_title_repository.dart';
import 'package:foxy/repository/creature_display_info_repository.dart';
import 'package:foxy/repository/creature_spell_data_repository.dart';
import 'package:foxy/repository/currency_type_repository.dart';
import 'package:foxy/repository/dbc_faction_repository.dart';
import 'package:foxy/repository/emote_text_repository.dart';
import 'package:foxy/repository/gem_property_repository.dart';
import 'package:foxy/repository/glyph_property_repository.dart';
import 'package:foxy/repository/item_display_info_repository.dart';
import 'package:foxy/repository/item_extended_cost_repository.dart';
import 'package:foxy/repository/item_random_properties_repository.dart';
import 'package:foxy/repository/item_random_suffix_repository.dart';
import 'package:foxy/repository/item_set_repository.dart';
import 'package:foxy/repository/lock_repository.dart';
import 'package:foxy/repository/map_info_repository.dart';
import 'package:foxy/repository/quest_faction_reward_repository.dart';
import 'package:foxy/repository/quest_info_repository.dart';
import 'package:foxy/repository/quest_sort_repository.dart';
import 'package:foxy/repository/scaling_stat_distribution_solo_repository.dart';
import 'package:foxy/repository/scaling_stat_value_repository.dart';
import 'package:foxy/repository/spell_duration_repository.dart';
import 'package:foxy/repository/spell_icon_repository.dart';
import 'package:foxy/repository/spell_item_enchantment_solo_repository.dart';
import 'package:foxy/repository/spell_range_repository.dart';
import 'package:foxy/repository/spell_repository.dart';
import 'package:foxy/repository/talent_repository.dart';
import 'package:foxy/repository/vehicle_repository.dart';
import 'package:get_it/get_it.dart';

/// DBC 导出数据源：一律经 Repository 的 `get{Entities}`（全列全行）加载。
///
/// 返回值为 Entity.`toJson()` 行；键名与 DBC / MySQL 列名对齐，供 [DbcExportUtil] 写文件。
/// 无完整 Entity 仓储的表（仅 `dbc_creature_model_data`）经对应 Repository 的表读路径兜底。
class DbcExportRegistry {
  DbcExportRegistry._();

  static final _getIt = GetIt.instance;

  /// 按表短名（如 `dbc_spell`）加载全量导出行。
  static Future<List<Map<String, dynamic>>> loadRows(String tableShort) async {
    switch (tableShort) {
      case 'dbc_achievement':
        return _maps(
          await _getIt.get<AchievementRepository>().getAchievements(),
        );
      case 'dbc_area_table':
        return _maps(await _getIt.get<AreaTableRepository>().getAreaTables());
      case 'dbc_char_titles':
        return _maps(await _getIt.get<CharTitleRepository>().getCharTitles());
      case 'dbc_creature_display_info':
        return _maps(
          await _getIt
              .get<CreatureDisplayInfoRepository>()
              .getCreatureDisplayInfos(),
        );
      case 'dbc_creature_model_data':
        // 尚无独立 Entity 仓储：经 Database/laconic 读 foxy 表（与 Repository 同源连接）
        return _rawTableMaps('foxy.dbc_creature_model_data');
      case 'dbc_creature_spell_data':
        return _maps(
          await _getIt
              .get<CreatureSpellDataRepository>()
              .getCreatureSpellDatas(),
        );
      case 'dbc_currency_types':
        return _maps(
          await _getIt.get<CurrencyTypeRepository>().getCurrencyTypes(),
        );
      case 'dbc_emotes_text':
        return _maps(await _getIt.get<EmoteTextRepository>().getEmoteTexts());
      case 'dbc_faction':
        return _maps(await _getIt.get<DbcFactionRepository>().getDbcFactions());
      case 'dbc_gem_properties':
        return _maps(
          await _getIt.get<GemPropertyRepository>().getGemProperties(),
        );
      case 'dbc_glyph_properties':
        return _maps(
          await _getIt.get<GlyphPropertyRepository>().getGlyphProperties(),
        );
      case 'dbc_item_display_info':
        return _maps(
          await _getIt.get<ItemDisplayInfoRepository>().getItemDisplayInfos(),
        );
      case 'dbc_item_extended_cost':
        return _maps(
          await _getIt
              .get<ItemExtendedCostRepository>()
              .getItemExtendedCosts(),
        );
      case 'dbc_item_random_properties':
        return _maps(
          await _getIt
              .get<ItemRandomPropertiesRepository>()
              .getItemRandomProperties(),
        );
      case 'dbc_item_random_suffix':
        return _maps(
          await _getIt
              .get<ItemRandomSuffixRepository>()
              .getItemRandomSuffixes(),
        );
      case 'dbc_item_set':
        return _maps(await _getIt.get<ItemSetRepository>().getItemSets());
      case 'dbc_lock':
        return _maps(await _getIt.get<LockRepository>().getLocks());
      case 'dbc_map':
        return _maps(await _getIt.get<MapInfoRepository>().getMapInfos());
      case 'dbc_quest_faction_reward':
        return _maps(
          await _getIt
              .get<QuestFactionRewardRepository>()
              .getQuestFactionRewards(),
        );
      case 'dbc_quest_info':
        return _maps(await _getIt.get<QuestInfoRepository>().getQuestInfos());
      case 'dbc_quest_sort':
        return _maps(await _getIt.get<QuestSortRepository>().getQuestSorts());
      case 'dbc_scaling_stat_distribution':
        return _maps(
          await _getIt
              .get<ScalingStatDistributionSoloRepository>()
              .getScalingStatDistributions(),
        );
      case 'dbc_scaling_stat_values':
        return _maps(
          await _getIt
              .get<ScalingStatValueRepository>()
              .getScalingStatValues(),
        );
      case 'dbc_spell':
        return _maps(await _getIt.get<SpellRepository>().getSpells());
      case 'dbc_spell_duration':
        return _maps(
          await _getIt.get<SpellDurationRepository>().getSpellDurations(),
        );
      case 'dbc_spell_icon':
        return _maps(await _getIt.get<SpellIconRepository>().getSpellIcons());
      case 'dbc_spell_item_enchantment':
        return _maps(
          await _getIt
              .get<SpellItemEnchantmentSoloRepository>()
              .getSpellItemEnchantments(),
        );
      case 'dbc_spell_range':
        return _maps(await _getIt.get<SpellRangeRepository>().getSpellRanges());
      case 'dbc_talent':
        return _maps(await _getIt.get<TalentRepository>().getTalents());
      case 'dbc_vehicle':
        return _maps(await _getIt.get<VehicleRepository>().getVehicles());
      default:
        throw StateError('未知的 DBC 导出表: $tableShort');
    }
  }

  /// 与 [loadRows] 对应的行数（列表预览用）。
  static Future<int> countRows(String tableShort) async {
    switch (tableShort) {
      case 'dbc_achievement':
        return _getIt.get<AchievementRepository>().countAchievements();
      case 'dbc_area_table':
        return _getIt.get<AreaTableRepository>().countAreaTables();
      case 'dbc_char_titles':
        return _getIt.get<CharTitleRepository>().countCharTitles();
      case 'dbc_creature_display_info':
        return _getIt
            .get<CreatureDisplayInfoRepository>()
            .countCreatureDisplayInfos();
      case 'dbc_creature_model_data':
        return Database.instance.laconic
            .table('foxy.dbc_creature_model_data')
            .count();
      case 'dbc_creature_spell_data':
        return _getIt
            .get<CreatureSpellDataRepository>()
            .countCreatureSpellDatas();
      case 'dbc_currency_types':
        return _getIt.get<CurrencyTypeRepository>().countCurrencyTypes();
      case 'dbc_emotes_text':
        return _getIt.get<EmoteTextRepository>().countEmoteTexts();
      case 'dbc_faction':
        return _getIt.get<DbcFactionRepository>().countDbcFactions();
      case 'dbc_gem_properties':
        return _getIt.get<GemPropertyRepository>().countGemProperties();
      case 'dbc_glyph_properties':
        return _getIt.get<GlyphPropertyRepository>().countGlyphProperties();
      case 'dbc_item_display_info':
        return _getIt.get<ItemDisplayInfoRepository>().countItemDisplayInfos();
      case 'dbc_item_extended_cost':
        return _getIt
            .get<ItemExtendedCostRepository>()
            .countItemExtendedCosts();
      case 'dbc_item_random_properties':
        return _getIt
            .get<ItemRandomPropertiesRepository>()
            .countItemRandomProperties();
      case 'dbc_item_random_suffix':
        return _getIt
            .get<ItemRandomSuffixRepository>()
            .countItemRandomSuffixes();
      case 'dbc_item_set':
        return _getIt.get<ItemSetRepository>().countItemSets();
      case 'dbc_lock':
        return _getIt.get<LockRepository>().countLocks();
      case 'dbc_map':
        return _getIt.get<MapInfoRepository>().countMapInfos();
      case 'dbc_quest_faction_reward':
        return _getIt
            .get<QuestFactionRewardRepository>()
            .countQuestFactionRewards();
      case 'dbc_quest_info':
        return _getIt.get<QuestInfoRepository>().countQuestInfos();
      case 'dbc_quest_sort':
        return _getIt.get<QuestSortRepository>().countQuestSorts();
      case 'dbc_scaling_stat_distribution':
        return _getIt
            .get<ScalingStatDistributionSoloRepository>()
            .countScalingStatDistributions();
      case 'dbc_scaling_stat_values':
        return _getIt
            .get<ScalingStatValueRepository>()
            .countScalingStatValues();
      case 'dbc_spell':
        return _getIt.get<SpellRepository>().countSpells();
      case 'dbc_spell_duration':
        return _getIt.get<SpellDurationRepository>().countSpellDurations();
      case 'dbc_spell_icon':
        return _getIt.get<SpellIconRepository>().countSpellIcons();
      case 'dbc_spell_item_enchantment':
        return _getIt
            .get<SpellItemEnchantmentSoloRepository>()
            .countSpellItemEnchantments();
      case 'dbc_spell_range':
        return _getIt.get<SpellRangeRepository>().countSpellRanges();
      case 'dbc_talent':
        return _getIt.get<TalentRepository>().countTalents();
      case 'dbc_vehicle':
        return _getIt.get<VehicleRepository>().countVehicles();
      default:
        return 0;
    }
  }

  static List<Map<String, dynamic>> _maps(List<dynamic> entities) {
    return entities
        .map((e) => Map<String, dynamic>.from((e as dynamic).toJson() as Map))
        .toList();
  }

  static Future<List<Map<String, dynamic>>> _rawTableMaps(String table) async {
    final results = await Database.instance.laconic.table(table).get();
    return results.map((e) => Map<String, dynamic>.from(e.toMap())).toList();
  }
}
