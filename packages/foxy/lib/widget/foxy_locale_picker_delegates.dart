import 'package:foxy/constant/dbc_locale_fields.dart';
import 'package:foxy/entity/creature_template_locale_entity.dart';
import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/entity/game_object_template_locale_entity.dart';
import 'package:foxy/entity/gossip_menu_option_entity.dart';
import 'package:foxy/entity/gossip_menu_option_locale_entity.dart';
import 'package:foxy/entity/item_template_locale_entity.dart';
import 'package:foxy/entity/npc_text_locale_entity.dart';
import 'package:foxy/entity/page_text_locale_entity.dart';
import 'package:foxy/entity/quest_offer_reward_locale_entity.dart';
import 'package:foxy/entity/quest_request_items_locale_entity.dart';
import 'package:foxy/entity/quest_template_locale_entity.dart';
import 'package:foxy/infrastructure/errors/foxy_exceptions.dart';
import 'package:foxy/repository/achievement_category_repository.dart';
import 'package:foxy/repository/achievement_criteria_repository.dart';
import 'package:foxy/repository/achievement_repository.dart';
import 'package:foxy/repository/area_table_repository.dart';
import 'package:foxy/repository/char_title_repository.dart';
import 'package:foxy/repository/creature_template_locale_repository.dart';
import 'package:foxy/repository/currency_category_repository.dart';
import 'package:foxy/repository/dbc_faction_repository.dart';
import 'package:foxy/repository/emote_text_data_repository.dart';
import 'package:foxy/repository/game_object_template_locale_repository.dart';
import 'package:foxy/repository/gossip_menu_option_locale_repository.dart';
import 'package:foxy/repository/item_random_properties_repository.dart';
import 'package:foxy/repository/item_random_suffix_repository.dart';
import 'package:foxy/repository/item_set_repository.dart';
import 'package:foxy/repository/item_template_locale_repository.dart';
import 'package:foxy/repository/mail_template_repository.dart';
import 'package:foxy/repository/map_info_repository.dart';
import 'package:foxy/repository/npc_text_locale_repository.dart';
import 'package:foxy/repository/page_text_locale_repository.dart';
import 'package:foxy/repository/quest_info_repository.dart';
import 'package:foxy/repository/quest_offer_reward_locale_repository.dart';
import 'package:foxy/repository/quest_request_items_locale_repository.dart';
import 'package:foxy/repository/quest_sort_repository.dart';
import 'package:foxy/repository/quest_template_locale_repository.dart';
import 'package:foxy/repository/skill_line_category_repository.dart';
import 'package:foxy/repository/skill_line_repository.dart';
import 'package:foxy/repository/spell_item_enchantment_repository.dart';
import 'package:foxy/repository/spell_range_repository.dart';
import 'package:foxy/repository/spell_repository.dart';
import 'package:foxy/repository/talent_tab_repository.dart';
import 'package:foxy/widget/database_locale_changes.dart';
import 'package:foxy/widget/foxy_locale_picker.dart';
import 'package:get_it/get_it.dart';

/// Registry of locale-picker delegates, centralizing each module's
/// load/save config.
///
/// Follows the [FoxyEntityPickerDelegates] pattern: one instance delegate
/// per entity, pure data + closures, no mutable state, shareable by
/// multiple [FoxyLocalePicker]s. Static getters forward to the singleton
/// so call sites stay unchanged.
class FoxyLocalePickerDelegates {
  static final instance = FoxyLocalePickerDelegates._();

  FoxyLocalePickerDelegates._();

  late final _creatureTemplateName = _creatureTemplateField('name', '名称');
  static DatabaseLocaleEditorDelegate get creatureTemplateName =>
      instance._creatureTemplateName;
  late final _creatureTemplateTitle = _creatureTemplateField('title', '称号');
  static DatabaseLocaleEditorDelegate get creatureTemplateTitle =>
      instance._creatureTemplateTitle;

  late final _gameObjectName = DatabaseLocaleEditorDelegate(
    fields: ['locale', 'name'],
    fieldLabels: ['语言', '名称'],
    onLoad: (entry) => _loadGameObjectTemplateLocaleRows(
      entry,
      (locale) => {'locale': locale.locale, 'name': locale.name},
    ),
    onSave: (entry, changes) async {
      final repo = GetIt.instance.get<GameObjectTemplateLocaleRepository>();
      final creations = <GameObjectTemplateLocaleEntity>[];
      final updates =
          <GameObjectTemplateLocaleKey, GameObjectTemplateLocaleEntity>{};
      for (final row in changes.rows) {
        final d = row.values;
        final originalLocale = row.originalLocale;
        if (originalLocale == null) {
          creations.add(
            GameObjectTemplateLocaleEntity(
              entry: entry,
              locale: d['locale'] ?? '',
              name: d['name'] ?? '',
            ),
          );
          continue;
        }
        final originalKey = GameObjectTemplateLocaleKey(
          entry: entry,
          locale: originalLocale,
        );
        final existing = await repo.getGameObjectTemplateLocale(originalKey);
        if (existing == null) {
          throw RecordNotFoundException('record not found');
        }
        updates[originalKey] = existing.copyWith(
          locale: d['locale'] ?? '',
          name: d['name'] ?? '',
        );
      }
      await repo.applyGameObjectTemplateLocaleChanges(
        creations: creations,
        deletions: changes.deletedLocales
            .map(
              (locale) =>
                  GameObjectTemplateLocaleKey(entry: entry, locale: locale),
            )
            .toList(),
        updates: updates,
      );
    },
  );
  static DatabaseLocaleEditorDelegate get gameObjectName =>
      instance._gameObjectName;

  late final _npcTextText00 = _npcTextField('text00', '文本0-0');
  static DatabaseLocaleEditorDelegate get npcTextText00 =>
      instance._npcTextText00;
  late final _npcTextText01 = _npcTextField('text01', '文本0-1');
  static DatabaseLocaleEditorDelegate get npcTextText01 =>
      instance._npcTextText01;
  late final _npcTextText10 = _npcTextField('text10', '文本1-0');
  static DatabaseLocaleEditorDelegate get npcTextText10 =>
      instance._npcTextText10;
  late final _npcTextText11 = _npcTextField('text11', '文本1-1');
  static DatabaseLocaleEditorDelegate get npcTextText11 =>
      instance._npcTextText11;
  late final _npcTextText20 = _npcTextField('text20', '文本2-0');
  static DatabaseLocaleEditorDelegate get npcTextText20 =>
      instance._npcTextText20;
  late final _npcTextText21 = _npcTextField('text21', '文本2-1');
  static DatabaseLocaleEditorDelegate get npcTextText21 =>
      instance._npcTextText21;
  late final _npcTextText30 = _npcTextField('text30', '文本3-0');
  static DatabaseLocaleEditorDelegate get npcTextText30 =>
      instance._npcTextText30;
  late final _npcTextText31 = _npcTextField('text31', '文本3-1');
  static DatabaseLocaleEditorDelegate get npcTextText31 =>
      instance._npcTextText31;
  late final _npcTextText40 = _npcTextField('text40', '文本4-0');
  static DatabaseLocaleEditorDelegate get npcTextText40 =>
      instance._npcTextText40;
  late final _npcTextText41 = _npcTextField('text41', '文本4-1');
  static DatabaseLocaleEditorDelegate get npcTextText41 =>
      instance._npcTextText41;
  late final _npcTextText50 = _npcTextField('text50', '文本5-0');
  static DatabaseLocaleEditorDelegate get npcTextText50 =>
      instance._npcTextText50;
  late final _npcTextText51 = _npcTextField('text51', '文本5-1');
  static DatabaseLocaleEditorDelegate get npcTextText51 =>
      instance._npcTextText51;
  late final _npcTextText60 = _npcTextField('text60', '文本6-0');
  static DatabaseLocaleEditorDelegate get npcTextText60 =>
      instance._npcTextText60;
  late final _npcTextText61 = _npcTextField('text61', '文本6-1');
  static DatabaseLocaleEditorDelegate get npcTextText61 =>
      instance._npcTextText61;
  late final _npcTextText70 = _npcTextField('text70', '文本7-0');
  static DatabaseLocaleEditorDelegate get npcTextText70 =>
      instance._npcTextText70;
  late final _npcTextText71 = _npcTextField('text71', '文本7-1');
  static DatabaseLocaleEditorDelegate get npcTextText71 =>
      instance._npcTextText71;

