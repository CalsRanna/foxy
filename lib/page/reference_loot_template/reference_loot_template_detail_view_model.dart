import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/util/format_util.dart';
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
  String _fmt(num v) => formatNum(v);

  int _pi(String t) => int.tryParse(t) ?? 0;
  double _pd(String t) => double.tryParse(t) ?? 0.0;

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
    entryController.text = _fmt(loot.entry);
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

  Future<void> save(BuildContext context) async {
    final oItem = originalItem.value;
    try {
      final data = _collectFromControllers();
      if (oItem != null) {
        await repository.updateLootTemplate(data.entry, oItem, data);
        template.value = data;
        _logActivity(ActivityActionType.update, data);
      } else {
        await repository.storeLootTemplate(data);
        template.value = data;
        _logActivity(ActivityActionType.create, data);
      }
      if (!context.mounted) return;
      ShadSonner.of(context).show(ShadToast(description: Text('保存成功')));
    } catch (e) {
      if (!context.mounted) return;
      ShadSonner.of(context).show(ShadToast(description: Text(e.toString())));
    }
  }

  void pop() {
    routerFacade.goBack();
  }

  LootTemplateEntity _collectFromControllers() {
    return LootTemplateEntity(
      entry: _pi(entryController.text),
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
    chanceController.dispose();
    commentController.dispose();
    entryController.dispose();
    groupIdController.dispose();
    itemController.dispose();
    lootModeController.dispose();
    maxCountController.dispose();
    minCountController.dispose();
    questRequiredController.dispose();
    referenceController.dispose();
  }
}
