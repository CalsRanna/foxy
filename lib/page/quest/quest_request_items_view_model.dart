import 'package:flutter/material.dart';
import 'package:foxy/model/quest_request_items.dart';
import 'package:foxy/repository/quest_request_items_locale_repository.dart';
import 'package:foxy/repository/quest_request_items_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class QuestRequestItemsViewModel {
  final routerFacade = GetIt.instance.get<RouterFacade>();
  final questId = signal(0);

  final idController = TextEditingController();
  final emoteOnCompleteController = TextEditingController();
  final emoteOnIncompleteController = TextEditingController();
  final completionTextController = TextEditingController();

  final _localeControllers = <String, TextEditingController>{};
  TextEditingController localeControllerOf(String key) {
    return _localeControllers.putIfAbsent(key, () => TextEditingController());
  }

  int _originalId = 0;

  Future<void> initSignals({required int questId}) async {
    this.questId.value = questId;
    final repository = QuestRequestItemsRepository();
    final existing = await repository.find(questId);
    if (existing != null) {
      _originalId = existing.id;
      _applyToControllers(existing);
    } else {
      final blank = await repository.create(questId);
      _applyToControllers(blank);
    }
    idController.text = questId.toString();

    final localeRepository = QuestRequestItemsLocaleRepository();
    final locales = await localeRepository.search(questId);
    QuestRequestItemsLocale? zhCN;
    for (final l in locales) {
      if (l.locale == 'zhCN') {
        zhCN = l;
        break;
      }
    }
    final target = zhCN ?? (QuestRequestItemsLocale()..id = questId);
    _applyLocaleToControllers(target);
  }

  Future<void> save(BuildContext context) async {
    try {
      final model = _collectFromControllers();
      final repository = QuestRequestItemsRepository();
      if (_originalId == 0) {
        await repository.store(model);
      } else {
        await repository.update(_originalId, model);
      }
      _originalId = model.id;

      final locale = _collectLocaleFromControllers(model.id);
      final localeRepository = QuestRequestItemsLocaleRepository();
      await localeRepository.replaceAll(model.id, [locale]);

      if (!context.mounted) return;
      var toast = ShadToast(description: Text('提交物品数据已保存'));
      ShadSonner.of(context).show(toast);
    } catch (e) {
      if (!context.mounted) return;
      var toast = ShadToast(description: Text(e.toString()));
      ShadSonner.of(context).show(toast);
    }
  }

  void pop() {
    routerFacade.goBack();
  }

  void _applyToControllers(QuestRequestItems model) {
    idController.text = model.id.toString();
    emoteOnCompleteController.text = model.emoteOnComplete.toString();
    emoteOnIncompleteController.text = model.emoteOnIncomplete.toString();
    completionTextController.text = model.completionText;
  }

  void _applyLocaleToControllers(QuestRequestItemsLocale locale) {
    localeControllerOf('CompletionText').text = locale.completionText;
  }

  QuestRequestItems _collectFromControllers() {
    final model = QuestRequestItems();
    model.id = questId.value;
    model.emoteOnComplete = _parseInt(emoteOnCompleteController.text);
    model.emoteOnIncomplete = _parseInt(emoteOnIncompleteController.text);
    model.completionText = completionTextController.text;
    return model;
  }

  QuestRequestItemsLocale _collectLocaleFromControllers(int id) {
    final locale = QuestRequestItemsLocale();
    locale.id = id;
    locale.locale = 'zhCN';
    locale.completionText = localeControllerOf('CompletionText').text;
    return locale;
  }

  int _parseInt(String text) => text.isEmpty ? 0 : int.parse(text);

  void dispose() {
    idController.dispose();
    emoteOnCompleteController.dispose();
    emoteOnIncompleteController.dispose();
    completionTextController.dispose();
    for (final c in _localeControllers.values) {
      c.dispose();
    }
    _localeControllers.clear();
  }
}