  late final _gossipMenuOptionOptionText = CompositeKeyLocaleEditorDelegate(
    fields: ['locale', 'optionText'],
    fieldLabels: ['语言', '选项文本'],
    onLoad: (key) =>
        _loadGossipMenuOptionLocaleRows(key as GossipMenuOptionKey),
    onSave: (key, changes) => _saveGossipMenuOptionLocaleField(
      key as GossipMenuOptionKey,
      changes,
      'optionText',
    ),
  );
  static CompositeKeyLocaleEditorDelegate get gossipMenuOptionOptionText =>
      instance._gossipMenuOptionOptionText;
  late final _gossipMenuOptionBoxText = CompositeKeyLocaleEditorDelegate(
    fields: ['locale', 'boxText'],
    fieldLabels: ['语言', '确认文本'],
    onLoad: (key) =>
        _loadGossipMenuOptionLocaleRows(key as GossipMenuOptionKey),
    onSave: (key, changes) => _saveGossipMenuOptionLocaleField(
      key as GossipMenuOptionKey,
      changes,
      'boxText',
    ),
  );
  static CompositeKeyLocaleEditorDelegate get gossipMenuOptionBoxText =>
      instance._gossipMenuOptionBoxText;

  late final _gameObjectCaption = DatabaseLocaleEditorDelegate(
    fields: ['locale', 'castBarCaption'],
    fieldLabels: ['语言', '使用说明'],
    onLoad: (entry) => _loadGameObjectTemplateLocaleRows(
      entry,
      (locale) => {
        'locale': locale.locale,
        'castBarCaption': locale.castBarCaption,
      },
    ),
    onSave: (entry, changes) async {
      final repo = GetIt.instance.get<GameObjectTemplateLocaleRepository>();
      final creations = <GameObjectTemplateLocaleEntity>[];
      final updates =
          <GameObjectTemplateLocaleKey, GameObjectTemplateLocaleEntity>{};
      for (final row in changes.rows) {
        final d = row.values;
        final originalLocale = row.originalLocale;
        if (originalLocale == null) {
          creations.add(
            GameObjectTemplateLocaleEntity(
              entry: entry,
              locale: d['locale'] ?? '',
              castBarCaption: d['castBarCaption'] ?? '',
            ),
          );
          continue;
        }
        final originalKey = GameObjectTemplateLocaleKey(
          entry: entry,
          locale: originalLocale,
        );
        final existing = await repo.getGameObjectTemplateLocale(originalKey);
        if (existing == null) {
          throw RecordNotFoundException('record not found');
        }
        updates[originalKey] = existing.copyWith(
          locale: d['locale'] ?? '',
          castBarCaption: d['castBarCaption'] ?? '',
        );
      }
      await repo.applyGameObjectTemplateLocaleChanges(
        creations: creations,
        deletions: changes.deletedLocales
            .map(
              (locale) =>
                  GameObjectTemplateLocaleKey(entry: entry, locale: locale),
            )
            .toList(),
        updates: updates,
      );
    },
  );
  static DatabaseLocaleEditorDelegate get gameObjectCaption =>
      instance._gameObjectCaption;

  late final _itemName = DatabaseLocaleEditorDelegate(
    fields: ['locale', 'name'],
    fieldLabels: ['语言', '名称'],
    onLoad: (entry) => _loadItemTemplateLocaleRows(
      entry,
      (locale) => {'locale': locale.locale, 'name': locale.name},
    ),
    onSave: (entry, changes) async {
      final repo = GetIt.instance.get<ItemTemplateLocaleRepository>();
      final creations = <ItemTemplateLocaleEntity>[];
      final updates = <ItemTemplateLocaleKey, ItemTemplateLocaleEntity>{};
      for (final row in changes.rows) {
        final d = row.values;
        final originalLocale = row.originalLocale;
        if (originalLocale == null) {
          creations.add(
            ItemTemplateLocaleEntity(
              id: entry,
              locale: d['locale'] ?? '',
              name: d['name'] ?? '',
            ),
          );
          continue;
        }
        final originalKey = ItemTemplateLocaleKey(
          id: entry,
          locale: originalLocale,
        );
        final existing = await repo.getItemTemplateLocale(originalKey);
        if (existing == null) {
          throw RecordNotFoundException('record not found');
        }
        updates[originalKey] = existing.copyWith(
          locale: d['locale'] ?? '',
          name: d['name'] ?? '',
        );
      }
      await repo.applyItemTemplateLocaleChanges(
        creations: creations,
        deletions: changes.deletedLocales
            .map((locale) => ItemTemplateLocaleKey(id: entry, locale: locale))
            .toList(),
        updates: updates,
      );
    },
  );
  static DatabaseLocaleEditorDelegate get itemName => instance._itemName;

  late final _itemDescription = DatabaseLocaleEditorDelegate(
    fields: ['locale', 'description'],
    fieldLabels: ['语言', '描述'],
    onLoad: (entry) => _loadItemTemplateLocaleRows(
      entry,
      (locale) => {'locale': locale.locale, 'description': locale.description},
    ),
    onSave: (entry, changes) async {
      final repo = GetIt.instance.get<ItemTemplateLocaleRepository>();
      final creations = <ItemTemplateLocaleEntity>[];
      final updates = <ItemTemplateLocaleKey, ItemTemplateLocaleEntity>{};
      for (final row in changes.rows) {
        final d = row.values;
        final originalLocale = row.originalLocale;
        if (originalLocale == null) {
          creations.add(
            ItemTemplateLocaleEntity(
              id: entry,
              locale: d['locale'] ?? '',
              description: d['description'] ?? '',
            ),
          );
          continue;
        }
        final originalKey = ItemTemplateLocaleKey(
          id: entry,
          locale: originalLocale,
        );
        final existing = await repo.getItemTemplateLocale(originalKey);
        if (existing == null) {
          throw RecordNotFoundException('record not found');
        }
        updates[originalKey] = existing.copyWith(
          locale: d['locale'] ?? '',
          description: d['description'] ?? '',
        );
      }
      await repo.applyItemTemplateLocaleChanges(
        creations: creations,
        deletions: changes.deletedLocales
            .map((locale) => ItemTemplateLocaleKey(id: entry, locale: locale))
            .toList(),
        updates: updates,
      );
    },
  );
  static DatabaseLocaleEditorDelegate get itemDescription =>
      instance._itemDescription;

