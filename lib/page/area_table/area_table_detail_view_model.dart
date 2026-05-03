import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/area_table_entity.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/area_table_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class AreaTableDetailViewModel {
  final routerFacade = GetIt.instance.get<RouterFacade>();

  /// Basic
  final id = signal<int>(0);
  final nameController = TextEditingController();
  final continentId = signal<int>(0);
  final parentAreaId = signal<int>(0);
  final areaBit = signal<int>(0);
  final flags = signal<int>(0);
  final factionGroupMask = signal<int>(0);
  final explorationLevel = signal<int>(0);

  /// Sound
  final soundProviderPref = signal<int>(0);
  final soundProviderPrefUnderwater = signal<int>(0);
  final ambienceId = signal<int>(0);
  final zoneMusic = signal<int>(0);
  final introSound = signal<int>(0);
  final ambientMultiplier = signal<double>(0.0);
  final lightId = signal<int>(0);
  final minElevation = signal<double>(0.0);

  /// Other
  final liquidTypeId0 = signal<int>(0);
  final liquidTypeId1 = signal<int>(0);
  final liquidTypeId2 = signal<int>(0);
  final liquidTypeId3 = signal<int>(0);

  final area = signal(AreaTableEntity());
  /// 保存到数据库
  Future<void> save(BuildContext context) async {
    try {
      final t = _collectFromControllers();
      final repository = AreaTableRepository();
      if (t.id == 0) {
        await repository.storeAreaTable(t);
      } else {
        await repository.updateAreaTable(t);
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
      id: id.value,
      areaNameLangZhCn: nameController.text,
      continentId: continentId.value,
      parentAreaId: parentAreaId.value,
      areaBit: areaBit.value,
      flags: flags.value,
      factionGroupMask: factionGroupMask.value,
      explorationLevel: explorationLevel.value,
      soundProviderPref: soundProviderPref.value,
      soundProviderPrefUnderwater: soundProviderPrefUnderwater.value,
      ambienceId: ambienceId.value,
      zoneMusic: zoneMusic.value,
      introSound: introSound.value,
      ambientMultiplier: ambientMultiplier.value,
      lightId: lightId.value,
      minElevation: minElevation.value,
      liquidTypeId0: liquidTypeId0.value,
      liquidTypeId1: liquidTypeId1.value,
      liquidTypeId2: liquidTypeId2.value,
      liquidTypeId3: liquidTypeId3.value,
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
    nameController.dispose();
  }

  Future<void> initSignals({int? id}) async {
    if (id == null) return;
    try {
      area.value = (await AreaTableRepository().getAreaTable(id))!;
      _initControllers(area.value);
    } catch (e, s) {
      LoggerUtil.instance.e('加载区域(id=$id)失败', error: e, stackTrace: s);
    }
  }

  void _initControllers(AreaTableEntity table) {
    /// Basic
    id.value = table.id;
    nameController.text = table.areaNameLangZhCn;
    continentId.value = table.continentId;
    parentAreaId.value = table.parentAreaId;
    areaBit.value = table.areaBit;
    flags.value = table.flags;
    factionGroupMask.value = table.factionGroupMask;
    explorationLevel.value = table.explorationLevel;

    /// Sound
    soundProviderPref.value = table.soundProviderPref;
    soundProviderPrefUnderwater.value = table.soundProviderPrefUnderwater;
    ambienceId.value = table.ambienceId;
    zoneMusic.value = table.zoneMusic;
    introSound.value = table.introSound;
    ambientMultiplier.value = table.ambientMultiplier;
    lightId.value = table.lightId;
    minElevation.value = table.minElevation;

    /// Other
    liquidTypeId0.value = table.liquidTypeId0;
    liquidTypeId1.value = table.liquidTypeId1;
    liquidTypeId2.value = table.liquidTypeId2;
    liquidTypeId3.value = table.liquidTypeId3;
  }
}
