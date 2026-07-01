import 'package:flutter/widgets.dart';
import 'package:foxy/entity/player_create_info_entity.dart';
import 'package:foxy/util/format_util.dart';
import 'package:foxy/repository/player_create_info_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class PlayerCreateInfoActionViewModel {
  final routerFacade = GetIt.instance.get<RouterFacade>();
  final _repository = GetIt.instance.get<PlayerCreateInfoRepository>();

  final actions = signal<List<PlayerCreateInfoActionEntity>>([]);
  int? _race;
  int? _class_;
  int? _oldButton;

  final buttonController = TextEditingController();
  final actionController = TextEditingController();
  final typeController = TextEditingController();

  String _fmt(num v) => formatNum(v);

  int _pi(String t) => int.tryParse(t) ?? 0;

  Future<void> initSignals({int? race, int? class_}) async {
    try {
      _race = race;
      _class_ = class_;
      if (race == null || class_ == null) return;
      actions.value = await _repository.getActions(race, class_);
    } catch (e) {
      LoggerUtil.instance.e('加载角色动作失败: $e');
      DialogUtil.instance.error('加载角色动作失败: $e');
    }
  }

  void create() {
    _oldButton = null;
    buttonController.text = _fmt(0);
    actionController.text = _fmt(0);
    typeController.text = _fmt(0);
  }

  void edit(int index) {
    if (index >= actions.value.length) return;
    final item = actions.value[index];
    _oldButton = item.button;
    buttonController.text = _fmt(item.button);
    actionController.text = _fmt(item.action);
    typeController.text = _fmt(item.type);
  }

  Future<void> save(BuildContext context) async {
    if (_race == null || _class_ == null) return;
    try {
      final item = _collect();
      await _repository.storeAction(item);
      actions.value = await _repository.getActions(_race!, _class_!);
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
      await _repository.updateAction(item, oldButton: _oldButton);
      actions.value = await _repository.getActions(_race!, _class_!);
      if (!context.mounted) return;
      ShadSonner.of(context).show(ShadToast(description: Text('更新成功')));
    } catch (e) {
      if (!context.mounted) return;
      ShadSonner.of(context).show(ShadToast(description: Text(e.toString())));
    }
  }

  Future<void> delete(
    BuildContext context,
    PlayerCreateInfoActionEntity item,
  ) async {
    if (_race == null || _class_ == null) return;
    try {
      await _repository.deleteAction(_race!, _class_!, item.button);
      actions.value = await _repository.getActions(_race!, _class_!);
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
      button: _pi(buttonController.text),
      action: _pi(actionController.text),
      type: _pi(typeController.text),
    );
  }

  void dispose() {
    actionController.dispose();
    buttonController.dispose();
    typeController.dispose();
  }
}
