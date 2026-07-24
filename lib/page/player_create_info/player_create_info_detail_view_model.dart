import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/player_create_info_entity.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:foxy/repository/player_create_info_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/form/validation/player_create_info_entity_validation_mixin.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

class PlayerCreateInfoDetailViewModel
    with
        ViewModelValidationMixin,
        PlayerCreateInfoValidationMixin,
        FieldControllerMixin {
  final _repository = GetIt.instance.get<PlayerCreateInfoRepository>();
  final _activityLogService = GetIt.instance.get<ActivityLogService>();

  final entity = signal<PlayerCreateInfoEntity?>(null);
  final persistedKey = signal<PlayerCreateInfoKey?>(null);
  final loading = signal(false);
  final submitting = signal(false);
  final errorMessage = signal<String?>(null);

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

  Future<void> initSignals({PlayerCreateInfoKey? key}) async {
    loading.value = true;
    errorMessage.value = null;
    try {
      if (key == null) {
        final blank = await _repository.createPlayerCreateInfo();
        entity.value = blank;
        _applyCandidate(blank);
        persistedKey.value = null;
        return;
      }
      final result = await _repository.getPlayerCreateInfo(key);
      if (result == null) {
        throw StateError('原出生信息记录不存在，可能已被其他操作修改或删除');
      }
      entity.value = result;
      _applyCandidate(result);
      persistedKey.value = key;
    } catch (error, stackTrace) {
      errorMessage.value = error.toString();
      LoggerUtil.instance.e('加载详情失败', error: error, stackTrace: stackTrace);
      rethrow;
    } finally {
      loading.value = false;
    }
  }

  Future<void> persist() async {
    if (submitting.value) throw StateError('正在保存，请稍候');
    submitting.value = true;
    errorMessage.value = null;
    try {
      final candidate = _collectCandidate();
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
      entity.value = candidate;
      _logActivity(action, candidate);
    } catch (error) {
      errorMessage.value = error.toString();
      rethrow;
    } finally {
      submitting.value = false;
    }
  }

  PlayerCreateInfoEntity _collectCandidate() {
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

  void _applyCandidate(PlayerCreateInfoEntity i) {
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
    _activityLogService.recordBestEffort(log);
  }

  void dispose() {
    disposeControllers();
  }
}
