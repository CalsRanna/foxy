import 'package:flutter/widgets.dart';
import 'package:foxy/entity/page_text_locale_entity.dart';
import 'package:foxy/repository/page_text_repository.dart';
import 'package:foxy/util/field_controller.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';
import 'package:get_it/get_it.dart';

class PageTextLocaleViewModel with FieldControllerMixin {
  final _repository = GetIt.instance.get<PageTextRepository>();

  final locales = signal<List<PageTextLocaleEntity>>([]);
  int _currentId = 0;

  /// 预分配 16 个 Controller，覆盖可能的 locale 行数。
  late final localeController0 = registerController(StringFieldController());
  late final localeController1 = registerController(StringFieldController());
  late final localeController2 = registerController(StringFieldController());
  late final localeController3 = registerController(StringFieldController());
  late final localeController4 = registerController(StringFieldController());
  late final localeController5 = registerController(StringFieldController());
  late final localeController6 = registerController(StringFieldController());
  late final localeController7 = registerController(StringFieldController());
  late final localeController8 = registerController(StringFieldController());
  late final localeController9 = registerController(StringFieldController());
  late final localeController10 = registerController(StringFieldController());
  late final localeController11 = registerController(StringFieldController());
  late final localeController12 = registerController(StringFieldController());
  late final localeController13 = registerController(StringFieldController());
  late final localeController14 = registerController(StringFieldController());
  late final localeController15 = registerController(StringFieldController());

  StringFieldController localeController(int index) {
    return switch (index) {
      0 => localeController0,
      1 => localeController1,
      2 => localeController2,
      3 => localeController3,
      4 => localeController4,
      5 => localeController5,
      6 => localeController6,
      7 => localeController7,
      8 => localeController8,
      9 => localeController9,
      10 => localeController10,
      11 => localeController11,
      12 => localeController12,
      13 => localeController13,
      14 => localeController14,
      15 => localeController15,
      _ => localeController0, // 防御：超出范围回退首个
    };
  }

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

  void _syncControllers() {
    final data = locales.value;
    for (var i = 0; i < 16; i++) {
      if (i < data.length) {
        localeController(i).init(data[i].text);
      } else {
        localeController(i).init('');
      }
    }
  }

  void addLocale() {
    final newLocales = [
      ...locales.value,
      PageTextLocaleEntity(id: _currentId, locale: 'zhCN'),
    ];
    locales.value = newLocales;
    _syncControllers();
  }

  void removeLocale(int index) {
    final newLocales = [...locales.value];
    newLocales.removeAt(index);
    locales.value = newLocales;
    _syncControllers();
  }

  Future<void> save(BuildContext context) async {
    try {
      final data = locales.value;
      final updatedLocales = data.asMap().entries.map((entry) {
        final idx = entry.key;
        final locale = entry.value;
        return PageTextLocaleEntity(
          id: locale.id,
          locale: locale.locale,
          text: localeController(idx).collect(),
          verifiedBuild: locale.verifiedBuild,
        );
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
    disposeControllers();
  }
}
