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
  final creating = signal(false);
  final editing = signal(false);
  int? editingEnch;

  final enchSignal = signal<int>(0);
  final chanceController = TextEditingController();

  final _repository = GetIt.instance.get<ItemEnchantmentTemplateRepository>();

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

  double _pd(String t) => double.tryParse(t) ?? 0.0;

  Future<void> load() async {
    final data = await _repository.getItemEnchantmentTemplatesByEntry(
      entry.value,
    );
    items.value = data;
    selectedIndex.value = null;
    creating.value = false;
    editing.value = false;
    editingEnch = null;
  }

  void resetForm() {
    enchSignal.value = 0;
    chanceController.text = _fmt(0);
  }

  void fillForm(BriefItemEnchantmentTemplateEntity model) {
    enchSignal.value = model.ench;
    chanceController.text = _fmt(model.chance);
  }

  ItemEnchantmentTemplateEntity collectFromForm() {
    return ItemEnchantmentTemplateEntity(
      entry: entry.value,
      ench: enchSignal.value,
      chance: _pd(chanceController.text),
    );
  }

  Future<void> create() async {
    try {
      final maxEnch = items.value.fold<int>(
        0,
        (max, e) => e.ench > max ? e.ench : max,
      );
      resetForm();
      enchSignal.value = (maxEnch + 1);
      creating.value = true;
      editing.value = false;
      selectedIndex.value = null;
      editingEnch = null;
    } catch (e) {
      LoggerUtil.instance.e('创建失败: $e');
      DialogUtil.instance.error('创建失败: $e');
    }
  }

  void edit() {
    final index = selectedIndex.value;
    if (index == null || index < 0 || index >= items.value.length) return;

    final model = items.value[index];
    fillForm(model);
    editing.value = true;
    creating.value = false;
    editingEnch = model.ench;
  }

  Future<void> copy(BuildContext context) async {
    final index = selectedIndex.value;
    if (index == null || index < 0 || index >= items.value.length) return;

    final model = items.value[index];
    try {
      await _repository.copyItemEnchantmentTemplate(model.entry, model.ench);
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
        await _repository.destroyItemEnchantmentTemplate(
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

  Future<void> save(BuildContext context) async {
    try {
      final model = collectFromForm();
      await _repository.storeItemEnchantmentTemplate(model);
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
      final model = collectFromForm();
      await _repository.updateItemEnchantmentTemplate(
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
    }
  }

  void selectRow(int index) {
    if (index >= 0 && index < items.value.length) {
      selectedIndex.value = index;
    }
  }

  Future<void> initSignals({required int entry}) async {
    try {
      this.entry.value = entry;
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
  }
}
