import 'package:flutter/widgets.dart';
import 'package:foxy/model/quest_template_locale.dart';
import 'package:foxy/repository/quest_template_locale_repository.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/logger.dart';
import 'package:signals/signals.dart';

/// QuestTemplateLocale ViewModel（纯 locale 编辑模式，无 1:1 主表）
class QuestTemplateLocaleViewModel {
  final _localeRepository = QuestTemplateLocaleRepository();

  final idController = TextEditingController();
  final localeController = TextEditingController();

  final _localeControllers = <String, TextEditingController>{};
  TextEditingController localeControllerOf(String key) {
    return _localeControllers.putIfAbsent(key, () => TextEditingController());
  }

  final loading = signal(false);
  final saving = signal(false);
  final creating = signal(true);
  final currentId = signal(0);
  final localeExists = signal(false);

  Future<void> search(int questId) async {
    loading.value = true;
    try {
      currentId.value = questId;

      final locales = await _localeRepository.search(questId);
      QuestTemplateLocale? zhCN;
      for (final l in locales) {
        if (l.locale == 'zhCN') {
          zhCN = l;
          break;
        }
      }

      if (zhCN != null) {
        creating.value = false;
        localeExists.value = true;
        _applyLocaleToControllers(zhCN);
      } else {
        creating.value = true;
        localeExists.value = false;
        final blank = QuestTemplateLocale();
        blank.id = questId;
        blank.locale = 'zhCN';
        _applyLocaleToControllers(blank);
      }
    } finally {
      loading.value = false;
    }
  }

  Future<void> onSave() async {
    saving.value = true;
    try {
      final locale = _collectLocaleFromControllers();
      await _localeRepository.replaceAll(currentId.value, [locale]);
      localeExists.value = true;
      creating.value = false;

      DialogUtil.instance.success('保存成功');
    } catch (e) {
      logger.e(e.toString());
      DialogUtil.instance.error('保存失败: ${e.toString()}');
    } finally {
      saving.value = false;
    }
  }

  void _applyLocaleToControllers(QuestTemplateLocale locale) {
    idController.text = locale.id.toString();
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
    locale.id = currentId.value;
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
    for (final controller in _localeControllers.values) {
      controller.dispose();
    }
    _localeControllers.clear();
  }
}