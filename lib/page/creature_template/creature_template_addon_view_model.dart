import 'package:flutter/widgets.dart';
import 'package:foxy/entity/creature_template_addon_entity.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/creature_template_addon_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/form/validation/creature_template_addon_entity_validation_mixin.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class CreatureTemplateAddonViewModel
    with
        ViewModelValidationMixin,
        CreatureTemplateAddonValidationMixin,
        FieldControllerMixin {
  final _repository = GetIt.instance.get<CreatureTemplateAddonRepository>();
  final routerFacade = GetIt.instance.get<RouterFacade>();
  late final creatureIdController = registerController(IntFieldController());

  late final pathIdController = registerController(IntFieldController());
  late final mountController = registerController(IntFieldController());
  late final emoteController = registerController(IntFieldController());
  late final bytes1Controller = registerController(IntFieldController());
  late final bytes2Controller = registerController(IntFieldController());
  late final visibilityDistanceTypeController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final aurasController = registerController(StringFieldController());

  final addon = signal(CreatureTemplateAddonEntity());
  final editingKey = signal<int?>(null);

  /// 清理资源
  void dispose() {
    disposeControllers();
  }

  /// 初始化 ViewModel
  Future<void> initSignals({required int creatureId}) async {
    try {
      final key = creatureId;
      final data = await _repository.getCreatureTemplateAddon(key);
      if (data == null) {
        editingKey.value = null;
        final blank = await _repository.createCreatureTemplateAddon(creatureId);
        addon.value = blank;
        _initSignals(blank);
      } else {
        editingKey.value = key;
        addon.value = data;
        _initSignals(data);
      }
    } catch (e) {
      LoggerUtil.instance.e('初始化生物附加失败: $e');
      DialogUtil.instance.error('初始化生物附加失败: $e');
    }
  }

  /// 退出页面
  void pop() {
    routerFacade.goBack();
  }

  /// 保存数据到数据库
  Future<void> save(BuildContext context) async {
    try {
      final addonData = _collectFromControllers();
      validateCreatureTemplateAddonFields(addonData);
      final originalKey = editingKey.value;
      if (originalKey == null) {
        await _repository.storeCreatureTemplateAddon(addonData);
      } else {
        await _repository.updateCreatureTemplateAddon(originalKey, addonData);
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

  /// 从 Controller 收集数据构建 CreatureTemplateAddon
  CreatureTemplateAddonEntity _collectFromControllers() {
    return CreatureTemplateAddonEntity(
      entry: creatureIdController.collect(),
      pathId: pathIdController.collect(),
      mount: mountController.collect(),
      emote: emoteController.collect(),
      bytes1: bytes1Controller.collect(),
      bytes2: bytes2Controller.collect(),
      visibilityDistanceType: visibilityDistanceTypeController.collect(),
      auras: normalizeCreatureTemplateAddonAuras(aurasController.collect()),
    );
  }

  /// 初始化 Controller 的值
  void _initSignals(CreatureTemplateAddonEntity data) {
    creatureIdController.init(data.entry);
    pathIdController.init(data.pathId);
    mountController.init(data.mount);
    emoteController.init(data.emote);
    bytes1Controller.init(data.bytes1);
    bytes2Controller.init(data.bytes2);
    visibilityDistanceTypeController.init(data.visibilityDistanceType);
    aurasController.init(data.auras);
  }
}
