import 'package:foxy/widget/form/view_model_validation_mixin.dart';
import 'package:foxy/widget/form/validation/spell_linked_spell_entity_validation_mixin.dart';
import 'package:flutter/widgets.dart';
import 'package:foxy/entity/spell_linked_spell_entity.dart';
import 'package:foxy/repository/spell_linked_spell_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class SpellLinkedSpellViewModel
    with
        ViewModelValidationMixin,
        SpellLinkedSpellValidationMixin,
        FieldControllerMixin {
  final routerFacade = GetIt.instance.get<RouterFacade>();

  final spellId = signal(0);
  final items = signal<List<SpellLinkedSpellEntity>>([]);
  final selectedIndex = signal<int?>(null);

  late final spellTriggerController = registerController(IntFieldController());
  late final spellEffectController = registerController(IntFieldController());
  late final typeController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final commentController = registerController(StringFieldController());

  final _repository = GetIt.instance.get<SpellLinkedSpellRepository>();

  Future<void> load() async {
    final data = await _repository.getBriefSpellLinkedSpells(spellId.value);
    items.value = data;
    selectedIndex.value = null;
  }

  void resetForm() {
    spellTriggerController.init(spellId.value);
    spellEffectController.init(0);
    typeController.init(0);
    commentController.init('');
  }

  void fillForm(SpellLinkedSpellEntity data) {
    spellTriggerController.init(data.spellTrigger);
    spellEffectController.init(data.spellEffect);
    typeController.init(data.type);
    commentController.init(data.comment);
  }

  SpellLinkedSpellEntity collectFromForm() {
    final trigger = spellTriggerController.collect();
    if (trigger.abs() != spellId.value) {
      throw ArgumentError('触发法术绝对值必须等于当前法术ID');
    }
    return SpellLinkedSpellEntity(
      spellTrigger: trigger,
      spellEffect: spellEffectController.collect(),
      type: typeController.collect(),
      comment: commentController.collect(),
    );
  }

  Future<void> create() async {
    try {
      resetForm();
      selectedIndex.value = null;
    } catch (e) {
      LoggerUtil.instance.e('法术链接-创建失败: $e');
      DialogUtil.instance.error('法术链接-创建失败: $e');
    }
  }

  void edit() {
    final index = selectedIndex.value;
    if (index == null || index < 0 || index >= items.value.length) return;
    final linked = items.value[index];
    fillForm(linked);
  }

  Future<void> copy(BuildContext context) async {
    final index = selectedIndex.value;
    if (index == null || index < 0 || index >= items.value.length) return;
    final linked = items.value[index];
    try {
      await _repository.copySpellLinkedSpell(
        linked.spellTrigger,
        linked.spellEffect,
        linked.type,
      );
      await load();
      if (!context.mounted) return;
      var toast = ShadToast(description: Text('复制成功'));
      ShadSonner.of(context).show(toast);
    } catch (e) {
      if (!context.mounted) return;
      var toast = ShadToast(description: Text(e.toString()));
      ShadSonner.of(context).show(toast);
    }
  }

  Future<void> delete(BuildContext context) async {
    final index = selectedIndex.value;
    if (index == null || index < 0 || index >= items.value.length) return;
    final linked = items.value[index];
    final confirmed = await showFoxyDialog<bool>(
      context: context,
      builder: (context) => ShadDialog.alert(
        title: Text('确认删除'),
        description: Text('确定要删除这条链接技能记录吗？'),
        actions: [
          ShadButton.outline(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('取消'),
          ),
          ShadButton.destructive(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('删除'),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      try {
        await _repository.destroySpellLinkedSpell(
          linked.spellTrigger,
          linked.spellEffect,
          linked.type,
        );
        await load();
        if (!context.mounted) return;
        var toast = ShadToast(description: Text('删除成功'));
        ShadSonner.of(context).show(toast);
      } catch (e) {
        if (!context.mounted) return;
        var toast = ShadToast(description: Text(e.toString()));
        ShadSonner.of(context).show(toast);
      }
    }
  }

  Future<void> save(BuildContext context) async {
    try {
      final data = collectFromForm();
      validateSpellLinkedSpellFields(data);
      await _repository.storeSpellLinkedSpell(data);
      await load();
      if (!context.mounted) return;
      var toast = ShadToast(description: Text('保存成功'));
      ShadSonner.of(context).show(toast);
    } catch (e) {
      if (!context.mounted) return;
      var toast = ShadToast(description: Text(e.toString()));
      ShadSonner.of(context).show(toast);
    }
  }

  Future<void> update(BuildContext context) async {
    final index = selectedIndex.value;
    if (index == null || index < 0 || index >= items.value.length) return;
    try {
      final oldData = items.value[index];
      final newData = collectFromForm();
      validateSpellLinkedSpellFields(newData);
      await _repository.updateSpellLinkedSpell(
        oldData.spellTrigger,
        oldData.spellEffect,
        oldData.type,
        newData,
      );
      await load();
      if (!context.mounted) return;
      var toast = ShadToast(description: Text('更新成功'));
      ShadSonner.of(context).show(toast);
    } catch (e) {
      if (!context.mounted) return;
      var toast = ShadToast(description: Text(e.toString()));
      ShadSonner.of(context).show(toast);
    }
  }

  void selectRow(int index) {
    if (index >= 0 && index < items.value.length) {
      selectedIndex.value = index;
    }
  }

  Future<void> initSignals({required int spellId}) async {
    try {
      this.spellId.value = spellId;
      spellTriggerController.init(spellId);
      await load();
    } catch (e) {
      LoggerUtil.instance.e('法术链接-初始化失败: $e');
      DialogUtil.instance.error('法术链接-初始化失败: $e');
    }
  }

  void pop() {
    routerFacade.goBack();
  }

  void dispose() {
    disposeControllers();
  }
}
