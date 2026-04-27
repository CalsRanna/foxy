import 'package:flutter/material.dart';
import 'package:foxy/model/player_create_info.dart';
import 'package:foxy/repository/player_create_info_repository.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class PlayerCreateInfoItemViewModel {
  final repository = PlayerCreateInfoRepository();

  final items = signal<List<PlayerCreateInfoItem>>([]);
  int? _race;
  int? _class_;

  final itemIdController = TextEditingController();
  final amountController = TextEditingController();
  final noteController = TextEditingController();

  Future<void> initSignals({int? race, int? class_}) async {
    _race = race;
    _class_ = class_;
    if (race == null || class_ == null) return;
    items.value = await repository.getItems(race, class_);
  }

  void create() {
    itemIdController.clear();
    amountController.text = '1';
    noteController.clear();
  }

  Future<void> save(BuildContext context) async {
    if (_race == null || _class_ == null) return;
    try {
      final item = PlayerCreateInfoItem()
        ..race = _race!
        ..class_ = _class_!
        ..itemid = _parseInt(itemIdController.text)
        ..amount = _parseInt(amountController.text)
        ..note = noteController.text;
      await repository.storeItem(item);
      items.value = await repository.getItems(_race!, _class_!);
      if (!context.mounted) return;
      ShadSonner.of(context).show(ShadToast(description: Text('保存成功')));
    } catch (e) {
      if (!context.mounted) return;
      ShadSonner.of(context).show(ShadToast(description: Text(e.toString())));
    }
  }

  Future<void> onDelete(BuildContext context, PlayerCreateInfoItem item) async {
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

  int _parseInt(String text) {
    if (text.isEmpty) return 0;
    final value = int.tryParse(text);
    if (value == null) throw Exception('输入值 "$text" 不是有效数字');
    return value;
  }

  void dispose() {
    itemIdController.dispose();
    amountController.dispose();
    noteController.dispose();
  }
}
