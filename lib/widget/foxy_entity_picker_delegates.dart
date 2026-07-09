import 'package:flutter/material.dart';
import 'package:foxy/constant/item_quality.dart';
import 'package:foxy/entity/area_table_entity.dart';
import 'package:foxy/entity/area_table_filter_entity.dart';
import 'package:foxy/entity/broadcast_text_entity.dart';
import 'package:foxy/entity/char_title_entity.dart';
import 'package:foxy/entity/creature_spell_data_entity.dart';
import 'package:foxy/entity/creature_template_entity.dart';
import 'package:foxy/entity/creature_template_filter_entity.dart';
import 'package:foxy/entity/dbc_faction_entity.dart';
import 'package:foxy/entity/emote_text_entity.dart';
import 'package:foxy/entity/emote_text_filter_entity.dart';
import 'package:foxy/entity/gossip_menu_entity.dart';
import 'package:foxy/entity/gossip_menu_filter_entity.dart';
import 'package:foxy/entity/item_display_info_entity.dart';
import 'package:foxy/entity/item_enchantment_template_entity.dart';
import 'package:foxy/entity/item_extended_cost_entity.dart';
import 'package:foxy/entity/item_extended_cost_filter_entity.dart';
import 'package:foxy/entity/item_random_properties_entity.dart';
import 'package:foxy/entity/item_random_suffix_entity.dart';
import 'package:foxy/entity/item_template_entity.dart';
import 'package:foxy/entity/item_template_filter_entity.dart';
import 'package:foxy/entity/lock_entity.dart';
import 'package:foxy/entity/loot_template_entity.dart';
import 'package:foxy/entity/map_info_entity.dart';
import 'package:foxy/entity/npc_text_entity.dart';
import 'package:foxy/entity/npc_text_filter_entity.dart';
import 'package:foxy/entity/page_text_entity.dart';
import 'package:foxy/entity/page_text_filter_entity.dart';
import 'package:foxy/entity/quest_info_entity.dart';
import 'package:foxy/entity/quest_info_filter_entity.dart';
import 'package:foxy/entity/quest_template_entity.dart';
import 'package:foxy/entity/quest_template_filter_entity.dart';
import 'package:foxy/entity/spell_duration_entity.dart';
import 'package:foxy/entity/spell_entity.dart';
import 'package:foxy/entity/spell_filter_entity.dart';
import 'package:foxy/entity/spell_icon_entity.dart';
import 'package:foxy/entity/spell_range_entity.dart';
import 'package:foxy/entity/scaling_stat_distribution_entity.dart';
import 'package:foxy/entity/scaling_stat_distribution_filter_entity.dart';
import 'package:foxy/entity/vehicle_entity.dart';
import 'package:foxy/repository/area_table_repository.dart';
import 'package:foxy/repository/broadcast_text_repository.dart';
import 'package:foxy/repository/char_title_repository.dart';
import 'package:foxy/repository/creature_spell_data_repository.dart';
import 'package:foxy/repository/creature_template_repository.dart';
import 'package:foxy/repository/dbc_faction_repository.dart';
import 'package:foxy/repository/emote_text_repository.dart';
import 'package:foxy/repository/gossip_menu_repository.dart';
import 'package:foxy/repository/item_display_info_repository.dart';
import 'package:foxy/repository/item_enchantment_template_repository.dart';
import 'package:foxy/repository/item_extended_cost_repository.dart';
import 'package:foxy/repository/item_random_properties_repository.dart';
import 'package:foxy/repository/item_random_suffix_repository.dart';
import 'package:foxy/repository/item_template_repository.dart';
import 'package:foxy/repository/lock_repository.dart';
import 'package:foxy/repository/loot_template_repository.dart';
import 'package:foxy/repository/map_info_repository.dart';
import 'package:foxy/repository/npc_text_repository.dart';
import 'package:foxy/repository/page_text_repository.dart';
import 'package:foxy/repository/quest_info_repository.dart';
import 'package:foxy/repository/quest_template_repository.dart';
import 'package:foxy/repository/scaling_stat_distribution_repository.dart';
import 'package:foxy/repository/spell_duration_repository.dart';
import 'package:foxy/repository/spell_icon_repository.dart';
import 'package:foxy/repository/spell_range_repository.dart';
import 'package:foxy/repository/spell_repository.dart';
import 'package:foxy/repository/vehicle_repository.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:foxy/widget/foxy_game_asset_icon.dart';
import 'package:get_it/get_it.dart';

