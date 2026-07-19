import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:foxy/entity/brief_player_create_info_item_entity.dart';
import 'package:foxy/entity/player_create_info_entity.dart';
import 'package:foxy/entity/player_create_info_item_key.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/player_create_info_item_repository.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/form/validation/player_create_info_entity_validation_mixin.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class PlayerCreateInfoItemViewModel
    with
        ViewModelValidationMixin,
        PlayerCreateInfoItemValidationMixin,
        FieldControllerMixin {
  final _repository = GetIt.instance.get<PlayerCreateInfoItemRepository>();

  final editingKey = signal<PlayerCreateInfoItemKey?>(null);
  final items = signal<List<BriefPlayerCreateInfoItemEntity>>([]);
  final page = signal(1);
  final total = signal(0);

  int? _race;
  int? _class_;
  int _refreshToken = 0;

  late final raceController = registerController(IntFieldController());
  late final classController = registerController(IntFieldController());
  late final itemIdController = registerController(IntFieldController());
  late final amountController = registerController(IntFieldController());
  late final noteController = registerController(StringFieldController());

  Future<bool> create() async {
    final race = _race;
    final class_ = _class_;
    if (race == null || class_ == null) return false;
    try {
      final candidate = await _repository.createPlayerCreateInfoItem(
        race,
        class_,
      );
      editingKey.value = null;
      _initControllers(candidate);
      return true;
    } catch (error) {
      LoggerUtil.instance.e('创建角色物品失败: $error');
      DialogUtil.instance.error('创建角色物品失败: $error');
      return false;
    }
  }

  Future<void> delete(
    BuildContext context,
    BriefPlayerCreateInfoItemEntity item,
  ) async {
    try {
      await _repository.destroyPlayerCreateInfoItem(item.key);
      await _refresh();
      if (!context.mounted) return;
      ShadSonner.of(context).show(const ShadToast(description: Text('删除成功')));
    } catch (error) {
      if (!context.mounted) return;
      ShadSonner.of(context).show(ShadToast(description: Text('$error')));
    }
  }

  void dispose() => disposeControllers();

  Future<bool> edit(BriefPlayerCreateInfoItemEntity item) async {
    final key = item.key;
    editingKey.value = key;
    try {
      final entity = await _repository.getPlayerCreateInfoItem(key);
      if (entity == null) {
        throw StateError('原角色物品记录不存在，可能已被其他操作修改或删除');
      }
      _initControllers(entity);
      return true;
    } catch (error) {
      editingKey.value = null;
      LoggerUtil.instance.e('加载角色物品失败: $error');
      DialogUtil.instance.error('加载角色物品失败: $error');
      return false;
    }
  }

  Future<void> initSignals({int? race, int? class_}) async {
    try {
      await setParent(race: race, class_: class_);
    } catch (error) {
      LoggerUtil.instance.e('加载角色物品失败: $error');
      DialogUtil.instance.error('加载角色物品失败: $error');
    }
  }

  Future<void> paginate(int page) async {
    this.page.value = page;
    await _refresh();
  }

  Future<void> persist() async {
    final candidate = _collect();
    validatePlayerCreateInfoItemFields(candidate);
    final originalKey = editingKey.value;
    if (originalKey == null) {
      await _repository.storePlayerCreateInfoItem(candidate);
    } else {
      await _repository.updatePlayerCreateInfoItem(originalKey, candidate);
    }
    editingKey.value = PlayerCreateInfoItemKey.fromEntity(candidate);
    await _refresh();
  }

  Future<bool> save(BuildContext context) async {
    try {
      await persist();
      if (!context.mounted) return true;
      ShadSonner.of(context).show(const ShadToast(description: Text('保存成功')));
      return true;
    } catch (error) {
      if (!context.mounted) return false;
      ShadSonner.of(context).show(ShadToast(description: Text('$error')));
      return false;
    }
  }

  Future<void> setParent({int? race, int? class_}) async {
    if (_race != race || _class_ != class_) page.value = 1;
    _race = race;
    _class_ = class_;
    editingKey.value = null;
    if (race == null || class_ == null) {
      items.value = [];
      total.value = 0;
      return;
    }
    await _refresh();
  }

  PlayerCreateInfoItemEntity _collect() => PlayerCreateInfoItemEntity(
    race: raceController.collect(),
    class_: classController.collect(),
    itemid: itemIdController.collect(),
    amount: amountController.collect(),
    note: noteController.collect(),
  );

  void _initControllers(PlayerCreateInfoItemEntity item) {
    raceController.init(item.race);
    classController.init(item.class_);
    itemIdController.init(item.itemid);
    amountController.init(item.amount);
    noteController.init(item.note);
  }

  Future<void> _refresh() async {
    final race = _race;
    final class_ = _class_;
    if (race == null || class_ == null) return;
    final token = ++_refreshToken;
    final count = await _repository.countPlayerCreateInfoItems(race, class_);
    if (token != _refreshToken) return;
    final lastPage = max(1, (count / _repository.kPageSize).ceil());
    if (page.value > lastPage) page.value = lastPage;
    final data = await _repository.getBriefPlayerCreateInfoItems(
      race,
      class_,
      page: page.value,
    );
    if (token != _refreshToken) return;
    items.value = data;
    total.value = count;
    editingKey.value = null;
  }
}
