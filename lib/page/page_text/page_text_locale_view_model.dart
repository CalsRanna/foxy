import 'package:flutter/widgets.dart';
import 'package:foxy/entity/page_text_locale_entity.dart';
import 'package:foxy/repository/page_text_repository.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class PageTextLocaleViewModel {
  final repository = PageTextRepository();

  final locales = signal<List<PageTextLocaleEntity>>([]);
  final _controllers = signal<List<TextEditingController>>([]);
  int _currentId = 0;

  Future<void> initSignals({int? id}) async {
    if (id == null) return;
    _currentId = id;
    try {
      final data = await repository.getLocales(id);
      locales.value = data;
      _syncControllers();
    } catch (e, s) {
      LoggerUtil.instance.e('加载页面文本本地化(ID=$id)失败', error: e, stackTrace: s);
    }
  }

  TextEditingController localeController(int index) {
    if (index >= _controllers.value.length) return TextEditingController();
    return _controllers.value[index];
  }

  void _syncControllers() {
    _controllers.value = locales.value.map((l) {
      return TextEditingController(text: l.text);
    }).toList();
  }

  void addLocale() {
    final newLocales = [...locales.value];
    final locale = PageTextLocaleEntity(id: _currentId, locale: 'zhCN');
    newLocales.add(locale);
    locales.value = newLocales;
    _controllers.value = [..._controllers.value, TextEditingController()];
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
      final updatedLocales = locales.value.asMap().entries.map((entry) {
        final idx = entry.key;
        final locale = entry.value;
        if (idx < _controllers.value.length) {
          return PageTextLocaleEntity(
            id: locale.id,
            locale: locale.locale,
            text: _controllers.value[idx].text,
            verifiedBuild: locale.verifiedBuild,
          );
        }
        return locale;
      }).toList();
      await repository.saveLocales(_currentId, updatedLocales);
      if (!context.mounted) return;
      ShadSonner.of(context).show(ShadToast(description: Text('本地化已保存')));
    } catch (e) {
      if (!context.mounted) return;
      ShadSonner.of(context).show(ShadToast(description: Text(e.toString())));
    }
  }

  void dispose() {
    for (final c in _controllers.value) {
      c.dispose();
    }
  }
}
