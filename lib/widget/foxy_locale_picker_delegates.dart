import 'package:foxy/constant/dbc_locale_fields.dart';
import 'package:foxy/entity/creature_template_locale_entity.dart';
import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/entity/game_object_template_locale_entity.dart';
import 'package:foxy/entity/item_template_locale_entity.dart';
import 'package:foxy/entity/quest_offer_reward_entity.dart';
import 'package:foxy/entity/quest_request_items_entity.dart';
import 'package:foxy/entity/quest_template_locale_entity.dart';
import 'package:foxy/repository/achievement_repository.dart';
import 'package:foxy/repository/achievement_category_repository.dart';
import 'package:foxy/repository/achievement_criteria_repository.dart';
import 'package:foxy/repository/area_table_repository.dart';
import 'package:foxy/repository/char_title_repository.dart';
import 'package:foxy/repository/creature_template_repository.dart';
import 'package:foxy/repository/currency_category_repository.dart';
import 'package:foxy/repository/dbc_faction_repository.dart';
import 'package:foxy/repository/emote_text_data_repository.dart';
import 'package:foxy/repository/game_object_template_repository.dart';
import 'package:foxy/repository/item_random_properties_repository.dart';
import 'package:foxy/repository/item_random_suffix_repository.dart';
import 'package:foxy/repository/item_set_repository.dart';
import 'package:foxy/repository/item_template_locale_repository.dart';
import 'package:foxy/repository/map_info_repository.dart';
import 'package:foxy/repository/mail_template_repository.dart';
import 'package:foxy/repository/quest_info_repository.dart';
import 'package:foxy/repository/quest_offer_reward_locale_repository.dart';
import 'package:foxy/repository/quest_request_items_locale_repository.dart';
import 'package:foxy/repository/quest_sort_repository.dart';
import 'package:foxy/repository/quest_template_locale_repository.dart';
import 'package:foxy/repository/spell_item_enchantment_repository.dart';
import 'package:foxy/repository/spell_range_repository.dart';
import 'package:foxy/repository/spell_repository.dart';
import 'package:foxy/repository/talent_tab_repository.dart';
import 'package:foxy/widget/foxy_locale_picker.dart';
import 'package:get_it/get_it.dart';

/// 多语言 picker delegate 注册表，集中各模块的加载/保存配置。
///
/// 对齐 [EntityPickerDelegates] 范式：每个实体一个 `static final` delegate，
/// 纯数据 + 闭包，不持有可变状态，可被多个 [FoxyLocalePicker] 共享。
class FoxyLocalePickerDelegates {
  static final creatureTemplateName = DatabaseLocaleEditorDelegate(
    fields: ['locale', 'name', 'title'],
    fieldLabels: ['语言', '名称', '称号'],
    onLoad: (entry) async {
      final repo = GetIt.instance.get<CreatureTemplateRepository>();
      final locales = await repo.getCreatureTemplateLocales(entry);
      return locales
          .map((e) => {'locale': e.locale, 'name': e.name, 'title': e.title})
          .toList();
    },
    onSave: (entry, data) async {
      final repo = GetIt.instance.get<CreatureTemplateRepository>();
      final locales = data
          .map(
            (d) => CreatureTemplateLocaleEntity(
              entry: entry,
              locale: d['locale'] ?? '',
              name: d['name'] ?? '',
              title: d['title'] ?? '',
            ),
          )
          .toList();
      await repo.saveCreatureTemplateLocales(entry, locales);
    },
  );

  static final gameObjectName = DatabaseLocaleEditorDelegate(
    fields: ['locale', 'name'],
    fieldLabels: ['语言', '名称'],
    onLoad: (entry) async {
      final repo = GetIt.instance.get<GameObjectTemplateRepository>();
      final locales = await repo.getGameObjectTemplateLocales(entry);
      return locales.map((e) => {'locale': e.locale, 'name': e.name}).toList();
    },
    onSave: (entry, data) async {
      final repo = GetIt.instance.get<GameObjectTemplateRepository>();
      final existing = await repo.getGameObjectTemplateLocales(entry);
      final locales = data.map((d) {
        final locale = d['locale'] ?? '';
        final current = existing.where((row) => row.locale == locale);
        final preserved = current.isEmpty ? null : current.first;
        return GameObjectTemplateLocaleEntity(
          entry: entry,
          locale: locale,
          name: d['name'] ?? '',
          castBarCaption: preserved?.castBarCaption ?? '',
          verifiedBuild: preserved?.verifiedBuild ?? 0,
        );
      }).toList();
      await repo.saveGameObjectTemplateLocales(entry, locales);
    },
  );

