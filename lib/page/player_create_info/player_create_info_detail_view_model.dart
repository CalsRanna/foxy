import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/player_create_info_entity.dart';
import 'package:foxy/entity/player_create_info_key.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/player_create_info_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/form/validation/player_create_info_entity_validation_mixin.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';
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
  final persistedKey = signal<PlayerCreateInfoKey?>(null);

  void dispose() {
    disposeControllers();
  }

  Future<void> initSignals({PlayerCreateInfoKey? key}) async {
    try {
      if (key == null) {
        persistedKey.value = null;
        final blank = await _repository.createPlayerCreateInfo();
        info.value = blank;
        _initControllers(blank);
        return;
      }
      persistedKey.value = key;
      final result = await _repository.getPlayerCreateInfo(key);
      if (result == null) {
        throw StateError('原出生信息记录不存在，可能已被其他操作修改或删除');
      }
      info.value = result;
      _initControllers(result);
    } catch (e, s) {
      LoggerUtil.instance.e('加载出生信息失败: $key', error: e, stackTrace: s);
    }
  }

  void pop() => routerFacade.goBack();

  Future<void> persist() async {
    final candidate = _collect();
    validatePlayerCreateInfoFields(candidate);
    final originalKey = persistedKey.value;
    final action = originalKey == null
        ? ActivityActionType.create
        : ActivityActionType.update;
    if (originalKey == null) {
      await _repository.storePlayerCreateInfo(candidate);
    } else {
      await _repository.updatePlayerCreateInfo(originalKey, candidate);
    }
    persistedKey.value = PlayerCreateInfoKey.fromEntity(candidate);
    info.value = candidate;
    routerFacade.updateCurrentLabel(
      '种族${candidate.race}-职业${candidate.class_}',
    );
    _logActivity(action, candidate);
  }

  Future<void> save(BuildContext context) async {
    try {
      await persist();
      if (!context.mounted) return;
      ShadSonner.of(context).show(ShadToast(description: Text('保存成功')));
    } catch (e) {
      if (!context.mounted) return;
      ShadSonner.of(context).show(ShadToast(description: Text(e.toString())));
    }
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

  void _logActivity(ActivityActionType action, PlayerCreateInfoEntity t) {
    final log = ActivityLogEntity(
      module: 'player_create_info',
      actionType: action,
      entityName: 'PlayerCreateInfo ${t.race}/${t.class_}',
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().storeActivityLogBestEffort(log);
  }
}
