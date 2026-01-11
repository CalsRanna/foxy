import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foxy/model/creature_template_addon.dart';
import 'package:foxy/repository/creature_template_addon_repository.dart';
import 'package:signals/signals.dart';

class CreatureTemplateAddonViewModel {
  final entry = signal(0);

  final pathIdController = TextEditingController();
  final mountController = TextEditingController();
  final emoteController = TextEditingController();
  final bytes1Controller = TextEditingController();
  final bytes2Controller = TextEditingController();
  final aurasController = TextEditingController();
  final isLargeController = TextEditingController();

  final loading = signal(false);
  final saving = signal(false);
  final addon = signal(CreatureTemplateAddon());

  /// 从数据库加载数据
  Future<void> load() async {
    loading.value = true;
    try {
      final repository = CreatureTemplateAddonRepository();
      final data = await repository.find(entry.value);
      // 只有当数据不为空时才更新 addon.value
      if (data != null) {
        addon.value = data;
      }
    } catch (e) {
      // 重新抛出异常，让调用者处理
      rethrow;
    } finally {
      loading.value = false;
    }
  }

  /// 保存数据到数据库
  Future<void> save() async {
    saving.value = true;
    try {
      final addonData = _collectFromControllers();
      final repository = CreatureTemplateAddonRepository();
      await repository.save(addonData);
      addon.value = addonData;
    } catch (e) {
      // 重新抛出异常，让调用者处理
      rethrow;
    } finally {
      saving.value = false;
    }
  }

  /// 从 Controller 收集数据构建 CreatureTemplateAddon
  CreatureTemplateAddon _collectFromControllers() {
    final data = CreatureTemplateAddon();
    data.entry = entry.value;
    data.pathId = _parseInt(pathIdController.text);
    data.mount = _parseInt(mountController.text);
    data.emote = _parseInt(emoteController.text);
    data.bytes1 = _parseInt(bytes1Controller.text);
    data.bytes2 = _parseInt(bytes2Controller.text);
    data.auras = aurasController.text;
    data.isLarge = _parseInt(isLargeController.text);
    return data;
  }

  int _parseInt(String text) => text.isEmpty ? 0 : int.parse(text);

  /// 初始化 Controller 的值
  void initControllers(CreatureTemplateAddon data) {
    pathIdController.text = data.pathId.toString();
    mountController.text = data.mount.toString();
    emoteController.text = data.emote.toString();
    bytes1Controller.text = data.bytes1.toString();
    bytes2Controller.text = data.bytes2.toString();
    aurasController.text = data.auras;
    isLargeController.text = data.isLarge.toString();
  }

  /// 初始化 ViewModel
  Future<void> init({required int entryId}) async {
    entry.value = entryId;
    await load();
  }

  /// 清理资源
  void dispose() {
    pathIdController.dispose();
    mountController.dispose();
    emoteController.dispose();
    bytes1Controller.dispose();
    bytes2Controller.dispose();
    aurasController.dispose();
    isLargeController.dispose();
  }
}