  late final _pageTextText = DatabaseLocaleEditorDelegate(
    fields: ['locale', 'text'],
    fieldLabels: ['语言', '文本'],
    onLoad: _loadPageTextLocaleRows,
    onSave: (entry, changes) async {
      final repo = GetIt.instance.get<PageTextLocaleRepository>();
      final creations = <PageTextLocaleEntity>[];
      final updates = <PageTextLocaleKey, PageTextLocaleEntity>{};
      for (final row in changes.rows) {
        final d = row.values;
        final originalLocale = row.originalLocale;
        if (originalLocale == null) {
          creations.add(
            PageTextLocaleEntity(
              id: entry,
              locale: d['locale'] ?? '',
              text: d['text'] ?? '',
            ),
          );
          continue;
        }
        final originalKey = PageTextLocaleKey(
          id: entry,
          locale: originalLocale,
        );
        final existing = await repo.getPageTextLocale(originalKey);
        if (existing == null) {
          throw RecordNotFoundException('record not found');
        }
        updates[originalKey] = existing.copyWith(
          locale: d['locale'] ?? '',
          text: d['text'] ?? '',
        );
      }
      await repo.applyPageTextLocaleChanges(
        creations: creations,
        deletions: changes.deletedLocales
            .map((locale) => PageTextLocaleKey(id: entry, locale: locale))
            .toList(),
        updates: updates,
      );
    },
  );
  static DatabaseLocaleEditorDelegate get pageTextText =>
      instance._pageTextText;

  late final _questTemplateTitle = _questTemplateField('title', '标题');
  static DatabaseLocaleEditorDelegate get questTemplateTitle =>
      instance._questTemplateTitle;
  late final _questTemplateDetails = _questTemplateField('details', '详情');
  static DatabaseLocaleEditorDelegate get questTemplateDetails =>
      instance._questTemplateDetails;
  late final _questTemplateObjectives = _questTemplateField('objectives', '目标');
  static DatabaseLocaleEditorDelegate get questTemplateObjectives =>
      instance._questTemplateObjectives;
  late final _questTemplateEndText = _questTemplateField('endText', '结束文本');
  static DatabaseLocaleEditorDelegate get questTemplateEndText =>
      instance._questTemplateEndText;
  late final _questTemplateCompletedText = _questTemplateField(
    'completedText',
    '完成文本',
  );
  static DatabaseLocaleEditorDelegate get questTemplateCompletedText =>
      instance._questTemplateCompletedText;
  late final _questTemplateObjectiveText1 = _questTemplateField(
    'objectiveText1',
    '目标文本1',
  );
  static DatabaseLocaleEditorDelegate get questTemplateObjectiveText1 =>
      instance._questTemplateObjectiveText1;
  late final _questTemplateObjectiveText2 = _questTemplateField(
    'objectiveText2',
    '目标文本2',
  );
  static DatabaseLocaleEditorDelegate get questTemplateObjectiveText2 =>
      instance._questTemplateObjectiveText2;
  late final _questTemplateObjectiveText3 = _questTemplateField(
    'objectiveText3',
    '目标文本3',
  );
  static DatabaseLocaleEditorDelegate get questTemplateObjectiveText3 =>
      instance._questTemplateObjectiveText3;
  late final _questTemplateObjectiveText4 = _questTemplateField(
    'objectiveText4',
    '目标文本4',
  );
  static DatabaseLocaleEditorDelegate get questTemplateObjectiveText4 =>
      instance._questTemplateObjectiveText4;

  late final _questOfferReward = DatabaseLocaleEditorDelegate(
    fields: ['locale', 'rewardText'],
    fieldLabels: ['语言', '奖励文本'],
    onLoad: _loadQuestOfferRewardLocaleRows,
    onSave: (entry, changes) async {
      final repo = GetIt.instance.get<QuestOfferRewardLocaleRepository>();
      final creations = <QuestOfferRewardLocaleEntity>[];
      final updates =
          <QuestOfferRewardLocaleKey, QuestOfferRewardLocaleEntity>{};
      for (final row in changes.rows) {
        final d = row.values;
        final originalLocale = row.originalLocale;
        if (originalLocale == null) {
          creations.add(
            QuestOfferRewardLocaleEntity(
              id: entry,
              locale: d['locale'] ?? '',
              rewardText: d['rewardText'] ?? '',
            ),
          );
          continue;
        }
        final originalKey = QuestOfferRewardLocaleKey(
          id: entry,
          locale: originalLocale,
        );
        final existing = await repo.getQuestOfferRewardLocale(originalKey);
        if (existing == null) {
          throw RecordNotFoundException('record not found');
        }
        updates[originalKey] = existing.copyWith(
          locale: d['locale'] ?? '',
          rewardText: d['rewardText'] ?? '',
        );
      }
      await repo.applyQuestOfferRewardLocaleChanges(
        creations: creations,
        deletions: changes.deletedLocales
            .map(
              (locale) => QuestOfferRewardLocaleKey(id: entry, locale: locale),
            )
            .toList(),
        updates: updates,
      );
    },
  );
  static DatabaseLocaleEditorDelegate get questOfferReward =>
      instance._questOfferReward;

  late final _questRequestItems = DatabaseLocaleEditorDelegate(
    fields: ['locale', 'completionText'],
    fieldLabels: ['语言', '完成文本'],
    onLoad: _loadQuestRequestItemsLocaleRows,
    onSave: (entry, changes) async {
      final repo = GetIt.instance.get<QuestRequestItemsLocaleRepository>();
      final creations = <QuestRequestItemsLocaleEntity>[];
      final updates =
          <QuestRequestItemsLocaleKey, QuestRequestItemsLocaleEntity>{};
      for (final row in changes.rows) {
        final d = row.values;
        final originalLocale = row.originalLocale;
        if (originalLocale == null) {
          creations.add(
            QuestRequestItemsLocaleEntity(
              id: entry,
              locale: d['locale'] ?? '',
              completionText: d['completionText'] ?? '',
            ),
          );
          continue;
        }
        final originalKey = QuestRequestItemsLocaleKey(
          id: entry,
          locale: originalLocale,
        );
        final existing = await repo.getQuestRequestItemsLocale(originalKey);
        if (existing == null) {
          throw RecordNotFoundException('record not found');
        }
        updates[originalKey] = existing.copyWith(
          locale: d['locale'] ?? '',
          completionText: d['completionText'] ?? '',
        );
      }
      await repo.applyQuestRequestItemsLocaleChanges(
        creations: creations,
        deletions: changes.deletedLocales
            .map(
              (locale) => QuestRequestItemsLocaleKey(id: entry, locale: locale),
            )
            .toList(),
        updates: updates,
      );
    },
  );
  static DatabaseLocaleEditorDelegate get questRequestItems =>
      instance._questRequestItems;

