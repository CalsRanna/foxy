import 'package:foxy/widget/form/view_model_validation_mixin.dart';
import 'package:foxy/widget/form/validation/spell_group_entity_validation_mixin.dart';
import 'package:flutter/widgets.dart';
import 'package:foxy/entity/spell_group_entity.dart';
import 'package:foxy/repository/spell_group_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class SpellGroupViewModel
    with
        ViewModelValidationMixin,
        SpellGroupValidationMixin,
        FieldControllerMixin {
  final routerFacade = GetIt.instance.get<RouterFacade>();

  final spellId = signal(0);
  final items = signal<List<SpellGroupEntity>>([]);
  final selectedIndex = signal<int?>(null);

  late final spellIdController = registerController(IntFieldController());
  late final groupIdController = registerController(IntFieldController());

  final _repository = GetIt.instance.get<SpellGroupRepository>();

  Future<void> load() async {
    final data = await _repository.getBriefSpellGroups(spellId.value);
    items.value = data;
    selectedIndex.value = null;
  }

  void resetForm() {
    groupIdController.init(0);
  }

  void fillForm(SpellGroupEntity data) {
    groupIdController.init(data.id);
  }

  SpellGroupEntity collectFromForm() {
    return SpellGroupEntity(
      spellId: spellId.value,
      id: groupIdController.collect(),
    );
  }

  Future<void> create() async {
    try {
      final blank = await _repository.createSpellGroup(spellId.value);
      resetForm();
      groupIdController.init(blank.id);
      selectedIndex.value = null;
    } catch (e) {
      LoggerUtil.instance.e('法术组-创建失败: $e');
      DialogUtil.instance.error('法术组-创建失败: $e');
    }
  }

  void edit() {
    final index = selectedIndex.value;
    if (index == null || index < 0 || index >= items.value.length) return;
    final group = items.value[index];
    fillForm(group);
  }

  Future<void> copy(BuildContext context) async {
    final index = selectedIndex.value;
    if (index == null || index < 0 || index >= items.value.length) return;
    final group = items.value[index];
    try {
      await _repository.copySpellGroup(group.id, group.spellId);
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
    final group = items.value[index];
    final confirmed = await showFoxyDialog<bool>(
      context: context,
      builder: (context) => ShadDialog.alert(
        title: Text('确认删除'),
        description: Text('确定要删除这条技能组记录吗？'),
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
        await _repository.destroySpellGroup(group.id, group.spellId);
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
      validateSpellGroupFields(data);
      await _repository.storeSpellGroup(data);
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
      validateSpellGroupFields(newData);
      await _repository.updateSpellGroup(oldData.id, oldData.spellId, newData);
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
      spellIdController.init(spellId);
      await load();
    } catch (e) {
      LoggerUtil.instance.e('法术组-初始化失败: $e');
      DialogUtil.instance.error('法术组-初始化失败: $e');
    }
  }

  void pop() {
    routerFacade.goBack();
  }

  void dispose() {
    disposeControllers();
  }
}
