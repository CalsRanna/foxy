import 'package:flutter/material.dart';
import 'package:foxy/widget/item_quality_color.dart';
import 'package:foxy/entity/brief_area_table_entity.dart';
import 'package:foxy/entity/area_table_filter_entity.dart';
import 'package:foxy/entity/achievement_entity.dart';
import 'package:foxy/entity/achievement_filter_entity.dart';
import 'package:foxy/entity/achievement_category_entity.dart';
import 'package:foxy/entity/achievement_category_filter_entity.dart';
import 'package:foxy/entity/broadcast_text_entity.dart';
import 'package:foxy/entity/broadcast_text_filter_entity.dart';
import 'package:foxy/entity/char_title_entity.dart';
import 'package:foxy/entity/char_title_filter_entity.dart';
import 'package:foxy/entity/cinematic_sequence_entity.dart';
import 'package:foxy/entity/cinematic_sequence_filter_entity.dart';
import 'package:foxy/entity/creature_immunity_entity.dart';
import 'package:foxy/entity/creature_immunity_filter_entity.dart';
import 'package:foxy/entity/creature_movement_info_entity.dart';
import 'package:foxy/entity/creature_movement_info_filter_entity.dart';
import 'package:foxy/entity/creature_spell_data_entity.dart';
import 'package:foxy/entity/creature_spell_data_filter_entity.dart';
import 'package:foxy/entity/creature_template_entity.dart';
import 'package:foxy/entity/creature_template_filter_entity.dart';
import 'package:foxy/entity/currency_category_entity.dart';
import 'package:foxy/entity/currency_category_filter_entity.dart';
import 'package:foxy/entity/creature_display_info_entity.dart';
import 'package:foxy/entity/creature_display_info_filter_entity.dart';
import 'package:foxy/entity/dbc_faction_entity.dart';
import 'package:foxy/entity/dbc_faction_filter_entity.dart';
import 'package:foxy/entity/dbc_faction_template_entity.dart';
import 'package:foxy/entity/dbc_faction_template_filter_entity.dart';
import 'package:foxy/entity/emote_text_entity.dart';
import 'package:foxy/entity/emote_text_filter_entity.dart';
import 'package:foxy/entity/emote_text_data_entity.dart';
import 'package:foxy/entity/emote_text_data_filter_entity.dart';
import 'package:foxy/entity/dbc_emote_entity.dart';
import 'package:foxy/entity/dbc_emote_filter_entity.dart';
import 'package:foxy/entity/dbc_item_entity.dart';
import 'package:foxy/entity/dbc_item_filter_entity.dart';
import 'package:foxy/entity/destructible_model_data_entity.dart';
import 'package:foxy/entity/destructible_model_data_filter_entity.dart';
import 'package:foxy/entity/gossip_menu_entity.dart';
import 'package:foxy/entity/gossip_menu_filter_entity.dart';
import 'package:foxy/entity/game_object_template_entity.dart';
import 'package:foxy/entity/game_object_template_filter_entity.dart';
import 'package:foxy/entity/game_object_art_kit_entity.dart';
import 'package:foxy/entity/game_object_art_kit_filter_entity.dart';
import 'package:foxy/entity/game_object_display_info_entity.dart';
import 'package:foxy/entity/game_object_display_info_filter_entity.dart';
import 'package:foxy/entity/gem_property_entity.dart';
import 'package:foxy/entity/gem_property_filter_entity.dart';
import 'package:foxy/entity/holiday_entity.dart';
import 'package:foxy/entity/holiday_filter_entity.dart';
import 'package:foxy/entity/item_display_info_entity.dart';
import 'package:foxy/entity/item_display_info_filter_entity.dart';
import 'package:foxy/entity/item_enchantment_template_entity.dart';
import 'package:foxy/entity/item_enchantment_template_filter_entity.dart';
import 'package:foxy/entity/item_extended_cost_entity.dart';
import 'package:foxy/entity/item_extended_cost_filter_entity.dart';
import 'package:foxy/entity/item_purchase_group_entity.dart';
import 'package:foxy/entity/item_purchase_group_filter_entity.dart';
import 'package:foxy/entity/item_limit_category_entity.dart';
import 'package:foxy/entity/item_limit_category_filter_entity.dart';
import 'package:foxy/entity/item_random_properties_entity.dart';
import 'package:foxy/entity/item_random_properties_filter_entity.dart';
import 'package:foxy/entity/item_random_suffix_entity.dart';
import 'package:foxy/entity/item_random_suffix_filter_entity.dart';
import 'package:foxy/entity/item_set_entity.dart';
import 'package:foxy/entity/item_set_filter_entity.dart';
import 'package:foxy/entity/item_visuals_entity.dart';
import 'package:foxy/entity/item_visuals_filter_entity.dart';
import 'package:foxy/entity/item_template_entity.dart';
import 'package:foxy/entity/item_template_filter_entity.dart';
import 'package:foxy/entity/lock_entity.dart';
import 'package:foxy/entity/lock_filter_entity.dart';
import 'package:foxy/entity/brief_light_entity.dart';
import 'package:foxy/entity/light_filter_entity.dart';
import 'package:foxy/entity/brief_liquid_type_entity.dart';
import 'package:foxy/entity/liquid_type_filter_entity.dart';
import 'package:foxy/entity/brief_loot_template_entry_entity.dart';
import 'package:foxy/entity/loot_table_type.dart';
import 'package:foxy/entity/loot_template_filter_entity.dart';
import 'package:foxy/entity/map_info_entity.dart';
import 'package:foxy/entity/map_info_filter_entity.dart';
import 'package:foxy/entity/mail_template_entity.dart';
import 'package:foxy/entity/mail_template_filter_entity.dart';
import 'package:foxy/entity/npc_text_entity.dart';
import 'package:foxy/entity/npc_text_filter_entity.dart';
import 'package:foxy/entity/brief_page_text_entity.dart';
import 'package:foxy/entity/page_text_filter_entity.dart';
import 'package:foxy/entity/point_of_interest_entity.dart';
import 'package:foxy/entity/point_of_interest_filter_entity.dart';
import 'package:foxy/entity/quest_info_entity.dart';
import 'package:foxy/entity/quest_info_filter_entity.dart';
import 'package:foxy/entity/quest_template_entity.dart';
import 'package:foxy/entity/quest_template_filter_entity.dart';
import 'package:foxy/entity/spell_duration_entity.dart';
import 'package:foxy/entity/spell_duration_filter_entity.dart';
import 'package:foxy/entity/spell_entity.dart';
import 'package:foxy/entity/spell_filter_entity.dart';
import 'package:foxy/entity/spell_focus_object_entity.dart';
import 'package:foxy/entity/spell_focus_object_filter_entity.dart';
import 'package:foxy/entity/spell_icon_entity.dart';
import 'package:foxy/entity/spell_icon_filter_entity.dart';
import 'package:foxy/entity/spell_range_entity.dart';
import 'package:foxy/entity/spell_range_filter_entity.dart';
import 'package:foxy/entity/spell_item_enchantment_entity.dart';
import 'package:foxy/entity/spell_item_enchantment_filter_entity.dart';
import 'package:foxy/entity/spell_item_enchantment_condition_entity.dart';
import 'package:foxy/entity/spell_item_enchantment_condition_filter_entity.dart';
import 'package:foxy/entity/skill_line_entity.dart';
import 'package:foxy/entity/skill_line_filter_entity.dart';
import 'package:foxy/entity/brief_sound_ambience_entity.dart';
import 'package:foxy/entity/sound_ambience_filter_entity.dart';
import 'package:foxy/entity/brief_sound_provider_preferences_entity.dart';
import 'package:foxy/entity/sound_provider_preferences_filter_entity.dart';
import 'package:foxy/entity/talent_entity.dart';
import 'package:foxy/entity/talent_filter_entity.dart';
import 'package:foxy/entity/talent_tab_entity.dart';
import 'package:foxy/entity/talent_tab_filter_entity.dart';
import 'package:foxy/entity/totem_category_entity.dart';
import 'package:foxy/entity/totem_category_filter_entity.dart';
import 'package:foxy/entity/taxi_path_entity.dart';
import 'package:foxy/entity/taxi_path_filter_entity.dart';
import 'package:foxy/entity/scaling_stat_distribution_entity.dart';
import 'package:foxy/entity/scaling_stat_distribution_filter_entity.dart';
import 'package:foxy/entity/vehicle_entity.dart';
import 'package:foxy/entity/vehicle_filter_entity.dart';
import 'package:foxy/entity/brief_zone_intro_music_entity.dart';
import 'package:foxy/entity/zone_intro_music_filter_entity.dart';
import 'package:foxy/entity/brief_zone_music_entity.dart';
import 'package:foxy/entity/zone_music_filter_entity.dart';
import 'package:foxy/entity/waypoint_data_entity.dart';
import 'package:foxy/entity/waypoint_data_filter_entity.dart';
import 'package:foxy/repository/area_table_repository.dart';
import 'package:foxy/repository/achievement_repository.dart';
import 'package:foxy/repository/achievement_category_repository.dart';
import 'package:foxy/repository/broadcast_text_repository.dart';
import 'package:foxy/repository/char_title_repository.dart';
import 'package:foxy/repository/cinematic_sequence_repository.dart';
import 'package:foxy/repository/creature_immunity_repository.dart';
import 'package:foxy/repository/creature_movement_info_repository.dart';
import 'package:foxy/repository/creature_spell_data_repository.dart';
import 'package:foxy/repository/creature_template_repository.dart';
import 'package:foxy/repository/creature_display_info_repository.dart';
import 'package:foxy/repository/currency_category_repository.dart';
import 'package:foxy/repository/dbc_faction_repository.dart';
import 'package:foxy/repository/dbc_faction_template_repository.dart';
import 'package:foxy/repository/emote_text_repository.dart';
import 'package:foxy/repository/emote_text_data_repository.dart';
import 'package:foxy/repository/dbc_emote_repository.dart';
import 'package:foxy/repository/dbc_item_repository.dart';
import 'package:foxy/repository/destructible_model_data_repository.dart';
import 'package:foxy/repository/gossip_menu_repository.dart';
import 'package:foxy/repository/game_object_template_repository.dart';
import 'package:foxy/repository/game_object_art_kit_repository.dart';
import 'package:foxy/repository/game_object_display_info_repository.dart';
import 'package:foxy/repository/gem_property_repository.dart';
import 'package:foxy/repository/holiday_repository.dart';
import 'package:foxy/repository/item_display_info_repository.dart';
import 'package:foxy/repository/item_enchantment_template_repository.dart';
import 'package:foxy/repository/item_extended_cost_repository.dart';
import 'package:foxy/repository/item_purchase_group_repository.dart';
import 'package:foxy/repository/item_limit_category_repository.dart';
import 'package:foxy/repository/item_random_properties_repository.dart';
import 'package:foxy/repository/item_random_suffix_repository.dart';
import 'package:foxy/repository/item_set_repository.dart';
import 'package:foxy/repository/item_visuals_repository.dart';
import 'package:foxy/repository/item_template_repository.dart';
import 'package:foxy/repository/lock_repository.dart';
import 'package:foxy/repository/light_repository.dart';
import 'package:foxy/repository/liquid_type_repository.dart';
import 'package:foxy/repository/loot_template_repository.dart';
import 'package:foxy/repository/map_info_repository.dart';
import 'package:foxy/repository/mail_template_repository.dart';
import 'package:foxy/repository/npc_text_repository.dart';
import 'package:foxy/repository/page_text_repository.dart';
import 'package:foxy/repository/point_of_interest_repository.dart';
import 'package:foxy/repository/quest_info_repository.dart';
import 'package:foxy/repository/quest_template_repository.dart';
import 'package:foxy/repository/scaling_stat_distribution_repository.dart';
import 'package:foxy/repository/spell_duration_repository.dart';
import 'package:foxy/repository/spell_icon_repository.dart';
import 'package:foxy/repository/spell_range_repository.dart';
import 'package:foxy/repository/spell_focus_object_repository.dart';
import 'package:foxy/repository/spell_item_enchantment_repository.dart';
import 'package:foxy/repository/spell_item_enchantment_condition_repository.dart';
import 'package:foxy/repository/skill_line_repository.dart';
import 'package:foxy/repository/sound_ambience_repository.dart';
import 'package:foxy/repository/sound_provider_preferences_repository.dart';
import 'package:foxy/repository/talent_repository.dart';
import 'package:foxy/repository/talent_tab_repository.dart';
import 'package:foxy/repository/totem_category_repository.dart';
import 'package:foxy/repository/taxi_path_repository.dart';
import 'package:foxy/repository/spell_repository.dart';
import 'package:foxy/repository/vehicle_repository.dart';
import 'package:foxy/repository/zone_intro_music_repository.dart';
import 'package:foxy/repository/zone_music_repository.dart';
import 'package:foxy/repository/waypoint_data_repository.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:foxy/widget/foxy_game_asset_icon.dart';
import 'package:get_it/get_it.dart';

