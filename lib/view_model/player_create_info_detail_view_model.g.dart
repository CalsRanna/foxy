// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_create_info_detail_view_model.dart';

mixin _PlayerCreateInfoDetailViewModelMixin on FieldControllerMixin {
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
}
