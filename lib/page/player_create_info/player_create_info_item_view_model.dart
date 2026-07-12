import 'package:flutter/widgets.dart';
import 'package:foxy/entity/player_create_info_entity.dart';
import 'package:foxy/util/format_util.dart';
import 'package:foxy/util/parse_util.dart';
import 'package:foxy/repository/player_create_info_item_repository.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';
import 'package:get_it/get_it.dart';

class PlayerCreateInfoItemViewModel {
  final _repository = GetIt.instance.get<PlayerCreateInfoItemRepository>();

  final items = signal<List<PlayerCreateInfoItemEntity>>([]);
  int? _race;
  int? _class_;

  final itemIdController = TextEditingController();
  final amountController = TextEditingController();
  final noteController = TextEditingController();

  String _fmt(num v) => formatNum(v);

  int _pi(String t, [String field = '']) => parseIntField(t, field: field);

  Future<void> initSignals({int? race, int? class_}) async {
    try {
      _race = race;
      _class_ = class_;
      if (race == null || class_ == null) return;
      items.value = await _repository.getBriefPlayerCreateInfoItems(
        race,
        class_,
      );
    } catch (e) {
      LoggerUtil.instance.e('加载角色物品失败: $e');
      DialogUtil.instance.error('加载角色物品失败: $e');
    }
  }

  void create() {
    itemIdController.text = _fmt(0);
    amountController.text = _fmt(1);
    noteController.clear();
  }

  Future<void> save(BuildContext context) async {
    if (_race == null || _class_ == null) return;
    try {
      final item = PlayerCreateInfoItemEntity(
        race: _race!,
        class_: _class_!,
        itemid: _pi(itemIdController.text),
        amount: _pi(amountController.text),
        note: noteController.text,
      );
      await _repository.storePlayerCreateInfoItem(item);
      items.value = await _repository.getBriefPlayerCreateInfoItems(
        _race!,
        _class_!,
      );
      if (!context.mounted) return;
      ShadSonner.of(context).show(ShadToast(description: Text('保存成功')));
    } catch (e) {
      if (!context.mounted) return;
      ShadSonner.of(context).show(ShadToast(description: Text(e.toString())));
    }
  }

  Future<void> delete(
    BuildContext context,
    PlayerCreateInfoItemEntity item,
  ) async {
    if (_race == null || _class_ == null) return;
    try {
      await _repository.destroyPlayerCreateInfoItem(
        _race!,
        _class_!,
        item.itemid,
      );
      items.value = await _repository.getBriefPlayerCreateInfoItems(
        _race!,
        _class_!,
      );
      if (!context.mounted) return;
      ShadSonner.of(context).show(ShadToast(description: Text('删除成功')));
    } catch (e) {
      if (!context.mounted) return;
      ShadSonner.of(context).show(ShadToast(description: Text(e.toString())));
    }
  }

  void dispose() {
    amountController.dispose();
    itemIdController.dispose();
    noteController.dispose();
  }
}
