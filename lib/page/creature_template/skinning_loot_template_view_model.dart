import 'package:flutter/widgets.dart';
import 'package:foxy/entity/creature_template_entity.dart';
import 'package:foxy/util/format_util.dart';
import 'package:foxy/entity/loot_template_entity.dart';
import 'package:foxy/repository/creature_template_repository.dart';
import 'package:foxy/repository/loot_template_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class SkinningLootTemplateViewModel {
  final routerFacade = GetIt.instance.get<RouterFacade>();

  final creatureId = signal(0);
  final creatureTemplate = signal<CreatureTemplateEntity?>(null);
  final items = signal<List<BriefLootTemplateEntity>>([]);
  final selectedIndex = signal<int?>(null);
  // 表单控制器
  final itemController = TextEditingController();
  final referenceController = TextEditingController();
  final chanceController = TextEditingController();
  final questRequiredController = ShadSelectController<int>();
  final lootModeController = TextEditingController();
  final groupIdController = TextEditingController();
  final minCountController = TextEditingController();
  final maxCountController = TextEditingController();
  final commentController = TextEditingController();

  final repository = LootTemplateRepository(LootTableType.skinning);
  final _creatureRepository = GetIt.instance.get<CreatureTemplateRepository>();

  /// 加载数据
  String _fmt(num v) => formatNum(v);

  int _pi(String t) => int.tryParse(t) ?? 0;
  double _pd(String t) => double.tryParse(t) ?? 0.0;

  Future<void> load() async {
    final template = await _creatureRepository.getCreatureTemplate(
      creatureId.value,
    );
    creatureTemplate.value = template;

    final data = await repository.getLootTemplates(template.skinLoot);
    items.value = data;
    selectedIndex.value = null;
  }

  /// 重置表单
  void resetForm() {
    itemController.clear();
    referenceController.text = _fmt(0);
    chanceController.text = _fmt(0.0);
    questRequiredController.value = {0};
    lootModeController.text = _fmt(1);
    groupIdController.text = _fmt(0);
    minCountController.text = _fmt(1);
    maxCountController.text = _fmt(1);
    commentController.clear();
  }

  /// 填充表单
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

  /// 从表单收集数据
  LootTemplateEntity collectFromForm() {
    final template = creatureTemplate.value;
    if (template == null) return LootTemplateEntity();

    return LootTemplateEntity(
      entry: template.skinLoot,
      item: _parseInt(itemController.text),
      reference: _pi(referenceController.text),
      chance: _pd(chanceController.text),
      questRequired: questRequiredController.value.firstOrNull == 1,
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

  /// 创建新记录
  Future<void> create() async {
    try {
      final template = creatureTemplate.value;
      if (template == null) return;

      final nextItem = await repository.getNextItemId(template.skinLoot);
      resetForm();
      itemController.text = nextItem.toString();
      selectedIndex.value = null;
    } catch (e) {
      LoggerUtil.instance.e('创建剥皮掉落记录失败: $e');
      DialogUtil.instance.error('创建剥皮掉落记录失败: $e');
    }
  }

  /// 编辑选中记录
  void edit() {
    final index = selectedIndex.value;
    if (index == null || index < 0 || index >= items.value.length) return;

    final loot = items.value[index];
    fillForm(loot);
  }

  /// 复制记录
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

  /// 删除记录
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

  /// 保存记录
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

  /// 更新记录
  Future<void> update(BuildContext context) async {
    try {
      final loot = collectFromForm();
      final oldItem = items.value[selectedIndex.value!].item;
      await repository.updateLootTemplate(loot, oldItem: oldItem);
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
      LoggerUtil.instance.e('初始化剥皮掉落失败: $e');
      DialogUtil.instance.error('初始化剥皮掉落失败: $e');
    }
  }

  /// 退出页面
  void pop() {
    routerFacade.goBack();
  }

  /// 清理资源
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
