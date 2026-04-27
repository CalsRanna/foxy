import 'package:flutter/material.dart';
import 'package:foxy/model/spell_area.dart';
import 'package:foxy/repository/spell_area_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class SpellAreaViewModel {
  final routerFacade = GetIt.instance.get<RouterFacade>();

  final spellId = signal(0);
  final items = signal<List<SpellArea>>([]);
  final selectedIndex = signal<int?>(null);
  final loading = signal(false);
  final saving = signal(false);

  final areaController = TextEditingController();
  final questStartController = TextEditingController();
  final questEndController = TextEditingController();
  final auraSpellController = TextEditingController();
  final racemaskController = TextEditingController();
  final genderController = TextEditingController();
  final autocastController = TextEditingController();
  final questStartStatusController = TextEditingController();
  final questEndStatusController = TextEditingController();

  final repository = SpellAreaRepository();

  Future<void> load() async {
    loading.value = true;
    try {
      final data = await repository.getBySpell(spellId.value);
      items.value = data;
      selectedIndex.value = null;
    } catch (e) {
      rethrow;
    } finally {
      loading.value = false;
    }
  }

  void resetForm() {
    areaController.clear();
    questStartController.clear();
    questEndController.text = '0';
    auraSpellController.clear();
    racemaskController.clear();
    genderController.clear();
    autocastController.text = '0';
    questStartStatusController.text = '0';
    questEndStatusController.text = '0';
  }

  void fillForm(SpellArea data) {
    areaController.text = data.area.toString();
    questStartController.text = data.questStart.toString();
    questEndController.text = data.questEnd.toString();
    auraSpellController.text = data.auraSpell.toString();
    racemaskController.text = data.racemask.toString();
    genderController.text = data.gender.toString();
    autocastController.text = data.autocast.toString();
    questStartStatusController.text = data.questStartStatus.toString();
    questEndStatusController.text = data.questEndStatus.toString();
  }

  SpellArea collectFromForm() {
    final data = SpellArea();
    data.spell = spellId.value;
    data.area = _parseInt(areaController.text);
    data.questStart = _parseInt(questStartController.text);
    data.questEnd = _parseInt(questEndController.text);
    data.auraSpell = _parseInt(auraSpellController.text);
    data.racemask = _parseInt(racemaskController.text);
    data.gender = _parseInt(genderController.text);
    data.autocast = _parseInt(autocastController.text);
    data.questStartStatus = _parseInt(questStartStatusController.text);
    data.questEndStatus = _parseInt(questEndStatusController.text);
    return data;
  }

  int _parseInt(String text) {
    if (text.isEmpty) return 0;
    final value = int.tryParse(text);
    if (value == null) throw Exception('输入值 "$text" 不是有效数字');
    return value;
  }

  Future<void> create() async {
    resetForm();
    selectedIndex.value = null;
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
      await repository.copy(area);
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
        await repository.delete(
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
    saving.value = true;
    try {
      final data = collectFromForm();
      await repository.store(data);
      await load();
      if (!context.mounted) return;
      var toast = ShadToast(description: Text('保存成功'));
      ShadSonner.of(context).show(toast);
    } catch (e) {
      if (!context.mounted) return;
      var toast = ShadToast(description: Text(e.toString()));
      ShadSonner.of(context).show(toast);
    } finally {
      saving.value = false;
    }
  }

  Future<void> update(BuildContext context) async {
    final index = selectedIndex.value;
    if (index == null || index < 0 || index >= items.value.length) return;
    saving.value = true;
    try {
      final oldData = items.value[index];
      final newData = collectFromForm();
      await repository.update(oldData, newData);
      await load();
      if (!context.mounted) return;
      var toast = ShadToast(description: Text('更新成功'));
      ShadSonner.of(context).show(toast);
    } catch (e) {
      if (!context.mounted) return;
      var toast = ShadToast(description: Text(e.toString()));
      ShadSonner.of(context).show(toast);
    } finally {
      saving.value = false;
    }
  }

  void selectRow(int index) {
    if (index >= 0 && index < items.value.length) {
      selectedIndex.value = index;
    }
  }

  Future<void> initSignals({required int spellId}) async {
    this.spellId.value = spellId;
    await load();
  }

  void pop() {
    routerFacade.goBack();
  }

  void dispose() {
    areaController.dispose();
    questStartController.dispose();
    questEndController.dispose();
    auraSpellController.dispose();
    racemaskController.dispose();
    genderController.dispose();
    autocastController.dispose();
    questStartStatusController.dispose();
    questEndStatusController.dispose();
  }
}