class FoxyEntityPickerDelegates {
  static final currencyCategory =
      FoxyEntityPickerDelegate<BriefCurrencyCategoryEntity>(
        title: '货币分类',
        errorLabel: '搜索 CurrencyCategory.dbc 货币分类失败',
        filters: const [
          FoxyEntityPickerFilter('分类 ID'),
          FoxyEntityPickerFilter('分类名称'),
        ],
        columns: [
          FoxyEntityPickerColumn(
            header: '编号',
            width: 120,
            text: (BriefCurrencyCategoryEntity row) => row.id.toString(),
          ),
          FoxyEntityPickerColumn(
            header: '名称',
            text: (BriefCurrencyCategoryEntity row) => row.nameLangZhCN,
          ),
          FoxyEntityPickerColumn(
            header: '标志',
            width: 120,
            text: (BriefCurrencyCategoryEntity row) => row.flags.toString(),
          ),
        ],
        idOf: (BriefCurrencyCategoryEntity row) => row.id,
        fetch: (page, values) => GetIt.instance
            .get<CurrencyCategoryRepository>()
            .getBriefCurrencyCategories(
              page: page,
              filter: CurrencyCategoryFilterEntity(
                id: values[0],
                name: values[1],
              ),
            ),
        count: (values) => GetIt.instance
            .get<CurrencyCategoryRepository>()
            .countCurrencyCategories(
              filter: CurrencyCategoryFilterEntity(
                id: values[0],
                name: values[1],
              ),
            ),
      );

  static final achievement = FoxyEntityPickerDelegate<BriefAchievementEntity>(
    title: '成就',
    errorLabel: '搜索 Achievement.dbc 成就失败',
    filters: const [
      FoxyEntityPickerFilter('成就 ID'),
      FoxyEntityPickerFilter('成就名称'),
    ],
    columns: [
      FoxyEntityPickerColumn(
        header: '编号',
        width: 120,
        text: (BriefAchievementEntity value) => value.id.toString(),
      ),
      FoxyEntityPickerColumn(
        header: '名称',
        text: (BriefAchievementEntity value) => value.titleLangZhCN,
      ),
      FoxyEntityPickerColumn(
        header: '说明',
        text: (BriefAchievementEntity value) => value.descriptionLangZhCN,
      ),
    ],
    idOf: (BriefAchievementEntity value) => value.id,
    fetch: (page, values) =>
        GetIt.instance.get<AchievementRepository>().getBriefAchievements(
          page: page,
          filter: AchievementFilterEntity(id: values[0], title: values[1]),
        ),
    count: (values) =>
        GetIt.instance.get<AchievementRepository>().countAchievements(
          filter: AchievementFilterEntity(id: values[0], title: values[1]),
        ),
  );

  static final handEquippableDbcItem =
      FoxyEntityPickerDelegate<BriefDbcItemEntity>(
        title: '可持握物品',
        errorLabel: '搜索 Item.dbc 物品失败',
        filters: const [FoxyEntityPickerFilter('物品 ID')],
        columns: [
          FoxyEntityPickerColumn(
            header: '物品 ID',
            width: 140,
            text: (BriefDbcItemEntity t) => t.id.toString(),
          ),
          FoxyEntityPickerColumn(
            header: '类 / 子类',
            width: 140,
            text: (BriefDbcItemEntity t) => '${t.classId} / ${t.subclassId}',
          ),
          FoxyEntityPickerColumn(
            header: '装备位置',
            width: 120,
            text: (BriefDbcItemEntity t) => t.inventoryType.toString(),
          ),
          FoxyEntityPickerColumn(
            header: '显示 ID',
            text: (BriefDbcItemEntity t) => t.displayInfoId.toString(),
          ),
        ],
        idOf: (BriefDbcItemEntity t) => t.id,
        fetch: (page, v) =>
            GetIt.instance.get<DbcItemRepository>().getBriefDbcItems(
              page: page,
              filter: DbcItemFilterEntity(id: v[0], handEquippableOnly: true),
            ),
        count: (v) => GetIt.instance.get<DbcItemRepository>().countDbcItems(
          filter: DbcItemFilterEntity(id: v[0], handEquippableOnly: true),
        ),
      );

  static final achievementCategory =
      FoxyEntityPickerDelegate<BriefAchievementCategoryEntity>(
        title: '成就分类',
        errorLabel: '搜索 Achievement_Category.dbc 分类失败',
        filters: const [
          FoxyEntityPickerFilter('分类 ID'),
          FoxyEntityPickerFilter('分类名称'),
        ],
        columns: [
          FoxyEntityPickerColumn(
            header: '编号',
            width: 120,
            text: (BriefAchievementCategoryEntity value) => value.id.toString(),
          ),
          FoxyEntityPickerColumn(
            header: '名称',
            text: (BriefAchievementCategoryEntity value) => value.nameLangZhCN,
          ),
          FoxyEntityPickerColumn(
            header: '父分类',
            width: 120,
            text: (BriefAchievementCategoryEntity value) =>
                value.parent.toString(),
          ),
        ],
        idOf: (BriefAchievementCategoryEntity value) => value.id,
        fetch: (page, values) => GetIt.instance
            .get<AchievementCategoryRepository>()
            .getBriefAchievementCategories(
              page: page,
              filter: AchievementCategoryFilterEntity(
                id: values[0],
                name: values[1],
              ),
            ),
        count: (values) => GetIt.instance
            .get<AchievementCategoryRepository>()
            .countAchievementCategories(
              filter: AchievementCategoryFilterEntity(
                id: values[0],
                name: values[1],
              ),
            ),
      );

  static final _referenceLootRepository = LootTemplateRepository(
    LootTableType.reference,
  );
  static final _disenchantLootRepository = LootTemplateRepository(
    LootTableType.disenchant,
  );

  static final referenceLoot =
      FoxyEntityPickerDelegate<BriefLootTemplateEntryEntity>(
        title: '关联掉落模板',
        errorLabel: '搜索关联掉落模板失败',
        filters: const [FoxyEntityPickerFilter('模板 ID')],
        columns: [
          FoxyEntityPickerColumn(
            header: '模板 ID',
            width: 160,
            text: (BriefLootTemplateEntryEntity t) => t.entry.toString(),
          ),
          FoxyEntityPickerColumn(
            header: '掉落项数',
            text: (BriefLootTemplateEntryEntity t) => t.itemCount.toString(),
          ),
        ],
        idOf: (BriefLootTemplateEntryEntity t) => t.entry,
        fetch: (page, v) =>
            _referenceLootRepository.getBriefLootTemplateEntries(
              page: page,
              filter: LootTemplateFilterEntity(entry: v[0]),
            ),
        count: (v) => _referenceLootRepository.countLootTemplates(
          filter: LootTemplateFilterEntity(entry: v[0]),
        ),
      );

  static final dbcEmote = FoxyEntityPickerDelegate<BriefDbcEmoteEntity>(
    title: '生物表情',
    errorLabel: '搜索生物表情失败',
    filters: const [
      FoxyEntityPickerFilter('表情 ID'),
      FoxyEntityPickerFilter('斜杠命令'),
    ],
    columns: [
      FoxyEntityPickerColumn(
        header: '编号',
        width: 120,
        text: (BriefDbcEmoteEntity t) => t.id.toString(),
      ),
      FoxyEntityPickerColumn(
        header: '命令',
        text: (BriefDbcEmoteEntity t) => t.slashCommand,
      ),
      FoxyEntityPickerColumn(
        header: '动画 ID',
        width: 120,
        text: (BriefDbcEmoteEntity t) => t.animId.toString(),
      ),
    ],
    idOf: (BriefDbcEmoteEntity t) => t.id,
    fetch: (page, v) =>
        GetIt.instance.get<DbcEmoteRepository>().getBriefDbcEmotes(
          page: page,
          filter: DbcEmoteFilterEntity(id: v[0], command: v[1]),
        ),
    count: (v) => GetIt.instance.get<DbcEmoteRepository>().countDbcEmotes(
      filter: DbcEmoteFilterEntity(id: v[0], command: v[1]),
    ),
  );

  static final emoteTextData =
      FoxyEntityPickerDelegate<BriefEmoteTextDataEntity>(
        title: '表情文本内容',
        errorLabel: '搜索表情文本内容失败',
        filters: const [
          FoxyEntityPickerFilter('文本 ID'),
          FoxyEntityPickerFilter('文本内容'),
        ],
        columns: [
          FoxyEntityPickerColumn(
            header: '编号',
            width: 120,
            text: (BriefEmoteTextDataEntity t) => t.id.toString(),
          ),
          FoxyEntityPickerColumn(
            header: '文本',
            text: (BriefEmoteTextDataEntity t) => t.textLangZhCN,
          ),
        ],
        idOf: (BriefEmoteTextDataEntity t) => t.id,
        fetch: (page, v) => GetIt.instance
            .get<EmoteTextDataRepository>()
            .getBriefEmoteTextDatas(
              page: page,
              filter: EmoteTextDataFilterEntity(id: v[0], text: v[1]),
            ),
        count: (v) =>
            GetIt.instance.get<EmoteTextDataRepository>().countEmoteTextDatas(
              filter: EmoteTextDataFilterEntity(id: v[0], text: v[1]),
            ),
      );

  static final skillLine = FoxyEntityPickerDelegate<BriefSkillLineEntity>(
    title: '技能线',
    errorLabel: '搜索技能线失败',
    filters: const [
      FoxyEntityPickerFilter('技能线 ID'),
      FoxyEntityPickerFilter('技能线名称'),
    ],
    columns: [
      FoxyEntityPickerColumn(
        header: '编号',
        width: 120,
        text: (BriefSkillLineEntity t) => t.id.toString(),
      ),
      FoxyEntityPickerColumn(
        header: '名称',
        text: (BriefSkillLineEntity t) => t.displayNameZhCN,
      ),
      FoxyEntityPickerColumn(
        header: '分类 ID',
        width: 120,
        text: (BriefSkillLineEntity t) => t.categoryId.toString(),
      ),
    ],
    idOf: (BriefSkillLineEntity t) => t.id,
    fetch: (page, v) =>
        GetIt.instance.get<SkillLineRepository>().getBriefSkillLines(
          page: page,
          filter: SkillLineFilterEntity(id: v[0], name: v[1]),
        ),
    count: (v) => GetIt.instance.get<SkillLineRepository>().countSkillLines(
      filter: SkillLineFilterEntity(id: v[0], name: v[1]),
    ),
  );

  static final creatureDisplayInfo =
      FoxyEntityPickerDelegate<BriefCreatureDisplayInfoEntity>(
        title: '生物显示信息',
        errorLabel: '搜索生物显示信息失败',
        filters: const [
          FoxyEntityPickerFilter('显示信息 ID'),
          FoxyEntityPickerFilter('模型名称'),
        ],
        columns: [
          FoxyEntityPickerColumn(
            header: '编号',
            width: 120,
            text: (BriefCreatureDisplayInfoEntity t) => t.id.toString(),
          ),
          FoxyEntityPickerColumn(
            header: '模型 ID',
            width: 120,
            text: (BriefCreatureDisplayInfoEntity t) => t.modelId.toString(),
          ),
          FoxyEntityPickerColumn(
            header: '模型名称',
            text: (BriefCreatureDisplayInfoEntity t) => t.modelName,
          ),
        ],
        idOf: (BriefCreatureDisplayInfoEntity t) => t.id,
        fetch: (page, v) => GetIt.instance
            .get<CreatureDisplayInfoRepository>()
            .getBriefCreatureDisplayInfos(
              page: page,
              filter: CreatureDisplayInfoFilterEntity(
                id: v[0],
                modelName: v[1],
              ),
            ),
        count: (v) => GetIt.instance
            .get<CreatureDisplayInfoRepository>()
            .countCreatureDisplayInfos(
              filter: CreatureDisplayInfoFilterEntity(
                id: v[0],
                modelName: v[1],
              ),
            ),
      );

  static final waypointData = FoxyEntityPickerDelegate<BriefWaypointDataEntity>(
    title: '路径',
    errorLabel: '搜索路径失败',
    filters: const [FoxyEntityPickerFilter('路径 ID')],
    columns: [
      FoxyEntityPickerColumn(
        header: '路径 ID',
        width: 160,
        text: (BriefWaypointDataEntity t) => t.id.toString(),
      ),
      FoxyEntityPickerColumn(
        header: '路径点数',
        text: (BriefWaypointDataEntity t) => t.points.toString(),
      ),
    ],
    idOf: (BriefWaypointDataEntity t) => t.id,
    fetch: (page, v) =>
        GetIt.instance.get<WaypointDataRepository>().getBriefWaypointDatas(
          page: page,
          filter: WaypointDataFilterEntity(id: v[0]),
        ),
    count: (v) => GetIt.instance
        .get<WaypointDataRepository>()
        .countWaypointDatas(filter: WaypointDataFilterEntity(id: v[0])),
  );

