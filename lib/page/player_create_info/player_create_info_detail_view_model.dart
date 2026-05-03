import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/player_create_info_entity.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/player_create_info_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class PlayerCreateInfoDetailViewModel {
  final routerFacade = GetIt.instance.get<RouterFacade>();
  final repository = PlayerCreateInfoRepository();

  final race = signal<int>(0);
  final playerClass = signal<int>(0);
  final map = signal<int>(0);
  final zone = signal<int>(0);
  final positionX = signal<double>(0.0);
  final positionY = signal<double>(0.0);
  final positionZ = signal<double>(0.0);
  final orientation = signal<double>(0.0);

  final info = signal<PlayerCreateInfoEntity?>(null);
  Future<void> initSignals({int? race, int? playerClass}) async {
    if (race == null || playerClass == null) return;
    try {
      final result = await repository.getPlayerCreateInfo(race, playerClass);
      info.value = result;
      _initControllers(result);
    } catch (e, s) {
      LoggerUtil.instance.e(
        '加载出生信息(race=$race, class=$playerClass)失败',
        error: e,
        stackTrace: s,
      );
    }
  }

  void _initControllers(PlayerCreateInfoEntity i) {
    race.value = i.race;
    playerClass.value = i.class_;
    map.value = i.map;
    zone.value = i.zone;
    positionX.value = i.positionX;
    positionY.value = i.positionY;
    positionZ.value = i.positionZ;
    orientation.value = i.orientation;
  }

  Future<void> save(BuildContext context) async {
    try {
      final data = _collect();
      await repository.storePlayerCreateInfo(data);
      info.value = data;
      _logActivity(ActivityActionType.create, data);
      if (!context.mounted) return;
      ShadSonner.of(context).show(ShadToast(description: Text('出生信息已保存')));
    } catch (e) {
      if (!context.mounted) return;
      ShadSonner.of(context).show(ShadToast(description: Text(e.toString())));
    }
  }

  Future<void> update(BuildContext context) async {
    final current = info.value;
    if (current == null) return;
    try {
      final data = _collect();
      await repository.updatePlayerCreateInfo(current.buildCredential(), data);
      info.value = data;
      _logActivity(ActivityActionType.update, data);
      if (!context.mounted) return;
      ShadSonner.of(context).show(ShadToast(description: Text('更新成功')));
    } catch (e) {
      if (!context.mounted) return;
      ShadSonner.of(context).show(ShadToast(description: Text(e.toString())));
    }
  }

  void pop() => routerFacade.goBack();

  void _logActivity(ActivityActionType action, PlayerCreateInfoEntity t) {
    final log = ActivityLogEntity(
      module: 'player_create_info',
      actionType: action,
      entityId: t.race,
      entityName: '',
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().storeActivityLog(log);
  }

  PlayerCreateInfoEntity _collect() {
    return PlayerCreateInfoEntity(
      race: race.value,
      class_: playerClass.value,
      map: map.value,
      zone: zone.value,
      positionX: positionX.value,
      positionY: positionY.value,
      positionZ: positionZ.value,
      orientation: orientation.value,
    );
  }

  void dispose() {}
}