  // ---------------------------------------------------------------------------
  // DBC wide-table locale fields (one independent Delegate per field)
  // ---------------------------------------------------------------------------

  late final _dbcAchievementTitle = _dbc(
    DbcLocaleFields.achievementTitle,
    () => GetIt.instance.get<AchievementRepository>(),
    (repo, id, field) => repo.getAchievementLocales(id, field),
    (repo, id, field, values) => repo.saveAchievementLocales(id, field, values),
  );
  static DbcLocaleFieldEditorDelegate get dbcAchievementTitle =>
      instance._dbcAchievementTitle;

  late final _dbcAchievementDescription = _dbc(
    DbcLocaleFields.achievementDescription,
    () => GetIt.instance.get<AchievementRepository>(),
    (repo, id, field) => repo.getAchievementLocales(id, field),
    (repo, id, field, values) => repo.saveAchievementLocales(id, field, values),
  );
  static DbcLocaleFieldEditorDelegate get dbcAchievementDescription =>
      instance._dbcAchievementDescription;

  late final _dbcAchievementReward = _dbc(
    DbcLocaleFields.achievementReward,
    () => GetIt.instance.get<AchievementRepository>(),
    (repo, id, field) => repo.getAchievementLocales(id, field),
    (repo, id, field, values) => repo.saveAchievementLocales(id, field, values),
  );
  static DbcLocaleFieldEditorDelegate get dbcAchievementReward =>
      instance._dbcAchievementReward;

  late final _dbcAchievementCategoryName = _dbc(
    DbcLocaleFields.achievementCategoryName,
    () => GetIt.instance.get<AchievementCategoryRepository>(),
    (repo, id, field) => repo.getAchievementCategoryLocales(id, field),
    (repo, id, field, values) =>
        repo.saveAchievementCategoryLocales(id, field, values),
  );
  static DbcLocaleFieldEditorDelegate get dbcAchievementCategoryName =>
      instance._dbcAchievementCategoryName;

  late final _dbcAchievementCriteriaDescription = _dbc(
    DbcLocaleFields.achievementCriteriaDescription,
    () => GetIt.instance.get<AchievementCriteriaRepository>(),
    (repo, id, field) => repo.getAchievementCriteriaLocales(id, field),
    (repo, id, field, values) =>
        repo.saveAchievementCriteriaLocales(id, field, values),
  );
  static DbcLocaleFieldEditorDelegate get dbcAchievementCriteriaDescription =>
      instance._dbcAchievementCriteriaDescription;

  late final _dbcAreaTableAreaName = _dbc(
    DbcLocaleFields.areaTableAreaName,
    () => GetIt.instance.get<AreaTableRepository>(),
    (repo, id, field) => repo.getAreaTableLocales(id, field),
    (repo, id, field, values) => repo.saveAreaTableLocales(id, field, values),
  );
  static DbcLocaleFieldEditorDelegate get dbcAreaTableAreaName =>
      instance._dbcAreaTableAreaName;

  late final _dbcCharTitlesName = _dbc(
    DbcLocaleFields.charTitlesName,
    () => GetIt.instance.get<CharTitleRepository>(),
    (repo, id, field) => repo.getCharTitleLocales(id, field),
    (repo, id, field, values) => repo.saveCharTitleLocales(id, field, values),
  );
  static DbcLocaleFieldEditorDelegate get dbcCharTitlesName =>
      instance._dbcCharTitlesName;

  late final _dbcCharTitlesName1 = _dbc(
    DbcLocaleFields.charTitlesName1,
    () => GetIt.instance.get<CharTitleRepository>(),
    (repo, id, field) => repo.getCharTitleLocales(id, field),
    (repo, id, field, values) => repo.saveCharTitleLocales(id, field, values),
  );
  static DbcLocaleFieldEditorDelegate get dbcCharTitlesName1 =>
      instance._dbcCharTitlesName1;

  late final _dbcCurrencyCategoryName = _dbc(
    DbcLocaleFields.currencyCategoryName,
    () => GetIt.instance.get<CurrencyCategoryRepository>(),
    (repo, id, field) => repo.getCurrencyCategoryLocales(id, field),
    (repo, id, field, values) =>
        repo.saveCurrencyCategoryLocales(id, field, values),
  );
  static DbcLocaleFieldEditorDelegate get dbcCurrencyCategoryName =>
      instance._dbcCurrencyCategoryName;

  late final _dbcFactionName = _dbc(
    DbcLocaleFields.factionName,
    () => GetIt.instance.get<DbcFactionRepository>(),
    (repo, id, field) => repo.getDbcFactionLocales(id, field),
    (repo, id, field, values) => repo.saveDbcFactionLocales(id, field, values),
  );
  static DbcLocaleFieldEditorDelegate get dbcFactionName =>
      instance._dbcFactionName;

  late final _dbcFactionDescription = _dbc(
    DbcLocaleFields.factionDescription,
    () => GetIt.instance.get<DbcFactionRepository>(),
    (repo, id, field) => repo.getDbcFactionLocales(id, field),
    (repo, id, field, values) => repo.saveDbcFactionLocales(id, field, values),
  );
  static DbcLocaleFieldEditorDelegate get dbcFactionDescription =>
      instance._dbcFactionDescription;

  late final _dbcEmotesTextDataText = _dbc(
    DbcLocaleFields.emotesTextDataText,
    () => GetIt.instance.get<EmoteTextDataRepository>(),
    (repo, id, field) => repo.getEmoteTextDataLocales(id, field),
    (repo, id, field, values) =>
        repo.saveEmoteTextDataLocales(id, field, values),
  );
  static DbcLocaleFieldEditorDelegate get dbcEmotesTextDataText =>
      instance._dbcEmotesTextDataText;

  late final _dbcMailTemplateSubject = _dbc(
    DbcLocaleFields.mailTemplateSubject,
    () => GetIt.instance.get<MailTemplateRepository>(),
    (repo, id, field) => repo.getMailTemplateLocales(id, field),
    (repo, id, field, values) =>
        repo.saveMailTemplateLocales(id, field, values),
  );
  static DbcLocaleFieldEditorDelegate get dbcMailTemplateSubject =>
      instance._dbcMailTemplateSubject;

  late final _dbcMailTemplateBody = _dbc(
    DbcLocaleFields.mailTemplateBody,
    () => GetIt.instance.get<MailTemplateRepository>(),
    (repo, id, field) => repo.getMailTemplateLocales(id, field),
    (repo, id, field, values) =>
        repo.saveMailTemplateLocales(id, field, values),
  );
  static DbcLocaleFieldEditorDelegate get dbcMailTemplateBody =>
      instance._dbcMailTemplateBody;

  late final _dbcItemRandomPropertiesName = _dbc(
    DbcLocaleFields.itemRandomPropertiesName,
    () => GetIt.instance.get<ItemRandomPropertiesRepository>(),
    (repo, id, field) => repo.getItemRandomPropertiesLocales(id, field),
    (repo, id, field, values) =>
        repo.saveItemRandomPropertiesLocales(id, field, values),
  );
  static DbcLocaleFieldEditorDelegate get dbcItemRandomPropertiesName =>
      instance._dbcItemRandomPropertiesName;