  static final areaTable = FoxyEntityPickerDelegate<BriefAreaTableEntity>(
    title: '区域',
    errorLabel: '搜索区域失败',
    filters: const [
      FoxyEntityPickerFilter('区域ID'),
      FoxyEntityPickerFilter('区域名称'),
    ],
    columns: [
      FoxyEntityPickerColumn(
        header: '编号',
        width: 120,
        text: (BriefAreaTableEntity t) => t.id.toString(),
      ),
      FoxyEntityPickerColumn(
        header: '名称',
        text: (BriefAreaTableEntity t) => t.areaNameLangZhCN,
      ),
      FoxyEntityPickerColumn(
        header: '地区编号',
        width: 120,
        text: (BriefAreaTableEntity t) => t.continentId.toString(),
      ),
    ],
    idOf: (BriefAreaTableEntity t) => t.id,
    fetch: (page, v) =>
        GetIt.instance.get<AreaTableRepository>().getBriefAreaTables(
          filter: AreaTableFilterEntity(id: v[0], name: v[1]),
          page: page,
        ),
    count: (v) => GetIt.instance.get<AreaTableRepository>().countAreaTables(
      filter: AreaTableFilterEntity(id: v[0], name: v[1]),
    ),
  );

  static final soundProviderPreferences =
      FoxyEntityPickerDelegate<BriefSoundProviderPreferencesEntity>(
        title: '声音提供器偏好',
        errorLabel: '搜索 SoundProviderPreferences.dbc 失败',
        filters: const [
          FoxyEntityPickerFilter('偏好 ID'),
          FoxyEntityPickerFilter('描述'),
        ],
        columns: [
          FoxyEntityPickerColumn(
            header: '编号',
            width: 120,
            text: (BriefSoundProviderPreferencesEntity value) =>
                value.id.toString(),
          ),
          FoxyEntityPickerColumn(
            header: '描述',
            text: (BriefSoundProviderPreferencesEntity value) =>
                value.description,
          ),
          FoxyEntityPickerColumn(
            header: '标志',
            width: 120,
            text: (BriefSoundProviderPreferencesEntity value) =>
                value.flags.toString(),
          ),
        ],
        idOf: (BriefSoundProviderPreferencesEntity value) => value.id,
        fetch: (page, values) => GetIt.instance
            .get<SoundProviderPreferencesRepository>()
            .getBriefSoundProviderPreferences(
              page: page,
              filter: SoundProviderPreferencesFilterEntity(
                id: values[0],
                description: values[1],
              ),
            ),
        count: (values) => GetIt.instance
            .get<SoundProviderPreferencesRepository>()
            .countSoundProviderPreferences(
              filter: SoundProviderPreferencesFilterEntity(
                id: values[0],
                description: values[1],
              ),
            ),
      );

  static final soundAmbience =
      FoxyEntityPickerDelegate<BriefSoundAmbienceEntity>(
        title: '环境声音',
        errorLabel: '搜索 SoundAmbience.dbc 失败',
        filters: const [FoxyEntityPickerFilter('环境声音 ID')],
        columns: [
          FoxyEntityPickerColumn(
            header: '编号',
            width: 120,
            text: (BriefSoundAmbienceEntity value) => value.id.toString(),
          ),
          FoxyEntityPickerColumn(
            header: '日间声音',
            text: (BriefSoundAmbienceEntity value) =>
                value.ambienceId0.toString(),
          ),
          FoxyEntityPickerColumn(
            header: '夜间声音',
            text: (BriefSoundAmbienceEntity value) =>
                value.ambienceId1.toString(),
          ),
        ],
        idOf: (BriefSoundAmbienceEntity value) => value.id,
        fetch: (page, values) => GetIt.instance
            .get<SoundAmbienceRepository>()
            .getBriefSoundAmbiences(
              page: page,
              filter: SoundAmbienceFilterEntity(id: values[0]),
            ),
        count: (values) =>
            GetIt.instance.get<SoundAmbienceRepository>().countSoundAmbiences(
              filter: SoundAmbienceFilterEntity(id: values[0]),
            ),
      );

  static final zoneMusic = FoxyEntityPickerDelegate<BriefZoneMusicEntity>(
    title: '区域音乐',
    errorLabel: '搜索 ZoneMusic.dbc 失败',
    filters: const [
      FoxyEntityPickerFilter('音乐 ID'),
      FoxyEntityPickerFilter('集合名称'),
    ],
    columns: [
      FoxyEntityPickerColumn(
        header: '编号',
        width: 120,
        text: (BriefZoneMusicEntity value) => value.id.toString(),
      ),
      FoxyEntityPickerColumn(
        header: '名称',
        text: (BriefZoneMusicEntity value) => value.setName,
      ),
      FoxyEntityPickerColumn(
        header: '日间声音',
        width: 120,
        text: (BriefZoneMusicEntity value) => value.sounds0.toString(),
      ),
      FoxyEntityPickerColumn(
        header: '夜间声音',
        width: 120,
        text: (BriefZoneMusicEntity value) => value.sounds1.toString(),
      ),
    ],
    idOf: (BriefZoneMusicEntity value) => value.id,
    fetch: (page, values) =>
        GetIt.instance.get<ZoneMusicRepository>().getBriefZoneMusics(
          page: page,
          filter: ZoneMusicFilterEntity(id: values[0], name: values[1]),
        ),
    count: (values) =>
        GetIt.instance.get<ZoneMusicRepository>().countZoneMusics(
          filter: ZoneMusicFilterEntity(id: values[0], name: values[1]),
        ),
  );

  static final zoneIntroMusic =
      FoxyEntityPickerDelegate<BriefZoneIntroMusicEntity>(
        title: '区域进入音乐',
        errorLabel: '搜索 ZoneIntroMusicTable.dbc 失败',
        filters: const [
          FoxyEntityPickerFilter('进入音乐 ID'),
          FoxyEntityPickerFilter('名称'),
        ],
        columns: [
          FoxyEntityPickerColumn(
            header: '编号',
            width: 120,
            text: (BriefZoneIntroMusicEntity value) => value.id.toString(),
          ),
          FoxyEntityPickerColumn(
            header: '名称',
            text: (BriefZoneIntroMusicEntity value) => value.name,
          ),
          FoxyEntityPickerColumn(
            header: '声音 ID',
            width: 120,
            text: (BriefZoneIntroMusicEntity value) => value.soundId.toString(),
          ),
        ],
        idOf: (BriefZoneIntroMusicEntity value) => value.id,
        fetch: (page, values) => GetIt.instance
            .get<ZoneIntroMusicRepository>()
            .getBriefZoneIntroMusics(
              page: page,
              filter: ZoneIntroMusicFilterEntity(
                id: values[0],
                name: values[1],
              ),
            ),
        count: (values) =>
            GetIt.instance.get<ZoneIntroMusicRepository>().countZoneIntroMusics(
              filter: ZoneIntroMusicFilterEntity(
                id: values[0],
                name: values[1],
              ),
            ),
      );

  static final liquidType = FoxyEntityPickerDelegate<BriefLiquidTypeEntity>(
    title: '液体类型',
    errorLabel: '搜索 LiquidType.dbc 失败',
    filters: const [
      FoxyEntityPickerFilter('液体类型 ID'),
      FoxyEntityPickerFilter('名称'),
    ],
    columns: [
      FoxyEntityPickerColumn(
        header: '编号',
        width: 120,
        text: (BriefLiquidTypeEntity value) => value.id.toString(),
      ),
      FoxyEntityPickerColumn(
        header: '名称',
        text: (BriefLiquidTypeEntity value) => value.name,
      ),
      FoxyEntityPickerColumn(
        header: '类别',
        width: 120,
        text: (BriefLiquidTypeEntity value) => value.soundBank.toString(),
      ),
      FoxyEntityPickerColumn(
        header: '法术 ID',
        width: 120,
        text: (BriefLiquidTypeEntity value) => value.spellId.toString(),
      ),
    ],
    idOf: (BriefLiquidTypeEntity value) => value.id,
    fetch: (page, values) =>
        GetIt.instance.get<LiquidTypeRepository>().getBriefLiquidTypes(
          page: page,
          filter: LiquidTypeFilterEntity(id: values[0], name: values[1]),
        ),
    count: (values) =>
        GetIt.instance.get<LiquidTypeRepository>().countLiquidTypes(
          filter: LiquidTypeFilterEntity(id: values[0], name: values[1]),
        ),
  );

  static final light = FoxyEntityPickerDelegate<BriefLightEntity>(
    title: '光照',
    errorLabel: '搜索 Light.dbc 失败',
    filters: const [
      FoxyEntityPickerFilter('光照 ID'),
      FoxyEntityPickerFilter('地图 ID'),
    ],
    columns: [
      FoxyEntityPickerColumn(
        header: '编号',
        width: 120,
        text: (BriefLightEntity value) => value.id.toString(),
      ),
      FoxyEntityPickerColumn(
        header: '地图 ID',
        width: 120,
        text: (BriefLightEntity value) => value.continentId.toString(),
      ),
      FoxyEntityPickerColumn(
        header: '坐标 X',
        text: (BriefLightEntity value) => value.gameCoords0.toString(),
      ),
      FoxyEntityPickerColumn(
        header: '坐标 Y',
        text: (BriefLightEntity value) => value.gameCoords1.toString(),
      ),
      FoxyEntityPickerColumn(
        header: '坐标 Z',
        text: (BriefLightEntity value) => value.gameCoords2.toString(),
      ),
    ],
    idOf: (BriefLightEntity value) => value.id,
    fetch: (page, values) =>
        GetIt.instance.get<LightRepository>().getBriefLights(
          page: page,
          filter: LightFilterEntity(id: values[0], continentId: values[1]),
        ),
    count: (values) => GetIt.instance.get<LightRepository>().countLights(
      filter: LightFilterEntity(id: values[0], continentId: values[1]),
    ),
  );

  static final broadcastText =
      FoxyEntityPickerDelegate<BriefBroadcastTextEntity>(
        title: '广播文本',
        errorLabel: '搜索广播文本失败',
        filters: const [
          FoxyEntityPickerFilter('广播文本ID'),
          FoxyEntityPickerFilter('文本内容'),
        ],
        columns: [
          FoxyEntityPickerColumn(
            header: '编号',
            width: 120,
            text: (BriefBroadcastTextEntity t) => t.id.toString(),
          ),
          FoxyEntityPickerColumn(
            header: '文本',
            text: (BriefBroadcastTextEntity t) => t.maleText,
          ),
          FoxyEntityPickerColumn(
            header: '语言',
            width: 120,
            text: (BriefBroadcastTextEntity t) => t.languageId.toString(),
          ),
        ],
        idOf: (BriefBroadcastTextEntity t) => t.id,
        fetch: (page, v) => GetIt.instance
            .get<BroadcastTextRepository>()
            .getBriefBroadcastTexts(
              filter: BroadcastTextFilterEntity(id: v[0], text: v[1]),
              page: page,
            ),
        count: (v) =>
            GetIt.instance.get<BroadcastTextRepository>().countBroadcastTexts(
              filter: BroadcastTextFilterEntity(id: v[0], text: v[1]),
            ),
      );

  static final charTitle = FoxyEntityPickerDelegate<BriefCharTitleEntity>(
    title: '称号',
    errorLabel: '搜索称号失败',
    filters: const [
      FoxyEntityPickerFilter('称号ID'),
      FoxyEntityPickerFilter('称号名称'),
    ],
    columns: [
      FoxyEntityPickerColumn(
        header: '编号',
        width: 120,
        text: (BriefCharTitleEntity t) => t.id.toString(),
      ),
      FoxyEntityPickerColumn(
        header: '名称',
        text: (BriefCharTitleEntity t) => t.nameLangZhCN,
      ),
    ],
    idOf: (BriefCharTitleEntity t) => t.id,
    fetch: (page, v) =>
        GetIt.instance.get<CharTitleRepository>().getBriefCharTitles(
          filter: CharTitleFilterEntity(id: v[0], name: v[1]),
          page: page,
        ),
    count: (v) => GetIt.instance.get<CharTitleRepository>().countCharTitles(
      filter: CharTitleFilterEntity(id: v[0], name: v[1]),
    ),
  );

  static final creatureSpellData =
      FoxyEntityPickerDelegate<BriefCreatureSpellDataEntity>(
        title: '宠物技能',
        errorLabel: '搜索宠物技能失败',
        filters: const [
          FoxyEntityPickerFilter('编号'),
          FoxyEntityPickerFilter('技能名称'),
        ],
        columns: [
          FoxyEntityPickerColumn(
            header: '编号',
            width: 120,
            text: (BriefCreatureSpellDataEntity t) => t.id.toString(),
          ),
          FoxyEntityPickerColumn(
            header: '技能1',
            text: (BriefCreatureSpellDataEntity t) => t.spellName1,
          ),
          FoxyEntityPickerColumn(
            header: '技能2',
            text: (BriefCreatureSpellDataEntity t) => t.spellName2,
          ),
          FoxyEntityPickerColumn(
            header: '技能3',
            text: (BriefCreatureSpellDataEntity t) => t.spellName3,
          ),
          FoxyEntityPickerColumn(
            header: '技能4',
            text: (BriefCreatureSpellDataEntity t) => t.spellName4,
          ),
        ],
        idOf: (BriefCreatureSpellDataEntity t) => t.id,
        fetch: (page, v) => GetIt.instance
            .get<CreatureSpellDataRepository>()
            .getBriefCreatureSpellDatas(
              filter: CreatureSpellDataFilterEntity(id: v[0], spell: v[1]),
              page: page,
            ),
        count: (v) => GetIt.instance
            .get<CreatureSpellDataRepository>()
            .countCreatureSpellDatas(
              filter: CreatureSpellDataFilterEntity(id: v[0], spell: v[1]),
            ),
      );

