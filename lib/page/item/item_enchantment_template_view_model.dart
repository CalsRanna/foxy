import 'package:flutter/widgets.dart';
import 'package:foxy/entity/item_enchantment_template_entity.dart';
import 'package:foxy/repository/item_enchantment_template_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class ItemEnchantmentTemplateViewModel {
  final routerFacade = GetIt.instance.get<RouterFacade>();

  final entry = signal(0);
  final items = signal<List<BriefItemEnchantmentTemplateEntity>>([]);
  final selectedIndex = signal<int?>(null);
  final loading = signal(false);
  final saving = signal(false);
  final creating = signal(false);
  final editing = signal(false);
  int? editingEnch;

  // 表单控制器
  final entryController = TextEditingController();
  final enchController = TextEditingController();
  final chanceController = TextEditingController();

  final repository = ItemEnchantmentTemplateRepository();

  /// 加载数据
  Future<void> load() async {
    loading.value = true;
    try {
      final data = await repository.getItemEnchantmentTemplatesByEntry(
        entry.value,
      );
      items.value = data;
      selectedIndex.value = null;
      creating.value = false;
      editing.value = false;
      editingEnch = null;
    } catch (e) {
      rethrow;
    } finally {
      loading.value = false;
    }
  }

  /// 重置表单
  void resetForm() {
    entryController.text = entry.value.toString();
    enchController.clear();
    chanceController.text = '0';
  }

  /// 填充表单
  void fillForm(BriefItemEnchantmentTemplateEntity model) {
    entryController.text = model.entry.toString();
    enchController.text = model.ench.toString();
    chanceController.text = model.chance.toString();
  }

  /// 从表单收集数据
  ItemEnchantmentTemplateEntity collectFromForm() {
    return ItemEnchantmentTemplateEntity(
      entry: entry.value,
      ench: _parseInt(enchController.text),
      chance: _parseDouble(chanceController.text),
    );
  }

  int _parseInt(String text) {
    if (text.isEmpty) return 0;
    final value = int.tryParse(text);
    if (value == null) throw Exception('输入值 "$text" 不是有效数字');
    return value;
  }

  double _parseDouble(String text) => text.isEmpty ? 0 : double.parse(text);

  /// 创建新记录
  Future<void> create() async {
    try {
      final maxEnch = items.value.fold<int>(
        0,
        (max, e) => e.ench > max ? e.ench : max,
      );
      resetForm();
      enchController.text = (maxEnch + 1).toString();
      creating.value = true;
      editing.value = false;
      selectedIndex.value = null;
      editingEnch = null;
    } catch (e) {
      LoggerUtil.instance.e('创建失败: $e');
      DialogUtil.instance.error('创建失败: $e');
    }
  }

  /// 编辑选中记录
  void edit() {
    final index = selectedIndex.value;
    if (index == null || index < 0 || index >= items.value.length) return;

    final model = items.value[index];
    fillForm(model);
    editing.value = true;
    creating.value = false;
    editingEnch = model.ench;
  }

  /// 复制记录
  Future<void> copy(BuildContext context) async {
    final index = selectedIndex.value;
    if (index == null || index < 0 || index >= items.value.length) return;

    final model = items.value[index];
    try {
      await repository.copyItemEnchantmentTemplate(model.entry, model.ench);
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

    final model = items.value[index];

    final confirmed = await showShadDialog<bool>(
      context: context,
      builder: (context) => ShadDialog.alert(
        title: Text('确认删除'),
        description: Text('确定要删除这条附魔记录吗？'),
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
        await repository.destroyItemEnchantmentTemplate(
          model.entry,
          model.ench,
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
    saving.value = true;
    try {
      final model = collectFromForm();
      await repository.storeItemEnchantmentTemplate(model);
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

  /// 更新记录
  Future<void> update(BuildContext context) async {
    saving.value = true;
    try {
      final model = collectFromForm();
      await repository.updateItemEnchantmentTemplate(
        model,
        oldEnch: editingEnch,
      );
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

  /// 选择行
  void selectRow(int index) {
    if (index >= 0 && index < items.value.length) {
      selectedIndex.value = index;
    }
  }

  /// 初始化
  Future<void> initSignals({required int entry}) async {
    try {
      this.entry.value = entry;
      await load();
    } catch (e) {
      LoggerUtil.instance.e('初始化失败: $e');
      DialogUtil.instance.error('初始化失败: $e');
    }
  }

  /// 退出页面
  void pop() {
    routerFacade.goBack();
  }

  /// 清理资源
  void dispose() {
    entryController.dispose();
    enchController.dispose();
    chanceController.dispose();
  }
}