  static final gameObjectCaption = DatabaseLocaleEditorDelegate(
    fields: ['locale', 'castBarCaption'],
    fieldLabels: ['语言', '使用说明'],
    onLoad: (entry) async {
      final repo = GetIt.instance.get<GameObjectTemplateRepository>();
      final locales = await repo.getGameObjectTemplateLocales(entry);
      return locales
          .map((e) => {'locale': e.locale, 'castBarCaption': e.castBarCaption})
          .toList();
    },
    onSave: (entry, data) async {
      final repo = GetIt.instance.get<GameObjectTemplateRepository>();
      final existing = await repo.getGameObjectTemplateLocales(entry);
      final locales = data.map((d) {
        final locale = d['locale'] ?? '';
        final current = existing.where((row) => row.locale == locale);
        final preserved = current.isEmpty ? null : current.first;
        return GameObjectTemplateLocaleEntity(
          entry: entry,
          locale: locale,
          name: preserved?.name ?? '',
          castBarCaption: d['castBarCaption'] ?? '',
          verifiedBuild: preserved?.verifiedBuild ?? 0,
        );
      }).toList();
      await repo.saveGameObjectTemplateLocales(entry, locales);
    },
  );

  static final itemName = DatabaseLocaleEditorDelegate(
    fields: ['locale', 'name'],
    fieldLabels: ['语言', '名称'],
    onLoad: (entry) async {
      final repo = GetIt.instance.get<ItemTemplateLocaleRepository>();
      final locales = await repo.getItemTemplateLocales(entry);
      return locales.map((e) => {'locale': e.locale, 'name': e.name}).toList();
    },
    onSave: (entry, data) async {
      final repo = GetIt.instance.get<ItemTemplateLocaleRepository>();
      final locales = data
          .map(
            (d) => ItemTemplateLocaleEntity(
              id: entry,
              locale: d['locale'] ?? '',
              name: d['name'] ?? '',
            ),
          )
          .toList();
      await repo.saveItemTemplateLocales(entry, locales);
    },
  );

  static final itemDescription = DatabaseLocaleEditorDelegate(
    fields: ['locale', 'description'],
    fieldLabels: ['语言', '描述'],
    onLoad: (entry) async {
      final repo = GetIt.instance.get<ItemTemplateLocaleRepository>();
      final locales = await repo.getItemTemplateLocales(entry);
      return locales
          .map((e) => {'locale': e.locale, 'description': e.description})
          .toList();
    },
    onSave: (entry, data) async {
      final repo = GetIt.instance.get<ItemTemplateLocaleRepository>();
      final locales = data
          .map(
            (d) => ItemTemplateLocaleEntity(
              id: entry,
              locale: d['locale'] ?? '',
              description: d['description'] ?? '',
            ),
          )
          .toList();
      await repo.saveItemTemplateLocales(entry, locales);
    },
  );

  static final questTemplate = DatabaseLocaleEditorDelegate(
    fields: [
      'locale',
      'title',
      'details',
      'objectives',
      'endText',
      'completedText',
      'objectiveText1',
      'objectiveText2',
      'objectiveText3',
      'objectiveText4',
    ],
    fieldLabels: [
      '语言',
      '标题',
      '详情',
      '目标',
      '结束文本',
      '完成文本',
      '目标文本1',
      '目标文本2',
      '目标文本3',
      '目标文本4',
    ],
    onLoad: (entry) async {
      final repo = GetIt.instance.get<QuestTemplateLocaleRepository>();
      final locales = await repo.getQuestTemplateLocales(entry);
      return locales
          .map(
            (e) => {
              'locale': e.locale,
              'title': e.title,
              'details': e.details,
              'objectives': e.objectives,
              'endText': e.endText,
              'completedText': e.completedText,
              'objectiveText1': e.objectiveText1,
              'objectiveText2': e.objectiveText2,
              'objectiveText3': e.objectiveText3,
              'objectiveText4': e.objectiveText4,
            },
          )
          .toList();
    },
    onSave: (entry, data) async {
      final repo = GetIt.instance.get<QuestTemplateLocaleRepository>();
      final locales = data
          .map(
            (d) => QuestTemplateLocaleEntity(
              id: entry,
              locale: d['locale'] ?? '',
              title: d['title'] ?? '',
              details: d['details'] ?? '',
              objectives: d['objectives'] ?? '',
              endText: d['endText'] ?? '',
              completedText: d['completedText'] ?? '',
              objectiveText1: d['objectiveText1'] ?? '',
              objectiveText2: d['objectiveText2'] ?? '',
              objectiveText3: d['objectiveText3'] ?? '',
              objectiveText4: d['objectiveText4'] ?? '',
            ),
          )
          .toList();
      await repo.saveQuestTemplateLocales(entry, locales);
    },
  );

