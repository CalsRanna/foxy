import 'package:flutter/widgets.dart';
import 'package:foxy/entity/creature_template_spell_entity.dart';
import 'package:foxy/repository/creature_template_spell_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class CreatureTemplateSpellViewModel {
  final routerFacade = GetIt.instance.get<RouterFacade>();

  final creatureId = signal(0);
  final items = signal<List<CreatureTemplateSpellEntity>>([]);
  final selectedIndex = signal<int?>(null);
  final index = signal<int>(0);
  final spell = signal<int>(0);
  final verifiedBuild = signal<int>(0);

  final repository = CreatureTemplateSpellRepository();

  Future<void> load() async {
    final data = await repository.getCreatureTemplateSpells(creatureId.value);
    items.value = data;
    selectedIndex.value = null;
  }

  void resetForm() {
    index.value = 0;
    spell.value = 0;
    verifiedBuild.value = 0;
  }

  void fillForm(CreatureTemplateSpellEntity spell) {
    index.value = spell.index;
    this.spell.value = spell.spell;
    verifiedBuild.value = spell.verifiedBuild;
  }

  CreatureTemplateSpellEntity collectFromForm() {
    final spell = CreatureTemplateSpellEntity();
    spell.creatureID = creatureId.value;
    spell.index = index.value;
    spell.spell = this.spell.value;
    spell.verifiedBuild = verifiedBuild.value;
    return spell;
  }

  Future<void> create() async {
    try {
      final nextIndex = await repository.getNextIndex(creatureId.value);
      resetForm();
      index.value = nextIndex;
      selectedIndex.value = null;
    } catch (e) {
      LoggerUtil.instance.e('创建生物法术记录失败: $e');
      DialogUtil.instance.error('创建生物法术记录失败: $e');
    }
  }

  void edit() {
    final idx = selectedIndex.value;
    if (idx == null || idx < 0 || idx >= items.value.length) return;

    final spell = items.value[idx];
    fillForm(spell);
  }

  Future<void> copy(BuildContext context) async {
    final idx = selectedIndex.value;
    if (idx == null || idx < 0 || idx >= items.value.length) return;

    final spell = items.value[idx];
    try {
      await repository.copyCreatureTemplateSpell(spell.creatureID, spell.index);
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
    final idx = selectedIndex.value;
    if (idx == null || idx < 0 || idx >= items.value.length) return;

    final spell = items.value[idx];

    final confirmed = await showShadDialog<bool>(
      context: context,
      builder: (context) => ShadDialog.alert(
        title: Text('确认删除'),
        description: Text('确定要删除这条技能记录吗？'),
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
        await repository.destroyCreatureTemplateSpell(
          spell.creatureID,
          spell.index,
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
      final spell = collectFromForm();
      await repository.storeCreatureTemplateSpell(spell);
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
    try {
      final spell = collectFromForm();
      await repository.updateCreatureTemplateSpell(spell);
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

  Future<void> initSignals({required int creatureId}) async {
    try {
      this.creatureId.value = creatureId;
      await load();
    } catch (e) {
      LoggerUtil.instance.e('初始化生物法术失败: $e');
      DialogUtil.instance.error('初始化生物法术失败: $e');
    }
  }

  void pop() {
    routerFacade.goBack();
  }

  void dispose() {}
}
