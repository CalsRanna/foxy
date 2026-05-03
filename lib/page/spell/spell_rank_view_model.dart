import 'package:flutter/widgets.dart';
import 'package:foxy/entity/spell_rank_entity.dart';
import 'package:foxy/repository/spell_rank_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class SpellRankViewModel {
  final routerFacade = GetIt.instance.get<RouterFacade>();

  final spellId = signal(0);
  final items = signal<List<SpellRankEntity>>([]);
  final selectedIndex = signal<int?>(null);
  final firstSpellId = signal<int>(0);
  final rankSpellId = signal<int>(0);
  final rank = signal<int>(0);

  final repository = SpellRankRepository();

  Future<void> load() async {
    final data = await repository.getSpellRanks(spellId.value);
    items.value = data;
    selectedIndex.value = null;
  }

  void resetForm() {
    firstSpellId.value = 0;
    rankSpellId.value = 0;
    rank.value = 0;
  }

  void fillForm(SpellRankEntity data) {
    firstSpellId.value = data.firstSpellId;
    rankSpellId.value = data.spellId;
    rank.value = data.rank;
  }

  SpellRankEntity collectFromForm() {
    final data = SpellRankEntity(
      firstSpellId: firstSpellId.value,
      spellId: rankSpellId.value,
      rank: rank.value,
    );
    return data;
  }

  Future<void> create() async {
    try {
      resetForm();
      firstSpellId.value = items.value.isNotEmpty
          ? items.value.first.firstSpellId
          : 0;
      rankSpellId.value = spellId.value;
      rank.value = items.value.isNotEmpty
          ? (items.value.last.rank + 1)
          : 1;
      selectedIndex.value = null;
    } catch (e) {
      LoggerUtil.instance.e('法术等级-创建失败: $e');
      DialogUtil.instance.error('法术等级-创建失败: $e');
    }
  }

  void edit() {
    final index = selectedIndex.value;
    if (index == null || index < 0 || index >= items.value.length) return;
    final rank = items.value[index];
    fillForm(rank);
  }

  Future<void> copy(BuildContext context) async {
    final index = selectedIndex.value;
    if (index == null || index < 0 || index >= items.value.length) return;
    final rank = items.value[index];
    try {
      await repository.copySpellRank(rank);
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
    final rank = items.value[index];
    final confirmed = await showShadDialog<bool>(
      context: context,
      builder: (context) => ShadDialog.alert(
        title: Text('确认删除'),
        description: Text('确定要删除这条技能排行记录吗？'),
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
        await repository.destroySpellRank(rank.firstSpellId, rank.rank);
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
      await repository.storeSpellRank(data);
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
      await repository.updateSpellRank(oldData, newData);
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
      LoggerUtil.instance.e('法术等级-初始化失败: $e');
      DialogUtil.instance.error('法术等级-初始化失败: $e');
    }
  }

  void pop() {
    routerFacade.goBack();
  }

  void dispose() {}
}
