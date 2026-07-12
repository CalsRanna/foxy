import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/area_table_entity.dart';
import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/area_table_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/field_controller.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class AreaTableDetailViewModel {
  final _repository = GetIt.instance.get<AreaTableRepository>();
  final routerFacade = GetIt.instance.get<RouterFacade>();

  /// Basic
  final idController = IntFieldController();
  final nameController = StringFieldController();
  final continentIdController = IntFieldController();
  final parentAreaIdController = IntFieldController();
  final areaBitController = IntFieldController();
  final flagsController = IntFieldController();
  final factionGroupMaskController = IntFieldController();
  final explorationLevelController = IntFieldController();

  /// Sound
  final soundProviderPrefController = IntFieldController();
  final soundProviderPrefUnderwaterController = IntFieldController();
  final ambienceIdController = IntFieldController();
  final zoneMusicController = IntFieldController();
  final introSoundController = IntFieldController();
  final ambientMultiplierController = DoubleFieldController();
  final lightIdController = IntFieldController();
  final minElevationController = DoubleFieldController();

  /// Other
  final liquidTypeId0Controller = IntFieldController();
  final liquidTypeId1Controller = IntFieldController();
  final liquidTypeId2Controller = IntFieldController();
  final liquidTypeId3Controller = IntFieldController();

  late final _controllers = <FieldController>[
    idController,
    nameController,
    continentIdController,
    parentAreaIdController,
    areaBitController,
    flagsController,
    factionGroupMaskController,
    explorationLevelController,
    soundProviderPrefController,
    soundProviderPrefUnderwaterController,
    ambienceIdController,
    zoneMusicController,
    introSoundController,
    ambientMultiplierController,
    lightIdController,
    minElevationController,
    liquidTypeId0Controller,
    liquidTypeId1Controller,
    liquidTypeId2Controller,
    liquidTypeId3Controller,
  ];

  final area = signal(AreaTableEntity());

  Future<void> save(BuildContext context) async {
    try {
      var t = _collectFromControllers();
      final isCreate = (await _repository.getAreaTable(t.id)) == null;
      if (isCreate) {
        final id = await _repository.storeAreaTable(t);
        t = t.copyWith(id: id);
        idController.init(id);
      } else {
        await _repository.updateAreaTable(t);
      }
      area.value = t;
      _logActivity(
        isCreate ? ActivityActionType.create : ActivityActionType.update,
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

  /// 弹窗保存区域名称本地化后，合并回当前 Entity 并同步主语言输入框。
  void applyAreaNameLocales(List<DbcLocaleFieldValue> values) {
    area.value = area.value.copyWith(
      areaNameLangEnUS: values.valueOf('enUS'),
      areaNameLangKoKR: values.valueOf('koKR'),
      areaNameLangFrFR: values.valueOf('frFR'),
      areaNameLangDeDE: values.valueOf('deDE'),
      areaNameLangZhCN: values.valueOf('zhCN'),
      areaNameLangZhTW: values.valueOf('zhTW'),
      areaNameLangEsES: values.valueOf('esES'),
      areaNameLangEsMX: values.valueOf('esMX'),
      areaNameLangRuRU: values.valueOf('ruRU'),
      areaNameLangJaJP: values.valueOf('jaJP'),
      areaNameLangPtPT: values.valueOf('ptPT'),
      areaNameLangPtBR: values.valueOf('ptBR'),
      areaNameLangItIT: values.valueOf('itIT'),
      areaNameLangUnk1: values.valueOf('unk1'),
      areaNameLangUnk2: values.valueOf('unk2'),
      areaNameLangUnk3: values.valueOf('unk3'),
    );
    nameController.init(values.zhCN);
  }

  /// 退出页面
  void pop() {
    routerFacade.goBack();
  }

  /// 从所有 Controller 收集数据构建 AreaTable
  AreaTableEntity _collectFromControllers() {
    // 基于已加载实体覆盖 UI 字段，避免清空未展示的多语言等列。
    return area.value.copyWith(
      id: idController.collect(),
      areaNameLangZhCN: nameController.collect(),
      continentId: continentIdController.collect(),
      parentAreaId: parentAreaIdController.collect(),
      areaBit: areaBitController.collect(),
      flags: flagsController.collect(),
      factionGroupMask: factionGroupMaskController.collect(),
      explorationLevel: explorationLevelController.collect(),
      soundProviderPref: soundProviderPrefController.collect(),
      soundProviderPrefUnderwater: soundProviderPrefUnderwaterController
          .collect(),
      ambienceId: ambienceIdController.collect(),
      zoneMusic: zoneMusicController.collect(),
      introSound: introSoundController.collect(),
      ambientMultiplier: ambientMultiplierController.collect(),
      lightId: lightIdController.collect(),
      minElevation: minElevationController.collect(),
      liquidTypeId0: liquidTypeId0Controller.collect(),
      liquidTypeId1: liquidTypeId1Controller.collect(),
      liquidTypeId2: liquidTypeId2Controller.collect(),
      liquidTypeId3: liquidTypeId3Controller.collect(),
    );
  }

  void _logActivity(ActivityActionType action, AreaTableEntity t) {
    final log = ActivityLogEntity(
      module: 'area_table',
      actionType: action,
      entityId: t.id,
      entityName: t.areaNameLangZhCN,
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().storeActivityLogBestEffort(log);
  }

  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
  }

  Future<void> initSignals({int? id}) async {
    try {
      if (id == null || id <= 0) {
        final blank = await _repository.createAreaTable();
        area.value = blank;
        _initControllers(blank);
        return;
      }
      area.value = (await _repository.getAreaTable(id))!;
      _initControllers(area.value);
    } catch (e, s) {
      LoggerUtil.instance.e('加载区域(id=$id)失败', error: e, stackTrace: s);
    }
  }

  void _initControllers(AreaTableEntity table) {
    idController.init(table.id);
    nameController.init(table.areaNameLangZhCN);
    continentIdController.init(table.continentId);
    parentAreaIdController.init(table.parentAreaId);
    areaBitController.init(table.areaBit);
    flagsController.init(table.flags);
    factionGroupMaskController.init(table.factionGroupMask);
    explorationLevelController.init(table.explorationLevel);
    soundProviderPrefController.init(table.soundProviderPref);
    soundProviderPrefUnderwaterController.init(
      table.soundProviderPrefUnderwater,
    );
    ambienceIdController.init(table.ambienceId);
    zoneMusicController.init(table.zoneMusic);
    introSoundController.init(table.introSound);
    ambientMultiplierController.init(table.ambientMultiplier);
    lightIdController.init(table.lightId);
    minElevationController.init(table.minElevation);
    liquidTypeId0Controller.init(table.liquidTypeId0);
    liquidTypeId1Controller.init(table.liquidTypeId1);
    liquidTypeId2Controller.init(table.liquidTypeId2);
    liquidTypeId3Controller.init(table.liquidTypeId3);
  }
}