  static final questOfferReward = DatabaseLocaleEditorDelegate(
    fields: ['locale', 'rewardText'],
    fieldLabels: ['语言', '奖励文本'],
    onLoad: (entry) async {
      final repo = GetIt.instance.get<QuestOfferRewardLocaleRepository>();
      final locales = await repo.getQuestOfferRewardLocales(entry);
      return locales
          .map((e) => {'locale': e.locale, 'rewardText': e.rewardText})
          .toList();
    },
    onSave: (entry, data) async {
      final repo = GetIt.instance.get<QuestOfferRewardLocaleRepository>();
      final locales = data
          .map(
            (d) => QuestOfferRewardLocaleEntity(
              id: entry,
              locale: d['locale'] ?? '',
              rewardText: d['rewardText'] ?? '',
            ),
          )
          .toList();
      await repo.saveQuestOfferRewardLocales(entry, locales);
    },
  );

  static final questRequestItems = DatabaseLocaleEditorDelegate(
    fields: ['locale', 'completionText'],
    fieldLabels: ['语言', '完成文本'],
    onLoad: (entry) async {
      final repo = GetIt.instance.get<QuestRequestItemsLocaleRepository>();
      final locales = await repo.getQuestRequestItemsLocales(entry);
      return locales
          .map((e) => {'locale': e.locale, 'completionText': e.completionText})
          .toList();
    },
    onSave: (entry, data) async {
      final repo = GetIt.instance.get<QuestRequestItemsLocaleRepository>();
      final locales = data
          .map(
            (d) => QuestRequestItemsLocaleEntity(
              id: entry,
              locale: d['locale'] ?? '',
              completionText: d['completionText'] ?? '',
            ),
          )
          .toList();
      await repo.saveQuestRequestItemsLocales(entry, locales);
    },
  );

  // ---------------------------------------------------------------------------
  // DBC 宽表本地化字段（每个字段独立 Delegate）
  // ---------------------------------------------------------------------------

  static final dbcAchievementTitle = _dbc(
    DbcLocaleFields.achievementTitle,
    () => GetIt.instance.get<AchievementRepository>(),
    (repo, id, field) => repo.getAchievementLocales(id, field),
    (repo, id, field, values) => repo.saveAchievementLocales(id, field, values),
  );

  static final dbcAchievementDescription = _dbc(
    DbcLocaleFields.achievementDescription,
    () => GetIt.instance.get<AchievementRepository>(),
    (repo, id, field) => repo.getAchievementLocales(id, field),
    (repo, id, field, values) => repo.saveAchievementLocales(id, field, values),
  );

  static final dbcAchievementReward = _dbc(
    DbcLocaleFields.achievementReward,
    () => GetIt.instance.get<AchievementRepository>(),
    (repo, id, field) => repo.getAchievementLocales(id, field),
    (repo, id, field, values) => repo.saveAchievementLocales(id, field, values),
  );

  static final dbcAchievementCategoryName = _dbc(
    DbcLocaleFields.achievementCategoryName,
    () => GetIt.instance.get<AchievementCategoryRepository>(),
    (repo, id, field) => repo.getAchievementCategoryLocales(id, field),
    (repo, id, field, values) =>
        repo.saveAchievementCategoryLocales(id, field, values),
  );

  static final dbcAchievementCriteriaDescription = _dbc(
    DbcLocaleFields.achievementCriteriaDescription,
    () => GetIt.instance.get<AchievementCriteriaRepository>(),
    (repo, id, field) => repo.getAchievementCriteriaLocales(id, field),
    (repo, id, field, values) =>
        repo.saveAchievementCriteriaLocales(id, field, values),
  );

  static final dbcAreaTableAreaName = _dbc(
    DbcLocaleFields.areaTableAreaName,
    () => GetIt.instance.get<AreaTableRepository>(),
    (repo, id, field) => repo.getAreaTableLocales(id, field),
    (repo, id, field, values) => repo.saveAreaTableLocales(id, field, values),
  );

