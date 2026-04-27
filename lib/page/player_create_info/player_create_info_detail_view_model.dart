import 'package:flutter/widgets.dart';
import 'package:foxy/model/player_create_info.dart';
import 'package:foxy/repository/player_create_info_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class PlayerCreateInfoDetailViewModel {
  final routerFacade = GetIt.instance.get<RouterFacade>();
  final repository = PlayerCreateInfoRepository();

  final raceController = TextEditingController();
  final classController = TextEditingController();
  final mapController = TextEditingController();
  final zoneController = TextEditingController();
  final positionXController = TextEditingController();
  final positionYController = TextEditingController();
  final positionZController = TextEditingController();
  final orientationController = TextEditingController();

  final info = signal<PlayerCreateInfo?>(null);

  Future<void> initSignals({int? race, int? playerClass}) async {
    if (race == null || playerClass == null) return;
    try {
      final result = await repository.find(race, playerClass);
      info.value = result;
      _initControllers(result);
    } catch (e, s) {
      logger.e('加载出生信息(race=$race, class=$playerClass)失败', error: e, stackTrace: s);
    }
  }

  void _initControllers(PlayerCreateInfo i) {
    raceController.text = i.race.toString();
    classController.text = i.class_.toString();
    mapController.text = i.map.toString();
    zoneController.text = i.zone.toString();
    positionXController.text = i.positionX.toString();
    positionYController.text = i.positionY.toString();
    positionZController.text = i.positionZ.toString();
    orientationController.text = i.orientation.toString();
  }

  Future<void> save(BuildContext context) async {
    try {
      final data = _collect();
      await repository.store(data);
      info.value = data;
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
      await repository.update(current.buildCredential(), data);
      info.value = data;
      if (!context.mounted) return;
      ShadSonner.of(context).show(ShadToast(description: Text('更新成功')));
    } catch (e) {
      if (!context.mounted) return;
      ShadSonner.of(context).show(ShadToast(description: Text(e.toString())));
    }
  }

  void pop() => routerFacade.goBack();

  PlayerCreateInfo _collect() {
    final i = PlayerCreateInfo();
    i.race = _parseInt(raceController.text);
    i.class_ = _parseInt(classController.text);
    i.map = _parseInt(mapController.text);
    i.zone = _parseInt(zoneController.text);
    i.positionX = _parseDouble(positionXController.text);
    i.positionY = _parseDouble(positionYController.text);
    i.positionZ = _parseDouble(positionZController.text);
    i.orientation = _parseDouble(orientationController.text);
    return i;
  }

  int _parseInt(String text) {
    if (text.isEmpty) return 0;
    final value = int.tryParse(text);
    if (value == null) throw Exception('输入值 "$text" 不是有效数字');
    return value;
  }
  double _parseDouble(String text) => text.isEmpty ? 0 : double.parse(text);

  void dispose() {
    raceController.dispose();
    classController.dispose();
    mapController.dispose();
    zoneController.dispose();
    positionXController.dispose();
    positionYController.dispose();
    positionZController.dispose();
    orientationController.dispose();
  }
}
