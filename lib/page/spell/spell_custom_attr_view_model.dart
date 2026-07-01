import 'package:flutter/widgets.dart';
import 'package:foxy/entity/spell_custom_attr_entity.dart';
import 'package:foxy/util/format_util.dart';
import 'package:foxy/repository/spell_custom_attr_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class SpellCustomAttrViewModel {
  final _repository = GetIt.instance.get<SpellCustomAttrRepository>();
  final routerFacade = GetIt.instance.get<RouterFacade>();
  final spellId = signal(0);

  final attributesController = TextEditingController();

  final customAttr = signal(SpellCustomAttrEntity());

  String _fmt(num v) => formatNum(v);

  int _pi(String t) => int.tryParse(t) ?? 0;

  Future<void> load() async {
    final data = await _repository.getSpellCustomAttr(spellId.value);
    if (data != null) {
      customAttr.value = data;
    }
  }

  Future<void> save(BuildContext context) async {
    try {
      final data = _collectFromControllers();
      await _repository.saveSpellCustomAttr(data);
      customAttr.value = data;
      if (!context.mounted) return;
      var toast = ShadToast(description: Text('自定义属性已保存'));
      ShadSonner.of(context).show(toast);
    } catch (e) {
      var toast = ShadToast(description: Text(e.toString()));
      ShadSonner.of(context).show(toast);
    }
  }

  void pop() {
    routerFacade.goBack();
  }

  SpellCustomAttrEntity _collectFromControllers() {
    final data = SpellCustomAttrEntity(
      spellId: spellId.value,
      attributes: _pi(attributesController.text),
    );
    return data;
  }

  void initControllers(SpellCustomAttrEntity data) {
    attributesController.text = _fmt(data.attributes);
  }

  Future<void> initSignals({required int spellId}) async {
    try {
      this.spellId.value = spellId;
      await load();
    } catch (e) {
      LoggerUtil.instance.e('法术自定义属性-初始化失败: $e');
      DialogUtil.instance.error('法术自定义属性-初始化失败: $e');
    }
  }

  void dispose() {
    attributesController.dispose();
  }
}