  late final _dbcItemRandomSuffixName = _dbc(
    DbcLocaleFields.itemRandomSuffixName,
    () => GetIt.instance.get<ItemRandomSuffixRepository>(),
    (repo, id, field) => repo.getItemRandomSuffixLocales(id, field),
    (repo, id, field, values) =>
        repo.saveItemRandomSuffixLocales(id, field, values),
  );
  static DbcLocaleFieldEditorDelegate get dbcItemRandomSuffixName =>
      instance._dbcItemRandomSuffixName;

  late final _dbcItemSetName = _dbc(
    DbcLocaleFields.itemSetName,
    () => GetIt.instance.get<ItemSetRepository>(),
    (repo, id, field) => repo.getItemSetLocales(id, field),
    (repo, id, field, values) => repo.saveItemSetLocales(id, field, values),
  );
  static DbcLocaleFieldEditorDelegate get dbcItemSetName =>
      instance._dbcItemSetName;

  late final _dbcMapMapName = _dbc(
    DbcLocaleFields.mapMapName,
    () => GetIt.instance.get<MapInfoRepository>(),
    (repo, id, field) => repo.getMapInfoLocales(id, field),
    (repo, id, field, values) => repo.saveMapInfoLocales(id, field, values),
  );
  static DbcLocaleFieldEditorDelegate get dbcMapMapName =>
      instance._dbcMapMapName;

  late final _dbcMapMapDescription0 = _dbc(
    DbcLocaleFields.mapMapDescription0,
    () => GetIt.instance.get<MapInfoRepository>(),
    (repo, id, field) => repo.getMapInfoLocales(id, field),
    (repo, id, field, values) => repo.saveMapInfoLocales(id, field, values),
  );
  static DbcLocaleFieldEditorDelegate get dbcMapMapDescription0 =>
      instance._dbcMapMapDescription0;

  late final _dbcMapMapDescription1 = _dbc(
    DbcLocaleFields.mapMapDescription1,
    () => GetIt.instance.get<MapInfoRepository>(),
    (repo, id, field) => repo.getMapInfoLocales(id, field),
    (repo, id, field, values) => repo.saveMapInfoLocales(id, field, values),
  );
  static DbcLocaleFieldEditorDelegate get dbcMapMapDescription1 =>
      instance._dbcMapMapDescription1;

  late final _dbcQuestInfoInfoName = _dbc(
    DbcLocaleFields.questInfoInfoName,
    () => GetIt.instance.get<QuestInfoRepository>(),
    (repo, id, field) => repo.getQuestInfoLocales(id, field),
    (repo, id, field, values) => repo.saveQuestInfoLocales(id, field, values),
  );
  static DbcLocaleFieldEditorDelegate get dbcQuestInfoInfoName =>
      instance._dbcQuestInfoInfoName;

  late final _dbcQuestSortSortName = _dbc(
    DbcLocaleFields.questSortSortName,
    () => GetIt.instance.get<QuestSortRepository>(),
    (repo, id, field) => repo.getQuestSortLocales(id, field),
    (repo, id, field, values) => repo.saveQuestSortLocales(id, field, values),
  );
  static DbcLocaleFieldEditorDelegate get dbcQuestSortSortName =>
      instance._dbcQuestSortSortName;

  late final _dbcSpellName = _dbc(
    DbcLocaleFields.spellName,
    () => GetIt.instance.get<SpellRepository>(),
    (repo, id, field) => repo.getSpellLocales(id, field),
    (repo, id, field, values) => repo.saveSpellLocales(id, field, values),
  );
  static DbcLocaleFieldEditorDelegate get dbcSpellName =>
      instance._dbcSpellName;

  late final _dbcSpellNameSubtext = _dbc(
    DbcLocaleFields.spellNameSubtext,
    () => GetIt.instance.get<SpellRepository>(),
    (repo, id, field) => repo.getSpellLocales(id, field),
    (repo, id, field, values) => repo.saveSpellLocales(id, field, values),
  );
  static DbcLocaleFieldEditorDelegate get dbcSpellNameSubtext =>
      instance._dbcSpellNameSubtext;

  late final _dbcSpellDescription = _dbc(
    DbcLocaleFields.spellDescription,
    () => GetIt.instance.get<SpellRepository>(),
    (repo, id, field) => repo.getSpellLocales(id, field),
    (repo, id, field, values) => repo.saveSpellLocales(id, field, values),
  );
  static DbcLocaleFieldEditorDelegate get dbcSpellDescription =>
      instance._dbcSpellDescription;

  late final _dbcSpellAuraDescription = _dbc(
    DbcLocaleFields.spellAuraDescription,
    () => GetIt.instance.get<SpellRepository>(),
    (repo, id, field) => repo.getSpellLocales(id, field),
    (repo, id, field, values) => repo.saveSpellLocales(id, field, values),
  );
  static DbcLocaleFieldEditorDelegate get dbcSpellAuraDescription =>
      instance._dbcSpellAuraDescription;

  late final _dbcTalentTabName = _dbc(
    DbcLocaleFields.talentTabName,
    () => GetIt.instance.get<TalentTabRepository>(),
    (repo, id, field) => repo.getTalentTabLocales(id, field),
    (repo, id, field, values) => repo.saveTalentTabLocales(id, field, values),
  );
  static DbcLocaleFieldEditorDelegate get dbcTalentTabName =>
      instance._dbcTalentTabName;

  late final _dbcSkillLineDisplayName = _dbc(
    DbcLocaleFields.skillLineDisplayName,
    () => GetIt.instance.get<SkillLineRepository>(),
    (repo, id, field) => repo.getSkillLineLocales(id, field),
    (repo, id, field, values) => repo.saveSkillLineLocales(id, field, values),
  );
  static DbcLocaleFieldEditorDelegate get dbcSkillLineDisplayName =>
      instance._dbcSkillLineDisplayName;

  late final _dbcSkillLineDescription = _dbc(
    DbcLocaleFields.skillLineDescription,
    () => GetIt.instance.get<SkillLineRepository>(),
    (repo, id, field) => repo.getSkillLineLocales(id, field),
    (repo, id, field, values) => repo.saveSkillLineLocales(id, field, values),
  );
  static DbcLocaleFieldEditorDelegate get dbcSkillLineDescription =>
      instance._dbcSkillLineDescription;

  late final _dbcSkillLineAlternateVerb = _dbc(
    DbcLocaleFields.skillLineAlternateVerb,
    () => GetIt.instance.get<SkillLineRepository>(),
    (repo, id, field) => repo.getSkillLineLocales(id, field),
    (repo, id, field, values) => repo.saveSkillLineLocales(id, field, values),
  );
  static DbcLocaleFieldEditorDelegate get dbcSkillLineAlternateVerb =>
      instance._dbcSkillLineAlternateVerb;

  late final _dbcSkillLineCategoryName = _dbc(
    DbcLocaleFields.skillLineCategoryName,
    () => GetIt.instance.get<SkillLineCategoryRepository>(),
    (repo, id, field) => repo.getSkillLineCategoryLocales(id, field),
    (repo, id, field, values) =>
        repo.saveSkillLineCategoryLocales(id, field, values),
  );
  static DbcLocaleFieldEditorDelegate get dbcSkillLineCategoryName =>
      instance._dbcSkillLineCategoryName;

