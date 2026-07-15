import 'package:foxy/widget/form/view_model_validation_mixin.dart';
import 'package:foxy/widget/form/validation/player_create_info_entity_validation_mixin.dart';
import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/player_create_info_entity.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/player_create_info_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class PlayerCreateInfoDetailViewModel
    with
        ViewModelValidationMixin,
        PlayerCreateInfoValidationMixin,
        FieldControllerMixin {
  final routerFacade = GetIt.instance.get<RouterFacade>();
  final _repository = GetIt.instance.get<PlayerCreateInfoRepository>();

  late final raceController = registerController(IntFieldController());
  late final playerClassController = registerController(IntFieldController());
  late final mapController = registerController(IntFieldController());
  late final zoneController = registerController(IntFieldController());
  late final positionXController = registerController(DoubleFieldController());
  late final positionYController = registerController(DoubleFieldController());
  late final positionZController = registerController(DoubleFieldController());
  late final orientationController = registerController(
    DoubleFieldController(),
  );

  final info = signal<PlayerCreateInfoEntity?>(null);

  /// 复合主键 (race, class) 为语义键：新建可改，编辑只读。
  final isNew = signal(true);

  /// 编辑时用于 WHERE 的原主键
  int? _origRace;
  int? _origClass;

  Future<void> initSignals({int? race, int? playerClass}) async {
    try {
      if (race == null || playerClass == null) {
        isNew.value = true;
        _origRace = null;
        _origClass = null;
        final blank = await _repository.createPlayerCreateInfo();
        info.value = blank;
        _initControllers(blank);
        return;
      }
      isNew.value = false;
      _origRace = race;
      _origClass = playerClass;
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
    raceController.init(i.race);
    playerClassController.init(i.class_);
    mapController.init(i.map);
    zoneController.init(i.zone);
    positionXController.init(i.positionX);
    positionYController.init(i.positionY);
    positionZController.init(i.positionZ);
    orientationController.init(i.orientation);
  }

  Future<void> save(BuildContext context) async {
    try {
      final data = _collect();
      validatePlayerCreateInfoFields(data);
      if (isNew.value) {
        final existed = await _repository.getPlayerCreateInfo(
          data.race,
          data.class_,
        );
        if (existed != null) {
          throw Exception('该种族/职业组合已存在');
        }
        await _repository.storePlayerCreateInfo(data);
        info.value = data;
        _origRace = data.race;
        _origClass = data.class_;
        isNew.value = false;
        _logActivity(ActivityActionType.create, data);
      } else {
        await _repository.updatePlayerCreateInfo(_origRace!, _origClass!, data);
        info.value = data;
        _logActivity(ActivityActionType.update, data);
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
    GetIt.instance.get<ActivityLogRepository>().storeActivityLogBestEffort(log);
  }

  PlayerCreateInfoEntity _collect() {
    return PlayerCreateInfoEntity(
      race: raceController.collect(),
      class_: playerClassController.collect(),
      map: mapController.collect(),
      zone: zoneController.collect(),
      positionX: positionXController.collect(),
      positionY: positionYController.collect(),
      positionZ: positionZController.collect(),
      orientation: orientationController.collect(),
    );
  }

  void dispose() {
    disposeControllers();
  }
}
