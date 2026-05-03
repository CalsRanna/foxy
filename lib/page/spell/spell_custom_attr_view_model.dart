import 'package:flutter/widgets.dart';
import 'package:foxy/entity/spell_custom_attr_entity.dart';
import 'package:foxy/repository/spell_custom_attr_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class SpellCustomAttrViewModel {
  final routerFacade = GetIt.instance.get<RouterFacade>();
  final spellId = signal(0);

  final attributes = signal<int>(0);

  final customAttr = signal(SpellCustomAttrEntity());

  Future<void> load() async {
    final repository = SpellCustomAttrRepository();
    final data = await repository.getSpellCustomAttr(spellId.value);
    if (data != null) {
      customAttr.value = data;
    }
  }

  Future<void> save(BuildContext context) async {
    try {
      final data = _collectFromControllers();
      final repository = SpellCustomAttrRepository();
      await repository.saveSpellCustomAttr(data);
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
      attributes: attributes.value,
    );
    return data;
  }

  void initControllers(SpellCustomAttrEntity data) {
    attributes.value = data.attributes;
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

  void dispose() {}
}
