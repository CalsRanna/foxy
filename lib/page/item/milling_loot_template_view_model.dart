import 'package:flutter/widgets.dart';
import 'package:foxy/entity/loot_template_entity.dart';
import 'package:foxy/repository/loot_template_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class MillingLootTemplateViewModel {
  final routerFacade = GetIt.instance.get<RouterFacade>();

  final entry = signal(0);
  final items = signal<List<BriefLootTemplateEntity>>([]);
  final selectedIndex = signal<int?>(null);
  final creating = signal(false);
  final editing = signal(false);
  int? editingItem;

  final itemController = TextEditingController();
  final referenceController = TextEditingController();
  final chanceController = TextEditingController();
  final questRequiredController = ShadSelectController<int>();
  final lootModeController = TextEditingController();
  final groupIdController = TextEditingController();
  final minCountController = TextEditingController();
  final maxCountController = TextEditingController();
  final commentController = TextEditingController();

  final repository = LootTemplateRepository(LootTableType.milling);

  String _fmt(num v) {
    if (v is double) {
      final s = v.toString();
      if (s.contains('.') && s.endsWith('0')) {
        return s.replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '');
      }
      return s;
    }
    return v.toString();
  }

  int _pi(String t) => int.tryParse(t) ?? 0;
  double _pd(String t) => double.tryParse(t) ?? 0.0;

  Future<void> load() async {
    final data = await repository.getLootTemplates(entry.value);
    items.value = data;
    selectedIndex.value = null;
    creating.value = false;
    editing.value = false;
    editingItem = null;
  }

  void resetForm() {
    itemController.clear();
    referenceController.text = _fmt(0);
    chanceController.text = _fmt(0);
    questRequiredController.value = {0};
    lootModeController.text = _fmt(1);
    groupIdController.text = _fmt(0);
    minCountController.text = _fmt(1);
    maxCountController.text = _fmt(1);
    commentController.clear();
  }

  void fillForm(BriefLootTemplateEntity loot) {
    itemController.text = loot.item.toString();
    referenceController.text = _fmt(loot.reference);
    chanceController.text = _fmt(loot.chance);
    questRequiredController.value = {loot.questRequired ? 1 : 0};
    lootModeController.text = _fmt(loot.lootMode);
    groupIdController.text = _fmt(loot.groupId);
    minCountController.text = _fmt(loot.minCount);
    maxCountController.text = _fmt(loot.maxCount);
    commentController.text = loot.comment;
  }

  LootTemplateEntity collectFromForm() {
    return LootTemplateEntity(
      entry: entry.value,
      item: _parseInt(itemController.text),
      reference: _pi(referenceController.text),
      chance: _pd(chanceController.text),
      questRequired: questRequiredController.value.first == 1,
      lootMode: _pi(lootModeController.text),
      groupId: _pi(groupIdController.text),
      minCount: _pi(minCountController.text),
      maxCount: _pi(maxCountController.text),
      comment: commentController.text,
    );
  }

  int _parseInt(String text) {
    if (text.isEmpty) return 0;
    final value = int.tryParse(text);
    if (value == null) throw Exception('输入值 "$text" 不是有效数字');
    return value;
  }

  Future<void> create() async {
    try {
      final nextItem = await repository.getNextItemId(entry.value);
      resetForm();
      itemController.text = nextItem.toString();
      creating.value = true;
      editing.value = false;
      selectedIndex.value = null;
      editingItem = null;
    } catch (e) {
      LoggerUtil.instance.e('创建失败: $e');
      DialogUtil.instance.error('创建失败: $e');
    }
  }

  void edit() {
    final index = selectedIndex.value;
    if (index == null || index < 0 || index >= items.value.length) return;

    final loot = items.value[index];
    fillForm(loot);
    editing.value = true;
    creating.value = false;
    editingItem = loot.item;
  }

  Future<void> copy(BuildContext context) async {
    final index = selectedIndex.value;
    if (index == null || index < 0 || index >= items.value.length) return;

    final loot = items.value[index];
    try {
      await repository.copyLootTemplate(loot.entry, loot.item);
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
        description: Text('确定要删除这条掉落记录吗？'),
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
        await repository.destroyLootTemplate(loot.entry, loot.item);
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
      final loot = collectFromForm();
      await repository.storeLootTemplate(loot);
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
      final loot = collectFromForm();
      await repository.updateLootTemplate(loot, oldItem: editingItem);
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

  Future<void> initSignals({required int itemId}) async {
    try {
      entry.value = itemId;
      await load();
    } catch (e) {
      LoggerUtil.instance.e('初始化失败: $e');
      DialogUtil.instance.error('初始化失败: $e');
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
