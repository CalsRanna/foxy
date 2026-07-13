import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/loot_template_entity.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/loot_template_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class ReferenceLootTemplateDetailViewModel with FieldControllerMixin {
  final routerFacade = GetIt.instance.get<RouterFacade>();
  final repository = LootTemplateRepository(LootTableType.reference);

  late final entryController = registerController(IntFieldController());
  late final itemController = registerController(IntFieldController());
  late final referenceController = registerController(IntFieldController());
  late final chanceController = registerController(DoubleFieldController());
  late final questRequiredController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final lootModeController = registerController(IntFieldController());
  late final groupIdController = registerController(IntFieldController());
  late final minCountController = registerController(IntFieldController());
  late final maxCountController = registerController(IntFieldController());
  late final commentController = registerController(StringFieldController());

  final template = signal<LootTemplateEntity?>(null);
  final originalEntry = signal<int?>(null);
  final originalItem = signal<int?>(null);

  /// 复合主键 (Entry, Item) 均为业务语义键：新建可填，编辑只读。
  bool get isNew => originalItem.value == null;

  Future<void> initSignals({int? entry, int? item}) async {
    try {
      // 新建：不预填伪 Item 号；Entry/Item 由用户指定（Item 用实体选择器）
      if (entry == null || item == null) {
        originalEntry.value = null;
        originalItem.value = null;
        final blank = const LootTemplateEntity();
        template.value = blank;
        _initControllers(blank);
        return;
      }
      originalEntry.value = entry;
      originalItem.value = item;
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
    entryController.init(loot.entry);
    itemController.init(loot.item);
    referenceController.init(loot.reference);
    chanceController.init(loot.chance);
    questRequiredController.init(loot.questRequired ? 1 : 0);
    lootModeController.init(loot.lootMode);
    groupIdController.init(loot.groupId);
    minCountController.init(loot.minCount);
    maxCountController.init(loot.maxCount);
    commentController.init(loot.comment);
  }

  Future<void> save(BuildContext context) async {
    final oEntry = originalEntry.value;
    final oItem = originalItem.value;
    try {
      final data = _collectFromControllers();
      if (oItem != null && oEntry != null) {
        await repository.updateLootTemplate(oEntry, oItem, data);
        template.value = data;
        originalEntry.value = data.entry;
        originalItem.value = data.item;
        _logActivity(ActivityActionType.update, data);
      } else {
        final existed = await repository.getLootTemplate(data.entry, data.item);
        if (existed != null) {
          throw Exception('Entry=${data.entry}, Item=${data.item} 已存在');
        }
        await repository.storeLootTemplate(data);
        template.value = data;
        originalEntry.value = data.entry;
        originalItem.value = data.item;
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
      entry: entryController.collect(),
      item: itemController.collect(),
      reference: referenceController.collect(),
      chance: chanceController.collect(),
      questRequired: questRequiredController.collect() == 1,
      lootMode: lootModeController.collect(),
      groupId: groupIdController.collect(),
      minCount: minCountController.collect(),
      maxCount: maxCountController.collect(),
      comment: commentController.collect(),
    );
  }

  void _logActivity(ActivityActionType action, LootTemplateEntity t) {
    final log = ActivityLogEntity(
      module: 'reference_loot_template',
      actionType: action,
      entityId: t.entry,
      entityName: t.item.toString(),
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().storeActivityLogBestEffort(log);
  }

  void dispose() {
    disposeControllers();
  }
}