  static final creatureImmunity =
      FoxyEntityPickerDelegate<BriefCreatureImmunityEntity>(
        title: '生物免疫配置',
        errorLabel: '搜索生物免疫配置失败',
        filters: const [
          FoxyEntityPickerFilter('配置 ID'),
          FoxyEntityPickerFilter('注释'),
        ],
        columns: [
          FoxyEntityPickerColumn(
            header: '配置 ID',
            width: 100,
            text: (BriefCreatureImmunityEntity t) => t.id.toString(),
          ),
          FoxyEntityPickerColumn(
            header: '法术学派掩码',
            width: 120,
            text: (BriefCreatureImmunityEntity t) => t.schoolMask.toString(),
          ),
          FoxyEntityPickerColumn(
            header: '机制掩码',
            width: 120,
            text: (BriefCreatureImmunityEntity t) => t.mechanicsMask.toString(),
          ),
          FoxyEntityPickerColumn(
            header: 'AoE / 链式',
            width: 100,
            text: (BriefCreatureImmunityEntity t) =>
                '${t.immuneAoE} / ${t.immuneChain}',
          ),
          FoxyEntityPickerColumn(
            header: '注释',
            text: (BriefCreatureImmunityEntity t) => t.comment,
          ),
        ],
        idOf: (BriefCreatureImmunityEntity t) => t.id,
        fetch: (page, v) => GetIt.instance
            .get<CreatureImmunityRepository>()
            .getBriefCreatureImmunities(
              page: page,
              filter: CreatureImmunityFilterEntity(id: v[0], comment: v[1]),
            ),
        count: (v) => GetIt.instance
            .get<CreatureImmunityRepository>()
            .countCreatureImmunities(
              filter: CreatureImmunityFilterEntity(id: v[0], comment: v[1]),
            ),
      );

  static final creatureMovementInfo =
      FoxyEntityPickerDelegate<CreatureMovementInfoEntity>(
        title: '生物移动信息',
        errorLabel: '搜索生物移动信息失败',
        filters: const [FoxyEntityPickerFilter('编号')],
        columns: [
          FoxyEntityPickerColumn(
            header: '编号',
            width: 120,
            text: (CreatureMovementInfoEntity t) => t.id.toString(),
          ),
          FoxyEntityPickerColumn(
            header: '平滑转向追逐速率',
            text: (CreatureMovementInfoEntity t) =>
                t.smoothFacingChaseRate.toString(),
          ),
        ],
        idOf: (CreatureMovementInfoEntity t) => t.id,
        fetch: (page, v) => GetIt.instance
            .get<CreatureMovementInfoRepository>()
            .getBriefCreatureMovementInfos(
              page: page,
              filter: CreatureMovementInfoFilterEntity(id: v[0]),
            ),
        count: (v) => GetIt.instance
            .get<CreatureMovementInfoRepository>()
            .countCreatureMovementInfos(
              filter: CreatureMovementInfoFilterEntity(id: v[0]),
            ),
      );

  static final creatureTemplate =
      FoxyEntityPickerDelegate<BriefCreatureTemplateEntity>(
        title: '生物模板',
        errorLabel: '搜索生物模板失败',
        filters: const [
          FoxyEntityPickerFilter('编号'),
          FoxyEntityPickerFilter('名称'),
        ],
        columns: [
          FoxyEntityPickerColumn(
            header: '编号',
            width: 120,
            text: (BriefCreatureTemplateEntity t) => t.entry.toString(),
          ),
          FoxyEntityPickerColumn(
            header: '名称',
            text: (BriefCreatureTemplateEntity t) => t.displayName,
          ),
          FoxyEntityPickerColumn(
            header: '等级',
            width: 120,
            text: (BriefCreatureTemplateEntity t) =>
                '${t.minLevel} / ${t.maxLevel}',
          ),
        ],
        idOf: (BriefCreatureTemplateEntity t) => t.entry,
        fetch: (page, v) => GetIt.instance
            .get<CreatureTemplateRepository>()
            .getBriefCreatureTemplates(
              page: page,
              filter: CreatureTemplateFilterEntity(entry: v[0], name: v[1]),
            ),
        count: (v) => GetIt.instance
            .get<CreatureTemplateRepository>()
            .countCreatureTemplates(
              filter: CreatureTemplateFilterEntity(entry: v[0], name: v[1]),
            ),
      );

  static final dbcFaction = FoxyEntityPickerDelegate<BriefDbcFactionEntity>(
    title: '阵营',
    errorLabel: '搜索阵营失败',
    filters: const [
      FoxyEntityPickerFilter('阵营ID'),
      FoxyEntityPickerFilter('阵营名称'),
    ],
    columns: [
      FoxyEntityPickerColumn(
        header: '编号',
        width: 120,
        text: (BriefDbcFactionEntity t) => t.id.toString(),
      ),
      FoxyEntityPickerColumn(
        header: '名称',
        text: (BriefDbcFactionEntity t) => t.nameLangZhCN,
      ),
      FoxyEntityPickerColumn(
        header: '描述',
        text: (BriefDbcFactionEntity t) => t.descriptionLangZhCN,
      ),
    ],
    idOf: (BriefDbcFactionEntity t) => t.id,
    fetch: (page, v) =>
        GetIt.instance.get<DbcFactionRepository>().getBriefDbcFactions(
          filter: DbcFactionFilterEntity(id: v[0], name: v[1]),
          page: page,
        ),
    count: (v) => GetIt.instance.get<DbcFactionRepository>().countDbcFactions(
      filter: DbcFactionFilterEntity(id: v[0], name: v[1]),
    ),
  );

  static final dbcFactionTemplate =
      FoxyEntityPickerDelegate<BriefDbcFactionTemplateEntity>(
        title: '阵营模板',
        errorLabel: '搜索阵营模板失败',
        filters: const [
          FoxyEntityPickerFilter('模板 ID'),
          FoxyEntityPickerFilter('阵营 ID'),
          FoxyEntityPickerFilter('阵营名称'),
        ],
        columns: [
          FoxyEntityPickerColumn(
            header: '模板 ID',
            width: 100,
            text: (BriefDbcFactionTemplateEntity t) => t.id.toString(),
          ),
          FoxyEntityPickerColumn(
            header: '阵营 ID',
            width: 100,
            text: (BriefDbcFactionTemplateEntity t) => t.faction.toString(),
          ),
          FoxyEntityPickerColumn(
            header: '阵营名称',
            text: (BriefDbcFactionTemplateEntity t) => t.displayName,
          ),
          FoxyEntityPickerColumn(
            header: '组 / 友好 / 敌对',
            width: 150,
            text: (BriefDbcFactionTemplateEntity t) =>
                '${t.factionGroup} / ${t.friendGroup} / ${t.enemyGroup}',
          ),
        ],
        idOf: (BriefDbcFactionTemplateEntity t) => t.id,
        fetch: (page, v) => GetIt.instance
            .get<DbcFactionTemplateRepository>()
            .getBriefDbcFactionTemplates(
              page: page,
              filter: DbcFactionTemplateFilterEntity(
                id: v[0],
                faction: v[1],
                name: v[2],
              ),
            ),
        count: (v) => GetIt.instance
            .get<DbcFactionTemplateRepository>()
            .countDbcFactionTemplates(
              filter: DbcFactionTemplateFilterEntity(
                id: v[0],
                faction: v[1],
                name: v[2],
              ),
            ),
      );

  static final emote = FoxyEntityPickerDelegate<BriefEmoteTextEntity>(
    title: '表情',
    errorLabel: '搜索表情失败',
    filters: const [
      FoxyEntityPickerFilter('表情ID'),
      FoxyEntityPickerFilter('表情名称'),
    ],
    columns: [
      FoxyEntityPickerColumn(
        header: '编号',
        width: 120,
        text: (BriefEmoteTextEntity t) => t.id.toString(),
      ),
      FoxyEntityPickerColumn(
        header: '名称',
        text: (BriefEmoteTextEntity t) => t.name,
      ),
      FoxyEntityPickerColumn(
        header: '表情编号',
        width: 120,
        text: (BriefEmoteTextEntity t) => t.emoteId.toString(),
      ),
    ],
    idOf: (BriefEmoteTextEntity t) => t.id,
    fetch: (page, v) =>
        GetIt.instance.get<EmoteTextRepository>().getBriefEmoteTexts(
          filter: EmoteTextFilterEntity(id: v[0], name: v[1]),
          page: page,
        ),
    count: (v) => GetIt.instance.get<EmoteTextRepository>().countEmoteTexts(
      filter: EmoteTextFilterEntity(id: v[0], name: v[1]),
    ),
  );

  static final gossipMenu = FoxyEntityPickerDelegate<BriefGossipMenuEntity>(
    title: '对话菜单',
    errorLabel: '搜索对话菜单失败',
    filters: const [
      FoxyEntityPickerFilter('菜单ID'),
      FoxyEntityPickerFilter('文本内容'),
    ],
    columns: [
      FoxyEntityPickerColumn(
        header: '菜单ID',
        width: 120,
        text: (BriefGossipMenuEntity t) => t.menuId.toString(),
      ),
      FoxyEntityPickerColumn(
        header: '文本ID',
        width: 120,
        text: (BriefGossipMenuEntity t) => t.textId.toString(),
      ),
      FoxyEntityPickerColumn(
        header: '文本内容',
        text: (BriefGossipMenuEntity t) => t.text,
      ),
    ],
    idOf: (BriefGossipMenuEntity t) => t.menuId,
    fetch: (page, v) =>
        GetIt.instance.get<GossipMenuRepository>().getBriefGossipMenus(
          filter: GossipMenuFilterEntity(menuId: v[0], text: v[1]),
          page: page,
        ),
    count: (v) => GetIt.instance.get<GossipMenuRepository>().countGossipMenus(
      filter: GossipMenuFilterEntity(menuId: v[0], text: v[1]),
    ),
  );

  static final pointOfInterest =
      FoxyEntityPickerDelegate<BriefPointOfInterestEntity>(
        title: '兴趣点',
        errorLabel: '搜索兴趣点失败',
        filters: const [
          FoxyEntityPickerFilter('兴趣点 ID'),
          FoxyEntityPickerFilter('名称'),
        ],
        columns: [
          FoxyEntityPickerColumn(
            header: 'ID',
            width: 120,
            text: (BriefPointOfInterestEntity entity) => entity.id.toString(),
          ),
          FoxyEntityPickerColumn(
            header: '名称',
            text: (BriefPointOfInterestEntity entity) => entity.displayName,
          ),
        ],
        idOf: (BriefPointOfInterestEntity entity) => entity.id,
        fetch: (page, values) => GetIt.instance
            .get<PointOfInterestRepository>()
            .getBriefPointsOfInterest(
              page: page,
              filter: PointOfInterestFilterEntity(
                id: values[0],
                name: values[1],
              ),
            ),
        count: (values) => GetIt.instance
            .get<PointOfInterestRepository>()
            .countPointsOfInterest(
              filter: PointOfInterestFilterEntity(
                id: values[0],
                name: values[1],
              ),
            ),
      );

  static final cinematicSequence =
      FoxyEntityPickerDelegate<BriefCinematicSequenceEntity>(
        title: '过场动画序列',
        errorLabel: '搜索 CinematicSequences.dbc 失败',
        filters: const [FoxyEntityPickerFilter('序列 ID')],
        columns: [
          FoxyEntityPickerColumn(
            header: 'ID',
            width: 120,
            text: (BriefCinematicSequenceEntity row) => row.id.toString(),
          ),
          FoxyEntityPickerColumn(
            header: '声音 ID',
            width: 160,
            text: (BriefCinematicSequenceEntity row) => row.soundId.toString(),
          ),
          FoxyEntityPickerColumn(
            header: '首个镜头 ID',
            text: (BriefCinematicSequenceEntity row) => row.camera0.toString(),
          ),
        ],
        idOf: (BriefCinematicSequenceEntity row) => row.id,
        fetch: (page, values) => GetIt.instance
            .get<CinematicSequenceRepository>()
            .getBriefCinematicSequences(
              page: page,
              filter: CinematicSequenceFilterEntity(id: values[0]),
            ),
        count: (values) => GetIt.instance
            .get<CinematicSequenceRepository>()
            .countCinematicSequences(
              filter: CinematicSequenceFilterEntity(id: values[0]),
            ),
      );

