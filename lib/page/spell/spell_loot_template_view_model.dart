import 'package:flutter/widgets.dart';
import 'package:foxy/entity/spell_loot_template_entity.dart';
import 'package:foxy/repository/spell_loot_template_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class SpellLootTemplateViewModel {
  final routerFacade = GetIt.instance.get<RouterFacade>();

  final spellId = signal(0);
  final items = signal<List<SpellLootTemplateEntity>>([]);
  final selectedIndex = signal<int?>(null);
  final item = signal<int>(0);
  final reference = signal<int>(0);
  final chance = signal<double>(0.0);
  final questRequired = signal<int>(0);
  final lootMode = signal<int>(0);
  final groupId = signal<int>(0);
  final minCount = signal<int>(0);
  final maxCount = signal<int>(0);
  final commentController = TextEditingController();

  final repository = SpellLootTemplateRepository();

  Future<void> load() async {
    final data = await repository.getSpellLootTemplates(spellId.value);
    items.value = data;
    selectedIndex.value = null;
  }

  void resetForm() {
    item.value = 0;
    reference.value = 0;
    chance.value = 0.0;
    questRequired.value = 0;
    lootMode.value = 0;
    groupId.value = 0;
    minCount.value = 0;
    maxCount.value = 0;
    commentController.clear();
  }

  void fillForm(SpellLootTemplateEntity data) {
    item.value = data.item;
    reference.value = data.reference;
    chance.value = data.chance;
    questRequired.value = data.questRequired;
    lootMode.value = data.lootMode;
    groupId.value = data.groupId;
    minCount.value = data.minCount;
    maxCount.value = data.maxCount;
    commentController.text = data.comment;
  }

  SpellLootTemplateEntity collectFromForm() {
    final data = SpellLootTemplateEntity(
      entry: spellId.value,
      item: item.value,
      reference: reference.value,
      chance: chance.value,
      questRequired: questRequired.value,
      lootMode: lootMode.value,
      groupId: groupId.value,
      minCount: minCount.value,
      maxCount: maxCount.value,
      comment: commentController.text,
    );
    return data;
  }

  Future<void> create() async {
    try {
      resetForm();
      selectedIndex.value = null;
    } catch (e) {
      LoggerUtil.instance.e('法术掉落模板-创建失败: $e');
      DialogUtil.instance.error('法术掉落模板-创建失败: $e');
    }
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
    }
  }

  Future<void> update(BuildContext context) async {
    final index = selectedIndex.value;
    if (index == null || index < 0 || index >= items.value.length) return;
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
      LoggerUtil.instance.e('法术掉落模板-初始化失败: $e');
      DialogUtil.instance.error('法术掉落模板-初始化失败: $e');
    }
  }

  void pop() {
    routerFacade.goBack();
  }

  void dispose() {
    commentController.dispose();
  }
}