  late final _dbcSpellItemEnchantmentName = _dbc(
    DbcLocaleFields.spellItemEnchantmentName,
    () => GetIt.instance.get<SpellItemEnchantmentRepository>(),
    (repo, id, field) => repo.getSpellItemEnchantmentLocales(id, field),
    (repo, id, field, values) =>
        repo.saveSpellItemEnchantmentLocales(id, field, values),
  );
  static DbcLocaleFieldEditorDelegate get dbcSpellItemEnchantmentName =>
      instance._dbcSpellItemEnchantmentName;

  late final _dbcSpellRangeDisplayName = _dbc(
    DbcLocaleFields.spellRangeDisplayName,
    () => GetIt.instance.get<SpellRangeRepository>(),
    (repo, id, field) => repo.getSpellRangeLocales(id, field),
    (repo, id, field, values) => repo.saveSpellRangeLocales(id, field, values),
  );
  static DbcLocaleFieldEditorDelegate get dbcSpellRangeDisplayName =>
      instance._dbcSpellRangeDisplayName;

  late final _dbcSpellRangeDisplayNameShort = _dbc(
    DbcLocaleFields.spellRangeDisplayNameShort,
    () => GetIt.instance.get<SpellRangeRepository>(),
    (repo, id, field) => repo.getSpellRangeLocales(id, field),
    (repo, id, field, values) => repo.saveSpellRangeLocales(id, field, values),
  );
  static DbcLocaleFieldEditorDelegate get dbcSpellRangeDisplayNameShort =>
      instance._dbcSpellRangeDisplayNameShort;

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

  static Future<List<DatabaseLocaleRow>> _loadGossipMenuOptionLocaleRows(
    GossipMenuOptionKey key,
  ) async {
    final repo = GetIt.instance.get<GossipMenuOptionLocaleRepository>();
    final locale = await repo.getGossipMenuOptionLocale(
      GossipMenuOptionLocaleKey(
        menuId: key.menuId,
        optionId: key.optionId,
        locale: 'zhCN',
      ),
    );
    if (locale == null) {
      // No zhCN row yet: an empty editor with a placeholder new row is the
      // natural entry point.
      return const [];
    }
    return [
      DatabaseLocaleRow.persisted({
        'locale': locale.locale,
        'optionText': locale.optionText,
        'boxText': locale.boxText,
      }),
    ];
  }

  /// Saves a single locale [field] column of a gossip_menu_option_locale
  /// row, leaving other columns untouched.
  static Future<void> _saveGossipMenuOptionLocaleField(
    GossipMenuOptionKey key,
    DatabaseLocaleChanges changes,
    String field,
  ) async {
    final repo = GetIt.instance.get<GossipMenuOptionLocaleRepository>();
    final creations = <GossipMenuOptionLocaleEntity>[];
    final updates = <GossipMenuOptionLocaleKey, GossipMenuOptionLocaleEntity>{};
    for (final row in changes.rows) {
      final d = row.values;
      final originalLocale = row.originalLocale;
      if (originalLocale == null) {
        creations.add(
          GossipMenuOptionLocaleEntity(
            menuId: key.menuId,
            optionId: key.optionId,
            locale: d['locale'] ?? '',
            optionText: field == 'optionText' ? (d['optionText'] ?? '') : '',
            boxText: field == 'boxText' ? (d['boxText'] ?? '') : '',
          ),
        );
        continue;
      }
      final originalKey = GossipMenuOptionLocaleKey(
        menuId: key.menuId,
        optionId: key.optionId,
        locale: originalLocale,
      );
      final existing = await repo.getGossipMenuOptionLocale(originalKey);
      if (existing == null) {
        throw RecordNotFoundException('record not found');
      }
      updates[originalKey] = _gossipMenuOptionLocaleCopyWith(
        existing,
        field,
        d[field] ?? '',
        d['locale'] ?? '',
      );
    }
    await repo.applyGossipMenuOptionLocaleChanges(
      creations: creations,
      deletions: changes.deletedLocales
          .map(
            (locale) => GossipMenuOptionLocaleKey(
              menuId: key.menuId,
              optionId: key.optionId,
              locale: locale,
            ),
          )
          .toList(),
      updates: updates,
    );
  }

  static GossipMenuOptionLocaleEntity _gossipMenuOptionLocaleCopyWith(
    GossipMenuOptionLocaleEntity entity,
    String field,
    String value,
    String locale,
  ) {
    return switch (field) {
      'optionText' => entity.copyWith(locale: locale, optionText: value),
      'boxText' => entity.copyWith(locale: locale, boxText: value),
      _ => throw ArgumentError(
        'unknown gossip_menu_option locale field: $field',
      ),
    };
  }

  static Future<List<DatabaseLocaleRow>> _loadNpcTextLocaleRows(
    int entry,
  ) async {
    final repo = GetIt.instance.get<NpcTextLocaleRepository>();
    final (briefs, count) = await (
      repo.getBriefNpcTextLocales(id: entry),
      repo.countNpcTextLocales(id: entry),
    ).wait;
    if (briefs.length != count) {
      throw ValidationException(
        'locale count exceeds the current editor page range',
      );
    }
    return Future.wait(
      briefs.map((brief) async {
        final locale = await repo.getNpcTextLocale(brief.key);
        if (locale == null) {
          throw RecordNotFoundException('record not found');
        }
        return DatabaseLocaleRow.persisted({
          'locale': locale.locale,
          'text00': locale.text00,
          'text01': locale.text01,
          'text10': locale.text10,
          'text11': locale.text11,
          'text20': locale.text20,
          'text21': locale.text21,
          'text30': locale.text30,
          'text31': locale.text31,
          'text40': locale.text40,
          'text41': locale.text41,
          'text50': locale.text50,
          'text51': locale.text51,
          'text60': locale.text60,
          'text61': locale.text61,
          'text70': locale.text70,
          'text71': locale.text71,
        });
      }),
    );
  }

  static Future<List<DatabaseLocaleRow>> _loadPageTextLocaleRows(
    int entry,
  ) async {
    final repo = GetIt.instance.get<PageTextLocaleRepository>();
    final (briefs, count) = await (
      repo.getBriefPageTextLocales(id: entry),
      repo.countPageTextLocales(entry),
    ).wait;
    if (briefs.length != count) {
      throw ValidationException(
        'locale count exceeds the current editor page range',
      );
    }
    return Future.wait(
      briefs.map((brief) async {
        final locale = await repo.getPageTextLocale(brief.key);
        if (locale == null) {
          throw RecordNotFoundException('record not found');
        }
        return DatabaseLocaleRow.persisted({
          'locale': locale.locale,
          'text': locale.text,
        });
      }),
    );
  }

  static Future<List<DatabaseLocaleRow>> _loadCreatureTemplateLocaleRows(
    int entry,
  ) async {
    final repo = GetIt.instance.get<CreatureTemplateLocaleRepository>();
    final (briefs, count) = await (
      repo.getBriefCreatureTemplateLocales(entry: entry),
      repo.countCreatureTemplateLocales(entry: entry),
    ).wait;
    if (briefs.length != count) {
      throw ValidationException(
        'locale count exceeds the current editor page range',
      );
    }
    return Future.wait(
      briefs.map((brief) async {
        final locale = await repo.getCreatureTemplateLocale(brief.key);
        if (locale == null) {
          throw RecordNotFoundException('record not found');
        }
        return DatabaseLocaleRow.persisted({
          'locale': locale.locale,
          'name': locale.name,
          'title': locale.title,
        });
      }),
    );
  }

