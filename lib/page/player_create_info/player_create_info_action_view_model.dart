import 'package:flutter/widgets.dart';
import 'package:foxy/entity/player_create_info_entity.dart';
import 'package:foxy/repository/player_create_info_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class PlayerCreateInfoActionViewModel {
  final routerFacade = GetIt.instance.get<RouterFacade>();
  final repository = PlayerCreateInfoRepository();

  final actions = signal<List<PlayerCreateInfoActionEntity>>([]);
  int? _race;
  int? _class_;
  int? _oldButton;

  final buttonController = TextEditingController();
  final actionController = TextEditingController();
  final typeController = TextEditingController();

  Future<void> initSignals({int? race, int? class_}) async {
    try {
      _race = race;
      _class_ = class_;
      if (race == null || class_ == null) return;
      actions.value = await repository.getActions(race, class_);
    } catch (e) {
      LoggerUtil.instance.e('加载角色动作失败: $e');
      DialogUtil.instance.error('加载角色动作失败: $e');
    }
  }

  void create() {
    _oldButton = null;
    buttonController.clear();
    actionController.clear();
    typeController.clear();
  }

  void edit(int index) {
    if (index >= actions.value.length) return;
    final item = actions.value[index];
    _oldButton = item.button;
    buttonController.text = item.button.toString();
    actionController.text = item.action.toString();
    typeController.text = item.type.toString();
  }

  Future<void> save(BuildContext context) async {
    if (_race == null || _class_ == null) return;
    try {
      final item = _collect();
      await repository.storeAction(item);
      actions.value = await repository.getActions(_race!, _class_!);
      if (!context.mounted) return;
      ShadSonner.of(context).show(ShadToast(description: Text('保存成功')));
    } catch (e) {
      if (!context.mounted) return;
      ShadSonner.of(context).show(ShadToast(description: Text(e.toString())));
    }
  }

  Future<void> update(BuildContext context) async {
    if (_race == null || _class_ == null) return;
    try {
      final item = _collect();
      await repository.updateAction(item, oldButton: _oldButton);
      actions.value = await repository.getActions(_race!, _class_!);
      if (!context.mounted) return;
      ShadSonner.of(context).show(ShadToast(description: Text('更新成功')));
    } catch (e) {
      if (!context.mounted) return;
      ShadSonner.of(context).show(ShadToast(description: Text(e.toString())));
    }
  }

  Future<void> onDelete(
    BuildContext context,
    PlayerCreateInfoActionEntity item,
  ) async {
    if (_race == null || _class_ == null) return;
    try {
      await repository.deleteAction(_race!, _class_!, item.button);
      actions.value = await repository.getActions(_race!, _class_!);
      if (!context.mounted) return;
      ShadSonner.of(context).show(ShadToast(description: Text('删除成功')));
    } catch (e) {
      if (!context.mounted) return;
      ShadSonner.of(context).show(ShadToast(description: Text(e.toString())));
    }
  }

  PlayerCreateInfoActionEntity _collect() {
    return PlayerCreateInfoActionEntity(
      race: _race ?? 0,
      class_: _class_ ?? 0,
      button: _parseInt(buttonController.text),
      action: _parseInt(actionController.text),
      type: _parseInt(typeController.text),
    );
  }

  int _parseInt(String text) {
    if (text.isEmpty) return 0;
    final value = int.tryParse(text);
    if (value == null) throw Exception('输入值 "$text" 不是有效数字');
    return value;
  }

  void dispose() {
    buttonController.dispose();
    actionController.dispose();
    typeController.dispose();
  }
}
