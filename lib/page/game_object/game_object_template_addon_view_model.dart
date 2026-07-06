import 'package:flutter/widgets.dart';
import 'package:foxy/entity/game_object_template_addon_entity.dart';
import 'package:foxy/util/format_util.dart';
import 'package:foxy/repository/game_object_template_addon_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class GameObjectTemplateAddonViewModel {
  final _repository = GetIt.instance.get<GameObjectTemplateAddonRepository>();
  final routerFacade = GetIt.instance.get<RouterFacade>();
  final gameObjectId = signal<int>(0);

  final factionController = TextEditingController();
  final flagsController = TextEditingController();
  final gameObjectIdController = TextEditingController();
  final minGoldController = TextEditingController();
  final maxGoldController = TextEditingController();

  final addon = signal(GameObjectTemplateAddonEntity());

  String _fmt(num v) => formatNum(v);

  int _pi(String t) => int.tryParse(t) ?? 0;

  Future<void> load() async {
    final data = await _repository.getGameObjectTemplateAddon(
      gameObjectId.value,
    );
    if (data != null) {
      addon.value = data;
      _initSignals(data);
    }
  }

  Future<void> save(BuildContext context) async {
    try {
      final addonData = _collectFromControllers();
      await _repository.saveGameObjectTemplateAddon(addonData);
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

  GameObjectTemplateAddonEntity _collectFromControllers() {
    return GameObjectTemplateAddonEntity(
      entry: gameObjectId.value,
      faction: _pi(factionController.text),
      flags: _pi(flagsController.text),
      minGold: _pi(minGoldController.text),
      maxGold: _pi(maxGoldController.text),
    );
  }

  void _initSignals(GameObjectTemplateAddonEntity data) {
    factionController.text = _fmt(data.faction);
    flagsController.text = _fmt(data.flags);
    minGoldController.text = _fmt(data.minGold);
    maxGoldController.text = _fmt(data.maxGold);
  }

  Future<void> initSignals({required int gameObjectId}) async {
    try {
      this.gameObjectId.value = gameObjectId;
      gameObjectIdController.text = _fmt(gameObjectId);
      await load();
    } catch (e) {
      LoggerUtil.instance.e('初始化失败: $e');
      DialogUtil.instance.error('初始化失败: $e');
    }
  }

  void dispose() {
    factionController.dispose();
    flagsController.dispose();
    gameObjectIdController.dispose();
    maxGoldController.dispose();
    minGoldController.dispose();
  }
}
