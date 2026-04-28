import 'package:flutter/widgets.dart';
import 'package:foxy/model/area_table.dart';
import 'package:foxy/repository/area_table_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class AreaTableDetailViewModel {
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

  final area = signal(AreaTable());
  final saving = signal(false);

  /// 保存到数据库
  Future<void> save(BuildContext context) async {
    saving.value = true;
    try {
      final t = _collectFromControllers();
      final repository = AreaTableRepository();
      if (t.id == 0) {
        await repository.store(t);
      } else {
        await repository.update(t);
      }
      area.value = t;
      if (!context.mounted) return;
      var toast = ShadToast(description: Text('区域数据已保存'));
      ShadSonner.of(context).show(toast);
    } catch (e) {
      if (!context.mounted) return;
      var toast = ShadToast(description: Text(e.toString()));
      ShadSonner.of(context).show(toast);
    } finally {
      saving.value = false;
    }
  }

  /// 退出页面
  void pop() {
    routerFacade.goBack();
  }

  /// 从所有 Controller 收集数据构建 AreaTable
  AreaTable _collectFromControllers() {
    final t = AreaTable();

    /// Basic
    t.id = _parseInt(idController.text);
    t.areaNameLangZhCn = nameController.text;
    t.continentId = _parseInt(continentIdController.text);
    t.parentAreaId = _parseInt(parentAreaIdController.text);
    t.areaBit = _parseInt(areaBitController.text);
    t.flags = _parseInt(flagsController.text);
    t.factionGroupMask = _parseInt(factionGroupMaskController.text);
    t.explorationLevel = _parseInt(explorationLevelController.text);

    /// Sound
    t.soundProviderPref = _parseInt(soundProviderPrefController.text);
    t.soundProviderPrefUnderwater = _parseInt(
      soundProviderPrefUnderwaterController.text,
    );
    t.ambienceId = _parseInt(ambienceIdController.text);
    t.zoneMusic = _parseInt(zoneMusicController.text);
    t.introSound = _parseInt(introSoundController.text);
    t.ambientMultiplier = _parseDouble(ambientMultiplierController.text);
    t.lightId = _parseInt(lightIdController.text);
    t.minElevation = _parseDouble(minElevationController.text);

    /// Other
    t.liquidTypeId0 = _parseInt(liquidTypeId0Controller.text);
    t.liquidTypeId1 = _parseInt(liquidTypeId1Controller.text);
    t.liquidTypeId2 = _parseInt(liquidTypeId2Controller.text);
    t.liquidTypeId3 = _parseInt(liquidTypeId3Controller.text);

    return t;
  }

  int _parseInt(String text) {
    if (text.isEmpty) return 0;
    final value = int.tryParse(text);
    if (value == null) throw Exception('输入值 "$text" 不是有效数字');
    return value;
  }
  double _parseDouble(String text) {
    if (text.isEmpty) return 0.0;
    final value = double.tryParse(text);
    if (value == null) throw Exception('输入值 "$text" 不是有效数字');
    return value;
  }

  void dispose() {
    /// Basic
    idController.dispose();
    nameController.dispose();
    continentIdController.dispose();
    parentAreaIdController.dispose();
    areaBitController.dispose();
    flagsController.dispose();
    factionGroupMaskController.dispose();
    explorationLevelController.dispose();

    /// Sound
    soundProviderPrefController.dispose();
    soundProviderPrefUnderwaterController.dispose();
    ambienceIdController.dispose();
    zoneMusicController.dispose();
    introSoundController.dispose();
    ambientMultiplierController.dispose();
    lightIdController.dispose();
    minElevationController.dispose();

    /// Other
    liquidTypeId0Controller.dispose();
    liquidTypeId1Controller.dispose();
    liquidTypeId2Controller.dispose();
    liquidTypeId3Controller.dispose();
  }

  Future<void> initSignals({int? id}) async {
    if (id == null) return;
    try {
      area.value = (await AreaTableRepository().find(id))!;
      _initControllers(area.value);
    } catch (e, s) {
      logger.e('加载区域(id=$id)失败', error: e, stackTrace: s);
    }
  }

  void _initControllers(AreaTable table) {
    /// Basic
    idController.text = table.id.toString();
    nameController.text = table.areaNameLangZhCn;
    continentIdController.text = table.continentId.toString();
    parentAreaIdController.text = table.parentAreaId.toString();
    areaBitController.text = table.areaBit.toString();
    flagsController.text = table.flags.toString();
    factionGroupMaskController.text = table.factionGroupMask.toString();
    explorationLevelController.text = table.explorationLevel.toString();

    /// Sound
    soundProviderPrefController.text = table.soundProviderPref.toString();
    soundProviderPrefUnderwaterController.text = table
        .soundProviderPrefUnderwater.toString();
    ambienceIdController.text = table.ambienceId.toString();
    zoneMusicController.text = table.zoneMusic.toString();
    introSoundController.text = table.introSound.toString();
    ambientMultiplierController.text = table.ambientMultiplier.toString();
    lightIdController.text = table.lightId.toString();
    minElevationController.text = table.minElevation.toString();

    /// Other
    liquidTypeId0Controller.text = table.liquidTypeId0.toString();
    liquidTypeId1Controller.text = table.liquidTypeId1.toString();
    liquidTypeId2Controller.text = table.liquidTypeId2.toString();
    liquidTypeId3Controller.text = table.liquidTypeId3.toString();
  }
}