  static Future<List<DatabaseLocaleRow>> _loadGameObjectTemplateLocaleRows(
    int entry,
    Map<String, String> Function(GameObjectTemplateLocaleEntity locale)
    valuesOf,
  ) async {
    final repo = GetIt.instance.get<GameObjectTemplateLocaleRepository>();
    final (briefs, count) = await (
      repo.getBriefGameObjectTemplateLocales(entry: entry),
      repo.countGameObjectTemplateLocales(entry: entry),
    ).wait;
    if (briefs.length != count) {
      throw ValidationException(
        'locale count exceeds the current editor page range',
      );
    }
    return Future.wait(
      briefs.map((brief) async {
        final locale = await repo.getGameObjectTemplateLocale(brief.key);
        if (locale == null) {
          throw RecordNotFoundException('record not found');
        }
        return DatabaseLocaleRow.persisted(valuesOf(locale));
      }),
    );
  }

  static Future<List<DatabaseLocaleRow>> _loadItemTemplateLocaleRows(
    int entry,
    Map<String, String> Function(ItemTemplateLocaleEntity locale) valuesOf,
  ) async {
    final repo = GetIt.instance.get<ItemTemplateLocaleRepository>();
    final (briefs, count) = await (
      repo.getBriefItemTemplateLocales(id: entry),
      repo.countItemTemplateLocales(id: entry),
    ).wait;
    if (briefs.length != count) {
      throw ValidationException(
        'locale count exceeds the current editor page range',
      );
    }
    return Future.wait(
      briefs.map((brief) async {
        final locale = await repo.getItemTemplateLocale(brief.key);
        if (locale == null) {
          throw RecordNotFoundException('record not found');
        }
        return DatabaseLocaleRow.persisted(valuesOf(locale));
      }),
    );
  }

  static Future<List<DatabaseLocaleRow>> _loadQuestOfferRewardLocaleRows(
    int entry,
  ) async {
    final repo = GetIt.instance.get<QuestOfferRewardLocaleRepository>();
    final (briefs, count) = await (
      repo.getBriefQuestOfferRewardLocales(id: entry),
      repo.countQuestOfferRewardLocales(id: entry),
    ).wait;
    if (briefs.length != count) {
      throw ValidationException(
        'locale count exceeds the current editor page range',
      );
    }
    return Future.wait(
      briefs.map((brief) async {
        final locale = await repo.getQuestOfferRewardLocale(brief.key);
        if (locale == null) {
          throw RecordNotFoundException('record not found');
        }
        return DatabaseLocaleRow.persisted({
          'locale': locale.locale,
          'rewardText': locale.rewardText,
        });
      }),
    );
  }

  static Future<List<DatabaseLocaleRow>> _loadQuestRequestItemsLocaleRows(
    int entry,
  ) async {
    final repo = GetIt.instance.get<QuestRequestItemsLocaleRepository>();
    final (briefs, count) = await (
      repo.getBriefQuestRequestItemsLocales(id: entry),
      repo.countQuestRequestItemsLocales(id: entry),
    ).wait;
    if (briefs.length != count) {
      throw ValidationException(
        'locale count exceeds the current editor page range',
      );
    }
    return Future.wait(
      briefs.map((brief) async {
        final locale = await repo.getQuestRequestItemsLocale(brief.key);
        if (locale == null) {
          throw RecordNotFoundException('record not found');
        }
        return DatabaseLocaleRow.persisted({
          'locale': locale.locale,
          'completionText': locale.completionText,
        });
      }),
    );
  }

  static Future<List<DatabaseLocaleRow>> _loadQuestTemplateLocaleRows(
    int entry,
  ) async {
    final repo = GetIt.instance.get<QuestTemplateLocaleRepository>();
    final (briefs, count) = await (
      repo.getBriefQuestTemplateLocales(id: entry),
      repo.countQuestTemplateLocales(id: entry),
    ).wait;
    if (briefs.length != count) {
      throw ValidationException(
        'locale count exceeds the current editor page range',
      );
    }
    return Future.wait(
      briefs.map((brief) async {
        final locale = await repo.getQuestTemplateLocale(brief.key);
        if (locale == null) {
          throw RecordNotFoundException('record not found');
        }
        return DatabaseLocaleRow.persisted({
          'locale': locale.locale,
          'title': locale.title,
          'details': locale.details,
          'objectives': locale.objectives,
          'endText': locale.endText,
          'completedText': locale.completedText,
          'objectiveText1': locale.objectiveText1,
          'objectiveText2': locale.objectiveText2,
          'objectiveText3': locale.objectiveText3,
          'objectiveText4': locale.objectiveText4,
        });
      }),
    );
  }

  static QuestTemplateLocaleEntity _questTemplateLocaleFromValues(
    int entry,
    Map<String, String> values,
  ) {
    return QuestTemplateLocaleEntity(
      id: entry,
      locale: values['locale'] ?? '',
      title: values['title'] ?? '',
      details: values['details'] ?? '',
      objectives: values['objectives'] ?? '',
      endText: values['endText'] ?? '',
      completedText: values['completedText'] ?? '',
      objectiveText1: values['objectiveText1'] ?? '',
      objectiveText2: values['objectiveText2'] ?? '',
      objectiveText3: values['objectiveText3'] ?? '',
      objectiveText4: values['objectiveText4'] ?? '',
    );
  }

  /// quest_template_locale single-field delegate: the editor only reads
  /// and writes the [field] column.
  ///
  /// The update branch must pass only the target column to copyWith
  /// (omitted columns keep their values); the old all-column onSave must
  /// not be reused — it fills missing columns with '' and would wipe other
  /// fields.
  static DatabaseLocaleEditorDelegate _questTemplateField(
    String field,
    String label,
  ) {
    return DatabaseLocaleEditorDelegate(
      fields: ['locale', field],
      fieldLabels: ['语言', label],
      onLoad: _loadQuestTemplateLocaleRows,
      onSave: (entry, changes) async {
        final repo = GetIt.instance.get<QuestTemplateLocaleRepository>();
        final creations = <QuestTemplateLocaleEntity>[];
        final updates = <QuestTemplateLocaleKey, QuestTemplateLocaleEntity>{};
        for (final row in changes.rows) {
          final d = row.values;
          final originalLocale = row.originalLocale;
          if (originalLocale == null) {
            creations.add(_questTemplateLocaleFromValues(entry, d));
            continue;
          }
          final originalKey = QuestTemplateLocaleKey(
            id: entry,
            locale: originalLocale,
          );
          final existing = await repo.getQuestTemplateLocale(originalKey);
          if (existing == null) {
            throw RecordNotFoundException('record not found');
          }
          updates[originalKey] = _questTemplateLocaleCopyWith(
            existing,
            field,
            d[field] ?? '',
            d['locale'] ?? '',
          );
        }
        await repo.applyQuestTemplateLocaleChanges(
          creations: creations,
          deletions: changes.deletedLocales
              .map(
                (locale) => QuestTemplateLocaleKey(id: entry, locale: locale),
              )
              .toList(),
          updates: updates,
        );
      },
    );
  }