  static final dbcCharTitlesName = _dbc(
    DbcLocaleFields.charTitlesName,
    () => GetIt.instance.get<CharTitleRepository>(),
    (repo, id, field) => repo.getCharTitleLocales(id, field),
    (repo, id, field, values) => repo.saveCharTitleLocales(id, field, values),
  );

  static final dbcCharTitlesName1 = _dbc(
    DbcLocaleFields.charTitlesName1,
    () => GetIt.instance.get<CharTitleRepository>(),
    (repo, id, field) => repo.getCharTitleLocales(id, field),
    (repo, id, field, values) => repo.saveCharTitleLocales(id, field, values),
  );

  static final dbcCurrencyCategoryName = _dbc(
    DbcLocaleFields.currencyCategoryName,
    () => GetIt.instance.get<CurrencyCategoryRepository>(),
    (repo, id, field) => repo.getCurrencyCategoryLocales(id, field),
    (repo, id, field, values) =>
        repo.saveCurrencyCategoryLocales(id, field, values),
  );

  static final dbcFactionName = _dbc(
    DbcLocaleFields.factionName,
    () => GetIt.instance.get<DbcFactionRepository>(),
    (repo, id, field) => repo.getDbcFactionLocales(id, field),
    (repo, id, field, values) => repo.saveDbcFactionLocales(id, field, values),
  );

  static final dbcFactionDescription = _dbc(
    DbcLocaleFields.factionDescription,
    () => GetIt.instance.get<DbcFactionRepository>(),
    (repo, id, field) => repo.getDbcFactionLocales(id, field),
    (repo, id, field, values) => repo.saveDbcFactionLocales(id, field, values),
  );

  static final dbcEmotesTextDataText = _dbc(
    DbcLocaleFields.emotesTextDataText,
    () => GetIt.instance.get<EmoteTextDataRepository>(),
    (repo, id, field) => repo.getEmoteTextDataLocales(id, field),
    (repo, id, field, values) =>
        repo.saveEmoteTextDataLocales(id, field, values),
  );

  static final dbcMailTemplateSubject = _dbc(
    DbcLocaleFields.mailTemplateSubject,
    () => GetIt.instance.get<MailTemplateRepository>(),
    (repo, id, field) => repo.getMailTemplateLocales(id, field),
    (repo, id, field, values) =>
        repo.saveMailTemplateLocales(id, field, values),
  );

  static final dbcMailTemplateBody = _dbc(
    DbcLocaleFields.mailTemplateBody,
    () => GetIt.instance.get<MailTemplateRepository>(),
    (repo, id, field) => repo.getMailTemplateLocales(id, field),
    (repo, id, field, values) =>
        repo.saveMailTemplateLocales(id, field, values),
  );

  static final dbcItemRandomPropertiesName = _dbc(
    DbcLocaleFields.itemRandomPropertiesName,
    () => GetIt.instance.get<ItemRandomPropertiesRepository>(),
    (repo, id, field) => repo.getItemRandomPropertiesLocales(id, field),
    (repo, id, field, values) =>
        repo.saveItemRandomPropertiesLocales(id, field, values),
  );

  static final dbcItemRandomSuffixName = _dbc(
    DbcLocaleFields.itemRandomSuffixName,
    () => GetIt.instance.get<ItemRandomSuffixRepository>(),
    (repo, id, field) => repo.getItemRandomSuffixLocales(id, field),
    (repo, id, field, values) =>
        repo.saveItemRandomSuffixLocales(id, field, values),
  );

  static final dbcItemSetName = _dbc(
    DbcLocaleFields.itemSetName,
    () => GetIt.instance.get<ItemSetRepository>(),
    (repo, id, field) => repo.getItemSetLocales(id, field),
    (repo, id, field, values) => repo.saveItemSetLocales(id, field, values),
  );

  static final dbcMapMapName = _dbc(
    DbcLocaleFields.mapMapName,
    () => GetIt.instance.get<MapInfoRepository>(),
    (repo, id, field) => repo.getMapInfoLocales(id, field),
    (repo, id, field, values) => repo.saveMapInfoLocales(id, field, values),
  );

  static final dbcMapMapDescription0 = _dbc(
    DbcLocaleFields.mapMapDescription0,
    () => GetIt.instance.get<MapInfoRepository>(),
    (repo, id, field) => repo.getMapInfoLocales(id, field),
    (repo, id, field, values) => repo.saveMapInfoLocales(id, field, values),
  );

