import 'package:flutter/widgets.dart';
import 'package:foxy/entity/player_create_info_entity.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/player_create_info_action_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/form/validation/player_create_info_entity_validation_mixin.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class PlayerCreateInfoActionViewModel
    with
        ViewModelValidationMixin,
        PlayerCreateInfoActionValidationMixin,
        FieldControllerMixin {
  final routerFacade = GetIt.instance.get<RouterFacade>();
  final _repository = GetIt.instance.get<PlayerCreateInfoActionRepository>();
  final actions = signal<List<PlayerCreateInfoActionEntity>>([]);

  final actionType = signal(0);
  int? _race;
  int? _class_;
  int? _oldButton;
  late final buttonController = registerController(IntFieldController());

  late final actionController = registerController(IntFieldController());
  late final typeController = registerController(IntFieldController());
  PlayerCreateInfoActionViewModel() {
    typeController.addListener(_syncActionType);
  }

  void create() {
    _oldButton = null;
    buttonController.init(0);
    actionController.init(0);
    typeController.init(0);
  }

  Future<void> delete(
    BuildContext context,
    PlayerCreateInfoActionEntity item,
  ) async {
    if (_race == null || _class_ == null) return;
    try {
      await _repository.destroyPlayerCreateInfoAction(
        _race!,
        _class_!,
        item.button,
      );
      actions.value = await _repository.getBriefPlayerCreateInfoActions(
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
    typeController.removeListener(_syncActionType);
    disposeControllers();
  }

  void edit(int index) {
    if (index >= actions.value.length) return;
    final item = actions.value[index];
    _oldButton = item.button;
    buttonController.init(item.button);
    actionController.init(item.action);
    typeController.init(item.type);
  }

  Future<void> initSignals({int? race, int? class_}) async {
    try {
      _race = race;
      _class_ = class_;
      if (race == null || class_ == null) return;
      actions.value = await _repository.getBriefPlayerCreateInfoActions(
        race,
        class_,
      );
    } catch (e) {
      LoggerUtil.instance.e('加载角色动作失败: $e');
      DialogUtil.instance.error('加载角色动作失败: $e');
    }
  }

  Future<void> save(BuildContext context) async {
    if (_race == null || _class_ == null) return;
    try {
      final item = _collect();
      validatePlayerCreateInfoActionFields(item);
      await _repository.storePlayerCreateInfoAction(item);
      actions.value = await _repository.getBriefPlayerCreateInfoActions(
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

  Future<void> update(BuildContext context) async {
    if (_race == null || _class_ == null) return;
    try {
      final item = _collect();
      validatePlayerCreateInfoActionFields(item);
      await _repository.updatePlayerCreateInfoAction(
        _race!,
        _class_!,
        _oldButton ?? item.button,
        item,
      );
      actions.value = await _repository.getBriefPlayerCreateInfoActions(
        _race!,
        _class_!,
      );
      if (!context.mounted) return;
      ShadSonner.of(context).show(ShadToast(description: Text('更新成功')));
    } catch (e) {
      if (!context.mounted) return;
      ShadSonner.of(context).show(ShadToast(description: Text(e.toString())));
    }
  }

  PlayerCreateInfoActionEntity _collect() {
    return PlayerCreateInfoActionEntity(
      race: _race ?? 0,
      class_: _class_ ?? 0,
      button: buttonController.collect(),
      action: actionController.collect(),
      type: typeController.collect(),
    );
  }

  void _syncActionType() => actionType.value = typeController.collect();
}
