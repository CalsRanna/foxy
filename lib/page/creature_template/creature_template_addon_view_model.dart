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

  final pathId = signal<int>(0);
  final mount = signal<int>(0);
  final emote = signal<int>(0);
  final bytes1 = signal<int>(0);
  final bytes2 = signal<int>(0);
  final visibilityDistanceType = signal<int>(0);
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
    data.pathId = pathId.value;
    data.mount = mount.value;
    data.emote = emote.value;
    data.bytes1 = bytes1.value;
    data.bytes2 = bytes2.value;
    data.visibilityDistanceType = visibilityDistanceType.value;
    data.auras = aurasController.text;
    return data;
  }

  /// 初始化 Controller 的值
  void initControllers(CreatureTemplateAddonEntity data) {
    pathId.value = data.pathId;
    mount.value = data.mount;
    emote.value = data.emote;
    bytes1.value = data.bytes1;
    bytes2.value = data.bytes2;
    visibilityDistanceType.value = data.visibilityDistanceType;
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
    aurasController.dispose();
  }
}
