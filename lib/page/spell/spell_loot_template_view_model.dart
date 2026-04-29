import 'package:flutter/widgets.dart';
import 'package:foxy/entity/spell_loot_template.dart';
import 'package:foxy/repository/spell_loot_template_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class SpellLootTemplateViewModel {
  final routerFacade = GetIt.instance.get<RouterFacade>();

  final spellId = signal(0);
  final items = signal<List<SpellLootTemplate>>([]);
  final selectedIndex = signal<int?>(null);
  final loading = signal(false);
  final saving = signal(false);

  final itemController = TextEditingController();
  final referenceController = TextEditingController();
  final chanceController = TextEditingController();
  final questRequiredController = TextEditingController();
  final lootModeController = TextEditingController();
  final groupIdController = TextEditingController();
  final minCountController = TextEditingController();
  final maxCountController = TextEditingController();
  final commentController = TextEditingController();

  final repository = SpellLootTemplateRepository();

  Future<void> load() async {
    loading.value = true;
    try {
      final data = await repository.getSpellLootTemplates(spellId.value);
      items.value = data;
      selectedIndex.value = null;
    } catch (e) {
      rethrow;
    } finally {
      loading.value = false;
    }
  }

  void resetForm() {
    itemController.clear();
    referenceController.text = '0';
    chanceController.text = '0';
    questRequiredController.text = '0';
    lootModeController.text = '0';
    groupIdController.text = '0';
    minCountController.text = '0';
    maxCountController.text = '0';
    commentController.clear();
  }

  void fillForm(SpellLootTemplate data) {
    itemController.text = data.item.toString();
    referenceController.text = data.reference.toString();
    chanceController.text = data.chance.toString();
    questRequiredController.text = data.questRequired.toString();
    lootModeController.text = data.lootMode.toString();
    groupIdController.text = data.groupId.toString();
    minCountController.text = data.minCount.toString();
    maxCountController.text = data.maxCount.toString();
    commentController.text = data.comment;
  }

  SpellLootTemplate collectFromForm() {
    final data = SpellLootTemplate(
      entry: spellId.value,
      item: _parseInt(itemController.text),
      reference: _parseInt(referenceController.text),
      chance: _parseDouble(chanceController.text),
      questRequired: _parseInt(questRequiredController.text),
      lootMode: _parseInt(lootModeController.text),
      groupId: _parseInt(groupIdController.text),
      minCount: _parseInt(minCountController.text),
      maxCount: _parseInt(maxCountController.text),
      comment: commentController.text,
    );
    return data;
  }

  int _parseInt(String text) {
    if (text.isEmpty) return 0;
    final value = int.tryParse(text);
    if (value == null) throw Exception('输入值 "$text" 不是有效数字');
    return value;
  }

  double _parseDouble(String text) {
    if (text.isEmpty) return 0.0;
    final value = double.tryParse(text);
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
    final loot = items.value[index];
    fillForm(loot);
  }

  Future<void> copy(BuildContext context) async {
    final index = selectedIndex.value;
    if (index == null || index < 0 || index >= items.value.length) return;
    final loot = items.value[index];
    try {
      await repository.copySpellLootTemplate(loot);
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
    final loot = items.value[index];
    final confirmed = await showShadDialog<bool>(
      context: context,
      builder: (context) => ShadDialog.alert(
        title: Text('确认删除'),
        description: Text('确定要删除这条技能掉落记录吗？'),
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
        await repository.destroySpellLootTemplate(loot.entry, loot.item);
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
      await repository.storeSpellLootTemplate(data);
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
      await repository.updateSpellLootTemplate(oldData, newData);
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
    itemController.dispose();
    referenceController.dispose();
    chanceController.dispose();
    questRequiredController.dispose();
    lootModeController.dispose();
    groupIdController.dispose();
    minCountController.dispose();
    maxCountController.dispose();
    commentController.dispose();
  }
}
