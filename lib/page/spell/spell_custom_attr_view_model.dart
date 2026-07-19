import 'package:flutter/widgets.dart';
import 'package:foxy/entity/spell_custom_attr_entity.dart';
import 'package:foxy/entity/spell_custom_attr_key.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/spell_custom_attr_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/form/validation/spell_custom_attr_entity_validation_mixin.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class SpellCustomAttrViewModel
    with
        ViewModelValidationMixin,
        SpellCustomAttrValidationMixin,
        FieldControllerMixin {
  final _repository = GetIt.instance.get<SpellCustomAttrRepository>();
  final routerFacade = GetIt.instance.get<RouterFacade>();
  late final spellIdController = registerController(IntFieldController());
  late final attributesController = registerController(FlagFieldController());

  final customAttr = signal(SpellCustomAttrEntity());
  final editingKey = signal<SpellCustomAttrKey?>(null);

  void dispose() {
    disposeControllers();
  }

  Future<void> initSignals({required int spellId}) async {
    try {
      final key = SpellCustomAttrKey(spellId: spellId);
      final data = await _repository.getSpellCustomAttr(key);
      if (data == null) {
        editingKey.value = null;
        final blank = await _repository.createSpellCustomAttr(spellId);
        customAttr.value = blank;
        _initControllers(blank);
      } else {
        editingKey.value = key;
        customAttr.value = data;
        _initControllers(data);
      }
    } catch (e) {
      LoggerUtil.instance.e('法术自定义属性-初始化失败: $e');
      DialogUtil.instance.error('法术自定义属性-初始化失败: $e');
    }
  }

  void pop() {
    routerFacade.goBack();
  }

  Future<void> save(BuildContext context) async {
    try {
      final data = _collectFromControllers();
      validateSpellCustomAttrFields(data);
      final originalKey = editingKey.value;
      if (originalKey == null) {
        await _repository.storeSpellCustomAttr(data);
      } else {
        await _repository.updateSpellCustomAttr(originalKey, data);
      }
      editingKey.value = SpellCustomAttrKey.fromEntity(data);
      customAttr.value = data;
      if (!context.mounted) return;
      var toast = ShadToast(description: Text('自定义属性已保存'));
      ShadSonner.of(context).show(toast);
    } catch (e) {
      if (!context.mounted) return;
      var toast = ShadToast(description: Text(e.toString()));
      ShadSonner.of(context).show(toast);
    }
  }

  SpellCustomAttrEntity _collectFromControllers() {
    return SpellCustomAttrEntity(
      spellId: spellIdController.collect(),
      attributes: attributesController.collect(),
    );
  }

  void _initControllers(SpellCustomAttrEntity data) {
    spellIdController.init(data.spellId);
    attributesController.init(data.attributes);
  }
}
