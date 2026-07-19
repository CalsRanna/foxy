import 'package:flutter/widgets.dart';
import 'package:foxy/constant/page_text_constants.dart';
import 'package:foxy/entity/page_text_locale_entity.dart';
import 'package:foxy/entity/page_text_locale_key.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/page_text_locale_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/form/validation/page_text_locale_entity_validation_mixin.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class PageTextLocaleForm {
  PageTextLocaleKey? editingKey;
  final idController = IntFieldController();
  final localeController = SelectFieldController<String>(fallback: 'zhCN');
  final textController = StringFieldController();
  final verifiedBuildController = IntFieldController();

  PageTextLocaleForm(PageTextLocaleEntity locale, {this.editingKey}) {
    idController.init(locale.id);
    localeController.init(locale.locale);
    textController.init(locale.text);
    verifiedBuildController.init(locale.verifiedBuild);
  }

  PageTextLocaleEntity collect() {
    return PageTextLocaleEntity(
      id: idController.collect(),
      locale: localeController.collect(),
      text: textController.collect(),
      verifiedBuild: verifiedBuildController.collect(),
    );
  }

  void dispose() {
    idController.dispose();
    localeController.dispose();
    textController.dispose();
    verifiedBuildController.dispose();
  }
}

class PageTextLocaleViewModel
    with ViewModelValidationMixin, PageTextLocaleValidationMixin {
  final _repository = GetIt.instance.get<PageTextLocaleRepository>();

  final rows = signal<List<PageTextLocaleForm>>([]);
  final _deletedKeys = <PageTextLocaleKey>[];
  int _currentId = 0;

  void addLocale() {
    final used = rows.value
        .map((row) => row.localeController.collect())
        .toSet();
    final available = kPageTextLocaleOptions.keys.where(
      (locale) => !used.contains(locale),
    );
    if (available.isEmpty) return;
    final row = PageTextLocaleForm(
      PageTextLocaleEntity(id: _currentId, locale: available.first),
      editingKey: null,
    );
    rows.value = [...rows.value, row];
  }

  void dispose() {
    _deletedKeys.clear();
    _replaceRows([]);
  }

  Future<void> initSignals({int? id}) async {
    if (id == null || id <= 0) {
      _currentId = 0;
      _deletedKeys.clear();
      _replaceRows([]);
      return;
    }
    try {
      await _load(id);
    } catch (e, s) {
      LoggerUtil.instance.e('加载页面文本本地化(ID=$id)失败', error: e, stackTrace: s);
    }
  }

  void removeLocale(PageTextLocaleForm row) {
    final editingKey = row.editingKey;
    if (editingKey != null) _deletedKeys.add(editingKey);
    rows.value = rows.value.where((candidate) => candidate != row).toList();
    row.dispose();
  }

  Future<void> save(BuildContext context) async {
    try {
      final locales = rows.value.map((row) => row.collect()).toList();
      for (final locale in locales) {
        validatePageTextLocaleFields(locale);
      }
      final candidateKeys = <PageTextLocaleKey>{};
      for (final locale in locales) {
        final key = PageTextLocaleKey.fromEntity(locale);
        if (!candidateKeys.add(key)) {
          throw StateError('语言 ${locale.locale} 重复');
        }
      }
      final creations = <PageTextLocaleEntity>[];
      final updates = <PageTextLocaleKey, PageTextLocaleEntity>{};
      for (var index = 0; index < rows.value.length; index++) {
        final editingKey = rows.value[index].editingKey;
        if (editingKey == null) {
          creations.add(locales[index]);
        } else {
          updates[editingKey] = locales[index];
        }
      }
      await _repository.applyPageTextLocaleChanges(
        creations: creations,
        deletions: List.unmodifiable(_deletedKeys),
        updates: updates,
      );
      await _load(_currentId);
      if (!context.mounted) return;
      ShadSonner.of(context).show(ShadToast(description: Text('本地化已保存')));
    } catch (e) {
      if (!context.mounted) return;
      ShadSonner.of(context).show(ShadToast(description: Text(e.toString())));
    }
  }

  void _replaceRows(List<PageTextLocaleForm> next) {
    for (final row in rows.value) {
      row.dispose();
    }
    rows.value = next;
  }

  Future<void> _load(int id) async {
    _currentId = id;
    final (briefs, count) = await (
      _repository.getBriefPageTextLocales(id: id),
      _repository.countPageTextLocales(id),
    ).wait;
    if (briefs.length != count) {
      throw StateError('页面文本本地化数量超过当前编辑器分页范围');
    }
    final locales = await Future.wait(
      briefs.map((brief) async {
        final locale = await _repository.getPageTextLocale(brief.key);
        if (locale == null) {
          throw StateError('原本地化记录不存在，可能已被其他操作修改或删除');
        }
        return PageTextLocaleForm(locale, editingKey: brief.key);
      }),
    );
    _deletedKeys.clear();
    _replaceRows(locales);
  }
}
