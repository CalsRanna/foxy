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
  // 表单控制器
  final indexController = TextEditingController();
  final spellController = TextEditingController();
  final verifiedBuildController = TextEditingController();

  final repository = CreatureTemplateSpellRepository();

  /// 加载数据
  Future<void> load() async {
    final data = await repository.getCreatureTemplateSpells(creatureId.value);
    items.value = data;
    selectedIndex.value = null;
  }

  /// 重置表单
  void resetForm() {
    indexController.clear();
    spellController.clear();
    verifiedBuildController.text = '0';
  }

  /// 填充表单
  void fillForm(CreatureTemplateSpellEntity spell) {
    indexController.text = spell.index.toString();
    spellController.text = spell.spell.toString();
    verifiedBuildController.text = spell.verifiedBuild.toString();
  }

  /// 从表单收集数据
  CreatureTemplateSpellEntity collectFromForm() {
    final spell = CreatureTemplateSpellEntity();
    spell.creatureID = creatureId.value;
    spell.index = _parseInt(indexController.text);
    spell.spell = _parseInt(spellController.text);
    spell.verifiedBuild = _parseInt(verifiedBuildController.text);
    return spell;
  }

  int _parseInt(String text) {
    if (text.isEmpty) return 0;
    final value = int.tryParse(text);
    if (value == null) throw Exception('输入值 "$text" 不是有效数字');
    return value;
  }

  /// 创建新记录
  Future<void> create() async {
    try {
      final nextIndex = await repository.getNextIndex(creatureId.value);
      resetForm();
      indexController.text = nextIndex.toString();
      selectedIndex.value = null;
    } catch (e) {
      LoggerUtil.instance.e('创建生物法术记录失败: $e');
      DialogUtil.instance.error('创建生物法术记录失败: $e');
    }
  }

  /// 编辑选中记录
  void edit() {
    final index = selectedIndex.value;
    if (index == null || index < 0 || index >= items.value.length) return;

    final spell = items.value[index];
    fillForm(spell);
  }

  /// 复制记录
  Future<void> copy(BuildContext context) async {
    final index = selectedIndex.value;
    if (index == null || index < 0 || index >= items.value.length) return;

    final spell = items.value[index];
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

  /// 删除记录
  Future<void> delete(BuildContext context) async {
    final index = selectedIndex.value;
    if (index == null || index < 0 || index >= items.value.length) return;

    final spell = items.value[index];

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

  /// 保存记录
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

  /// 更新记录
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

  /// 选择行
  void selectRow(int index) {
    if (index >= 0 && index < items.value.length) {
      selectedIndex.value = index;
    }
  }

  /// 初始化
  Future<void> initSignals({required int creatureId}) async {
    try {
      this.creatureId.value = creatureId;
      await load();
    } catch (e) {
      LoggerUtil.instance.e('初始化生物法术失败: $e');
      DialogUtil.instance.error('初始化生物法术失败: $e');
    }
  }

  /// 退出页面
  void pop() {
    routerFacade.goBack();
  }

  /// 清理资源
  void dispose() {
    indexController.dispose();
    spellController.dispose();
    verifiedBuildController.dispose();
  }
}