class FoxyEntityPickerDelegates {
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
        text: (BriefAreaTableEntity t) => t.areaNameLangZhCn,
      ),
      FoxyEntityPickerColumn(
        header: '地区编号',
        width: 120,
        text: (BriefAreaTableEntity t) => t.continentId.toString(),
      ),
    ],
    idOf: (BriefAreaTableEntity t) => t.id,
    fetch: (page, v) => GetIt.instance.get<AreaTableRepository>().getBriefAreaTables(
      filter: AreaTableFilterEntity(id: v[0], name: v[1]),
      page: page,
    ),
    count: (v) => GetIt.instance.get<AreaTableRepository>().countAreaTables(
      filter: AreaTableFilterEntity(id: v[0], name: v[1]),
    ),
  );

  static final broadcastText = FoxyEntityPickerDelegate<BriefBroadcastTextEntity>(
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
    fetch: (page, v) =>
        GetIt.instance.get<BroadcastTextRepository>().getBriefBroadcastTexts(
          id: v[0].isEmpty ? null : v[0],
          text: v[1].isEmpty ? null : v[1],
          page: page,
        ),
    count: (v) =>
        GetIt.instance.get<BroadcastTextRepository>().countBroadcastTexts(
          id: v[0].isEmpty ? null : v[0],
          text: v[1].isEmpty ? null : v[1],
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
        text: (BriefCharTitleEntity t) => t.nameLangZhCn,
      ),
    ],
    idOf: (BriefCharTitleEntity t) => t.id,
    fetch: (page, v) => GetIt.instance.get<CharTitleRepository>().getBriefCharTitles(
      id: v[0].isEmpty ? null : v[0],
      name: v[1].isEmpty ? null : v[1],
      page: page,
    ),
    count: (v) => GetIt.instance.get<CharTitleRepository>().countCharTitles(
      id: v[0].isEmpty ? null : v[0],
      name: v[1].isEmpty ? null : v[1],
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
              id: v[0].isEmpty ? null : v[0],
              spell: v[1].isEmpty ? null : v[1],
              page: page,
            ),
        count: (v) => GetIt.instance
            .get<CreatureSpellDataRepository>()
            .countCreatureSpellDatas(
              id: v[0].isEmpty ? null : v[0],
              spell: v[1].isEmpty ? null : v[1],
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
        text: (BriefDbcFactionEntity t) => t.nameLangZhCn,
      ),
      FoxyEntityPickerColumn(
        header: '描述',
        text: (BriefDbcFactionEntity t) => t.descriptionLangZhCn,
      ),
    ],
    idOf: (BriefDbcFactionEntity t) => t.id,
    fetch: (page, v) =>
        GetIt.instance.get<DbcFactionRepository>().getBriefDbcFactions(
          id: v[0].isEmpty ? null : v[0],
          name: v[1].isEmpty ? null : v[1],
          page: page,
        ),
    count: (v) => GetIt.instance.get<DbcFactionRepository>().countDbcFactions(
      id: v[0].isEmpty ? null : v[0],
      name: v[1].isEmpty ? null : v[1],
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
        fetch: (page, v) =>
            GetIt.instance.get<ItemDisplayInfoRepository>().getBriefItemDisplayInfos(
              id: v[0].isEmpty ? null : v[0],
              name: v[1].isEmpty ? null : v[1],
              page: page,
            ),
        count: (v) => GetIt.instance
            .get<ItemDisplayInfoRepository>()
            .countItemDisplayInfos(
              id: v[0].isEmpty ? null : v[0],
              name: v[1].isEmpty ? null : v[1],
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
              entry: v[0].isEmpty ? null : v[0],
              page: page,
            ),
        count: (v) => GetIt.instance
            .get<ItemEnchantmentTemplateRepository>()
            .countItemEnchantmentTemplates(entry: v[0].isEmpty ? null : v[0]),
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
                t.nameLangZhCn.isNotEmpty ? t.nameLangZhCn : t.name,
          ),
        ],
        idOf: (BriefItemRandomPropertiesEntity t) => t.id,
        fetch: (page, v) => GetIt.instance
            .get<ItemRandomPropertiesRepository>()
            .getBriefItemRandomProperties(
              id: v[0].isEmpty ? null : v[0],
              name: v[1].isEmpty ? null : v[1],
              page: page,
            ),
        count: (v) => GetIt.instance
            .get<ItemRandomPropertiesRepository>()
            .countItemRandomProperties(
              id: v[0].isEmpty ? null : v[0],
              name: v[1].isEmpty ? null : v[1],
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
            text: (BriefItemRandomSuffixEntity t) => t.nameLangZhCn,
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
              id: v[0].isEmpty ? null : v[0],
              name: v[1].isEmpty ? null : v[1],
              page: page,
            ),
        count: (v) => GetIt.instance
            .get<ItemRandomSuffixRepository>()
            .countItemRandomSuffixes(
              id: v[0].isEmpty ? null : v[0],
              name: v[1].isEmpty ? null : v[1],
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
      id: v[0].isEmpty ? null : v[0],
      page: page,
    ),
    count: (v) => GetIt.instance.get<LockRepository>().countLocks(
      id: v[0].isEmpty ? null : v[0],
    ),
  );

  static FoxyEntityPickerDelegate<BriefLootTemplateEntity> lootTemplate(
    LootTableType tableType,
    String title,
  ) {
    final repository = LootTemplateRepository(tableType);
    return FoxyEntityPickerDelegate<BriefLootTemplateEntity>(
      title: title,
      errorLabel: '搜索掉落模板失败',
      filters: const [FoxyEntityPickerFilter('掉落编号')],
      columns: [
        FoxyEntityPickerColumn(
          header: '掉落编号',
          width: 120,
          text: (BriefLootTemplateEntity t) => t.entry.toString(),
        ),
        FoxyEntityPickerColumn(
          header: '物品数量',
          text: (BriefLootTemplateEntity t) => t.itemCount.toString(),
        ),
      ],
      idOf: (BriefLootTemplateEntity t) => t.entry,
      fetch: (page, v) => repository.getBriefLootTemplateEntries(
        entry: v[0].isEmpty ? null : v[0],
        page: page,
      ),
      count: (v) =>
          repository.countLootTemplates(entry: v[0].isEmpty ? null : v[0]),
    );
  }

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
        text: (BriefMapInfoEntity t) => t.mapNameLangZhCn,
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
    fetch: (page, v) => GetIt.instance.get<MapInfoRepository>().getBriefMapInfos(
      id: v[0].isEmpty ? null : v[0],
      name: v[1].isEmpty ? null : v[1],
      page: page,
    ),
    count: (v) => GetIt.instance.get<MapInfoRepository>().countMapInfos(
      id: v[0].isEmpty ? null : v[0],
      name: v[1].isEmpty ? null : v[1],
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
    filters: const [FoxyEntityPickerFilter('编号')],
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
          filter: PageTextFilterEntity(id: v[0], text: ''),
          page: page,
        ),
    count: (v) => GetIt.instance.get<PageTextRepository>().countPageTexts(
      filter: PageTextFilterEntity(id: v[0], text: ''),
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
        text: (BriefQuestInfoEntity t) => t.infoNameLangZhCn,
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

  static final spellDuration = FoxyEntityPickerDelegate<BriefSpellDurationEntity>(
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
        .getBriefSpellDurations(id: v[0].isEmpty ? null : v[0], page: page),
    count: (v) => GetIt.instance
        .get<SpellDurationRepository>()
        .countSpellDurations(id: v[0].isEmpty ? null : v[0]),
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
    fetch: (page, v) => GetIt.instance.get<SpellIconRepository>().getBriefSpellIcons(
      id: v[0].isEmpty ? null : v[0],
      name: v[1].isEmpty ? null : v[1],
      page: page,
    ),
    count: (v) => GetIt.instance.get<SpellIconRepository>().countSpellIcons(
      id: v[0].isEmpty ? null : v[0],
      name: v[1].isEmpty ? null : v[1],
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
        text: (BriefSpellRangeEntity t) => t.displayNameLangZhCn,
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
          id: v[0].isEmpty ? null : v[0],
          name: v[1].isEmpty ? null : v[1],
          page: page,
        ),
    count: (v) => GetIt.instance.get<SpellRangeRepository>().countSpellRanges(
      id: v[0].isEmpty ? null : v[0],
      name: v[1].isEmpty ? null : v[1],
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
    fetch: (page, v) => GetIt.instance.get<VehicleRepository>().getBriefVehicles(
      id: v[0].isEmpty ? null : v[0],
      page: page,
    ),
    count: (v) => GetIt.instance.get<VehicleRepository>().countVehicles(
      id: v[0].isEmpty ? null : v[0],
    ),
  );
}
