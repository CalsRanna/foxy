import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/util/format_util.dart';
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
  final _repository = GetIt.instance.get<PlayerCreateInfoRepository>();

  final raceController = TextEditingController();
  final playerClassController = TextEditingController();
  final mapController = TextEditingController();
  final zoneController = TextEditingController();
  final positionXController = TextEditingController();
  final positionYController = TextEditingController();
  final positionZController = TextEditingController();
  final orientationController = TextEditingController();

  final info = signal<PlayerCreateInfoEntity?>(null);
  String _fmt(num v) => formatNum(v);

  int _pi(String t) => int.tryParse(t) ?? 0;
  double _pd(String t) => double.tryParse(t) ?? 0.0;

  Future<void> initSignals({int? race, int? playerClass}) async {
    if (race == null || playerClass == null) return;
    try {
      final result = await _repository.getPlayerCreateInfo(race, playerClass);
      if (result == null) return;
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
    raceController.text = _fmt(i.race);
    playerClassController.text = _fmt(i.class_);
    mapController.text = _fmt(i.map);
    zoneController.text = _fmt(i.zone);
    positionXController.text = _fmt(i.positionX);
    positionYController.text = _fmt(i.positionY);
    positionZController.text = _fmt(i.positionZ);
    orientationController.text = _fmt(i.orientation);
  }

  Future<void> save(BuildContext context) async {
    final current = info.value;
    try {
      final data = _collect();
      if (current != null) {
        await _repository.updatePlayerCreateInfo(
          current.race,
          current.class_,
          data,
        );
        info.value = data;
        _logActivity(ActivityActionType.update, data);
      } else {
        await _repository.storePlayerCreateInfo(data);
        info.value = data;
        _logActivity(ActivityActionType.create, data);
      }
      if (!context.mounted) return;
      ShadSonner.of(context).show(ShadToast(description: Text('保存成功')));
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
      race: _pi(raceController.text),
      class_: _pi(playerClassController.text),
      map: _pi(mapController.text),
      zone: _pi(zoneController.text),
      positionX: _pd(positionXController.text),
      positionY: _pd(positionYController.text),
      positionZ: _pd(positionZController.text),
      orientation: _pd(orientationController.text),
    );
  }

  void dispose() {
    mapController.dispose();
    orientationController.dispose();
    playerClassController.dispose();
    positionXController.dispose();
    positionYController.dispose();
    positionZController.dispose();
    raceController.dispose();
    zoneController.dispose();
  }
}