  static final destructibleModelData =
      FoxyEntityPickerDelegate<BriefDestructibleModelDataEntity>(
        title: '可破坏模型数据',
        errorLabel: '搜索 DestructibleModelData.dbc 失败',
        filters: const [FoxyEntityPickerFilter('模型数据 ID')],
        columns: [
          FoxyEntityPickerColumn(
            header: 'ID',
            width: 120,
            text: (BriefDestructibleModelDataEntity row) => row.id.toString(),
          ),
          FoxyEntityPickerColumn(
            header: '状态 1 WMO',
            text: (BriefDestructibleModelDataEntity row) =>
                row.state1Wmo.toString(),
          ),
          FoxyEntityPickerColumn(
            header: '状态 2 WMO',
            text: (BriefDestructibleModelDataEntity row) =>
                row.state2Wmo.toString(),
          ),
          FoxyEntityPickerColumn(
            header: '状态 3 WMO',
            text: (BriefDestructibleModelDataEntity row) =>
                row.state3Wmo.toString(),
          ),
        ],
        idOf: (BriefDestructibleModelDataEntity row) => row.id,
        fetch: (page, values) => GetIt.instance
            .get<DestructibleModelDataRepository>()
            .getBriefDestructibleModelDatas(
              page: page,
              filter: DestructibleModelDataFilterEntity(id: values[0]),
            ),
        count: (values) => GetIt.instance
            .get<DestructibleModelDataRepository>()
            .countDestructibleModelDatas(
              filter: DestructibleModelDataFilterEntity(id: values[0]),
            ),
      );

  static final gameObjectArtKit =
      FoxyEntityPickerDelegate<BriefGameObjectArtKitEntity>(
        title: '游戏对象 ArtKit',
        errorLabel: '搜索 GameObjectArtKit.dbc 失败',
        filters: const [
          FoxyEntityPickerFilter('ArtKit ID'),
          FoxyEntityPickerFilter('资源路径'),
        ],
        columns: [
          FoxyEntityPickerColumn(
            header: 'ID',
            width: 120,
            text: (BriefGameObjectArtKitEntity row) => row.id.toString(),
          ),
          FoxyEntityPickerColumn(
            header: '纹理',
            text: (BriefGameObjectArtKitEntity row) => row.textureVariation0,
          ),
          FoxyEntityPickerColumn(
            header: '附加模型',
            text: (BriefGameObjectArtKitEntity row) => row.attachModel0,
          ),
        ],
        idOf: (BriefGameObjectArtKitEntity row) => row.id,
        fetch: (page, values) => GetIt.instance
            .get<GameObjectArtKitRepository>()
            .getBriefGameObjectArtKits(
              page: page,
              filter: GameObjectArtKitFilterEntity(
                id: values[0],
                path: values[1],
              ),
            ),
        count: (values) => GetIt.instance
            .get<GameObjectArtKitRepository>()
            .countGameObjectArtKits(
              filter: GameObjectArtKitFilterEntity(
                id: values[0],
                path: values[1],
              ),
            ),
      );

  static final gameObjectDisplayInfo =
      FoxyEntityPickerDelegate<BriefGameObjectDisplayInfoEntity>(
        title: '游戏对象显示信息',
        errorLabel: '搜索 GameObjectDisplayInfo.dbc 失败',
        filters: const [
          FoxyEntityPickerFilter('显示 ID'),
          FoxyEntityPickerFilter('模型名称'),
        ],
        columns: [
          FoxyEntityPickerColumn(
            header: 'ID',
            width: 120,
            text: (BriefGameObjectDisplayInfoEntity row) => row.id.toString(),
          ),
          FoxyEntityPickerColumn(
            header: '模型名称',
            text: (BriefGameObjectDisplayInfoEntity row) => row.modelName,
          ),
        ],
        idOf: (BriefGameObjectDisplayInfoEntity row) => row.id,
        fetch: (page, values) => GetIt.instance
            .get<GameObjectDisplayInfoRepository>()
            .getBriefGameObjectDisplayInfos(
              page: page,
              filter: GameObjectDisplayInfoFilterEntity(
                id: values[0],
                modelName: values[1],
              ),
            ),
        count: (values) => GetIt.instance
            .get<GameObjectDisplayInfoRepository>()
            .countGameObjectDisplayInfos(
              filter: GameObjectDisplayInfoFilterEntity(
                id: values[0],
                modelName: values[1],
              ),
            ),
      );

  static final spellFocusObject =
      FoxyEntityPickerDelegate<BriefSpellFocusObjectEntity>(
        title: '法术焦点对象',
        errorLabel: '搜索 SpellFocusObject.dbc 失败',
        filters: const [
          FoxyEntityPickerFilter('焦点 ID'),
          FoxyEntityPickerFilter('名称'),
        ],
        columns: [
          FoxyEntityPickerColumn(
            header: 'ID',
            width: 120,
            text: (BriefSpellFocusObjectEntity row) => row.id.toString(),
          ),
          FoxyEntityPickerColumn(
            header: '名称',
            text: (BriefSpellFocusObjectEntity row) => row.displayName,
          ),
        ],
        idOf: (BriefSpellFocusObjectEntity row) => row.id,
        fetch: (page, values) => GetIt.instance
            .get<SpellFocusObjectRepository>()
            .getBriefSpellFocusObjects(
              page: page,
              filter: SpellFocusObjectFilterEntity(
                id: values[0],
                name: values[1],
              ),
            ),
        count: (values) => GetIt.instance
            .get<SpellFocusObjectRepository>()
            .countSpellFocusObjects(
              filter: SpellFocusObjectFilterEntity(
                id: values[0],
                name: values[1],
              ),
            ),
      );

  static final taxiPath = FoxyEntityPickerDelegate<BriefTaxiPathEntity>(
    title: '飞行路径',
    errorLabel: '搜索 TaxiPath.dbc 失败',
    filters: const [FoxyEntityPickerFilter('路径 ID')],
    columns: [
      FoxyEntityPickerColumn(
        header: 'ID',
        width: 120,
        text: (BriefTaxiPathEntity row) => row.id.toString(),
      ),
      FoxyEntityPickerColumn(
        header: '起点',
        text: (BriefTaxiPathEntity row) => row.fromTaxiNode.toString(),
      ),
      FoxyEntityPickerColumn(
        header: '终点',
        text: (BriefTaxiPathEntity row) => row.toTaxiNode.toString(),
      ),
      FoxyEntityPickerColumn(
        header: '费用',
        text: (BriefTaxiPathEntity row) => row.cost.toString(),
      ),
    ],
    idOf: (BriefTaxiPathEntity row) => row.id,
    fetch: (page, values) =>
        GetIt.instance.get<TaxiPathRepository>().getBriefTaxiPaths(
          page: page,
          filter: TaxiPathFilterEntity(id: values[0]),
        ),
    count: (values) => GetIt.instance.get<TaxiPathRepository>().countTaxiPaths(
      filter: TaxiPathFilterEntity(id: values[0]),
    ),
  );

  static final gameObjectTemplate =
      FoxyEntityPickerDelegate<BriefGameObjectTemplateEntity>(
        title: '游戏对象模板',
        errorLabel: '搜索游戏对象模板失败',
        filters: const [
          FoxyEntityPickerFilter('游戏对象 ID'),
          FoxyEntityPickerFilter('名称'),
        ],
        columns: [
          FoxyEntityPickerColumn(
            header: '编号',
            width: 120,
            text: (BriefGameObjectTemplateEntity t) => t.entry.toString(),
          ),
          FoxyEntityPickerColumn(
            header: '名称',
            text: (BriefGameObjectTemplateEntity t) => t.displayName,
          ),
          FoxyEntityPickerColumn(
            header: '类型',
            width: 120,
            text: (BriefGameObjectTemplateEntity t) => t.type.toString(),
          ),
        ],
        idOf: (BriefGameObjectTemplateEntity t) => t.entry,
        fetch: (page, v) => GetIt.instance
            .get<GameObjectTemplateRepository>()
            .getBriefGameObjectTemplates(
              filter: GameObjectTemplateFilterEntity(entry: v[0], name: v[1]),
              page: page,
            ),
        count: (v) => GetIt.instance
            .get<GameObjectTemplateRepository>()
            .countGameObjectTemplates(
              filter: GameObjectTemplateFilterEntity(entry: v[0], name: v[1]),
            ),
      );

  static final itemDisplayInfo =
      FoxyEntityPickerDelegate<BriefItemDisplayInfoEntity>(
        title: '物品显示信息',
        errorLabel: '搜索显示信息失败',
        filters: const [
          FoxyEntityPickerFilter('显示信息ID'),
          FoxyEntityPickerFilter('模型名称'),
        ],
        columns: [
          FoxyEntityPickerColumn(
            header: '编号',
            width: 120,
            text: (BriefItemDisplayInfoEntity t) => t.id.toString(),
          ),
          FoxyEntityPickerColumn(
            header: '模型名称',
            text: (BriefItemDisplayInfoEntity t) => t.modelName0,
          ),
          FoxyEntityPickerColumn(
            header: '图标',
            text: (BriefItemDisplayInfoEntity t) => t.inventoryIcon0,
          ),
        ],
        idOf: (BriefItemDisplayInfoEntity t) => t.id,
        fetch: (page, v) => GetIt.instance
            .get<ItemDisplayInfoRepository>()
            .getBriefItemDisplayInfos(
              filter: ItemDisplayInfoFilterEntity(id: v[0], name: v[1]),
              page: page,
            ),
        count: (v) => GetIt.instance
            .get<ItemDisplayInfoRepository>()
            .countItemDisplayInfos(
              filter: ItemDisplayInfoFilterEntity(id: v[0], name: v[1]),
            ),
      );

  static final itemEnchantmentTemplate =
      FoxyEntityPickerDelegate<BriefItemEnchantmentTemplateEntity>(
        title: '附魔',
        errorLabel: '搜索附魔失败',
        filters: const [
          FoxyEntityPickerFilter('编号'),
          FoxyEntityPickerFilter('名称'),
        ],
        columns: [
          FoxyEntityPickerColumn(
            header: '编号',
            width: 120,
            text: (BriefItemEnchantmentTemplateEntity t) => t.entry.toString(),
          ),
          FoxyEntityPickerColumn(
            header: '名称',
            text: (BriefItemEnchantmentTemplateEntity t) => t.name,
          ),
        ],
        idOf: (BriefItemEnchantmentTemplateEntity t) => t.entry,
        fetch: (page, v) => GetIt.instance
            .get<ItemEnchantmentTemplateRepository>()
            .getBriefItemEnchantmentTemplates(
              filter: ItemEnchantmentTemplateFilterEntity(entry: v[0]),
              page: page,
            ),
        count: (v) => GetIt.instance
            .get<ItemEnchantmentTemplateRepository>()
            .countItemEnchantmentTemplates(
              filter: ItemEnchantmentTemplateFilterEntity(entry: v[0]),
            ),
      );

  static final randomPropertyGroup = _itemEnchantmentGroupDelegate(
    title: '随机属性组',
    kind: ItemEnchantmentKind.randomProperty,
  );

  static final randomSuffixGroup = _itemEnchantmentGroupDelegate(
    title: '随机后缀组',
    kind: ItemEnchantmentKind.randomSuffix,
  );

  static FoxyEntityPickerDelegate<BriefItemEnchantmentTemplateEntity>
  _itemEnchantmentGroupDelegate({
    required String title,
    required ItemEnchantmentKind kind,
  }) => FoxyEntityPickerDelegate<BriefItemEnchantmentTemplateEntity>(
    title: title,
    errorLabel: '搜索$title失败',
    filters: const [FoxyEntityPickerFilter('组 ID')],
    columns: [
      FoxyEntityPickerColumn(
        header: '组 ID',
        width: 160,
        text: (BriefItemEnchantmentTemplateEntity row) => row.entry.toString(),
      ),
      FoxyEntityPickerColumn(
        header: '有效附魔数',
        text: (BriefItemEnchantmentTemplateEntity row) =>
            row.itemCount.toString(),
      ),
    ],
    idOf: (BriefItemEnchantmentTemplateEntity row) => row.entry,
    fetch: (page, values) => GetIt.instance
        .get<ItemEnchantmentTemplateRepository>()
        .getBriefItemEnchantmentGroups(
          kind: kind,
          page: page,
          filter: ItemEnchantmentTemplateFilterEntity(entry: values[0]),
        ),
    count: (values) => GetIt.instance
        .get<ItemEnchantmentTemplateRepository>()
        .countItemEnchantmentGroups(
          kind: kind,
          filter: ItemEnchantmentTemplateFilterEntity(entry: values[0]),
        ),
  );

