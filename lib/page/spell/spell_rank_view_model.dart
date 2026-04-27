import 'package:flutter/material.dart';
import 'package:foxy/model/spell_rank.dart';
import 'package:foxy/repository/spell_rank_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class SpellRankViewModel {
  final routerFacade = GetIt.instance.get<RouterFacade>();

  final spellId = signal(0);
  final items = signal<List<SpellRank>>([]);
  final selectedIndex = signal<int?>(null);
  final loading = signal(false);
  final saving = signal(false);

  final firstSpellIdController = TextEditingController();
  final rankSpellIdController = TextEditingController();
  final rankController = TextEditingController();

  final repository = SpellRankRepository();

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
    firstSpellIdController.clear();
    rankSpellIdController.clear();
    rankController.clear();
  }

  void fillForm(SpellRank data) {
    firstSpellIdController.text = data.firstSpellId.toString();
    rankSpellIdController.text = data.spellId.toString();
    rankController.text = data.rank.toString();
  }

  SpellRank collectFromForm() {
    final data = SpellRank();
    data.firstSpellId = _parseInt(firstSpellIdController.text);
    data.spellId = _parseInt(rankSpellIdController.text);
    data.rank = _parseInt(rankController.text);
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
    firstSpellIdController.text = items.value.isNotEmpty
        ? items.value.first.firstSpellId.toString()
        : '0';
    rankSpellIdController.text = spellId.value.toString();
    rankController.text = items.value.isNotEmpty
        ? (items.value.last.rank + 1).toString()
        : '1';
    selectedIndex.value = null;
  }

  void edit() {
    final index = selectedIndex.value;
    if (index == null || index < 0 || index >= items.value.length) return;
    final rank = items.value[index];
    fillForm(rank);
  }

  Future<void> copy(BuildContext context) async {
    final index = selectedIndex.value;
    if (index == null || index < 0 || index >= items.value.length) return;
    final rank = items.value[index];
    try {
      await repository.copy(rank);
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
    final rank = items.value[index];
    final confirmed = await showShadDialog<bool>(
      context: context,
      builder: (context) => ShadDialog.alert(
        title: Text('确认删除'),
        description: Text('确定要删除这条技能排行记录吗？'),
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
        await repository.delete(rank.firstSpellId, rank.rank);
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
    firstSpellIdController.dispose();
    rankSpellIdController.dispose();
    rankController.dispose();
  }
}
