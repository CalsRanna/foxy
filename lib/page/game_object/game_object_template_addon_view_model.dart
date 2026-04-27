import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foxy/model/game_object_template_addon.dart';
import 'package:foxy/repository/game_object_template_addon_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class GameObjectTemplateAddonViewModel {
  final routerFacade = GetIt.instance.get<RouterFacade>();
  final gameObjectId = signal(0);

  final factionController = TextEditingController();
  final flagsController = TextEditingController();
  final minGoldController = TextEditingController();
  final maxGoldController = TextEditingController();

  final loading = signal(false);
  final saving = signal(false);
  final addon = signal(GameObjectTemplateAddon());

  Future<void> load() async {
    loading.value = true;
    try {
      final repository = GameObjectTemplateAddonRepository();
      final data = await repository.find(gameObjectId.value);
      if (data != null) {
        addon.value = data;
      }
    } catch (e) {
      rethrow;
    } finally {
      loading.value = false;
    }
  }

  Future<void> save(BuildContext context) async {
    try {
      final addonData = _collectFromControllers();
      final repository = GameObjectTemplateAddonRepository();
      await repository.save(addonData);
      addon.value = addonData;
      if (!context.mounted) return;
      var toast = ShadToast(description: Text('模板补充数据已保存'));
      ShadSonner.of(context).show(toast);
    } catch (e) {
      var toast = ShadToast(description: Text(e.toString()));
      ShadSonner.of(context).show(toast);
    }
  }

  void pop() {
    routerFacade.goBack();
  }

  GameObjectTemplateAddon _collectFromControllers() {
    final data = GameObjectTemplateAddon();
    data.entry = gameObjectId.value;
    data.faction = _parseInt(factionController.text);
    data.flags = _parseInt(flagsController.text);
    data.minGold = _parseInt(minGoldController.text);
    data.maxGold = _parseInt(maxGoldController.text);
    return data;
  }

  int _parseInt(String text) {
    if (text.isEmpty) return 0;
    final value = int.tryParse(text);
    if (value == null) throw Exception('输入值 "$text" 不是有效数字');
    return value;
  }

  void initControllers(GameObjectTemplateAddon data) {
    factionController.text = data.faction.toString();
    flagsController.text = data.flags.toString();
    minGoldController.text = data.minGold.toString();
    maxGoldController.text = data.maxGold.toString();
  }

  Future<void> initSignals({required int gameObjectId}) async {
    this.gameObjectId.value = gameObjectId;
    await load();
  }

  void dispose() {
    factionController.dispose();
    flagsController.dispose();
    minGoldController.dispose();
    maxGoldController.dispose();
  }
}