  static final itemSet = FoxyEntityPickerDelegate<BriefItemSetEntity>(
    title: '物品套装',
    errorLabel: '搜索物品套装失败',
    filters: const [
      FoxyEntityPickerFilter('套装 ID'),
      FoxyEntityPickerFilter('名称'),
    ],
    columns: [
      FoxyEntityPickerColumn(
        header: 'ID',
        width: 120,
        text: (BriefItemSetEntity row) => row.id.toString(),
      ),
      FoxyEntityPickerColumn(
        header: '名称',
        text: (BriefItemSetEntity row) => row.nameLangZhCN,
      ),
    ],
    idOf: (BriefItemSetEntity row) => row.id,
    fetch: (page, values) =>
        GetIt.instance.get<ItemSetRepository>().getBriefItemSets(
          page: page,
          filter: ItemSetFilterEntity(id: values[0], name: values[1]),
        ),
    count: (values) => GetIt.instance.get<ItemSetRepository>().countItemSets(
      filter: ItemSetFilterEntity(id: values[0], name: values[1]),
    ),
  );

  static final disenchantLoot =
      FoxyEntityPickerDelegate<BriefLootTemplateEntryEntity>(
        title: '分解掉落模板',
        errorLabel: '搜索分解掉落模板失败',
        filters: const [FoxyEntityPickerFilter('模板 ID')],
        columns: [
          FoxyEntityPickerColumn(
            header: '模板 ID',
            width: 160,
            text: (BriefLootTemplateEntryEntity row) => row.entry.toString(),
          ),
          FoxyEntityPickerColumn(
            header: '掉落项数',
            text: (BriefLootTemplateEntryEntity row) =>
                row.itemCount.toString(),
          ),
        ],
        idOf: (BriefLootTemplateEntryEntity row) => row.entry,
        fetch: (page, values) =>
            _disenchantLootRepository.getBriefLootTemplateEntries(
              page: page,
              filter: LootTemplateFilterEntity(entry: values[0]),
            ),
        count: (values) => _disenchantLootRepository.countLootTemplates(
          filter: LootTemplateFilterEntity(entry: values[0]),
        ),
      );

  static final gemProperty = FoxyEntityPickerDelegate<BriefGemPropertyEntity>(
    title: '宝石属性',
    errorLabel: '搜索宝石属性失败',
    filters: const [FoxyEntityPickerFilter('ID')],
    columns: [
      FoxyEntityPickerColumn(
        header: 'ID',
        width: 120,
        text: (BriefGemPropertyEntity row) => row.id.toString(),
      ),
      FoxyEntityPickerColumn(
        header: '附魔 ID',
        text: (BriefGemPropertyEntity row) => row.enchantId.toString(),
      ),
    ],
    idOf: (BriefGemPropertyEntity row) => row.id,
    fetch: (page, values) =>
        GetIt.instance.get<GemPropertyRepository>().getBriefGemProperties(
          page: page,
          filter: GemPropertyFilterEntity(id: values[0]),
        ),
    count: (values) => GetIt.instance
        .get<GemPropertyRepository>()
        .countGemProperties(filter: GemPropertyFilterEntity(id: values[0])),
  );

  static final itemVisuals = FoxyEntityPickerDelegate<BriefItemVisualsEntity>(
    title: '物品视觉',
    errorLabel: '搜索 ItemVisuals.dbc 失败',
    filters: const [FoxyEntityPickerFilter('ID')],
    columns: [
      FoxyEntityPickerColumn(
        header: 'ID',
        width: 120,
        text: (BriefItemVisualsEntity row) => row.id.toString(),
      ),
      FoxyEntityPickerColumn(
        header: '视觉效果槽 0',
        text: (BriefItemVisualsEntity row) => row.slot0.toString(),
      ),
      FoxyEntityPickerColumn(
        header: '视觉效果槽 1',
        text: (BriefItemVisualsEntity row) => row.slot1.toString(),
      ),
      FoxyEntityPickerColumn(
        header: '视觉效果槽 2',
        text: (BriefItemVisualsEntity row) => row.slot2.toString(),
      ),
      FoxyEntityPickerColumn(
        header: '视觉效果槽 3',
        text: (BriefItemVisualsEntity row) => row.slot3.toString(),
      ),
      FoxyEntityPickerColumn(
        header: '视觉效果槽 4',
        text: (BriefItemVisualsEntity row) => row.slot4.toString(),
      ),
    ],
    idOf: (BriefItemVisualsEntity row) => row.id,
    fetch: (page, values) =>
        GetIt.instance.get<ItemVisualsRepository>().getBriefItemVisuals(
          page: page,
          filter: ItemVisualsFilterEntity(id: values[0]),
        ),
    count: (values) => GetIt.instance
        .get<ItemVisualsRepository>()
        .countItemVisuals(filter: ItemVisualsFilterEntity(id: values[0])),
  );

  static final spellItemEnchantmentCondition =
      FoxyEntityPickerDelegate<BriefSpellItemEnchantmentConditionEntity>(
        title: '附魔条件',
        errorLabel: '搜索 SpellItemEnchantmentCondition.dbc 失败',
        filters: const [FoxyEntityPickerFilter('ID')],
        columns: [
          FoxyEntityPickerColumn(
            header: 'ID',
            text: (BriefSpellItemEnchantmentConditionEntity row) =>
                row.id.toString(),
          ),
        ],
        idOf: (BriefSpellItemEnchantmentConditionEntity row) => row.id,
        fetch: (page, values) => GetIt.instance
            .get<SpellItemEnchantmentConditionRepository>()
            .getBriefSpellItemEnchantmentConditions(
              page: page,
              filter: SpellItemEnchantmentConditionFilterEntity(id: values[0]),
            ),
        count: (values) => GetIt.instance
            .get<SpellItemEnchantmentConditionRepository>()
            .countSpellItemEnchantmentConditions(
              filter: SpellItemEnchantmentConditionFilterEntity(id: values[0]),
            ),
      );

  static final spellItemEnchantment =
      FoxyEntityPickerDelegate<BriefSpellItemEnchantmentEntity>(
        title: '法术物品附魔',
        errorLabel: '搜索法术物品附魔失败',
        filters: const [
          FoxyEntityPickerFilter('ID'),
          FoxyEntityPickerFilter('名称'),
        ],
        columns: [
          FoxyEntityPickerColumn(
            header: 'ID',
            width: 120,
            text: (BriefSpellItemEnchantmentEntity row) => row.id.toString(),
          ),
          FoxyEntityPickerColumn(
            header: '名称',
            text: (BriefSpellItemEnchantmentEntity row) => row.nameLangZhCN,
          ),
        ],
        idOf: (BriefSpellItemEnchantmentEntity row) => row.id,
        fetch: (page, values) => GetIt.instance
            .get<SpellItemEnchantmentRepository>()
            .getBriefSpellItemEnchantments(
              page: page,
              filter: SpellItemEnchantmentFilterEntity(
                id: values[0],
                name: values[1],
              ),
            ),
        count: (values) => GetIt.instance
            .get<SpellItemEnchantmentRepository>()
            .countSpellItemEnchantments(
              filter: SpellItemEnchantmentFilterEntity(
                id: values[0],
                name: values[1],
              ),
            ),
      );

  static final totemCategory =
      FoxyEntityPickerDelegate<BriefTotemCategoryEntity>(
        title: '图腾类别',
        errorLabel: '搜索图腾类别失败',
        filters: const [
          FoxyEntityPickerFilter('ID'),
          FoxyEntityPickerFilter('名称'),
        ],
        columns: [
          FoxyEntityPickerColumn(
            header: 'ID',
            width: 120,
            text: (BriefTotemCategoryEntity row) => row.id.toString(),
          ),
          FoxyEntityPickerColumn(
            header: '名称',
            text: (BriefTotemCategoryEntity row) => row.name,
          ),
        ],
        idOf: (BriefTotemCategoryEntity row) => row.id,
        fetch: (page, values) => GetIt.instance
            .get<TotemCategoryRepository>()
            .getBriefTotemCategories(
              page: page,
              filter: TotemCategoryFilterEntity(id: values[0], name: values[1]),
            ),
        count: (values) =>
            GetIt.instance.get<TotemCategoryRepository>().countTotemCategories(
              filter: TotemCategoryFilterEntity(id: values[0], name: values[1]),
            ),
      );

  static final itemLimitCategory =
      FoxyEntityPickerDelegate<BriefItemLimitCategoryEntity>(
        title: '物品限制类别',
        errorLabel: '搜索物品限制类别失败',
        filters: const [
          FoxyEntityPickerFilter('ID'),
          FoxyEntityPickerFilter('名称'),
        ],
        columns: [
          FoxyEntityPickerColumn(
            header: 'ID',
            width: 120,
            text: (BriefItemLimitCategoryEntity row) => row.id.toString(),
          ),
          FoxyEntityPickerColumn(
            header: '名称',
            text: (BriefItemLimitCategoryEntity row) => row.name,
          ),
          FoxyEntityPickerColumn(
            header: '数量',
            width: 100,
            text: (BriefItemLimitCategoryEntity row) => row.quantity.toString(),
          ),
        ],
        idOf: (BriefItemLimitCategoryEntity row) => row.id,
        fetch: (page, values) => GetIt.instance
            .get<ItemLimitCategoryRepository>()
            .getBriefItemLimitCategories(
              page: page,
              filter: ItemLimitCategoryFilterEntity(
                id: values[0],
                name: values[1],
              ),
            ),
        count: (values) => GetIt.instance
            .get<ItemLimitCategoryRepository>()
            .countItemLimitCategories(
              filter: ItemLimitCategoryFilterEntity(
                id: values[0],
                name: values[1],
              ),
            ),
      );

  static final holiday = FoxyEntityPickerDelegate<BriefHolidayEntity>(
    title: '节日',
    errorLabel: '搜索节日失败',
    filters: const [FoxyEntityPickerFilter('ID')],
    columns: [
      FoxyEntityPickerColumn(
        header: 'ID',
        width: 120,
        text: (BriefHolidayEntity row) => row.id.toString(),
      ),
      FoxyEntityPickerColumn(
        header: '名称记录 ID',
        width: 160,
        text: (BriefHolidayEntity row) => row.holidayNameId.toString(),
      ),
      FoxyEntityPickerColumn(
        header: '纹理',
        text: (BriefHolidayEntity row) => row.textureFileName,
      ),
    ],
    idOf: (BriefHolidayEntity row) => row.id,
    fetch: (page, values) =>
        GetIt.instance.get<HolidayRepository>().getBriefHolidays(
          page: page,
          filter: HolidayFilterEntity(id: values[0]),
        ),
    count: (values) => GetIt.instance.get<HolidayRepository>().countHolidays(
      filter: HolidayFilterEntity(id: values[0]),
    ),
  );

  static final itemExtendedCost =
      FoxyEntityPickerDelegate<BriefItemExtendedCostEntity>(
        title: '选择扩展价格',
        errorLabel: '搜索扩展价格失败',
        emptyText: '暂无数据',
        filters: const [FoxyEntityPickerFilter('编号')],
        columns: [
          FoxyEntityPickerColumn(
            header: '编号',
            width: 120,
            text: (BriefItemExtendedCostEntity t) => t.id.toString(),
          ),
          FoxyEntityPickerColumn(
            header: '荣誉点数',
            width: 120,
            text: (BriefItemExtendedCostEntity t) => t.honorPoints.toString(),
          ),
          FoxyEntityPickerColumn(
            header: '竞技场点数',
            width: 120,
            text: (BriefItemExtendedCostEntity t) => t.arenaPoints.toString(),
          ),
          FoxyEntityPickerColumn(
            header: '竞技场等级',
            text: (BriefItemExtendedCostEntity t) => t.arenaBracket.toString(),
          ),
        ],
        idOf: (BriefItemExtendedCostEntity t) => t.id,
        fetch: (page, v) => GetIt.instance
            .get<ItemExtendedCostRepository>()
            .getBriefItemExtendedCosts(
              filter: ItemExtendedCostFilterEntity(id: v[0]),
              page: page,
            ),
        count: (v) => GetIt.instance
            .get<ItemExtendedCostRepository>()
            .countItemExtendedCosts(
              filter: ItemExtendedCostFilterEntity(id: v[0]),
            ),
      );

  static final itemPurchaseGroup =
      FoxyEntityPickerDelegate<BriefItemPurchaseGroupEntity>(
        title: '选择物品购买组',
        errorLabel: '搜索物品购买组失败',
        emptyText: '暂无数据',
        filters: const [
          FoxyEntityPickerFilter('编号'),
          FoxyEntityPickerFilter('名称'),
        ],
        columns: [
          FoxyEntityPickerColumn(
            header: '编号',
            width: 120,
            text: (BriefItemPurchaseGroupEntity group) => group.id.toString(),
          ),
          FoxyEntityPickerColumn(
            header: '名称',
            text: (BriefItemPurchaseGroupEntity group) => group.nameLangZhCN,
          ),
        ],
        idOf: (BriefItemPurchaseGroupEntity group) => group.id,
        fetch: (page, values) => GetIt.instance
            .get<ItemPurchaseGroupRepository>()
            .getBriefItemPurchaseGroups(
              page: page,
              filter: ItemPurchaseGroupFilterEntity(
                id: values[0],
                name: values[1],
              ),
            ),
        count: (values) => GetIt.instance
            .get<ItemPurchaseGroupRepository>()
            .countItemPurchaseGroups(
              filter: ItemPurchaseGroupFilterEntity(
                id: values[0],
                name: values[1],
              ),
            ),
      );

