import 'package:flutter/widgets.dart';
import 'package:foxy/model/spell_group.dart';
import 'package:foxy/repository/spell_group_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class SpellGroupViewModel {
  final routerFacade = GetIt.instance.get<RouterFacade>();

  final spellId = signal(0);
  final items = signal<List<SpellGroup>>([]);
  final selectedIndex = signal<int?>(null);
  final loading = signal(false);
  final saving = signal(false);

  final idController = TextEditingController();
  final specialFlagController = TextEditingController();

  final repository = SpellGroupRepository();

  Future<void> load() async {
    loading.value = true;
    try {
      final data = await repository.getBySpellId(spellId.value);
      items.value = data;
      selectedIndex.value = null;
    } catch (e) {
      rethrow;
    } finally {
      loading.value = false;
    }
  }

  void resetForm() {
    idController.clear();
    specialFlagController.text = '0';
  }

  void fillForm(SpellGroup data) {
    idController.text = data.id.toString();
    specialFlagController.text = data.specialFlag.toString();
  }

  SpellGroup collectFromForm() {
    final data = SpellGroup();
    data.spellId = spellId.value;
    data.id = _parseInt(idController.text);
    data.specialFlag = _parseInt(specialFlagController.text);
    return data;
  }

  int _parseInt(String text) {
    if (text.isEmpty) return 0;
    final value = int.tryParse(text);
    if (value == null) throw Exception('输入值 "$text" 不是有效数字');
    return value;
  }

  Future<void> create() async {
    final nextId = await repository.getNextId();
    resetForm();
    idController.text = nextId.toString();
    selectedIndex.value = null;
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
      await repository.copy(group);
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
    final confirmed = await showShadDialog<bool>(
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
        await repository.delete(group.id, group.spellId);
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
    idController.dispose();
    specialFlagController.dispose();
  }
}