  static final dbcMapMapDescription1 = _dbc(
    DbcLocaleFields.mapMapDescription1,
    () => GetIt.instance.get<MapInfoRepository>(),
    (repo, id, field) => repo.getMapInfoLocales(id, field),
    (repo, id, field, values) => repo.saveMapInfoLocales(id, field, values),
  );

  static final dbcQuestInfoInfoName = _dbc(
    DbcLocaleFields.questInfoInfoName,
    () => GetIt.instance.get<QuestInfoRepository>(),
    (repo, id, field) => repo.getQuestInfoLocales(id, field),
    (repo, id, field, values) => repo.saveQuestInfoLocales(id, field, values),
  );

  static final dbcQuestSortSortName = _dbc(
    DbcLocaleFields.questSortSortName,
    () => GetIt.instance.get<QuestSortRepository>(),
    (repo, id, field) => repo.getQuestSortLocales(id, field),
    (repo, id, field, values) => repo.saveQuestSortLocales(id, field, values),
  );

  static final dbcSpellName = _dbc(
    DbcLocaleFields.spellName,
    () => GetIt.instance.get<SpellRepository>(),
    (repo, id, field) => repo.getSpellLocales(id, field),
    (repo, id, field, values) => repo.saveSpellLocales(id, field, values),
  );

  static final dbcSpellNameSubtext = _dbc(
    DbcLocaleFields.spellNameSubtext,
    () => GetIt.instance.get<SpellRepository>(),
    (repo, id, field) => repo.getSpellLocales(id, field),
    (repo, id, field, values) => repo.saveSpellLocales(id, field, values),
  );

  static final dbcSpellDescription = _dbc(
    DbcLocaleFields.spellDescription,
    () => GetIt.instance.get<SpellRepository>(),
    (repo, id, field) => repo.getSpellLocales(id, field),
    (repo, id, field, values) => repo.saveSpellLocales(id, field, values),
  );

  static final dbcSpellAuraDescription = _dbc(
    DbcLocaleFields.spellAuraDescription,
    () => GetIt.instance.get<SpellRepository>(),
    (repo, id, field) => repo.getSpellLocales(id, field),
    (repo, id, field, values) => repo.saveSpellLocales(id, field, values),
  );

  static final dbcTalentTabName = _dbc(
    DbcLocaleFields.talentTabName,
    () => GetIt.instance.get<TalentTabRepository>(),
    (repo, id, field) => repo.getTalentTabLocales(id, field),
    (repo, id, field, values) => repo.saveTalentTabLocales(id, field, values),
  );

  static final dbcSpellItemEnchantmentName = _dbc(
    DbcLocaleFields.spellItemEnchantmentName,
    () => GetIt.instance.get<SpellItemEnchantmentRepository>(),
    (repo, id, field) => repo.getSpellItemEnchantmentLocales(id, field),
    (repo, id, field, values) =>
        repo.saveSpellItemEnchantmentLocales(id, field, values),
  );

  static final dbcSpellRangeDisplayName = _dbc(
    DbcLocaleFields.spellRangeDisplayName,
    () => GetIt.instance.get<SpellRangeRepository>(),
    (repo, id, field) => repo.getSpellRangeLocales(id, field),
    (repo, id, field, values) => repo.saveSpellRangeLocales(id, field, values),
  );

  static final dbcSpellRangeDisplayNameShort = _dbc(
    DbcLocaleFields.spellRangeDisplayNameShort,
    () => GetIt.instance.get<SpellRangeRepository>(),
    (repo, id, field) => repo.getSpellRangeLocales(id, field),
    (repo, id, field, values) => repo.saveSpellRangeLocales(id, field, values),
  );

  static DbcLocaleFieldEditorDelegate _dbc<T>(
    DbcLocaleFieldDefinition field,
    T Function() repoOf,
    Future<List<DbcLocaleFieldValue>> Function(
      T repo,
      int id,
      DbcLocaleFieldDefinition field,
    )
    onLoad,
    Future<void> Function(
      T repo,
      int id,
      DbcLocaleFieldDefinition field,
      List<DbcLocaleFieldValue> values,
    )
    onSave,
  ) {
    return DbcLocaleFieldEditorDelegate(
      field: field,
      onLoad: (entry) => onLoad(repoOf(), entry, field),
      onSave: (entry, values) => onSave(repoOf(), entry, field, values),
    );
  }
}