  static final itemRandomProperties =
      FoxyEntityPickerDelegate<BriefItemRandomPropertiesEntity>(
        title: '随机属性',
        errorLabel: '搜索随机属性失败',
        filters: const [
          FoxyEntityPickerFilter('属性ID'),
          FoxyEntityPickerFilter('属性名称'),
        ],
        columns: [
          FoxyEntityPickerColumn(
            header: '编号',
            width: 120,
            text: (BriefItemRandomPropertiesEntity t) => t.id.toString(),
          ),
          FoxyEntityPickerColumn(
            header: '名称',
            text: (BriefItemRandomPropertiesEntity t) =>
                t.nameLangZhCN.isNotEmpty ? t.nameLangZhCN : t.name,
          ),
        ],
        idOf: (BriefItemRandomPropertiesEntity t) => t.id,
        fetch: (page, v) => GetIt.instance
            .get<ItemRandomPropertiesRepository>()
            .getBriefItemRandomProperties(
              filter: ItemRandomPropertiesFilterEntity(id: v[0], name: v[1]),
              page: page,
            ),
        count: (v) => GetIt.instance
            .get<ItemRandomPropertiesRepository>()
            .countItemRandomProperties(
              filter: ItemRandomPropertiesFilterEntity(id: v[0], name: v[1]),
            ),
      );

  static final itemRandomSuffix =
      FoxyEntityPickerDelegate<BriefItemRandomSuffixEntity>(
        title: '随机后缀',
        errorLabel: '搜索随机后缀失败',
        filters: const [
          FoxyEntityPickerFilter('后缀ID'),
          FoxyEntityPickerFilter('后缀名称'),
        ],
        columns: [
          FoxyEntityPickerColumn(
            header: '编号',
            width: 120,
            text: (BriefItemRandomSuffixEntity t) => t.id.toString(),
          ),
          FoxyEntityPickerColumn(
            header: '名称',
            text: (BriefItemRandomSuffixEntity t) => t.nameLangZhCN,
          ),
          FoxyEntityPickerColumn(
            header: '内部名称',
            text: (BriefItemRandomSuffixEntity t) => t.internalName,
          ),
        ],
        idOf: (BriefItemRandomSuffixEntity t) => t.id,
        fetch: (page, v) => GetIt.instance
            .get<ItemRandomSuffixRepository>()
            .getBriefItemRandomSuffixes(
              filter: ItemRandomSuffixFilterEntity(id: v[0], name: v[1]),
              page: page,
            ),
        count: (v) => GetIt.instance
            .get<ItemRandomSuffixRepository>()
            .countItemRandomSuffixes(
              filter: ItemRandomSuffixFilterEntity(id: v[0], name: v[1]),
            ),
      );

  static final itemTemplate = FoxyEntityPickerDelegate<BriefItemTemplateEntity>(
    title: '物品',
    errorLabel: '搜索失败',
    filters: const [
      FoxyEntityPickerFilter('编号'),
      FoxyEntityPickerFilter('名称'),
      FoxyEntityPickerFilter('描述'),
    ],
    columns: [
      FoxyEntityPickerColumn(
        header: '编号',
        width: 120,
        text: (BriefItemTemplateEntity t) => t.entry.toString(),
      ),
      FoxyEntityPickerColumn(
        header: '名称',
        cell: (BriefItemTemplateEntity t) {
          final color = kItemQualityColors[t.quality] ?? Colors.white;
          return Text(
            t.displayName,
            style: TextStyle(color: color),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          );
        },
      ),
      FoxyEntityPickerColumn(
        header: '物品等级',
        width: 120,
        text: (BriefItemTemplateEntity t) => t.itemLevel.toString(),
      ),
      FoxyEntityPickerColumn(
        header: '需求等级',
        width: 120,
        text: (BriefItemTemplateEntity t) => t.requiredLevel.toString(),
      ),
    ],
    idOf: (BriefItemTemplateEntity t) => t.entry,
    fetch: (page, v) =>
        GetIt.instance.get<ItemTemplateRepository>().getBriefItemTemplates(
          filter: ItemTemplateFilterEntity(
            entry: v[0],
            name: v[1],
            description: v[2],
          ),
          page: page,
        ),
    count: (v) =>
        GetIt.instance.get<ItemTemplateRepository>().countItemTemplates(
          filter: ItemTemplateFilterEntity(
            entry: v[0],
            name: v[1],
            description: v[2],
          ),
        ),
  );

  static final lock = FoxyEntityPickerDelegate<BriefLockEntity>(
    title: '锁',
    errorLabel: '搜索锁失败',
    filters: const [FoxyEntityPickerFilter('锁ID')],
    columns: [
      FoxyEntityPickerColumn(
        header: '编号',
        width: 120,
        text: (BriefLockEntity t) => t.id.toString(),
      ),
      FoxyEntityPickerColumn(
        header: '类型',
        width: 120,
        text: (BriefLockEntity t) => t.type0.toString(),
      ),
      FoxyEntityPickerColumn(
        header: '索引',
        width: 120,
        text: (BriefLockEntity t) => t.index0.toString(),
      ),
      FoxyEntityPickerColumn(
        header: '技能',
        text: (BriefLockEntity t) => t.skill0.toString(),
      ),
    ],
    idOf: (BriefLockEntity t) => t.id,
    fetch: (page, v) => GetIt.instance.get<LockRepository>().getBriefLocks(
      filter: LockFilterEntity(id: v[0]),
      page: page,
    ),
    count: (v) => GetIt.instance.get<LockRepository>().countLocks(
      filter: LockFilterEntity(id: v[0]),
    ),
  );

  static FoxyEntityPickerDelegate<BriefLootTemplateEntryEntity> lootTemplate(
    LootTableType tableType,
    String title,
  ) {
    final repository = LootTemplateRepository(tableType);
    return FoxyEntityPickerDelegate<BriefLootTemplateEntryEntity>(
      title: title,
      errorLabel: '搜索掉落模板失败',
      filters: const [FoxyEntityPickerFilter('掉落编号')],
      columns: [
        FoxyEntityPickerColumn(
          header: '掉落编号',
          width: 120,
          text: (BriefLootTemplateEntryEntity t) => t.entry.toString(),
        ),
        FoxyEntityPickerColumn(
          header: '物品数量',
          text: (BriefLootTemplateEntryEntity t) => t.itemCount.toString(),
        ),
      ],
      idOf: (BriefLootTemplateEntryEntity t) => t.entry,
      fetch: (page, v) => repository.getBriefLootTemplateEntries(
        filter: LootTemplateFilterEntity(entry: v[0]),
        page: page,
      ),
      count: (v) => repository.countLootTemplates(
        filter: LootTemplateFilterEntity(entry: v[0]),
      ),
    );
  }

  static final mailTemplate = FoxyEntityPickerDelegate<BriefMailTemplateEntity>(
    title: '邮件模板',
    errorLabel: '搜索邮件模板失败',
    filters: const [
      FoxyEntityPickerFilter('邮件模板 ID'),
      FoxyEntityPickerFilter('邮件主题'),
    ],
    columns: [
      FoxyEntityPickerColumn(
        header: '编号',
        width: 120,
        text: (BriefMailTemplateEntity t) => t.id.toString(),
      ),
      FoxyEntityPickerColumn(
        header: '主题',
        text: (BriefMailTemplateEntity t) => t.subjectLangZhCN,
      ),
      FoxyEntityPickerColumn(
        header: '正文',
        text: (BriefMailTemplateEntity t) => t.bodyLangZhCN,
      ),
    ],
    idOf: (BriefMailTemplateEntity t) => t.id,
    fetch: (page, v) =>
        GetIt.instance.get<MailTemplateRepository>().getBriefMailTemplates(
          filter: MailTemplateFilterEntity(id: v[0], subject: v[1]),
          page: page,
        ),
    count: (v) =>
        GetIt.instance.get<MailTemplateRepository>().countMailTemplates(
          filter: MailTemplateFilterEntity(id: v[0], subject: v[1]),
        ),
  );

  static final map = FoxyEntityPickerDelegate<BriefMapInfoEntity>(
    title: '地图',
    errorLabel: '搜索地图失败',
    filters: const [
      FoxyEntityPickerFilter('地图ID'),
      FoxyEntityPickerFilter('地图名称'),
    ],
    columns: [
      FoxyEntityPickerColumn(
        header: '编号',
        width: 120,
        text: (BriefMapInfoEntity t) => t.id.toString(),
      ),
      FoxyEntityPickerColumn(
        header: '名称',
        text: (BriefMapInfoEntity t) => t.mapNameLangZhCN,
      ),
      FoxyEntityPickerColumn(
        header: '类型',
        width: 120,
        text: (BriefMapInfoEntity t) => t.instanceType.toString(),
      ),
      FoxyEntityPickerColumn(
        header: 'PVP',
        width: 120,
        text: (BriefMapInfoEntity t) => t.pvp.toString(),
      ),
    ],
    idOf: (BriefMapInfoEntity t) => t.id,
    fetch: (page, v) =>
        GetIt.instance.get<MapInfoRepository>().getBriefMapInfos(
          filter: MapInfoFilterEntity(id: v[0], name: v[1]),
          page: page,
        ),
    count: (v) => GetIt.instance.get<MapInfoRepository>().countMapInfos(
      filter: MapInfoFilterEntity(id: v[0], name: v[1]),
    ),
  );

  static final playerCreateMap = FoxyEntityPickerDelegate<BriefMapInfoEntity>(
    title: '出生地图',
    errorLabel: '搜索出生地图失败',
    filters: const [
      FoxyEntityPickerFilter('地图ID'),
      FoxyEntityPickerFilter('地图名称'),
    ],
    columns: [
      FoxyEntityPickerColumn(
        header: '编号',
        width: 120,
        text: (BriefMapInfoEntity t) => t.id.toString(),
      ),
      FoxyEntityPickerColumn(
        header: '名称',
        text: (BriefMapInfoEntity t) => t.mapNameLangZhCN,
      ),
      FoxyEntityPickerColumn(
        header: '类型',
        width: 120,
        text: (BriefMapInfoEntity t) => t.instanceType.toString(),
      ),
    ],
    idOf: (BriefMapInfoEntity t) => t.id,
    fetch: (page, v) =>
        GetIt.instance.get<MapInfoRepository>().getBriefMapInfos(
          filter: MapInfoFilterEntity(id: v[0], name: v[1]),
          page: page,
          nonInstanceableOnly: true,
        ),
    count: (v) => GetIt.instance.get<MapInfoRepository>().countMapInfos(
      filter: MapInfoFilterEntity(id: v[0], name: v[1]),
      nonInstanceableOnly: true,
    ),
  );

  static final npcText = FoxyEntityPickerDelegate<BriefNpcTextEntity>(
    title: 'NPC 文本',
    errorLabel: '搜索NPC文本失败',
    filters: const [
      FoxyEntityPickerFilter('ID'),
      FoxyEntityPickerFilter('文本内容'),
    ],
    columns: [
      FoxyEntityPickerColumn(
        header: 'ID',
        width: 120,
        text: (BriefNpcTextEntity t) => t.id.toString(),
      ),
      FoxyEntityPickerColumn(
        header: '文本（text0_0 / text0_1）',
        text: (BriefNpcTextEntity t) => t.displayText,
      ),
    ],
    idOf: (BriefNpcTextEntity t) => t.id,
    fetch: (page, v) =>
        GetIt.instance.get<NpcTextRepository>().getBriefNpcTexts(
          filter: NpcTextFilterEntity(id: v[0], text: v[1]),
          page: page,
        ),
    count: (v) => GetIt.instance.get<NpcTextRepository>().countNpcTexts(
      filter: NpcTextFilterEntity(id: v[0], text: v[1]),
    ),
  );

  static final pageText = FoxyEntityPickerDelegate<BriefPageTextEntity>(
    title: '页面文本',
    errorLabel: '搜索页面文本失败',
    filters: const [FoxyEntityPickerFilter('编号'), FoxyEntityPickerFilter('文本')],
    columns: [
      FoxyEntityPickerColumn(
        header: '编号',
        width: 120,
        text: (BriefPageTextEntity t) => t.id.toString(),
      ),
      FoxyEntityPickerColumn(
        header: '文本',
        text: (BriefPageTextEntity t) => t.displayText,
      ),
    ],
    idOf: (BriefPageTextEntity t) => t.id,
    fetch: (page, v) =>
        GetIt.instance.get<PageTextRepository>().getBriefPageTexts(
          filter: PageTextFilterEntity(id: v[0], text: v[1]),
          page: page,
        ),
    count: (v) => GetIt.instance.get<PageTextRepository>().countPageTexts(
      filter: PageTextFilterEntity(id: v[0], text: v[1]),
    ),
  );

