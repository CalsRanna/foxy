import 'package:flutter/widgets.dart';
import 'package:foxy/entity/spell_loot_template_entity.dart';
import 'package:foxy/util/format_util.dart';
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
  final itemController = TextEditingController();
  final referenceController = TextEditingController();
  final chanceController = TextEditingController();
  final questRequiredController = TextEditingController();
  final lootModeController = TextEditingController();
  final groupIdController = TextEditingController();
  final minCountController = TextEditingController();
  final maxCountController = TextEditingController();
  final commentController = TextEditingController();

  final _repository = GetIt.instance.get<SpellLootTemplateRepository>();

  String _fmt(num v) => formatNum(v);

  int _pi(String t) => int.tryParse(t) ?? 0;
  double _pd(String t) => double.tryParse(t) ?? 0.0;

  Future<void> load() async {
    final data = await _repository.getSpellLootTemplates(spellId.value);
    items.value = data;
    selectedIndex.value = null;
  }

  void resetForm() {
    itemController.text = _fmt(0);
    referenceController.text = _fmt(0);
    chanceController.text = _fmt(0.0);
    questRequiredController.text = _fmt(0);
    lootModeController.text = _fmt(0);
    groupIdController.text = _fmt(0);
    minCountController.text = _fmt(0);
    maxCountController.text = _fmt(0);
    commentController.clear();
  }

  void fillForm(SpellLootTemplateEntity data) {
    itemController.text = _fmt(data.item);
    referenceController.text = _fmt(data.reference);
    chanceController.text = _fmt(data.chance);
    questRequiredController.text = _fmt(data.questRequired);
    lootModeController.text = _fmt(data.lootMode);
    groupIdController.text = _fmt(data.groupId);
    minCountController.text = _fmt(data.minCount);
    maxCountController.text = _fmt(data.maxCount);
    commentController.text = data.comment;
  }

  SpellLootTemplateEntity collectFromForm() {
    final data = SpellLootTemplateEntity(
      entry: spellId.value,
      item: _pi(itemController.text),
      reference: _pi(referenceController.text),
      chance: _pd(chanceController.text),
      questRequired: _pi(questRequiredController.text),
      lootMode: _pi(lootModeController.text),
      groupId: _pi(groupIdController.text),
      minCount: _pi(minCountController.text),
      maxCount: _pi(maxCountController.text),
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
      await _repository.copySpellLootTemplate(loot);
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
        await _repository.destroySpellLootTemplate(loot.entry, loot.item);
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
      await _repository.storeSpellLootTemplate(data);
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
      await _repository.updateSpellLootTemplate(oldData, newData);
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
    chanceController.dispose();
    commentController.dispose();
    groupIdController.dispose();
    itemController.dispose();
    lootModeController.dispose();
    maxCountController.dispose();
    minCountController.dispose();
    questRequiredController.dispose();
    referenceController.dispose();
  }
}
