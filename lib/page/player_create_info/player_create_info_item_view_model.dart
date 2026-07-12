import 'package:flutter/widgets.dart';
import 'package:foxy/entity/player_create_info_entity.dart';
import 'package:foxy/repository/player_create_info_item_repository.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/field_controller.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';
import 'package:get_it/get_it.dart';

class PlayerCreateInfoItemViewModel with FieldControllerMixin {
  final _repository = GetIt.instance.get<PlayerCreateInfoItemRepository>();

  final items = signal<List<PlayerCreateInfoItemEntity>>([]);
  int? _race;
  int? _class_;

  late final itemIdController = registerController(IntFieldController());
  late final amountController = registerController(IntFieldController());
  late final noteController = registerController(StringFieldController());

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
    itemIdController.init(0);
    amountController.init(1);
    noteController.init('');
  }

  Future<void> save(BuildContext context) async {
    if (_race == null || _class_ == null) return;
    try {
      final item = PlayerCreateInfoItemEntity(
        race: _race!,
        class_: _class_!,
        itemid: itemIdController.collect(),
        amount: amountController.collect(),
        note: noteController.collect(),
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
    disposeControllers();
  }
}
