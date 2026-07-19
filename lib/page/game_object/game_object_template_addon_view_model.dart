import 'package:flutter/widgets.dart';
import 'package:foxy/entity/game_object_template_addon_entity.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/game_object_template_addon_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/form/validation/game_object_template_addon_entity_validation_mixin.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class GameObjectTemplateAddonViewModel
    with
        ViewModelValidationMixin,
        GameObjectTemplateAddonValidationMixin,
        FieldControllerMixin {
  final _repository = GetIt.instance.get<GameObjectTemplateAddonRepository>();
  final routerFacade = GetIt.instance.get<RouterFacade>();
  late final factionController = registerController(IntFieldController());
  late final flagsController = registerController(FlagFieldController());
  late final gameObjectIdController = registerController(IntFieldController());
  late final minGoldController = registerController(IntFieldController());
  late final maxGoldController = registerController(IntFieldController());
  late final artkit0Controller = registerController(IntFieldController());
  late final artkit1Controller = registerController(IntFieldController());
  late final artkit2Controller = registerController(IntFieldController());
  late final artkit3Controller = registerController(IntFieldController());

  final addon = signal(GameObjectTemplateAddonEntity());
  final editingKey = signal<int?>(null);

  void dispose() {
    disposeControllers();
  }

  Future<void> initSignals({required int gameObjectId}) async {
    try {
      final key = gameObjectId;
      final data = await _repository.getGameObjectTemplateAddon(key);
      if (data == null) {
        editingKey.value = null;
        final blank = await _repository.createGameObjectTemplateAddon(
          gameObjectId,
        );
        addon.value = blank;
        _initSignals(blank);
      } else {
        editingKey.value = key;
        addon.value = data;
        _initSignals(data);
      }
    } catch (e) {
      LoggerUtil.instance.e('初始化失败: $e');
      DialogUtil.instance.error('初始化失败: $e');
    }
  }

  void pop() {
    routerFacade.goBack();
  }

  Future<void> save(BuildContext context) async {
    try {
      final addonData = _collectFromControllers();
      validateGameObjectTemplateAddonFields(addonData);
      final originalKey = editingKey.value;
      if (originalKey == null) {
        await _repository.storeGameObjectTemplateAddon(addonData);
      } else {
        await _repository.updateGameObjectTemplateAddon(originalKey, addonData);
      }
      editingKey.value = addonData.entry;
      addon.value = addonData;
      if (!context.mounted) return;
      var toast = ShadToast(description: Text('模板补充数据已保存'));
      ShadSonner.of(context).show(toast);
    } catch (e) {
      if (!context.mounted) return;
      var toast = ShadToast(description: Text(e.toString()));
      ShadSonner.of(context).show(toast);
    }
  }

  GameObjectTemplateAddonEntity _collectFromControllers() {
    return GameObjectTemplateAddonEntity(
      entry: gameObjectIdController.collect(),
      faction: factionController.collect(),
      flags: flagsController.collect(),
      minGold: minGoldController.collect(),
      maxGold: maxGoldController.collect(),
      artkit0: artkit0Controller.collect(),
      artkit1: artkit1Controller.collect(),
      artkit2: artkit2Controller.collect(),
      artkit3: artkit3Controller.collect(),
    );
  }

  void _initSignals(GameObjectTemplateAddonEntity data) {
    gameObjectIdController.init(data.entry);
    factionController.init(data.faction);
    flagsController.init(data.flags);
    minGoldController.init(data.minGold);
    maxGoldController.init(data.maxGold);
    artkit0Controller.init(data.artkit0);
    artkit1Controller.init(data.artkit1);
    artkit2Controller.init(data.artkit2);
    artkit3Controller.init(data.artkit3);
  }
}
