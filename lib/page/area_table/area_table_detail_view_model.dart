import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/util/format_util.dart';
import 'package:foxy/entity/area_table_entity.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/area_table_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class AreaTableDetailViewModel {
  final _repository = GetIt.instance.get<AreaTableRepository>();
  final routerFacade = GetIt.instance.get<RouterFacade>();

  /// Basic
  final idController = TextEditingController();
  final nameController = TextEditingController();
  final continentIdController = TextEditingController();
  final parentAreaIdController = TextEditingController();
  final areaBitController = TextEditingController();
  final flagsController = TextEditingController();
  final factionGroupMaskController = TextEditingController();
  final explorationLevelController = TextEditingController();

  /// Sound
  final soundProviderPrefController = TextEditingController();
  final soundProviderPrefUnderwaterController = TextEditingController();
  final ambienceIdController = TextEditingController();
  final zoneMusicController = TextEditingController();
  final introSoundController = TextEditingController();
  final ambientMultiplierController = TextEditingController();
  final lightIdController = TextEditingController();
  final minElevationController = TextEditingController();

  /// Other
  final liquidTypeId0Controller = TextEditingController();
  final liquidTypeId1Controller = TextEditingController();
  final liquidTypeId2Controller = TextEditingController();
  final liquidTypeId3Controller = TextEditingController();

  final area = signal(AreaTableEntity());

  /// 保存到数据库
  String _fmt(num v) => formatNum(v);

  int _pi(String t) => int.tryParse(t) ?? 0;
  double _pd(String t) => double.tryParse(t) ?? 0.0;

  Future<void> save(BuildContext context) async {
    try {
      final t = _collectFromControllers();
      if (t.id == 0) {
        final id = await _repository.storeAreaTable(t);
        idController.text = '$id';
      } else {
        await _repository.updateAreaTable(t);
      }
      area.value = t;
      _logActivity(
        t.id == 0 ? ActivityActionType.create : ActivityActionType.update,
        t,
      );
      if (!context.mounted) return;
      var toast = ShadToast(description: Text('区域数据已保存'));
      ShadSonner.of(context).show(toast);
    } catch (e) {
      if (!context.mounted) return;
      var toast = ShadToast(description: Text(e.toString()));
      ShadSonner.of(context).show(toast);
    }
  }

  /// 退出页面
  void pop() {
    routerFacade.goBack();
  }

  /// 从所有 Controller 收集数据构建 AreaTable
  AreaTableEntity _collectFromControllers() {
    final t = AreaTableEntity(
      id: _pi(idController.text),
      areaNameLangZhCn: nameController.text,
      continentId: _pi(continentIdController.text),
      parentAreaId: _pi(parentAreaIdController.text),
      areaBit: _pi(areaBitController.text),
      flags: _pi(flagsController.text),
      factionGroupMask: _pi(factionGroupMaskController.text),
      explorationLevel: _pi(explorationLevelController.text),
      soundProviderPref: _pi(soundProviderPrefController.text),
      soundProviderPrefUnderwater: _pi(
        soundProviderPrefUnderwaterController.text,
      ),
      ambienceId: _pi(ambienceIdController.text),
      zoneMusic: _pi(zoneMusicController.text),
      introSound: _pi(introSoundController.text),
      ambientMultiplier: _pd(ambientMultiplierController.text),
      lightId: _pi(lightIdController.text),
      minElevation: _pd(minElevationController.text),
      liquidTypeId0: _pi(liquidTypeId0Controller.text),
      liquidTypeId1: _pi(liquidTypeId1Controller.text),
      liquidTypeId2: _pi(liquidTypeId2Controller.text),
      liquidTypeId3: _pi(liquidTypeId3Controller.text),
    );

    return t;
  }

  void _logActivity(ActivityActionType action, AreaTableEntity t) {
    final log = ActivityLogEntity(
      module: 'area_table',
      actionType: action,
      entityId: t.id,
      entityName: t.areaNameLangZhCn,
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().storeActivityLog(log);
  }

  void dispose() {
    ambienceIdController.dispose();
    ambientMultiplierController.dispose();
    areaBitController.dispose();
    continentIdController.dispose();
    explorationLevelController.dispose();
    factionGroupMaskController.dispose();
    flagsController.dispose();
    idController.dispose();
    introSoundController.dispose();
    lightIdController.dispose();
    liquidTypeId0Controller.dispose();
    liquidTypeId1Controller.dispose();
    liquidTypeId2Controller.dispose();
    liquidTypeId3Controller.dispose();
    minElevationController.dispose();
    nameController.dispose();
    parentAreaIdController.dispose();
    soundProviderPrefController.dispose();
    soundProviderPrefUnderwaterController.dispose();
    zoneMusicController.dispose();
  }

  Future<void> initSignals({int? id}) async {
    if (id == null) return;
    try {
      area.value = (await _repository.getAreaTable(id))!;
      _initControllers(area.value);
    } catch (e, s) {
      LoggerUtil.instance.e('加载区域(id=$id)失败', error: e, stackTrace: s);
    }
  }

  void _initControllers(AreaTableEntity table) {
    /// Basic
    idController.text = _fmt(table.id);
    nameController.text = table.areaNameLangZhCn;
    continentIdController.text = _fmt(table.continentId);
    parentAreaIdController.text = _fmt(table.parentAreaId);
    areaBitController.text = _fmt(table.areaBit);
    flagsController.text = _fmt(table.flags);
    factionGroupMaskController.text = _fmt(table.factionGroupMask);
    explorationLevelController.text = _fmt(table.explorationLevel);

    /// Sound
    soundProviderPrefController.text = _fmt(table.soundProviderPref);
    soundProviderPrefUnderwaterController.text = _fmt(
      table.soundProviderPrefUnderwater,
    );
    ambienceIdController.text = _fmt(table.ambienceId);
    zoneMusicController.text = _fmt(table.zoneMusic);
    introSoundController.text = _fmt(table.introSound);
    ambientMultiplierController.text = _fmt(table.ambientMultiplier);
    lightIdController.text = _fmt(table.lightId);
    minElevationController.text = _fmt(table.minElevation);

    /// Other
    liquidTypeId0Controller.text = _fmt(table.liquidTypeId0);
    liquidTypeId1Controller.text = _fmt(table.liquidTypeId1);
    liquidTypeId2Controller.text = _fmt(table.liquidTypeId2);
    liquidTypeId3Controller.text = _fmt(table.liquidTypeId3);
  }
}
