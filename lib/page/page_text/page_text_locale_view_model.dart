import 'package:flutter/widgets.dart';
import 'package:foxy/entity/page_text_locale_entity.dart';
import 'package:foxy/repository/page_text_repository.dart';
import 'package:foxy/util/field_controller.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';
import 'package:get_it/get_it.dart';

class PageTextLocaleViewModel {
  final _repository = GetIt.instance.get<PageTextRepository>();

  final locales = signal<List<PageTextLocaleEntity>>([]);
  final _controllers = signal<List<StringFieldController>>([]);
  int _currentId = 0;

  Future<void> initSignals({int? id}) async {
    if (id == null) return;
    _currentId = id;
    try {
      final data = await _repository.getPageTextLocales(id);
      locales.value = data;
      _syncControllers();
    } catch (e, s) {
      LoggerUtil.instance.e('加载页面文本本地化(ID=$id)失败', error: e, stackTrace: s);
    }
  }

  StringFieldController localeController(int index) {
    final controllers = _controllers.value;
    if (index >= controllers.length) {
      // 防御：UI 与列表不同步时不应泄漏长期控制器
      return StringFieldController();
    }
    return controllers[index];
  }

  void _syncControllers() {
    for (final controller in _controllers.value) {
      controller.dispose();
    }
    _controllers.value = locales.value.map((l) {
      final controller = StringFieldController();
      controller.init(l.text);
      return controller;
    }).toList();
  }

  void addLocale() {
    final newLocales = [...locales.value];
    final locale = PageTextLocaleEntity(id: _currentId, locale: 'zhCN');
    newLocales.add(locale);
    locales.value = newLocales;
    _controllers.value = [..._controllers.value, StringFieldController()];
  }

  void removeLocale(int index) {
    final newLocales = [...locales.value];
    final newControllers = [..._controllers.value];
    newLocales.removeAt(index);
    newControllers[index].dispose();
    newControllers.removeAt(index);
    locales.value = newLocales;
    _controllers.value = newControllers;
  }

  Future<void> save(BuildContext context) async {
    try {
      final controllers = _controllers.value;
      final updatedLocales = locales.value.asMap().entries.map((entry) {
        final idx = entry.key;
        final locale = entry.value;
        if (idx < controllers.length) {
          return PageTextLocaleEntity(
            id: locale.id,
            locale: locale.locale,
            text: controllers[idx].collect(),
            verifiedBuild: locale.verifiedBuild,
          );
        }
        return locale;
      }).toList();
      await _repository.savePageTextLocales(_currentId, updatedLocales);
      if (!context.mounted) return;
      ShadSonner.of(context).show(ShadToast(description: Text('本地化已保存')));
    } catch (e) {
      if (!context.mounted) return;
      ShadSonner.of(context).show(ShadToast(description: Text(e.toString())));
    }
  }

  void dispose() {
    for (final controller in _controllers.value) {
      controller.dispose();
    }
  }
}
