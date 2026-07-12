import 'package:flutter/widgets.dart';
import 'package:foxy/entity/creature_template_spell_entity.dart';
import 'package:foxy/util/format_util.dart';
import 'package:foxy/util/parse_util.dart';
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
  final creatureIdController = TextEditingController();
  final indexController = TextEditingController();
  final spellController = TextEditingController();
  final verifiedBuildController = TextEditingController();

  final _repository = GetIt.instance.get<CreatureTemplateSpellRepository>();

  String _fmt(num v) => formatNum(v);

  int _pi(String t, [String field = '']) => parseIntField(t, field: field);

  Future<void> load() async {
    final data = await _repository.getBriefCreatureTemplateSpells(
      creatureId.value,
    );
    items.value = data;
    selectedIndex.value = null;
  }

  void resetForm() {
    indexController.text = _fmt(0);
    spellController.text = _fmt(0);
    verifiedBuildController.text = _fmt(0);
  }

  void fillForm(CreatureTemplateSpellEntity spell) {
    indexController.text = _fmt(spell.index);
    spellController.text = _fmt(spell.spell);
    verifiedBuildController.text = _fmt(spell.verifiedBuild);
  }

  CreatureTemplateSpellEntity collectFromForm() {
    return CreatureTemplateSpellEntity(
      creatureID: creatureId.value,
      index: _pi(indexController.text),
      spell: _pi(spellController.text),
      verifiedBuild: _pi(verifiedBuildController.text),
    );
  }

  Future<void> create() async {
    try {
      final blank = await _repository.createCreatureTemplateSpell(
        creatureId.value,
      );
      fillForm(blank);
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
      await _repository.copyCreatureTemplateSpell(
        spell.creatureID,
        spell.index,
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
    final idx = selectedIndex.value;
    if (idx == null || idx < 0 || idx >= items.value.length) return;

    final spell = items.value[idx];

    final confirmed = await showFoxyDialog<bool>(
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
        await _repository.destroyCreatureTemplateSpell(
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
      await _repository.storeCreatureTemplateSpell(spell);
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
      await _repository.updateCreatureTemplateSpell(spell);
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
      creatureIdController.text = _fmt(creatureId);
      await load();
    } catch (e) {
      LoggerUtil.instance.e('初始化生物法术失败: $e');
      DialogUtil.instance.error('初始化生物法术失败: $e');
    }
  }

  void pop() {
    routerFacade.goBack();
  }

  void dispose() {
    creatureIdController.dispose();
    indexController.dispose();
    spellController.dispose();
    verifiedBuildController.dispose();
  }
}
