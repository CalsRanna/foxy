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
  final _repository = GetIt.instance.get<CreatureTemplateAddonRepository>();
  final routerFacade = GetIt.instance.get<RouterFacade>();
  final creatureIdController = TextEditingController();

  final pathIdController = TextEditingController();
  final mountController = TextEditingController();
  final emoteController = TextEditingController();
  final bytes1Controller = TextEditingController();
  final bytes2Controller = TextEditingController();
  final visibilityDistanceTypeController = TextEditingController();
  final aurasController = TextEditingController();

  final addon = signal(CreatureTemplateAddonEntity());

  /// 从数据库加载数据
  String _fmt(num v) {
    if (v is double) {
      final s = v.toString();
      if (s.contains('.') && s.endsWith('0')) {
        return s.replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '');
      }
      return s;
    }
    return v.toString();
  }

  int _pi(String t) => int.tryParse(t) ?? 0;

  Future<void> load() async {
    try {
      final data = await _repository.getCreatureTemplateAddon(_pi(creatureIdController.text));
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
      entry: _pi(creatureIdController.text),
      pathId: _pi(pathIdController.text),
      mount: _pi(mountController.text),
      emote: _pi(emoteController.text),
      bytes1: _pi(bytes1Controller.text),
      bytes2: _pi(bytes2Controller.text),
      visibilityDistanceType: _pi(visibilityDistanceTypeController.text),
      auras: aurasController.text,
    );
  }

  /// 初始化 Controller 的值
  void _initSignals(CreatureTemplateAddonEntity data) {
    pathIdController.text = _fmt(data.pathId);
    mountController.text = _fmt(data.mount);
    emoteController.text = _fmt(data.emote);
    bytes1Controller.text = _fmt(data.bytes1);
    bytes2Controller.text = _fmt(data.bytes2);
    visibilityDistanceTypeController.text = _fmt(data.visibilityDistanceType);
    aurasController.text = data.auras;
  }

  /// 初始化 ViewModel
  Future<void> initSignals({required int creatureId}) async {
    try {
      creatureIdController.text = _fmt(creatureId);
      await load();
    } catch (e) {
      LoggerUtil.instance.e('初始化生物附加失败: $e');
      DialogUtil.instance.error('初始化生物附加失败: $e');
    }
  }

  /// 清理资源
  void dispose() {
    aurasController.dispose();
    bytes1Controller.dispose();
    bytes2Controller.dispose();
    creatureIdController.dispose();
    emoteController.dispose();
    mountController.dispose();
    pathIdController.dispose();
    visibilityDistanceTypeController.dispose();
  }
}