  static final questInfo = FoxyEntityPickerDelegate<BriefQuestInfoEntity>(
    title: '任务信息',
    errorLabel: '搜索任务信息失败',
    filters: const [
      FoxyEntityPickerFilter('任务信息ID'),
      FoxyEntityPickerFilter('信息名称'),
    ],
    columns: [
      FoxyEntityPickerColumn(
        header: '编号',
        width: 120,
        text: (BriefQuestInfoEntity t) => t.id.toString(),
      ),
      FoxyEntityPickerColumn(
        header: '名称',
        text: (BriefQuestInfoEntity t) => t.infoNameLangZhCN,
      ),
    ],
    idOf: (BriefQuestInfoEntity t) => t.id,
    fetch: (page, v) =>
        GetIt.instance.get<QuestInfoRepository>().getBriefQuestInfos(
          filter: QuestInfoFilterEntity(id: v[0], name: v[1]),
          page: page,
        ),
    count: (v) => GetIt.instance.get<QuestInfoRepository>().countQuestInfos(
      filter: QuestInfoFilterEntity(id: v[0], name: v[1]),
    ),
  );

  static final questTemplate =
      FoxyEntityPickerDelegate<BriefQuestTemplateEntity>(
        title: '任务',
        errorLabel: '搜索任务失败',
        filters: const [
          FoxyEntityPickerFilter('编号'),
          FoxyEntityPickerFilter('名称'),
        ],
        columns: [
          FoxyEntityPickerColumn(
            header: '编号',
            width: 120,
            text: (BriefQuestTemplateEntity t) => t.id.toString(),
          ),
          FoxyEntityPickerColumn(
            header: '名称',
            text: (BriefQuestTemplateEntity t) => t.displayTitle,
          ),
        ],
        idOf: (BriefQuestTemplateEntity t) => t.id,
        fetch: (page, v) => GetIt.instance
            .get<QuestTemplateRepository>()
            .getBriefQuestTemplates(
              filter: QuestTemplateFilterEntity(id: v[0], title: v[1]),
              page: page,
            ),
        count: (v) =>
            GetIt.instance.get<QuestTemplateRepository>().countQuestTemplates(
              filter: QuestTemplateFilterEntity(id: v[0], title: v[1]),
            ),
      );

  static final scalingStatDistribution =
      FoxyEntityPickerDelegate<BriefScalingStatDistributionEntity>(
        title: '属性缩放分布',
        errorLabel: '搜索缩放分布失败',
        filters: const [FoxyEntityPickerFilter('编号')],
        columns: [
          FoxyEntityPickerColumn(
            header: '编号',
            width: 120,
            text: (BriefScalingStatDistributionEntity t) => t.id.toString(),
          ),
          FoxyEntityPickerColumn(
            header: '属性分布',
            text: (BriefScalingStatDistributionEntity t) => t.displayStats,
          ),
        ],
        idOf: (BriefScalingStatDistributionEntity t) => t.id,
        fetch: (page, v) => GetIt.instance
            .get<ScalingStatDistributionRepository>()
            .getBriefScalingStatDistributions(
              filter: ScalingStatDistributionFilterEntity(id: v[0]),
              page: page,
            ),
        count: (v) => GetIt.instance
            .get<ScalingStatDistributionRepository>()
            .countScalingStatDistributions(
              filter: ScalingStatDistributionFilterEntity(id: v[0]),
            ),
      );

  static final spellDuration =
      FoxyEntityPickerDelegate<BriefSpellDurationEntity>(
        title: '施法时间',
        errorLabel: '搜索持续时间失败',
        filters: const [FoxyEntityPickerFilter('持续时间ID')],
        columns: [
          FoxyEntityPickerColumn(
            header: '编号',
            width: 120,
            text: (BriefSpellDurationEntity t) => t.id.toString(),
          ),
          FoxyEntityPickerColumn(
            header: '持续时间',
            width: 120,
            text: (BriefSpellDurationEntity t) => t.duration.toString(),
          ),
          FoxyEntityPickerColumn(
            header: '每级增加值',
            width: 120,
            text: (BriefSpellDurationEntity t) => t.durationPerLevel.toString(),
          ),
          FoxyEntityPickerColumn(
            header: '最大持续时间',
            text: (BriefSpellDurationEntity t) => t.maxDuration.toString(),
          ),
        ],
        idOf: (BriefSpellDurationEntity t) => t.id,
        fetch: (page, v) => GetIt.instance
            .get<SpellDurationRepository>()
            .getBriefSpellDurations(
              filter: SpellDurationFilterEntity(id: v[0]),
              page: page,
            ),
        count: (v) => GetIt.instance
            .get<SpellDurationRepository>()
            .countSpellDurations(filter: SpellDurationFilterEntity(id: v[0])),
      );

  static final spellIcon = FoxyEntityPickerDelegate<BriefSpellIconEntity>(
    title: '技能图标',
    errorLabel: '搜索图标失败',
    filters: const [
      FoxyEntityPickerFilter('图标ID'),
      FoxyEntityPickerFilter('文件名'),
    ],
    columns: [
      FoxyEntityPickerColumn(
        header: '编号',
        width: 120,
        text: (BriefSpellIconEntity t) => t.id.toString(),
      ),
      FoxyEntityPickerColumn(
        header: '图标文件',
        cell: (entity) => Row(
          spacing: 8,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: FoxyGameAssetIcon(rawPath: entity.textureFilename),
            ),
            Expanded(child: Text(entity.textureFilename)),
          ],
        ),
      ),
    ],
    idOf: (BriefSpellIconEntity t) => t.id,
    fetch: (page, v) =>
        GetIt.instance.get<SpellIconRepository>().getBriefSpellIcons(
          filter: SpellIconFilterEntity(id: v[0], name: v[1]),
          page: page,
        ),
    count: (v) => GetIt.instance.get<SpellIconRepository>().countSpellIcons(
      filter: SpellIconFilterEntity(id: v[0], name: v[1]),
    ),
  );

  static final spell = FoxyEntityPickerDelegate<BriefSpellEntity>(
    title: '技能',
    errorLabel: '搜索技能失败',
    filters: const [FoxyEntityPickerFilter('编号'), FoxyEntityPickerFilter('名称')],
    columns: [
      FoxyEntityPickerColumn(
        header: '编号',
        width: 120,
        text: (BriefSpellEntity t) => t.id.toString(),
      ),
      FoxyEntityPickerColumn(
        header: '名称',
        width: 240,
        text: (BriefSpellEntity t) => t.displayName,
      ),
      FoxyEntityPickerColumn(
        header: '子名称',
        width: 120,
        text: (BriefSpellEntity t) => t.displaySubtext,
      ),
      FoxyEntityPickerColumn(
        header: '描述',
        text: (BriefSpellEntity t) => t.displayDescription,
      ),
    ],
    idOf: (BriefSpellEntity t) => t.id,
    fetch: (page, v) async {
      final repo = GetIt.instance.get<SpellRepository>();
      final filter = SpellFilterEntity(
        id: v[0].isEmpty ? '' : v[0],
        name: v[1].isEmpty ? '' : v[1],
      );
      return repo.getBriefSpells(page: page, filter: filter);
    },
    count: (v) {
      final repo = GetIt.instance.get<SpellRepository>();
      final filter = SpellFilterEntity(
        id: v[0].isEmpty ? '' : v[0],
        name: v[1].isEmpty ? '' : v[1],
      );
      return repo.countSpells(filter: filter);
    },
  );

  static final talent = FoxyEntityPickerDelegate<BriefTalentEntity>(
    title: '天赋',
    errorLabel: '搜索 Talent.dbc 天赋失败',
    filters: const [
      FoxyEntityPickerFilter('天赋 ID'),
      FoxyEntityPickerFilter('法术 ID'),
    ],
    columns: [
      FoxyEntityPickerColumn(
        header: '编号',
        width: 120,
        text: (BriefTalentEntity row) => row.id.toString(),
      ),
      FoxyEntityPickerColumn(
        header: '天赋页',
        width: 120,
        text: (BriefTalentEntity row) => row.tabId.toString(),
      ),
      FoxyEntityPickerColumn(
        header: '层',
        width: 80,
        text: (BriefTalentEntity row) => row.tierId.toString(),
      ),
      FoxyEntityPickerColumn(
        header: '列',
        width: 80,
        text: (BriefTalentEntity row) => row.columnIndex.toString(),
      ),
      FoxyEntityPickerColumn(
        header: '第 1 级法术',
        width: 120,
        text: (BriefTalentEntity row) => row.spellRank0.toString(),
      ),
    ],
    idOf: (BriefTalentEntity row) => row.id,
    fetch: (page, values) =>
        GetIt.instance.get<TalentRepository>().getBriefTalents(
          page: page,
          filter: TalentFilterEntity(id: values[0], spell: values[1]),
        ),
    count: (values) => GetIt.instance.get<TalentRepository>().countTalents(
      filter: TalentFilterEntity(id: values[0], spell: values[1]),
    ),
  );

  static final talentTab = FoxyEntityPickerDelegate<BriefTalentTabEntity>(
    title: '天赋页',
    errorLabel: '搜索 TalentTab.dbc 天赋页失败',
    filters: const [
      FoxyEntityPickerFilter('天赋页 ID'),
      FoxyEntityPickerFilter('天赋页名称'),
    ],
    columns: [
      FoxyEntityPickerColumn(
        header: '编号',
        width: 120,
        text: (BriefTalentTabEntity row) => row.id.toString(),
      ),
      FoxyEntityPickerColumn(
        header: '名称',
        text: (BriefTalentTabEntity row) => row.nameLangZhCN,
      ),
      FoxyEntityPickerColumn(
        header: '职业掩码',
        width: 120,
        text: (BriefTalentTabEntity row) => row.classMask.toString(),
      ),
      FoxyEntityPickerColumn(
        header: '分类',
        width: 100,
        text: (BriefTalentTabEntity row) => row.categoryEnumId.toString(),
      ),
      FoxyEntityPickerColumn(
        header: '页序',
        width: 80,
        text: (BriefTalentTabEntity row) => row.orderIndex.toString(),
      ),
    ],
    idOf: (BriefTalentTabEntity row) => row.id,
    fetch: (page, values) =>
        GetIt.instance.get<TalentTabRepository>().getBriefTalentTabs(
          page: page,
          filter: TalentTabFilterEntity(id: values[0], name: values[1]),
        ),
    count: (values) =>
        GetIt.instance.get<TalentTabRepository>().countTalentTabs(
          filter: TalentTabFilterEntity(id: values[0], name: values[1]),
        ),
  );

  static final spellRange = FoxyEntityPickerDelegate<BriefSpellRangeEntity>(
    title: '技能射程',
    errorLabel: '搜索射程失败',
    filters: const [
      FoxyEntityPickerFilter('射程ID'),
      FoxyEntityPickerFilter('射程名称'),
    ],
    columns: [
      FoxyEntityPickerColumn(
        header: '编号',
        width: 120,
        text: (BriefSpellRangeEntity t) => t.id.toString(),
      ),
      FoxyEntityPickerColumn(
        header: '名称',
        text: (BriefSpellRangeEntity t) => t.displayNameLangZhCN,
      ),
      FoxyEntityPickerColumn(
        header: '最小射程',
        width: 120,
        text: (BriefSpellRangeEntity t) => t.rangeMin0.toStringAsFixed(1),
      ),
      FoxyEntityPickerColumn(
        header: '最大射程',
        width: 120,
        text: (BriefSpellRangeEntity t) => t.rangeMax0.toStringAsFixed(1),
      ),
    ],
    idOf: (BriefSpellRangeEntity t) => t.id,
    fetch: (page, v) =>
        GetIt.instance.get<SpellRangeRepository>().getBriefSpellRanges(
          filter: SpellRangeFilterEntity(id: v[0], name: v[1]),
          page: page,
        ),
    count: (v) => GetIt.instance.get<SpellRangeRepository>().countSpellRanges(
      filter: SpellRangeFilterEntity(id: v[0], name: v[1]),
    ),
  );

  static final vehicle = FoxyEntityPickerDelegate<BriefVehicleEntity>(
    title: '载具',
    errorLabel: '搜索载具失败',
    filters: const [FoxyEntityPickerFilter('载具ID')],
    columns: [
      FoxyEntityPickerColumn(
        header: '编号',
        width: 120,
        text: (BriefVehicleEntity t) => t.id.toString(),
      ),
      FoxyEntityPickerColumn(
        header: '标识',
        width: 120,
        text: (BriefVehicleEntity t) => t.flags.toString(),
      ),
      FoxyEntityPickerColumn(
        header: '转向速度',
        text: (BriefVehicleEntity t) => t.turnSpeed.toString(),
      ),
    ],
    idOf: (BriefVehicleEntity t) => t.id,
    fetch: (page, v) =>
        GetIt.instance.get<VehicleRepository>().getBriefVehicles(
          filter: VehicleFilterEntity(id: v[0]),
          page: page,
        ),
    count: (v) => GetIt.instance.get<VehicleRepository>().countVehicles(
      filter: VehicleFilterEntity(id: v[0]),
    ),
  );
}
