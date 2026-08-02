// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_create_info_detail_view_model.dart';

mixin _PlayerCreateInfoDetailViewModelMixin on FieldControllerMixin {
  final _repository = GetIt.instance.get<PlayerCreateInfoRepository>();

  final entity = signal<PlayerCreateInfoEntity?>(null);

  final persistedKey = signal<PlayerCreateInfoKey?>(null);

  final loading = signal(false);

  final submitting = signal(false);

  final errorMessage = signal<String?>(null);

  late final raceController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final classController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final mapController = registerController(IntFieldController());
  late final zoneController = registerController(IntFieldController());
  late final positionXController = registerController(DoubleFieldController());
  late final positionYController = registerController(DoubleFieldController());
  late final positionZController = registerController(DoubleFieldController());
  late final orientationController = registerController(
    DoubleFieldController(),
  );

  void dispose() {
    disposeControllers();
  }

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
        throw RecordNotFoundException('record not found');
      }
      entity.value = result;
      _applyCandidate(result);
      persistedKey.value = key;
    } catch (error, stackTrace) {
      errorMessage.value = foxyErrorMessage(error);
      LoggerUtil.instance.e('加载详情失败', error: error, stackTrace: stackTrace);
      rethrow;
    } finally {
      loading.value = false;
    }
  }

  Future<void> persist() async {
    if (submitting.value) throw BusyException('operation already in progress');
    submitting.value = true;
    errorMessage.value = null;
    try {
      final candidate = _collectCandidate();
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
      errorMessage.value = foxyErrorMessage(error);
      rethrow;
    } finally {
      submitting.value = false;
    }
  }

  void _afterApplyCandidate(PlayerCreateInfoEntity playerCreateInfo) {}

  void _applyCandidate(PlayerCreateInfoEntity playerCreateInfo) {
    raceController.init(playerCreateInfo.race);
    classController.init(playerCreateInfo.class_);
    mapController.init(playerCreateInfo.map);
    zoneController.init(playerCreateInfo.zone);
    positionXController.init(playerCreateInfo.positionX);
    positionYController.init(playerCreateInfo.positionY);
    positionZController.init(playerCreateInfo.positionZ);
    orientationController.init(playerCreateInfo.orientation);
    _afterApplyCandidate(playerCreateInfo);
  }

  PlayerCreateInfoEntity _collectCandidate() {
    return PlayerCreateInfoEntity(
      race: raceController.collect(),
      class_: classController.collect(),
      map: mapController.collect(),
      zone: zoneController.collect(),
      positionX: positionXController.collect(),
      positionY: positionYController.collect(),
      positionZ: positionZController.collect(),
      orientation: orientationController.collect(),
    );
  }

  void _logActivity(
    ActivityActionType action,
    PlayerCreateInfoEntity playerCreateInfo,
  ) {}
}
