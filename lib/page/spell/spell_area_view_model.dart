import 'package:flutter/widgets.dart';
import 'package:foxy/entity/spell_area_entity.dart';
import 'package:foxy/repository/spell_area_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class SpellAreaViewModel {
  final routerFacade = GetIt.instance.get<RouterFacade>();

  final spellId = signal(0);
  final items = signal<List<SpellAreaEntity>>([]);
  final selectedIndex = signal<int?>(null);
  final area = signal<int>(0);
  final questStart = signal<int>(0);
  final questEnd = signal<int>(0);
  final auraSpell = signal<int>(0);
  final racemask = signal<int>(0);
  final gender = signal<int>(0);
  final autocast = signal<int>(0);
  final questStartStatus = signal<int>(0);
  final questEndStatus = signal<int>(0);

  final repository = SpellAreaRepository();

  Future<void> load() async {
    final data = await repository.getSpellAreas(spellId.value);
    items.value = data;
    selectedIndex.value = null;
  }

  void resetForm() {
    area.value = 0;
    questStart.value = 0;
    questEnd.value = 0;
    auraSpell.value = 0;
    racemask.value = 0;
    gender.value = 0;
    autocast.value = 0;
    questStartStatus.value = 0;
    questEndStatus.value = 0;
  }

  void fillForm(SpellAreaEntity data) {
    area.value = data.area;
    questStart.value = data.questStart;
    questEnd.value = data.questEnd;
    auraSpell.value = data.auraSpell;
    racemask.value = data.racemask;
    gender.value = data.gender;
    autocast.value = data.autocast;
    questStartStatus.value = data.questStartStatus;
    questEndStatus.value = data.questEndStatus;
  }

  SpellAreaEntity collectFromForm() {
    return SpellAreaEntity(
      spell: spellId.value,
      area: area.value,
      questStart: questStart.value,
      questEnd: questEnd.value,
      auraSpell: auraSpell.value,
      racemask: racemask.value,
      gender: gender.value,
      autocast: autocast.value,
      questStartStatus: questStartStatus.value,
      questEndStatus: questEndStatus.value,
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

  Future<void> copy(BuildContext context) async {
    final index = selectedIndex.value;
    if (index == null || index < 0 || index >= items.value.length) return;
    final area = items.value[index];
    try {
      await repository.copySpellArea(area);
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
    final area = items.value[index];
    final confirmed = await showShadDialog<bool>(
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
        await repository.destroySpellArea(
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
      await repository.storeSpellArea(data);
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
      await repository.updateSpellArea(oldData, newData);
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
      await load();
    } catch (e) {
      LoggerUtil.instance.e('法术区域-初始化失败: $e');
      DialogUtil.instance.error('法术区域-初始化失败: $e');
    }
  }

  void pop() {
    routerFacade.goBack();
  }

  void dispose() {}
}
