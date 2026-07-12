import 'package:flutter/widgets.dart';
import 'package:foxy/util/field_controller.dart';
import 'package:foxy/entity/creature_template_addon_entity.dart';
import 'package:foxy/repository/creature_template_addon_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class CreatureTemplateAddonViewModel {
  final _repository = GetIt.instance.get<CreatureTemplateAddonRepository>();
  final routerFacade = GetIt.instance.get<RouterFacade>();
  final creatureIdController = IntFieldController();

  final pathIdController = IntFieldController();
  final mountController = IntFieldController();
  final emoteController = IntFieldController();
  final bytes1Controller = IntFieldController();
  final bytes2Controller = IntFieldController();
  final visibilityDistanceTypeController = IntFieldController();
  final aurasController = StringFieldController();

  late final _controllers = <FieldController>[
    creatureIdController,
    pathIdController,
    mountController,
    emoteController,
    bytes1Controller,
    bytes2Controller,
    visibilityDistanceTypeController,
    aurasController,
  ];

  final addon = signal(CreatureTemplateAddonEntity());

  /// 从数据库加载数据

  Future<void> load() async {
    try {
      final data = await _repository.getCreatureTemplateAddon(
        creatureIdController.collect(),
      );
      if (data != null) {
        addon.value = data;
        _initSignals(data);
      }
    } catch (e) {
      LoggerUtil.instance.e('加载生物附加数据失败: $e');
      DialogUtil.instance.error('加载生物附加数据失败: $e');
    }
  }

  /// 保存数据到数据库
  Future<void> save(BuildContext context) async {
    try {
      final addonData = _collectFromControllers();
      await _repository.saveCreatureTemplateAddon(addonData);
      addon.value = addonData;
      if (!context.mounted) return;
      var toast = ShadToast(description: Text('模板补充数据已保存'));
      ShadSonner.of(context).show(toast);
    } catch (e) {
      var toast = ShadToast(description: Text(e.toString()));
      ShadSonner.of(context).show(toast);
    }
  }

  /// 退出页面
  void pop() {
    routerFacade.goBack();
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
      auras: aurasController.collect(),
    );
  }

  /// 初始化 Controller 的值
  void _initSignals(CreatureTemplateAddonEntity data) {
    pathIdController.init(data.pathId);
    mountController.init(data.mount);
    emoteController.init(data.emote);
    bytes1Controller.init(data.bytes1);
    bytes2Controller.init(data.bytes2);
    visibilityDistanceTypeController.init(data.visibilityDistanceType);
    aurasController.init(data.auras);
  }

  /// 初始化 ViewModel
  Future<void> initSignals({required int creatureId}) async {
    try {
      creatureIdController.init(creatureId);
      await load();
    } catch (e) {
      LoggerUtil.instance.e('初始化生物附加失败: $e');
      DialogUtil.instance.error('初始化生物附加失败: $e');
    }
  }

  /// 清理资源
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
  }
}
