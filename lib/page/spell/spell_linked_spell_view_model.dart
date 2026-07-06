import 'package:flutter/widgets.dart';
import 'package:foxy/entity/spell_linked_spell_entity.dart';
import 'package:foxy/repository/spell_linked_spell_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/format_util.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class SpellLinkedSpellViewModel {
  final routerFacade = GetIt.instance.get<RouterFacade>();

  final spellId = signal(0);
  final items = signal<List<SpellLinkedSpellEntity>>([]);
  final selectedIndex = signal<int?>(null);
  final spellEffectController = TextEditingController();
  final typeController = TextEditingController();
  final commentController = TextEditingController();

  final _repository = GetIt.instance.get<SpellLinkedSpellRepository>();

  String _fmt(num v) => formatNum(v);

  int _pi(String t) => int.tryParse(t) ?? 0;

  Future<void> load() async {
    final data = await _repository.getSpellLinkedSpells(spellId.value);
    items.value = data;
    selectedIndex.value = null;
  }

  void resetForm() {
    spellEffectController.text = _fmt(0);
    typeController.text = _fmt(0);
    commentController.clear();
  }

  void fillForm(SpellLinkedSpellEntity data) {
    spellEffectController.text = _fmt(data.spellEffect);
    typeController.text = _fmt(data.type);
    commentController.text = data.comment;
  }

  SpellLinkedSpellEntity collectFromForm() {
    final data = SpellLinkedSpellEntity(
      spellTrigger: spellId.value,
      spellEffect: _pi(spellEffectController.text),
      type: _pi(typeController.text),
      comment: commentController.text,
    );
    return data;
  }

  Future<void> create() async {
    try {
      resetForm();
      selectedIndex.value = null;
    } catch (e) {
      LoggerUtil.instance.e('法术链接-创建失败: $e');
      DialogUtil.instance.error('法术链接-创建失败: $e');
    }
  }

  void edit() {
    final index = selectedIndex.value;
    if (index == null || index < 0 || index >= items.value.length) return;
    final linked = items.value[index];
    fillForm(linked);
  }

  Future<void> copy(BuildContext context) async {
    final index = selectedIndex.value;
    if (index == null || index < 0 || index >= items.value.length) return;
    final linked = items.value[index];
    try {
      await _repository.copySpellLinkedSpell(linked);
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
    final linked = items.value[index];
    final confirmed = await showShadDialog<bool>(
      context: context,
      builder: (context) => ShadDialog.alert(
        title: Text('确认删除'),
        description: Text('确定要删除这条链接技能记录吗？'),
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
        await _repository.destroySpellLinkedSpell(
          linked.spellTrigger,
          linked.spellEffect,
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
      final data = collectFromForm();
      await _repository.storeSpellLinkedSpell(data);
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
      await _repository.updateSpellLinkedSpell(oldData, newData);
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
      LoggerUtil.instance.e('法术链接-初始化失败: $e');
      DialogUtil.instance.error('法术链接-初始化失败: $e');
    }
  }

  void pop() {
    routerFacade.goBack();
  }

  void dispose() {
    commentController.dispose();
    spellEffectController.dispose();
    typeController.dispose();
  }
}
