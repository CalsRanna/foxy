import 'package:flutter/widgets.dart';
import 'package:foxy/model/loot_template.dart';
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

  final loot = signal<LootTemplate?>(null);
  final originalEntry = signal<int?>(null);
  final originalItem = signal<int?>(null);

  Future<void> initSignals({int? entry, int? item}) async {
    if (entry == null || item == null) return;
    originalEntry.value = entry;
    originalItem.value = item;
    try {
      final result = await repository.find(entry, item);
      if (result != null) {
        loot.value = result;
        _initControllers(result);
      }
    } catch (e, s) {
      logger.e('加载关联掉落(Entry=$entry, Item=$item)失败',
          error: e, stackTrace: s);
    }
  }

  void _initControllers(LootTemplate loot) {
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
    try {
      final data = _collectFromControllers();
      await repository.store(data);
      loot.value = data;
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
      await repository.update(data, oldItem: oItem);
      loot.value = data;
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

  LootTemplate _collectFromControllers() {
    final data = LootTemplate();
    data.entry = _parseInt(entryController.text);
    data.item = _parseInt(itemController.text);
    data.reference = _parseInt(referenceController.text);
    data.chance = _parseDouble(chanceController.text);
    data.questRequired = questRequiredController.value.first == 1;
    data.lootMode = _parseInt(lootModeController.text);
    data.groupId = _parseInt(groupIdController.text);
    data.minCount = _parseInt(minCountController.text);
    data.maxCount = _parseInt(maxCountController.text);
    data.comment = commentController.text;
    return data;
  }

  int _parseInt(String text) {
    if (text.isEmpty) return 0;
    final value = int.tryParse(text);
    if (value == null) throw Exception('输入值 "$text" 不是有效数字');
    return value;
  }
  double _parseDouble(String text) => text.isEmpty ? 0 : double.parse(text);

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
