import 'package:flutter/widgets.dart';
import 'package:foxy/constant/page_text_constants.dart';
import 'package:foxy/entity/page_text_locale_entity.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/page_text_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/form/validation/page_text_locale_entity_validation_mixin.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class PageTextLocaleForm {
  final idController = IntFieldController();
  final localeController = SelectFieldController<String>(fallback: 'zhCN');
  final textController = StringFieldController();
  final verifiedBuildController = IntFieldController();

  PageTextLocaleForm(PageTextLocaleEntity locale) {
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
  final _repository = GetIt.instance.get<PageTextRepository>();

  final rows = signal<List<PageTextLocaleForm>>([]);
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
    );
    rows.value = [...rows.value, row];
  }

  void dispose() => _replaceRows([]);

  Future<void> initSignals({int? id}) async {
    if (id == null || id <= 0) return;
    _currentId = id;
    try {
      final locales = await _repository.getPageTextLocales(id);
      _replaceRows(locales.map(PageTextLocaleForm.new).toList());
    } catch (e, s) {
      LoggerUtil.instance.e('加载页面文本本地化(ID=$id)失败', error: e, stackTrace: s);
    }
  }

  void removeLocale(PageTextLocaleForm row) {
    rows.value = rows.value.where((candidate) => candidate != row).toList();
    row.dispose();
  }

  Future<void> save(BuildContext context) async {
    try {
      final locales = rows.value.map((row) => row.collect()).toList();
      for (final locale in locales) {
        validatePageTextLocaleFields(locale);
      }
      await _repository.savePageTextLocales(_currentId, locales);
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
}
