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
import 'package:get_it/get_it.dart';

class EntityPickerDelegates {
  static final areaTable = EntityPickerDelegate<AreaTableEntity>(
    title: '区域',
    errorLabel: '搜索区域失败',
    filters: const [EntityPickerFilter('区域ID'), EntityPickerFilter('区域名称')],
    columns: [
      EntityPickerColumn(
        header: '编号',
        width: 120,
        text: (AreaTableEntity t) => t.id.toString(),
      ),
      EntityPickerColumn(
        header: '名称',
        text: (AreaTableEntity t) => t.areaNameLangZhCn,
      ),
      EntityPickerColumn(
        header: '地区编号',
        width: 120,
        text: (AreaTableEntity t) => t.continentId.toString(),
      ),
    ],
    idOf: (AreaTableEntity t) => t.id,
    fetch: (page, v) => GetIt.instance.get<AreaTableRepository>().getAreaTables(
      filter: AreaTableFilterEntity(id: v[0], name: v[1]),
      page: page,
    ),
    count: (v) => GetIt.instance.get<AreaTableRepository>().countAreaTables(
      filter: AreaTableFilterEntity(id: v[0], name: v[1]),
    ),
  );

  static final broadcastText = EntityPickerDelegate<BroadcastTextEntity>(
    title: '广播文本',
    errorLabel: '搜索广播文本失败',
    filters: const [EntityPickerFilter('广播文本ID'), EntityPickerFilter('文本内容')],
    columns: [
      EntityPickerColumn(
        header: '编号',
        width: 120,
        text: (BroadcastTextEntity t) => t.id.toString(),
      ),
      EntityPickerColumn(
        header: '文本',
        text: (BroadcastTextEntity t) => t.maleText,
      ),
      EntityPickerColumn(
        header: '语言',
        width: 120,
        text: (BroadcastTextEntity t) => t.languageId.toString(),
      ),
    ],
    idOf: (BroadcastTextEntity t) => t.id,
    fetch: (page, v) =>
        GetIt.instance.get<BroadcastTextRepository>().getBroadcastTexts(
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

  static final charTitle = EntityPickerDelegate<CharTitleEntity>(
    title: '称号',
    errorLabel: '搜索称号失败',
    filters: const [EntityPickerFilter('称号ID'), EntityPickerFilter('称号名称')],
    columns: [
      EntityPickerColumn(
        header: '编号',
        width: 120,
        text: (CharTitleEntity t) => t.id.toString(),
      ),
      EntityPickerColumn(
        header: '名称',
        text: (CharTitleEntity t) => t.nameLangZhCn,
      ),
    ],
    idOf: (CharTitleEntity t) => t.id,
    fetch: (page, v) => GetIt.instance.get<CharTitleRepository>().getCharTitles(
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
      EntityPickerDelegate<BriefCreatureSpellDataEntity>(
        title: '宠物技能',
        errorLabel: '搜索宠物技能失败',
        filters: const [EntityPickerFilter('编号'), EntityPickerFilter('技能名称')],
        columns: [
          EntityPickerColumn(
            header: '编号',
            width: 120,
            text: (BriefCreatureSpellDataEntity t) => t.id.toString(),
          ),
          EntityPickerColumn(
            header: '技能1',
            text: (BriefCreatureSpellDataEntity t) => t.spellName1,
          ),
          EntityPickerColumn(
            header: '技能2',
            text: (BriefCreatureSpellDataEntity t) => t.spellName2,
          ),
          EntityPickerColumn(
            header: '技能3',
            text: (BriefCreatureSpellDataEntity t) => t.spellName3,
          ),
          EntityPickerColumn(
            header: '技能4',
            text: (BriefCreatureSpellDataEntity t) => t.spellName4,
          ),
        ],
        idOf: (BriefCreatureSpellDataEntity t) => t.id,
        fetch: (page, v) => GetIt.instance
            .get<CreatureSpellDataRepository>()
            .getCreatureSpellDatas(
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
      EntityPickerDelegate<BriefCreatureTemplateEntity>(
        title: '生物模板',
        errorLabel: '搜索生物模板失败',
        filters: const [EntityPickerFilter('编号'), EntityPickerFilter('名称')],
        columns: [
          EntityPickerColumn(
            header: '编号',
            width: 120,
            text: (BriefCreatureTemplateEntity t) => t.entry.toString(),
          ),
          EntityPickerColumn(
            header: '名称',
            text: (BriefCreatureTemplateEntity t) => t.displayName,
          ),
          EntityPickerColumn(
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

  static final dbcFaction = EntityPickerDelegate<DbcFactionEntity>(
    title: '阵营',
    errorLabel: '搜索阵营失败',
    filters: const [EntityPickerFilter('阵营ID'), EntityPickerFilter('阵营名称')],
    columns: [
      EntityPickerColumn(
        header: '编号',
        width: 120,
        text: (DbcFactionEntity t) => t.id.toString(),
      ),
      EntityPickerColumn(
        header: '名称',
        text: (DbcFactionEntity t) => t.nameLangZhCn,
      ),
      EntityPickerColumn(
        header: '描述',
        text: (DbcFactionEntity t) => t.descriptionLangZhCn,
      ),
    ],
    idOf: (DbcFactionEntity t) => t.id,
    fetch: (page, v) =>
        GetIt.instance.get<DbcFactionRepository>().getDbcFactions(
          id: v[0].isEmpty ? null : v[0],
          name: v[1].isEmpty ? null : v[1],
          page: page,
        ),
    count: (v) => GetIt.instance.get<DbcFactionRepository>().countDbcFactions(
      id: v[0].isEmpty ? null : v[0],
      name: v[1].isEmpty ? null : v[1],
    ),
  );

  static final emote = EntityPickerDelegate<EmoteTextEntity>(
    title: '表情',
    errorLabel: '搜索表情失败',
    filters: const [EntityPickerFilter('表情ID'), EntityPickerFilter('表情名称')],
    columns: [
      EntityPickerColumn(
        header: '编号',
        width: 120,
        text: (EmoteTextEntity t) => t.id.toString(),
      ),
      EntityPickerColumn(header: '名称', text: (EmoteTextEntity t) => t.name),
      EntityPickerColumn(
        header: '表情编号',
        width: 120,
        text: (EmoteTextEntity t) => t.emoteId.toString(),
      ),
    ],
    idOf: (EmoteTextEntity t) => t.id,
    fetch: (page, v) => GetIt.instance.get<EmoteTextRepository>().getEmoteTexts(
      filter: EmoteTextFilterEntity(id: v[0], name: v[1]),
      page: page,
    ),
    count: (v) => GetIt.instance.get<EmoteTextRepository>().countEmoteTexts(
      filter: EmoteTextFilterEntity(id: v[0], name: v[1]),
    ),
  );

  static final gossipMenu = EntityPickerDelegate<BriefGossipMenuEntity>(
    title: '对话菜单',
    errorLabel: '搜索对话菜单失败',
    filters: const [EntityPickerFilter('菜单ID'), EntityPickerFilter('文本内容')],
    columns: [
      EntityPickerColumn(
        header: '菜单ID',
        width: 120,
        text: (BriefGossipMenuEntity t) => t.menuId.toString(),
      ),
      EntityPickerColumn(
        header: '文本ID',
        width: 120,
        text: (BriefGossipMenuEntity t) => t.textId.toString(),
      ),
      EntityPickerColumn(
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

  static final itemDisplayInfo = EntityPickerDelegate<ItemDisplayInfoEntity>(
    title: '物品显示信息',
    errorLabel: '搜索显示信息失败',
    filters: const [EntityPickerFilter('显示信息ID'), EntityPickerFilter('模型名称')],
    columns: [
      EntityPickerColumn(
        header: '编号',
        width: 120,
        text: (ItemDisplayInfoEntity t) => t.id.toString(),
      ),
      EntityPickerColumn(
        header: '模型名称',
        text: (ItemDisplayInfoEntity t) => t.modelName0,
      ),
      EntityPickerColumn(
        header: '图标',
        text: (ItemDisplayInfoEntity t) => t.inventoryIcon0,
      ),
    ],
    idOf: (ItemDisplayInfoEntity t) => t.id,
    fetch: (page, v) =>
        GetIt.instance.get<ItemDisplayInfoRepository>().getItemDisplayInfos(
          id: v[0].isEmpty ? null : v[0],
          name: v[1].isEmpty ? null : v[1],
          page: page,
        ),
    count: (v) =>
        GetIt.instance.get<ItemDisplayInfoRepository>().countItemDisplayInfos(
          id: v[0].isEmpty ? null : v[0],
          name: v[1].isEmpty ? null : v[1],
        ),
  );

  static final itemEnchantmentTemplate =
      EntityPickerDelegate<BriefItemEnchantmentTemplateEntity>(
        title: '附魔',
        errorLabel: '搜索附魔失败',
        filters: const [EntityPickerFilter('编号'), EntityPickerFilter('名称')],
        columns: [
          EntityPickerColumn(
            header: '编号',
            width: 120,
            text: (BriefItemEnchantmentTemplateEntity t) => t.entry.toString(),
          ),
          EntityPickerColumn(
            header: '名称',
            text: (BriefItemEnchantmentTemplateEntity t) => t.name,
          ),
        ],
        idOf: (BriefItemEnchantmentTemplateEntity t) => t.entry,
        fetch: (page, v) => GetIt.instance
            .get<ItemEnchantmentTemplateRepository>()
            .getItemEnchantmentTemplates(
              entry: v[0].isEmpty ? null : v[0],
              page: page,
            ),
        count: (v) => GetIt.instance
            .get<ItemEnchantmentTemplateRepository>()
            .countItemEnchantmentTemplates(entry: v[0].isEmpty ? null : v[0]),
      );

  static final itemExtendedCost = EntityPickerDelegate<ItemExtendedCostEntity>(
    title: '选择扩展价格',
    errorLabel: '搜索扩展价格失败',
    emptyText: '暂无数据',
    filters: const [EntityPickerFilter('编号')],
    columns: [
      EntityPickerColumn(
        header: '编号',
        width: 120,
        text: (ItemExtendedCostEntity t) => t.id.toString(),
      ),
      EntityPickerColumn(
        header: '荣誉点数',
        width: 120,
        text: (ItemExtendedCostEntity t) => t.honorPoints.toString(),
      ),
      EntityPickerColumn(
        header: '竞技场点数',
        width: 120,
        text: (ItemExtendedCostEntity t) => t.arenaPoints.toString(),
      ),
      EntityPickerColumn(
        header: '竞技场等级',
        text: (ItemExtendedCostEntity t) => t.arenaBracket.toString(),
      ),
    ],
    idOf: (ItemExtendedCostEntity t) => t.id,
    fetch: (page, v) =>
        GetIt.instance.get<ItemExtendedCostRepository>().getItemExtendedCosts(
          filter: ItemExtendedCostFilterEntity(id: v[0]),
          page: page,
        ),
    count: (v) => GetIt.instance
        .get<ItemExtendedCostRepository>()
        .countItemExtendedCosts(filter: ItemExtendedCostFilterEntity(id: v[0])),
  );

  static final itemRandomProperties =
      EntityPickerDelegate<ItemRandomPropertiesEntity>(
        title: '随机属性',
        errorLabel: '搜索随机属性失败',
        filters: const [EntityPickerFilter('属性ID'), EntityPickerFilter('属性名称')],
        columns: [
          EntityPickerColumn(
            header: '编号',
            width: 120,
            text: (ItemRandomPropertiesEntity t) => t.id.toString(),
          ),
          EntityPickerColumn(
            header: '名称',
            text: (ItemRandomPropertiesEntity t) =>
                t.nameLangZhCn.isNotEmpty ? t.nameLangZhCn : t.name,
          ),
        ],
        idOf: (ItemRandomPropertiesEntity t) => t.id,
        fetch: (page, v) => GetIt.instance
            .get<ItemRandomPropertiesRepository>()
            .getItemRandomProperties(
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

  static final itemRandomSuffix = EntityPickerDelegate<ItemRandomSuffixEntity>(
    title: '随机后缀',
    errorLabel: '搜索随机后缀失败',
    filters: const [EntityPickerFilter('后缀ID'), EntityPickerFilter('后缀名称')],
    columns: [
      EntityPickerColumn(
        header: '编号',
        width: 120,
        text: (ItemRandomSuffixEntity t) => t.id.toString(),
      ),
      EntityPickerColumn(
        header: '名称',
        text: (ItemRandomSuffixEntity t) => t.nameLangZhCn,
      ),
      EntityPickerColumn(
        header: '内部名称',
        text: (ItemRandomSuffixEntity t) => t.internalName,
      ),
    ],
    idOf: (ItemRandomSuffixEntity t) => t.id,
    fetch: (page, v) =>
        GetIt.instance.get<ItemRandomSuffixRepository>().getItemRandomSuffixes(
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

  static final itemTemplate = EntityPickerDelegate<BriefItemTemplateEntity>(
    title: '物品',
    errorLabel: '搜索失败',
    filters: const [
      EntityPickerFilter('编号'),
      EntityPickerFilter('名称'),
      EntityPickerFilter('描述'),
    ],
    columns: [
      EntityPickerColumn(
        header: '编号',
        width: 120,
        text: (BriefItemTemplateEntity t) => t.entry.toString(),
      ),
      EntityPickerColumn(
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
      EntityPickerColumn(
        header: '物品等级',
        width: 120,
        text: (BriefItemTemplateEntity t) => t.itemLevel.toString(),
      ),
      EntityPickerColumn(
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

  static final lock = EntityPickerDelegate<LockEntity>(
    title: '锁',
    errorLabel: '搜索锁失败',
    filters: const [EntityPickerFilter('锁ID')],
    columns: [
      EntityPickerColumn(
        header: '编号',
        width: 120,
        text: (LockEntity t) => t.id.toString(),
      ),
      EntityPickerColumn(
        header: '类型',
        width: 120,
        text: (LockEntity t) => t.type0.toString(),
      ),
      EntityPickerColumn(
        header: '索引',
        width: 120,
        text: (LockEntity t) => t.index0.toString(),
      ),
      EntityPickerColumn(
        header: '技能',
        text: (LockEntity t) => t.skill0.toString(),
      ),
    ],
    idOf: (LockEntity t) => t.id,
    fetch: (page, v) => GetIt.instance.get<LockRepository>().getLocks(
      id: v[0].isEmpty ? null : v[0],
      page: page,
    ),
    count: (v) => GetIt.instance.get<LockRepository>().countLocks(
      id: v[0].isEmpty ? null : v[0],
    ),
  );

  static EntityPickerDelegate<BriefLootTemplateEntity> lootTemplate(
    LootTableType tableType,
    String title,
  ) {
    final repository = LootTemplateRepository(tableType);
    return EntityPickerDelegate<BriefLootTemplateEntity>(
      title: title,
      errorLabel: '搜索掉落模板失败',
      filters: const [EntityPickerFilter('掉落编号')],
      columns: [
        EntityPickerColumn(
          header: '掉落编号',
          width: 120,
          text: (BriefLootTemplateEntity t) => t.entry.toString(),
        ),
        EntityPickerColumn(
          header: '物品数量',
          text: (BriefLootTemplateEntity t) => t.itemCount.toString(),
        ),
      ],
      idOf: (BriefLootTemplateEntity t) => t.entry,
      fetch: (page, v) => repository.getLootTemplateDistinctEntries(
        entry: v[0].isEmpty ? null : v[0],
        page: page,
      ),
      count: (v) =>
          repository.countLootTemplates(entry: v[0].isEmpty ? null : v[0]),
    );
  }

  static final map = EntityPickerDelegate<MapInfoEntity>(
    title: '地图',
    errorLabel: '搜索地图失败',
    filters: const [EntityPickerFilter('地图ID'), EntityPickerFilter('地图名称')],
    columns: [
      EntityPickerColumn(
        header: '编号',
        width: 120,
        text: (MapInfoEntity t) => t.id.toString(),
      ),
      EntityPickerColumn(
        header: '名称',
        text: (MapInfoEntity t) => t.mapNameLangZhCn,
      ),
      EntityPickerColumn(
        header: '类型',
        width: 120,
        text: (MapInfoEntity t) => t.instanceType.toString(),
      ),
      EntityPickerColumn(
        header: 'PVP',
        width: 120,
        text: (MapInfoEntity t) => t.pvp.toString(),
      ),
    ],
    idOf: (MapInfoEntity t) => t.id,
    fetch: (page, v) => GetIt.instance.get<MapInfoRepository>().getMapInfos(
      id: v[0].isEmpty ? null : v[0],
      name: v[1].isEmpty ? null : v[1],
      page: page,
    ),
    count: (v) => GetIt.instance.get<MapInfoRepository>().countMapInfos(
      id: v[0].isEmpty ? null : v[0],
      name: v[1].isEmpty ? null : v[1],
    ),
  );

  static final npcText = EntityPickerDelegate<NpcTextEntity>(
    title: 'NPC 文本',
    errorLabel: '搜索NPC文本失败',
    filters: const [EntityPickerFilter('ID'), EntityPickerFilter('文本内容')],
    columns: [
      EntityPickerColumn(
        header: 'ID',
        width: 120,
        text: (NpcTextEntity t) => t.id.toString(),
      ),
      EntityPickerColumn(
        header: '文本（text0_0 / text0_1）',
        text: (NpcTextEntity t) => t.entries[0].text0.isNotEmpty
            ? t.entries[0].text0
            : t.entries[0].text1,
      ),
    ],
    idOf: (NpcTextEntity t) => t.id,
    fetch: (page, v) =>
        GetIt.instance.get<NpcTextRepository>().getNpcTextsPaginated(
          id: v[0].isEmpty ? null : v[0],
          text: v[1].isEmpty ? null : v[1],
          page: page,
        ),
    count: (v) => GetIt.instance.get<NpcTextRepository>().countNpcTexts(
      id: v[0].isEmpty ? null : v[0],
      text: v[1].isEmpty ? null : v[1],
    ),
  );

  static final pageText = EntityPickerDelegate<PageTextEntity>(
    title: '页面文本',
    errorLabel: '搜索页面文本失败',
    filters: const [EntityPickerFilter('编号')],
    columns: [
      EntityPickerColumn(
        header: '编号',
        width: 120,
        text: (PageTextEntity t) => t.id.toString(),
      ),
      EntityPickerColumn(header: '文本', text: (PageTextEntity t) => t.text),
    ],
    idOf: (PageTextEntity t) => t.id,
    fetch: (page, v) => GetIt.instance.get<PageTextRepository>().getPageTexts(
      filter: PageTextFilterEntity(id: v[0], text: ''),
      page: page,
    ),
    count: (v) => GetIt.instance.get<PageTextRepository>().countPageTexts(
      filter: PageTextFilterEntity(id: v[0], text: ''),
    ),
  );

  static final questInfo = EntityPickerDelegate<QuestInfoEntity>(
    title: '任务信息',
    errorLabel: '搜索任务信息失败',
    filters: const [EntityPickerFilter('任务信息ID'), EntityPickerFilter('信息名称')],
    columns: [
      EntityPickerColumn(
        header: '编号',
        width: 120,
        text: (QuestInfoEntity t) => t.id.toString(),
      ),
      EntityPickerColumn(
        header: '名称',
        text: (QuestInfoEntity t) => t.infoNameLangZhCn,
      ),
    ],
    idOf: (QuestInfoEntity t) => t.id,
    fetch: (page, v) => GetIt.instance.get<QuestInfoRepository>().getQuestInfos(
      filter: QuestInfoFilterEntity(id: v[0], name: v[1]),
      page: page,
    ),
    count: (v) => GetIt.instance.get<QuestInfoRepository>().countQuestInfos(
      filter: QuestInfoFilterEntity(id: v[0], name: v[1]),
    ),
  );

  static final questTemplate = EntityPickerDelegate<BriefQuestTemplateEntity>(
    title: '任务',
    errorLabel: '搜索任务失败',
    filters: const [EntityPickerFilter('编号'), EntityPickerFilter('名称')],
    columns: [
      EntityPickerColumn(
        header: '编号',
        width: 120,
        text: (BriefQuestTemplateEntity t) => t.id.toString(),
      ),
      EntityPickerColumn(
        header: '名称',
        text: (BriefQuestTemplateEntity t) => t.displayTitle,
      ),
    ],
    idOf: (BriefQuestTemplateEntity t) => t.id,
    fetch: (page, v) =>
        GetIt.instance.get<QuestTemplateRepository>().getBriefQuestTemplates(
          filter: QuestTemplateFilterEntity(id: v[0], title: v[1]),
          page: page,
        ),
    count: (v) =>
        GetIt.instance.get<QuestTemplateRepository>().countQuestTemplates(
          filter: QuestTemplateFilterEntity(id: v[0], title: v[1]),
        ),
  );

  static final scalingStatDistribution =
      EntityPickerDelegate<BriefItemEnchantmentTemplateEntity>(
        title: '属性缩放分布',
        errorLabel: '搜索缩放分布失败',
        filters: const [EntityPickerFilter('编号')],
        columns: [
          EntityPickerColumn(
            header: '编号',
            width: 120,
            text: (BriefItemEnchantmentTemplateEntity t) => t.entry.toString(),
          ),
          EntityPickerColumn(
            header: '名称',
            text: (BriefItemEnchantmentTemplateEntity t) => t.name,
          ),
        ],
        idOf: (BriefItemEnchantmentTemplateEntity t) => t.entry,
        fetch: (page, v) => GetIt.instance
            .get<ScalingStatDistributionRepository>()
            .getScalingStatDistributions(
              id: v[0].isEmpty ? null : v[0],
              page: page,
            ),
        count: (v) => GetIt.instance
            .get<ScalingStatDistributionRepository>()
            .countScalingStatDistributions(id: v[0].isEmpty ? null : v[0]),
      );

  static final spellDuration = EntityPickerDelegate<SpellDurationEntity>(
    title: '施法时间',
    errorLabel: '搜索持续时间失败',
    filters: const [EntityPickerFilter('持续时间ID')],
    columns: [
      EntityPickerColumn(
        header: '编号',
        width: 120,
        text: (SpellDurationEntity t) => t.id.toString(),
      ),
      EntityPickerColumn(
        header: '持续时间',
        width: 120,
        text: (SpellDurationEntity t) => t.duration.toString(),
      ),
      EntityPickerColumn(
        header: '每级增加值',
        width: 120,
        text: (SpellDurationEntity t) => t.durationPerLevel.toString(),
      ),
      EntityPickerColumn(
        header: '最大持续时间',
        text: (SpellDurationEntity t) => t.maxDuration.toString(),
      ),
    ],
    idOf: (SpellDurationEntity t) => t.id,
    fetch: (page, v) => GetIt.instance
        .get<SpellDurationRepository>()
        .getSpellDurations(id: v[0].isEmpty ? null : v[0], page: page),
    count: (v) => GetIt.instance
        .get<SpellDurationRepository>()
        .countSpellDurations(id: v[0].isEmpty ? null : v[0]),
  );

  static final spellIcon = EntityPickerDelegate<SpellIconEntity>(
    title: '技能图标',
    errorLabel: '搜索图标失败',
    filters: const [EntityPickerFilter('图标ID'), EntityPickerFilter('文件名')],
    columns: [
      EntityPickerColumn(
        header: '编号',
        width: 120,
        text: (SpellIconEntity t) => t.id.toString(),
      ),
      EntityPickerColumn(
        header: '图标文件',
        text: (SpellIconEntity t) => t.textureFilename,
      ),
    ],
    idOf: (SpellIconEntity t) => t.id,
    fetch: (page, v) => GetIt.instance.get<SpellIconRepository>().getSpellIcons(
      id: v[0].isEmpty ? null : v[0],
      name: v[1].isEmpty ? null : v[1],
      page: page,
    ),
    count: (v) => GetIt.instance.get<SpellIconRepository>().countSpellIcons(
      id: v[0].isEmpty ? null : v[0],
      name: v[1].isEmpty ? null : v[1],
    ),
  );

  static final spell = EntityPickerDelegate<SpellEntity>(
    title: '技能',
    errorLabel: '搜索技能失败',
    filters: const [EntityPickerFilter('编号'), EntityPickerFilter('名称')],
    columns: [
      EntityPickerColumn(
        header: '编号',
        width: 120,
        text: (SpellEntity t) => t.id.toString(),
      ),
      EntityPickerColumn(
        header: '名称',
        width: 240,
        text: (SpellEntity t) => t.nameLangZhCN,
      ),
      EntityPickerColumn(
        header: '子名称',
        width: 120,
        text: (SpellEntity t) => t.nameSubtextLangZhCN,
      ),
      EntityPickerColumn(
        header: '描述',
        text: (SpellEntity t) => t.descriptionLangZhCN,
      ),
    ],
    idOf: (SpellEntity t) => t.id,
    fetch: (page, v) async {
      final repo = GetIt.instance.get<SpellRepository>();
      final filter = SpellFilterEntity(
        id: v[0].isEmpty ? '' : v[0],
        name: v[1].isEmpty ? '' : v[1],
      );
      final briefs = await repo.getBriefSpells(page: page, filter: filter);
      return briefs
          .map(
            (b) => SpellEntity(
              id: b.id,
              nameLangZhCN: b.name,
              nameSubtextLangZhCN: b.subtext,
              descriptionLangZhCN: b.description,
            ),
          )
          .toList();
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

  static final spellRange = EntityPickerDelegate<SpellRangeEntity>(
    title: '技能射程',
    errorLabel: '搜索射程失败',
    filters: const [EntityPickerFilter('射程ID'), EntityPickerFilter('射程名称')],
    columns: [
      EntityPickerColumn(
        header: '编号',
        width: 120,
        text: (SpellRangeEntity t) => t.id.toString(),
      ),
      EntityPickerColumn(
        header: '名称',
        text: (SpellRangeEntity t) => t.displayNameLangZhCn,
      ),
      EntityPickerColumn(
        header: '最小射程',
        width: 120,
        text: (SpellRangeEntity t) => t.rangeMin0.toStringAsFixed(1),
      ),
      EntityPickerColumn(
        header: '最大射程',
        width: 120,
        text: (SpellRangeEntity t) => t.rangeMax0.toStringAsFixed(1),
      ),
    ],
    idOf: (SpellRangeEntity t) => t.id,
    fetch: (page, v) =>
        GetIt.instance.get<SpellRangeRepository>().getSpellRanges(
          id: v[0].isEmpty ? null : v[0],
          name: v[1].isEmpty ? null : v[1],
          page: page,
        ),
    count: (v) => GetIt.instance.get<SpellRangeRepository>().countSpellRanges(
      id: v[0].isEmpty ? null : v[0],
      name: v[1].isEmpty ? null : v[1],
    ),
  );

  static final vehicle = EntityPickerDelegate<VehicleEntity>(
    title: '载具',
    errorLabel: '搜索载具失败',
    filters: const [EntityPickerFilter('载具ID')],
    columns: [
      EntityPickerColumn(
        header: '编号',
        width: 120,
        text: (VehicleEntity t) => t.id.toString(),
      ),
      EntityPickerColumn(
        header: '标识',
        width: 120,
        text: (VehicleEntity t) => t.flags.toString(),
      ),
      EntityPickerColumn(
        header: '转向速度',
        text: (VehicleEntity t) => t.turnSpeed.toString(),
      ),
    ],
    idOf: (VehicleEntity t) => t.id,
    fetch: (page, v) => GetIt.instance.get<VehicleRepository>().getVehicles(
      id: v[0].isEmpty ? null : v[0],
      page: page,
    ),
    count: (v) => GetIt.instance.get<VehicleRepository>().countVehicles(
      id: v[0].isEmpty ? null : v[0],
    ),
  );
}
