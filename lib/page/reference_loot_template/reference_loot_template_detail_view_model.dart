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

  final entryController = TextEditingController();
  final itemController = TextEditingController();
  final referenceController = TextEditingController();
  final chanceController = TextEditingController();
  final questRequiredController = ShadSelectController<int>();
  final lootModeController = TextEditingController();
  final groupIdController = TextEditingController();
  final minCountController = TextEditingController();
  final maxCountController = TextEditingController();
  final commentController = TextEditingController();

  final template = signal<LootTemplateEntity?>(null);
  final originalEntry = signal<int?>(null);
  final originalItem = signal<int?>(null);
  final saving = signal(false);

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
      logger.e('加载关联掉落(Entry=$entry, Item=$item)失败', error: e, stackTrace: s);
    }
  }

  void _initControllers(LootTemplateEntity loot) {
    entryController.text = loot.entry.toString();
    itemController.text = loot.item.toString();
    referenceController.text = loot.reference.toString();
    chanceController.text = loot.chance.toString();
    questRequiredController.value = {loot.questRequired ? 1 : 0};
    lootModeController.text = loot.lootMode.toString();
    groupIdController.text = loot.groupId.toString();
    minCountController.text = loot.minCount.toString();
    maxCountController.text = loot.maxCount.toString();
    commentController.text = loot.comment;
  }

  Future<void> save(BuildContext context) async {
    saving.value = true;
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
    } finally {
      saving.value = false;
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
      entry: _parseInt(entryController.text),
      item: _parseInt(itemController.text),
      reference: _parseInt(referenceController.text),
      chance: _parseDouble(chanceController.text),
      questRequired: questRequiredController.value.first == 1,
      lootMode: _parseInt(lootModeController.text),
      groupId: _parseInt(groupIdController.text),
      minCount: _parseInt(minCountController.text),
      maxCount: _parseInt(maxCountController.text),
      comment: commentController.text,
    );
  }

  int _parseInt(String text) {
    if (text.isEmpty) return 0;
    final value = int.tryParse(text);
    if (value == null) throw Exception('输入值 "$text" 不是有效数字');
    return value;
  }

  double _parseDouble(String text) => text.isEmpty ? 0 : double.parse(text);

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
    entryController.dispose();
    itemController.dispose();
    referenceController.dispose();
    chanceController.dispose();
    questRequiredController.dispose();
    lootModeController.dispose();
    groupIdController.dispose();
    minCountController.dispose();
    maxCountController.dispose();
    commentController.dispose();
  }
}
