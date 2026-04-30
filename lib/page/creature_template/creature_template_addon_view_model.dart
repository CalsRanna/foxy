import 'package:flutter/widgets.dart';
import 'package:foxy/entity/creature_template_addon_entity.dart';
import 'package:foxy/repository/creature_template_addon_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class CreatureTemplateAddonViewModel {
  final routerFacade = GetIt.instance.get<RouterFacade>();
  final creatureId = signal(0);

  final pathIdController = TextEditingController();
  final mountController = TextEditingController();
  final emoteController = TextEditingController();
  final bytes1Controller = TextEditingController();
  final bytes2Controller = TextEditingController();
  final visibilityDistanceTypeController = TextEditingController();
  final aurasController = TextEditingController();

  final addon = signal(CreatureTemplateAddonEntity());

  /// 从数据库加载数据
  Future<void> load() async {
    try {
      final repository = CreatureTemplateAddonRepository();
      final data = await repository.getCreatureTemplateAddon(creatureId.value);
      if (data != null) {
        addon.value = data;
        initControllers(data);
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
      final repository = CreatureTemplateAddonRepository();
      await repository.saveCreatureTemplateAddon(addonData);
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
    final data = CreatureTemplateAddonEntity();
    data.entry = creatureId.value;
    data.pathId = _parseInt(pathIdController.text);
    data.mount = _parseInt(mountController.text);
    data.emote = _parseInt(emoteController.text);
    data.bytes1 = _parseInt(bytes1Controller.text);
    data.bytes2 = _parseInt(bytes2Controller.text);
    data.visibilityDistanceType = _parseInt(
      visibilityDistanceTypeController.text,
    );
    data.auras = aurasController.text;
    return data;
  }

  int _parseInt(String text) {
    if (text.isEmpty) return 0;
    final value = int.tryParse(text);
    if (value == null) throw Exception('输入值 "$text" 不是有效数字');
    return value;
  }

  /// 初始化 Controller 的值
  void initControllers(CreatureTemplateAddonEntity data) {
    pathIdController.text = data.pathId.toString();
    mountController.text = data.mount.toString();
    emoteController.text = data.emote.toString();
    bytes1Controller.text = data.bytes1.toString();
    bytes2Controller.text = data.bytes2.toString();
    visibilityDistanceTypeController.text = data.visibilityDistanceType
        .toString();
    aurasController.text = data.auras;
  }

  /// 初始化 ViewModel
  Future<void> initSignals({required int creatureId}) async {
    try {
      this.creatureId.value = creatureId;
      await load();
    } catch (e) {
      LoggerUtil.instance.e('初始化生物附加失败: $e');
      DialogUtil.instance.error('初始化生物附加失败: $e');
    }
  }

  /// 清理资源
  void dispose() {
    pathIdController.dispose();
    mountController.dispose();
    emoteController.dispose();
    bytes1Controller.dispose();
    bytes2Controller.dispose();
    visibilityDistanceTypeController.dispose();
    aurasController.dispose();
  }
}
