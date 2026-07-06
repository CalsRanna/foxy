import 'package:foxy/entity/creature_template_locale_entity.dart';
import 'package:foxy/entity/game_object_template_locale_entity.dart';
import 'package:foxy/entity/item_template_locale_entity.dart';
import 'package:foxy/entity/quest_offer_reward_entity.dart';
import 'package:foxy/entity/quest_request_items_entity.dart';
import 'package:foxy/entity/quest_template_locale_entity.dart';
import 'package:foxy/repository/creature_template_repository.dart';
import 'package:foxy/repository/game_object_template_repository.dart';
import 'package:foxy/repository/item_template_locale_repository.dart';
import 'package:foxy/repository/quest_offer_reward_locale_repository.dart';
import 'package:foxy/repository/quest_request_items_locale_repository.dart';
import 'package:foxy/repository/quest_template_locale_repository.dart';
import 'package:foxy/widget/foxy_locale_picker.dart';
import 'package:get_it/get_it.dart';

/// 多语言 picker delegate 注册表，集中各模块的加载/保存配置。
///
/// 对齐 [EntityPickerDelegates] 范式：每个实体一个 `static final` delegate，
/// 纯数据 + 闭包，不持有可变状态，可被多个 [FoxyLocalePicker] 共享。
class LocalePickerDelegates {
  static final creatureTemplateName = LocalePickerDelegate(
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

  static final gameObjectName = LocalePickerDelegate(
    fields: ['locale', 'name'],
    fieldLabels: ['语言', '名称'],
    onLoad: (entry) async {
      final repo = GetIt.instance.get<GameObjectTemplateRepository>();
      final locales = await repo.getGameObjectTemplateLocales(entry);
      return locales
          .map((e) => {'locale': e.locale, 'name': e.name})
          .toList();
    },
    onSave: (entry, data) async {
      final repo = GetIt.instance.get<GameObjectTemplateRepository>();
      final locales = data
          .map(
            (d) => GameObjectTemplateLocaleEntity(
              entry: entry,
              locale: d['locale'] ?? '',
              name: d['name'] ?? '',
            ),
          )
          .toList();
      await repo.saveGameObjectTemplateLocales(entry, locales);
    },
  );

  static final gameObjectCaption = LocalePickerDelegate(
    fields: ['locale', 'name'],
    fieldLabels: ['语言', '使用说明'],
    onLoad: (entry) async {
      final repo = GetIt.instance.get<GameObjectTemplateRepository>();
      final locales = await repo.getGameObjectTemplateLocales(entry);
      return locales
          .map((e) => {'locale': e.locale, 'name': e.name})
          .toList();
    },
    onSave: (entry, data) async {
      final repo = GetIt.instance.get<GameObjectTemplateRepository>();
      final locales = data
          .map(
            (d) => GameObjectTemplateLocaleEntity(
              entry: entry,
              locale: d['locale'] ?? '',
              name: d['name'] ?? '',
            ),
          )
          .toList();
      await repo.saveGameObjectTemplateLocales(entry, locales);
    },
  );

  static final itemName = LocalePickerDelegate(
    fields: ['locale', 'name'],
    fieldLabels: ['语言', '名称'],
    onLoad: (entry) async {
      final repo = GetIt.instance.get<ItemTemplateLocaleRepository>();
      final locales = await repo.getItemTemplateLocales(entry);
      return locales
          .map((e) => {'locale': e.locale, 'name': e.name})
          .toList();
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
      await repo.replaceAll(entry, locales);
    },
  );

  static final itemDescription = LocalePickerDelegate(
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
      await repo.replaceAll(entry, locales);
    },
  );

  static final questTemplate = LocalePickerDelegate(
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
      await repo.replaceAll(entry, locales);
    },
  );

  static final questOfferReward = LocalePickerDelegate(
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
      await repo.replaceAll(entry, locales);
    },
  );

  static final questRequestItems = LocalePickerDelegate(
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
      await repo.replaceAll(entry, locales);
    },
  );
}