  /// npc_text_locale single-field delegate: the editor only reads and
  /// writes the [field] column.
  static DatabaseLocaleEditorDelegate _npcTextField(
    String field,
    String label,
  ) {
    return DatabaseLocaleEditorDelegate(
      fields: ['locale', field],
      fieldLabels: ['语言', label],
      onLoad: _loadNpcTextLocaleRows,
      onSave: (entry, changes) async {
        final repo = GetIt.instance.get<NpcTextLocaleRepository>();
        final creations = <NpcTextLocaleEntity>[];
        final updates = <NpcTextLocaleKey, NpcTextLocaleEntity>{};
        for (final row in changes.rows) {
          final d = row.values;
          final originalLocale = row.originalLocale;
          if (originalLocale == null) {
            creations.add(_npcTextLocaleFromValues(entry, d));
            continue;
          }
          final originalKey = NpcTextLocaleKey(
            id: entry,
            locale: originalLocale,
          );
          final existing = await repo.getNpcTextLocale(originalKey);
          if (existing == null) {
            throw RecordNotFoundException('record not found');
          }
          updates[originalKey] = _npcTextLocaleCopyWith(
            existing,
            field,
            d[field] ?? '',
            d['locale'] ?? '',
          );
        }
        await repo.applyNpcTextLocaleChanges(
          creations: creations,
          deletions: changes.deletedLocales
              .map((locale) => NpcTextLocaleKey(id: entry, locale: locale))
              .toList(),
          updates: updates,
        );
      },
    );
  }

  static NpcTextLocaleEntity _npcTextLocaleFromValues(
    int entry,
    Map<String, String> values,
  ) {
    return NpcTextLocaleEntity(
      id: entry,
      locale: values['locale'] ?? '',
      text00: values['text00'] ?? '',
      text01: values['text01'] ?? '',
      text10: values['text10'] ?? '',
      text11: values['text11'] ?? '',
      text20: values['text20'] ?? '',
      text21: values['text21'] ?? '',
      text30: values['text30'] ?? '',
      text31: values['text31'] ?? '',
      text40: values['text40'] ?? '',
      text41: values['text41'] ?? '',
      text50: values['text50'] ?? '',
      text51: values['text51'] ?? '',
      text60: values['text60'] ?? '',
      text61: values['text61'] ?? '',
      text70: values['text70'] ?? '',
      text71: values['text71'] ?? '',
    );
  }

  static NpcTextLocaleEntity _npcTextLocaleCopyWith(
    NpcTextLocaleEntity entity,
    String field,
    String value,
    String locale,
  ) {
    return switch (field) {
      'text00' => entity.copyWith(locale: locale, text00: value),
      'text01' => entity.copyWith(locale: locale, text01: value),
      'text10' => entity.copyWith(locale: locale, text10: value),
      'text11' => entity.copyWith(locale: locale, text11: value),
      'text20' => entity.copyWith(locale: locale, text20: value),
      'text21' => entity.copyWith(locale: locale, text21: value),
      'text30' => entity.copyWith(locale: locale, text30: value),
      'text31' => entity.copyWith(locale: locale, text31: value),
      'text40' => entity.copyWith(locale: locale, text40: value),
      'text41' => entity.copyWith(locale: locale, text41: value),
      'text50' => entity.copyWith(locale: locale, text50: value),
      'text51' => entity.copyWith(locale: locale, text51: value),
      'text60' => entity.copyWith(locale: locale, text60: value),
      'text61' => entity.copyWith(locale: locale, text61: value),
      'text70' => entity.copyWith(locale: locale, text70: value),
      'text71' => entity.copyWith(locale: locale, text71: value),
      _ => throw ArgumentError('unknown npc_text locale field: $field'),
    };
  }

  static QuestTemplateLocaleEntity _questTemplateLocaleCopyWith(
    QuestTemplateLocaleEntity entity,
    String field,
    String value,
    String locale,
  ) {
    return switch (field) {
      'title' => entity.copyWith(locale: locale, title: value),
      'details' => entity.copyWith(locale: locale, details: value),
      'objectives' => entity.copyWith(locale: locale, objectives: value),
      'endText' => entity.copyWith(locale: locale, endText: value),
      'completedText' => entity.copyWith(locale: locale, completedText: value),
      'objectiveText1' => entity.copyWith(
        locale: locale,
        objectiveText1: value,
      ),
      'objectiveText2' => entity.copyWith(
        locale: locale,
        objectiveText2: value,
      ),
      'objectiveText3' => entity.copyWith(
        locale: locale,
        objectiveText3: value,
      ),
      'objectiveText4' => entity.copyWith(
        locale: locale,
        objectiveText4: value,
      ),
      _ => throw ArgumentError('unknown quest locale field: $field'),
    };
  }

  /// creature_template_locale single-field delegate: the editor only reads
  /// and writes the [field] column.
  static DatabaseLocaleEditorDelegate _creatureTemplateField(
    String field,
    String label,
  ) {
    return DatabaseLocaleEditorDelegate(
      fields: ['locale', field],
      fieldLabels: ['语言', label],
      onLoad: _loadCreatureTemplateLocaleRows,
      onSave: (entry, changes) async {
        final repo = GetIt.instance.get<CreatureTemplateLocaleRepository>();
        final creations = <CreatureTemplateLocaleEntity>[];
        final updates =
            <CreatureTemplateLocaleKey, CreatureTemplateLocaleEntity>{};
        for (final row in changes.rows) {
          final d = row.values;
          final originalLocale = row.originalLocale;
          if (originalLocale == null) {
            creations.add(
              CreatureTemplateLocaleEntity(
                entry: entry,
                locale: d['locale'] ?? '',
                name: field == 'name' ? (d['name'] ?? '') : '',
                title: field == 'title' ? (d['title'] ?? '') : '',
              ),
            );
            continue;
          }
          final originalKey = CreatureTemplateLocaleKey(
            entry: entry,
            locale: originalLocale,
          );
          final existing = await repo.getCreatureTemplateLocale(originalKey);
          if (existing == null) {
            throw RecordNotFoundException('record not found');
          }
          updates[originalKey] = _creatureTemplateLocaleCopyWith(
            existing,
            field,
            d[field] ?? '',
            d['locale'] ?? '',
          );
        }
        await repo.applyCreatureTemplateLocaleChanges(
          creations: creations,
          deletions: changes.deletedLocales
              .map(
                (locale) =>
                    CreatureTemplateLocaleKey(entry: entry, locale: locale),
              )
              .toList(),
          updates: updates,
        );
      },
    );
  }

  static CreatureTemplateLocaleEntity _creatureTemplateLocaleCopyWith(
    CreatureTemplateLocaleEntity entity,
    String field,
    String value,
    String locale,
  ) {
    return switch (field) {
      'name' => entity.copyWith(locale: locale, name: value),
      'title' => entity.copyWith(locale: locale, title: value),
      _ => throw ArgumentError('unknown creature locale field: $field'),
    };
  }
}
