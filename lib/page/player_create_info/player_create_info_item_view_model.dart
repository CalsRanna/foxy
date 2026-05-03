import 'package:flutter/widgets.dart';
import 'package:foxy/entity/player_create_info_entity.dart';
import 'package:foxy/repository/player_create_info_repository.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class PlayerCreateInfoItemViewModel {
  final repository = PlayerCreateInfoRepository();

  final items = signal<List<PlayerCreateInfoItemEntity>>([]);
  int? _race;
  int? _class_;

  final itemId = signal<int>(0);
  final amount = signal<int>(1);
  final noteController = TextEditingController();

  Future<void> initSignals({int? race, int? class_}) async {
    try {
      _race = race;
      _class_ = class_;
      if (race == null || class_ == null) return;
      items.value = await repository.getItems(race, class_);
    } catch (e) {
      LoggerUtil.instance.e('加载角色物品失败: $e');
      DialogUtil.instance.error('加载角色物品失败: $e');
    }
  }

  void create() {
    itemId.value = 0;
    amount.value = 1;
    noteController.clear();
  }

  Future<void> save(BuildContext context) async {
    if (_race == null || _class_ == null) return;
    try {
      final item = PlayerCreateInfoItemEntity(
        race: _race!,
        class_: _class_!,
        itemid: itemId.value,
        amount: amount.value,
        note: noteController.text,
      );
      await repository.storeItem(item);
      items.value = await repository.getItems(_race!, _class_!);
      if (!context.mounted) return;
      ShadSonner.of(context).show(ShadToast(description: Text('保存成功')));
    } catch (e) {
      if (!context.mounted) return;
      ShadSonner.of(context).show(ShadToast(description: Text(e.toString())));
    }
  }

  Future<void> onDelete(
    BuildContext context,
    PlayerCreateInfoItemEntity item,
  ) async {
    if (_race == null || _class_ == null) return;
    try {
      await repository.deleteItem(_race!, _class_!, item.itemid);
      items.value = await repository.getItems(_race!, _class_!);
      if (!context.mounted) return;
      ShadSonner.of(context).show(ShadToast(description: Text('删除成功')));
    } catch (e) {
      if (!context.mounted) return;
      ShadSonner.of(context).show(ShadToast(description: Text(e.toString())));
    }
  }

  void dispose() {
    noteController.dispose();
  }
}
