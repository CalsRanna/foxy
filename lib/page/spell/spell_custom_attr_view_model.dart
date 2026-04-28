import 'package:flutter/widgets.dart';
import 'package:foxy/model/spell_custom_attr.dart';
import 'package:foxy/repository/spell_custom_attr_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class SpellCustomAttrViewModel {
  final routerFacade = GetIt.instance.get<RouterFacade>();
  final spellId = signal(0);

  final attributesController = TextEditingController();

  final loading = signal(false);
  final customAttr = signal(SpellCustomAttr());

  Future<void> load() async {
    loading.value = true;
    try {
      final repository = SpellCustomAttrRepository();
      final data = await repository.find(spellId.value);
      if (data != null) {
        customAttr.value = data;
      }
    } catch (e) {
      rethrow;
    } finally {
      loading.value = false;
    }
  }

  Future<void> save(BuildContext context) async {
    try {
      final data = _collectFromControllers();
      final repository = SpellCustomAttrRepository();
      await repository.save(data);
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

  SpellCustomAttr _collectFromControllers() {
    final data = SpellCustomAttr();
    data.spellId = spellId.value;
    data.attributes = _parseInt(attributesController.text);
    return data;
  }

  int _parseInt(String text) {
    if (text.isEmpty) return 0;
    final value = int.tryParse(text);
    if (value == null) throw Exception('输入值 "$text" 不是有效数字');
    return value;
  }

  void initControllers(SpellCustomAttr data) {
    attributesController.text = data.attributes.toString();
  }

  Future<void> initSignals({required int spellId}) async {
    this.spellId.value = spellId;
    await load();
  }

  void dispose() {
    attributesController.dispose();
  }
}
