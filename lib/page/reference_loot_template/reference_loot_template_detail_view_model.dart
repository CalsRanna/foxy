import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/loot_template_entity.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/loot_template_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class ReferenceLootTemplateDetailViewModel {
  final routerFacade = GetIt.instance.get<RouterFacade>();
  final repository = LootTemplateRepository(LootTableType.reference);

  final entry = signal<int>(0);
  final itemController = TextEditingController();
  final reference = signal<int>(0);
  final chance = signal<double>(0.0);
  final questRequiredController = ShadSelectController<int>();
  final lootMode = signal<int>(0);
  final groupId = signal<int>(0);
  final minCount = signal<int>(0);
  final maxCount = signal<int>(0);
  final commentController = TextEditingController();

  final template = signal<LootTemplateEntity?>(null);
  final originalEntry = signal<int?>(null);
  final originalItem = signal<int?>(null);
  Future<void> initSignals({int? entry, int? item}) async {
    if (entry == null || item == null) return;
    originalEntry.value = entry;
    originalItem.value = item;
    try {
      final result = await repository.getLootTemplate(entry, item);
      if (result != null) {
        template.value = result;
        _initControllers(result);
      }
    } catch (e, s) {
      LoggerUtil.instance.e(
        '加载关联掉落(Entry=$entry, Item=$item)失败',
        error: e,
        stackTrace: s,
      );
    }
  }

  void _initControllers(LootTemplateEntity loot) {
    entry.value = loot.entry;
    itemController.text = loot.item.toString();
    reference.value = loot.reference;
    chance.value = loot.chance;
    questRequiredController.value = {loot.questRequired ? 1 : 0};
    lootMode.value = loot.lootMode;
    groupId.value = loot.groupId;
    minCount.value = loot.minCount;
    maxCount.value = loot.maxCount;
    commentController.text = loot.comment;
  }

  Future<void> save(BuildContext context) async {
    try {
      final data = _collectFromControllers();
      await repository.storeLootTemplate(data);
      template.value = data;
      _logActivity(ActivityActionType.create, data);
      if (!context.mounted) return;
      var toast = ShadToast(description: Text('关联掉落已保存'));
      ShadSonner.of(context).show(toast);
    } catch (e) {
      if (!context.mounted) return;
      var toast = ShadToast(description: Text(e.toString()));
      ShadSonner.of(context).show(toast);
    }
  }

  Future<void> update(BuildContext context) async {
    final oEntry = originalEntry.value;
    final oItem = originalItem.value;
    if (oEntry == null || oItem == null) return;

    try {
      final data = _collectFromControllers();
      await repository.updateLootTemplate(data, oldItem: oItem);
      template.value = data;
      _logActivity(ActivityActionType.update, data);
      if (!context.mounted) return;
      var toast = ShadToast(description: Text('更新成功'));
      ShadSonner.of(context).show(toast);
    } catch (e) {
      if (!context.mounted) return;
      var toast = ShadToast(description: Text(e.toString()));
      ShadSonner.of(context).show(toast);
    }
  }

  void pop() {
    routerFacade.goBack();
  }

  LootTemplateEntity _collectFromControllers() {
    return LootTemplateEntity(
      entry: entry.value,
      item: _parseInt(itemController.text),
      reference: reference.value,
      chance: chance.value,
      questRequired: questRequiredController.value.first == 1,
      lootMode: lootMode.value,
      groupId: groupId.value,
      minCount: minCount.value,
      maxCount: maxCount.value,
      comment: commentController.text,
    );
  }

  int _parseInt(String text) {
    if (text.isEmpty) return 0;
    final value = int.tryParse(text);
    if (value == null) throw Exception('输入值 "$text" 不是有效数字');
    return value;
  }

  void _logActivity(ActivityActionType action, LootTemplateEntity t) {
    final log = ActivityLogEntity(
      module: 'reference_loot_template',
      actionType: action,
      entityId: t.entry,
      entityName: t.item.toString(),
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().storeActivityLog(log);
  }

  void dispose() {
    itemController.dispose();
    questRequiredController.dispose();
    commentController.dispose();
  }
}
