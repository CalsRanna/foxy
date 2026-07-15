import 'package:foxy/widget/form/view_model_validation_mixin.dart';
import 'package:foxy/widget/form/validation/spell_area_entity_validation_mixin.dart';
import 'package:flutter/widgets.dart';
import 'package:foxy/entity/spell_area_entity.dart';
import 'package:foxy/repository/spell_area_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class SpellAreaViewModel
    with
        ViewModelValidationMixin,
        SpellAreaValidationMixin,
        FieldControllerMixin {
  final routerFacade = GetIt.instance.get<RouterFacade>();

  final spellId = signal(0);
  final items = signal<List<SpellAreaEntity>>([]);
  final selectedIndex = signal<int?>(null);

  late final spellIdController = registerController(IntFieldController());
  late final areaController = registerController(IntFieldController());
  late final questStartController = registerController(IntFieldController());
  late final questEndController = registerController(IntFieldController());
  late final auraSpellController = registerController(IntFieldController());
  late final racemaskController = registerController(FlagFieldController());
  late final genderController = registerController(
    SelectFieldController<int>(fallback: 2),
  );
  late final autocastController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final questStartStatusController = registerController(
    FlagFieldController(),
  );
  late final questEndStatusController = registerController(
    FlagFieldController(),
  );

  final _repository = GetIt.instance.get<SpellAreaRepository>();

  Future<void> load() async {
    final data = await _repository.getBriefSpellAreas(spellId.value);
    items.value = data;
    selectedIndex.value = null;
  }

  void resetForm() {
    areaController.init(0);
    questStartController.init(0);
    questEndController.init(0);
    auraSpellController.init(0);
    racemaskController.init(0);
    genderController.init(2);
    autocastController.init(0);
    questStartStatusController.init(64);
    questEndStatusController.init(11);
  }

  void fillForm(SpellAreaEntity data) {
    areaController.init(data.area);
    questStartController.init(data.questStart);
    questEndController.init(data.questEnd);
    auraSpellController.init(data.auraSpell);
    racemaskController.init(data.racemask);
    genderController.init(data.gender);
    autocastController.init(data.autocast);
    questStartStatusController.init(data.questStartStatus);
    questEndStatusController.init(data.questEndStatus);
  }

  SpellAreaEntity collectFromForm() {
    return SpellAreaEntity(
      spell: spellId.value,
      area: areaController.collect(),
      questStart: questStartController.collect(),
      questEnd: questEndController.collect(),
      auraSpell: auraSpellController.collect(),
      racemask: racemaskController.collect(),
      gender: genderController.collect(),
      autocast: autocastController.collect(),
      questStartStatus: questStartStatusController.collect(),
      questEndStatus: questEndStatusController.collect(),
    );
  }

  Future<void> create() async {
    try {
      resetForm();
      selectedIndex.value = null;
    } catch (e) {
      LoggerUtil.instance.e('法术区域-创建失败: $e');
      DialogUtil.instance.error('法术区域-创建失败: $e');
    }
  }

  void edit() {
    final index = selectedIndex.value;
    if (index == null || index < 0 || index >= items.value.length) return;
    final area = items.value[index];
    fillForm(area);
  }

  Future<void> delete(BuildContext context) async {
    final index = selectedIndex.value;
    if (index == null || index < 0 || index >= items.value.length) return;
    final area = items.value[index];
    final confirmed = await showFoxyDialog<bool>(
      context: context,
      builder: (context) => ShadDialog.alert(
        title: Text('确认删除'),
        description: Text('确定要删除这条区域技能记录吗？'),
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
        await _repository.destroySpellArea(
          area.spell,
          area.area,
          area.questStart,
          area.auraSpell,
          area.racemask,
          area.gender,
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
      validateSpellAreaFields(data);
      await _repository.storeSpellArea(data);
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
      validateSpellAreaFields(newData);
      await _repository.updateSpellArea(
        oldData.spell,
        oldData.area,
        oldData.questStart,
        oldData.auraSpell,
        oldData.racemask,
        oldData.gender,
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
      spellIdController.init(spellId);
      await load();
    } catch (e) {
      LoggerUtil.instance.e('法术区域-初始化失败: $e');
      DialogUtil.instance.error('法术区域-初始化失败: $e');
    }
  }

  void pop() {
    routerFacade.goBack();
  }

  void dispose() {
    disposeControllers();
  }
}
