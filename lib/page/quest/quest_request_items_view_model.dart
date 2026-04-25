import 'package:flutter/widgets.dart';
import 'package:foxy/model/quest_request_items.dart';
import 'package:foxy/repository/quest_request_items_locale_repository.dart';
import 'package:foxy/repository/quest_request_items_repository.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/logger.dart';
import 'package:signals/signals.dart';

/// QuestRequestItems 子表 ViewModel（1:1 编辑模式 + locale）
///
/// 4 个显式 TextEditingController 用于主表字段，
/// Map<String, TextEditingController> 用于 locale 字段。
class QuestRequestItemsViewModel {
  final _repository = QuestRequestItemsRepository();
  final _localeRepository = QuestRequestItemsLocaleRepository();

  final idController = TextEditingController();
  final emoteOnCompleteController = TextEditingController();
  final emoteOnIncompleteController = TextEditingController();
  final completionTextController = TextEditingController();

  final _localeControllers = <String, TextEditingController>{};

  /// 按需获取 locale 字段 controller（惰性初始化）
  TextEditingController localeControllerOf(String key) {
    return _localeControllers.putIfAbsent(key, () => TextEditingController());
  }

  final loading = signal(false);
  final saving = signal(false);
  final creating = signal(true);
  final currentId = signal(0);
  final localeExists = signal(false);

  int _originalId = 0;

  /// 加载：find main + load zhCN locale，不存在则进入创建模式
  Future<void> search(int questId) async {
    loading.value = true;
    try {
      final existing = await _repository.find(questId);
      if (existing != null) {
        creating.value = false;
        _originalId = existing.id;
        currentId.value = existing.id;
        _applyToControllers(existing);
      } else {
        creating.value = true;
        final blank = await _repository.create(questId);
        currentId.value = questId;
        _applyToControllers(blank);
      }

      final locales = await _localeRepository.search(questId);
      QuestRequestItemsLocale? zhCN;
      for (final l in locales) {
        if (l.locale == 'zhCN') {
          zhCN = l;
          break;
        }
      }
      localeExists.value = zhCN != null;
      final target = zhCN ?? (QuestRequestItemsLocale()..id = questId);
      _applyLocaleToControllers(target);
    } finally {
      loading.value = false;
    }
  }

  /// 保存主表 + replaceAll locale（zhCN）
  Future<void> onSave() async {
    saving.value = true;
    try {
      final model = _collectFromControllers();
      if (creating.value) {
        await _repository.store(model);
        creating.value = false;
      } else {
        await _repository.update(_originalId, model);
      }
      _originalId = model.id;
      currentId.value = model.id;

      final locale = _collectLocaleFromControllers(model.id);
      await _localeRepository.replaceAll(model.id, [locale]);
      localeExists.value = true;

      DialogUtil.instance.success('保存成功');
    } catch (e) {
      logger.e(e.toString());
      DialogUtil.instance.error('保存失败: ${e.toString()}');
    } finally {
      saving.value = false;
    }
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
    model.id = _parseInt(idController.text);
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

  int _parseInt(String text) => int.tryParse(text) ?? 0;

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