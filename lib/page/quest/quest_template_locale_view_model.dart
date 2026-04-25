import 'package:flutter/material.dart';
import 'package:foxy/model/quest_template_locale.dart';
import 'package:foxy/repository/quest_template_locale_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class QuestTemplateLocaleViewModel {
  final routerFacade = GetIt.instance.get<RouterFacade>();
  final questId = signal(0);

  final idController = TextEditingController();
  final localeController = TextEditingController();

  final _localeControllers = <String, TextEditingController>{};
  TextEditingController localeControllerOf(String key) {
    return _localeControllers.putIfAbsent(key, () => TextEditingController());
  }

  Future<void> initSignals({required int questId}) async {
    this.questId.value = questId;
    final repository = QuestTemplateLocaleRepository();
    final locales = await repository.search(questId);
    QuestTemplateLocale? zhCN;
    for (final l in locales) {
      if (l.locale == 'zhCN') {
        zhCN = l;
        break;
      }
    }
    final target = zhCN ?? (QuestTemplateLocale()..id = questId);
    _applyLocaleToControllers(target);
    idController.text = questId.toString();
  }

  Future<void> save(BuildContext context) async {
    try {
      final locale = _collectLocaleFromControllers();
      final repository = QuestTemplateLocaleRepository();
      await repository.replaceAll(questId.value, [locale]);

      if (!context.mounted) return;
      var toast = ShadToast(description: Text('本地化数据已保存'));
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

  void _applyLocaleToControllers(QuestTemplateLocale locale) {
    localeController.text = locale.locale;
    localeControllerOf('Title').text = locale.title;
    localeControllerOf('Details').text = locale.details;
    localeControllerOf('Objectives').text = locale.objectives;
    localeControllerOf('EndText').text = locale.endText;
    localeControllerOf('CompletedText').text = locale.completedText;
    localeControllerOf('ObjectiveText1').text = locale.objectiveText1;
    localeControllerOf('ObjectiveText2').text = locale.objectiveText2;
    localeControllerOf('ObjectiveText3').text = locale.objectiveText3;
    localeControllerOf('ObjectiveText4').text = locale.objectiveText4;
  }

  QuestTemplateLocale _collectLocaleFromControllers() {
    final locale = QuestTemplateLocale();
    locale.id = questId.value;
    locale.locale = 'zhCN';
    locale.title = localeControllerOf('Title').text;
    locale.details = localeControllerOf('Details').text;
    locale.objectives = localeControllerOf('Objectives').text;
    locale.endText = localeControllerOf('EndText').text;
    locale.completedText = localeControllerOf('CompletedText').text;
    locale.objectiveText1 = localeControllerOf('ObjectiveText1').text;
    locale.objectiveText2 = localeControllerOf('ObjectiveText2').text;
    locale.objectiveText3 = localeControllerOf('ObjectiveText3').text;
    locale.objectiveText4 = localeControllerOf('ObjectiveText4').text;
    return locale;
  }

  void dispose() {
    idController.dispose();
    localeController.dispose();
    for (final c in _localeControllers.values) {
      c.dispose();
    }
    _localeControllers.clear();
  }
}