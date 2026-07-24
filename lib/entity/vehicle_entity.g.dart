// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_entity.dart';

mixin _VehicleEntityMixin {
  static VehicleEntity fromJson(Map<String, dynamic> json) {
    return VehicleEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      flags: (json['Flags'] as num?)?.toInt() ?? 0,
      turnSpeed: (json['TurnSpeed'] as num?)?.toDouble() ?? 0.0,
      pitchSpeed: (json['PitchSpeed'] as num?)?.toDouble() ?? 0.0,
      pitchMin: (json['PitchMin'] as num?)?.toDouble() ?? 0.0,
      pitchMax: (json['PitchMax'] as num?)?.toDouble() ?? 0.0,
      seatID0: (json['SeatID0'] as num?)?.toInt() ?? 0,
      seatID1: (json['SeatID1'] as num?)?.toInt() ?? 0,
      seatID2: (json['SeatID2'] as num?)?.toInt() ?? 0,
      seatID3: (json['SeatID3'] as num?)?.toInt() ?? 0,
      seatID4: (json['SeatID4'] as num?)?.toInt() ?? 0,
      seatID5: (json['SeatID5'] as num?)?.toInt() ?? 0,
      seatID6: (json['SeatID6'] as num?)?.toInt() ?? 0,
      seatID7: (json['SeatID7'] as num?)?.toInt() ?? 0,
      mouseLookOffsetPitch:
          (json['MouseLookOffsetPitch'] as num?)?.toDouble() ?? 0.0,
      cameraFadeDistScalarMin:
          (json['CameraFadeDistScalarMin'] as num?)?.toDouble() ?? 0.0,
      cameraFadeDistScalarMax:
          (json['CameraFadeDistScalarMax'] as num?)?.toDouble() ?? 0.0,
      cameraPitchOffset: (json['CameraPitchOffset'] as num?)?.toDouble() ?? 0.0,
      facingLimitRight: (json['FacingLimitRight'] as num?)?.toDouble() ?? 0.0,
      facingLimitLeft: (json['FacingLimitLeft'] as num?)?.toDouble() ?? 0.0,
      msslTrgtTurnLingering:
          (json['MsslTrgtTurnLingering'] as num?)?.toDouble() ?? 0.0,
      msslTrgtPitchLingering:
          (json['MsslTrgtPitchLingering'] as num?)?.toDouble() ?? 0.0,
      msslTrgtMouseLingering:
          (json['MsslTrgtMouseLingering'] as num?)?.toDouble() ?? 0.0,
      msslTrgtEndOpacity:
          (json['MsslTrgtEndOpacity'] as num?)?.toDouble() ?? 0.0,
      msslTrgtArcSpeed: (json['MsslTrgtArcSpeed'] as num?)?.toDouble() ?? 0.0,
      msslTrgtArcRepeat: (json['MsslTrgtArcRepeat'] as num?)?.toDouble() ?? 0.0,
      msslTrgtArcWidth: (json['MsslTrgtArcWidth'] as num?)?.toDouble() ?? 0.0,
      msslTrgtImpactRadius0:
          (json['MsslTrgtImpactRadius0'] as num?)?.toDouble() ?? 0.0,
      msslTrgtImpactRadius1:
          (json['MsslTrgtImpactRadius1'] as num?)?.toDouble() ?? 0.0,
      msslTrgtArcTexture: json['MsslTrgtArcTexture']?.toString() ?? '',
      msslTrgtImpactTexture: json['MsslTrgtImpactTexture']?.toString() ?? '',
      msslTrgtImpactModel0: json['MsslTrgtImpactModel0']?.toString() ?? '',
      msslTrgtImpactModel1: json['MsslTrgtImpactModel1']?.toString() ?? '',
      cameraYawOffset: (json['CameraYawOffset'] as num?)?.toDouble() ?? 0.0,
      uiLocomotionType: (json['UiLocomotionType'] as num?)?.toInt() ?? 0,
      msslTrgtImpactTexRadius:
          (json['MsslTrgtImpactTexRadius'] as num?)?.toDouble() ?? 0.0,
      vehicleUIIndicatorID:
          (json['VehicleUIIndicatorID'] as num?)?.toInt() ?? 0,
      powerDisplayID0: (json['PowerDisplayID0'] as num?)?.toInt() ?? 0,
      powerDisplayID1: (json['PowerDisplayID1'] as num?)?.toInt() ?? 0,
      powerDisplayID2: (json['PowerDisplayID2'] as num?)?.toInt() ?? 0,
    );
  }

  VehicleEntity copyWith({
    int? id,
    int? flags,
    double? turnSpeed,
    double? pitchSpeed,
    double? pitchMin,
    double? pitchMax,
    int? seatID0,
    int? seatID1,
    int? seatID2,
    int? seatID3,
    int? seatID4,
    int? seatID5,
    int? seatID6,
    int? seatID7,
    double? mouseLookOffsetPitch,
    double? cameraFadeDistScalarMin,
    double? cameraFadeDistScalarMax,
    double? cameraPitchOffset,
    double? facingLimitRight,
    double? facingLimitLeft,
    double? msslTrgtTurnLingering,
    double? msslTrgtPitchLingering,
    double? msslTrgtMouseLingering,
    double? msslTrgtEndOpacity,
    double? msslTrgtArcSpeed,
    double? msslTrgtArcRepeat,
    double? msslTrgtArcWidth,
    double? msslTrgtImpactRadius0,
    double? msslTrgtImpactRadius1,
    String? msslTrgtArcTexture,
    String? msslTrgtImpactTexture,
    String? msslTrgtImpactModel0,
    String? msslTrgtImpactModel1,
    double? cameraYawOffset,
    int? uiLocomotionType,
    double? msslTrgtImpactTexRadius,
    int? vehicleUIIndicatorID,
    int? powerDisplayID0,
    int? powerDisplayID1,
    int? powerDisplayID2,
  }) {
    final self = this as VehicleEntity;
    return VehicleEntity(
      id: id ?? self.id,
      flags: flags ?? self.flags,
      turnSpeed: turnSpeed ?? self.turnSpeed,
      pitchSpeed: pitchSpeed ?? self.pitchSpeed,
      pitchMin: pitchMin ?? self.pitchMin,
      pitchMax: pitchMax ?? self.pitchMax,
      seatID0: seatID0 ?? self.seatID0,
      seatID1: seatID1 ?? self.seatID1,
      seatID2: seatID2 ?? self.seatID2,
      seatID3: seatID3 ?? self.seatID3,
      seatID4: seatID4 ?? self.seatID4,
      seatID5: seatID5 ?? self.seatID5,
      seatID6: seatID6 ?? self.seatID6,
      seatID7: seatID7 ?? self.seatID7,
      mouseLookOffsetPitch: mouseLookOffsetPitch ?? self.mouseLookOffsetPitch,
      cameraFadeDistScalarMin:
          cameraFadeDistScalarMin ?? self.cameraFadeDistScalarMin,
      cameraFadeDistScalarMax:
          cameraFadeDistScalarMax ?? self.cameraFadeDistScalarMax,
      cameraPitchOffset: cameraPitchOffset ?? self.cameraPitchOffset,
      facingLimitRight: facingLimitRight ?? self.facingLimitRight,
      facingLimitLeft: facingLimitLeft ?? self.facingLimitLeft,
      msslTrgtTurnLingering:
          msslTrgtTurnLingering ?? self.msslTrgtTurnLingering,
      msslTrgtPitchLingering:
          msslTrgtPitchLingering ?? self.msslTrgtPitchLingering,
      msslTrgtMouseLingering:
          msslTrgtMouseLingering ?? self.msslTrgtMouseLingering,
      msslTrgtEndOpacity: msslTrgtEndOpacity ?? self.msslTrgtEndOpacity,
      msslTrgtArcSpeed: msslTrgtArcSpeed ?? self.msslTrgtArcSpeed,
      msslTrgtArcRepeat: msslTrgtArcRepeat ?? self.msslTrgtArcRepeat,
      msslTrgtArcWidth: msslTrgtArcWidth ?? self.msslTrgtArcWidth,
      msslTrgtImpactRadius0:
          msslTrgtImpactRadius0 ?? self.msslTrgtImpactRadius0,
      msslTrgtImpactRadius1:
          msslTrgtImpactRadius1 ?? self.msslTrgtImpactRadius1,
      msslTrgtArcTexture: msslTrgtArcTexture ?? self.msslTrgtArcTexture,
      msslTrgtImpactTexture:
          msslTrgtImpactTexture ?? self.msslTrgtImpactTexture,
      msslTrgtImpactModel0: msslTrgtImpactModel0 ?? self.msslTrgtImpactModel0,
      msslTrgtImpactModel1: msslTrgtImpactModel1 ?? self.msslTrgtImpactModel1,
      cameraYawOffset: cameraYawOffset ?? self.cameraYawOffset,
      uiLocomotionType: uiLocomotionType ?? self.uiLocomotionType,
      msslTrgtImpactTexRadius:
          msslTrgtImpactTexRadius ?? self.msslTrgtImpactTexRadius,
      vehicleUIIndicatorID: vehicleUIIndicatorID ?? self.vehicleUIIndicatorID,
      powerDisplayID0: powerDisplayID0 ?? self.powerDisplayID0,
      powerDisplayID1: powerDisplayID1 ?? self.powerDisplayID1,
      powerDisplayID2: powerDisplayID2 ?? self.powerDisplayID2,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as VehicleEntity;
    return {
      'ID': self.id,
      'Flags': self.flags,
      'TurnSpeed': self.turnSpeed,
      'PitchSpeed': self.pitchSpeed,
      'PitchMin': self.pitchMin,
      'PitchMax': self.pitchMax,
      'SeatID0': self.seatID0,
      'SeatID1': self.seatID1,
      'SeatID2': self.seatID2,
      'SeatID3': self.seatID3,
      'SeatID4': self.seatID4,
      'SeatID5': self.seatID5,
      'SeatID6': self.seatID6,
      'SeatID7': self.seatID7,
      'MouseLookOffsetPitch': self.mouseLookOffsetPitch,
      'CameraFadeDistScalarMin': self.cameraFadeDistScalarMin,
      'CameraFadeDistScalarMax': self.cameraFadeDistScalarMax,
      'CameraPitchOffset': self.cameraPitchOffset,
      'FacingLimitRight': self.facingLimitRight,
      'FacingLimitLeft': self.facingLimitLeft,
      'MsslTrgtTurnLingering': self.msslTrgtTurnLingering,
      'MsslTrgtPitchLingering': self.msslTrgtPitchLingering,
      'MsslTrgtMouseLingering': self.msslTrgtMouseLingering,
      'MsslTrgtEndOpacity': self.msslTrgtEndOpacity,
      'MsslTrgtArcSpeed': self.msslTrgtArcSpeed,
      'MsslTrgtArcRepeat': self.msslTrgtArcRepeat,
      'MsslTrgtArcWidth': self.msslTrgtArcWidth,
      'MsslTrgtImpactRadius0': self.msslTrgtImpactRadius0,
      'MsslTrgtImpactRadius1': self.msslTrgtImpactRadius1,
      'MsslTrgtArcTexture': self.msslTrgtArcTexture,
      'MsslTrgtImpactTexture': self.msslTrgtImpactTexture,
      'MsslTrgtImpactModel0': self.msslTrgtImpactModel0,
      'MsslTrgtImpactModel1': self.msslTrgtImpactModel1,
      'CameraYawOffset': self.cameraYawOffset,
      'UiLocomotionType': self.uiLocomotionType,
      'MsslTrgtImpactTexRadius': self.msslTrgtImpactTexRadius,
      'VehicleUIIndicatorID': self.vehicleUIIndicatorID,
      'PowerDisplayID0': self.powerDisplayID0,
      'PowerDisplayID1': self.powerDisplayID1,
      'PowerDisplayID2': self.powerDisplayID2,
    };
  }

  @override
  bool operator ==(Object other) {
    final self = this as VehicleEntity;
    return identical(self, other) ||
        other is VehicleEntity &&
            self.runtimeType == other.runtimeType &&
            self.id == other.id &&
            self.flags == other.flags &&
            self.turnSpeed == other.turnSpeed &&
            self.pitchSpeed == other.pitchSpeed &&
            self.pitchMin == other.pitchMin &&
            self.pitchMax == other.pitchMax &&
            self.seatID0 == other.seatID0 &&
            self.seatID1 == other.seatID1 &&
            self.seatID2 == other.seatID2 &&
            self.seatID3 == other.seatID3 &&
            self.seatID4 == other.seatID4 &&
            self.seatID5 == other.seatID5 &&
            self.seatID6 == other.seatID6 &&
            self.seatID7 == other.seatID7 &&
            self.mouseLookOffsetPitch == other.mouseLookOffsetPitch &&
            self.cameraFadeDistScalarMin == other.cameraFadeDistScalarMin &&
            self.cameraFadeDistScalarMax == other.cameraFadeDistScalarMax &&
            self.cameraPitchOffset == other.cameraPitchOffset &&
            self.facingLimitRight == other.facingLimitRight &&
            self.facingLimitLeft == other.facingLimitLeft &&
            self.msslTrgtTurnLingering == other.msslTrgtTurnLingering &&
            self.msslTrgtPitchLingering == other.msslTrgtPitchLingering &&
            self.msslTrgtMouseLingering == other.msslTrgtMouseLingering &&
            self.msslTrgtEndOpacity == other.msslTrgtEndOpacity &&
            self.msslTrgtArcSpeed == other.msslTrgtArcSpeed &&
            self.msslTrgtArcRepeat == other.msslTrgtArcRepeat &&
            self.msslTrgtArcWidth == other.msslTrgtArcWidth &&
            self.msslTrgtImpactRadius0 == other.msslTrgtImpactRadius0 &&
            self.msslTrgtImpactRadius1 == other.msslTrgtImpactRadius1 &&
            self.msslTrgtArcTexture == other.msslTrgtArcTexture &&
            self.msslTrgtImpactTexture == other.msslTrgtImpactTexture &&
            self.msslTrgtImpactModel0 == other.msslTrgtImpactModel0 &&
            self.msslTrgtImpactModel1 == other.msslTrgtImpactModel1 &&
            self.cameraYawOffset == other.cameraYawOffset &&
            self.uiLocomotionType == other.uiLocomotionType &&
            self.msslTrgtImpactTexRadius == other.msslTrgtImpactTexRadius &&
            self.vehicleUIIndicatorID == other.vehicleUIIndicatorID &&
            self.powerDisplayID0 == other.powerDisplayID0 &&
            self.powerDisplayID1 == other.powerDisplayID1 &&
            self.powerDisplayID2 == other.powerDisplayID2;
  }

  @override
  int get hashCode {
    final self = this as VehicleEntity;
    return Object.hashAll([
      self.runtimeType,
      self.id,
      self.flags,
      self.turnSpeed,
      self.pitchSpeed,
      self.pitchMin,
      self.pitchMax,
      self.seatID0,
      self.seatID1,
      self.seatID2,
      self.seatID3,
      self.seatID4,
      self.seatID5,
      self.seatID6,
      self.seatID7,
      self.mouseLookOffsetPitch,
      self.cameraFadeDistScalarMin,
      self.cameraFadeDistScalarMax,
      self.cameraPitchOffset,
      self.facingLimitRight,
      self.facingLimitLeft,
      self.msslTrgtTurnLingering,
      self.msslTrgtPitchLingering,
      self.msslTrgtMouseLingering,
      self.msslTrgtEndOpacity,
      self.msslTrgtArcSpeed,
      self.msslTrgtArcRepeat,
      self.msslTrgtArcWidth,
      self.msslTrgtImpactRadius0,
      self.msslTrgtImpactRadius1,
      self.msslTrgtArcTexture,
      self.msslTrgtImpactTexture,
      self.msslTrgtImpactModel0,
      self.msslTrgtImpactModel1,
      self.cameraYawOffset,
      self.uiLocomotionType,
      self.msslTrgtImpactTexRadius,
      self.vehicleUIIndicatorID,
      self.powerDisplayID0,
      self.powerDisplayID1,
      self.powerDisplayID2,
    ]);
  }

  @override
  String toString() {
    final self = this as VehicleEntity;
    return 'VehicleEntity('
        'id: ${self.id}, '
        'flags: ${self.flags}, '
        'turnSpeed: ${self.turnSpeed}, '
        'pitchSpeed: ${self.pitchSpeed}, '
        'pitchMin: ${self.pitchMin}, '
        'pitchMax: ${self.pitchMax}, '
        'seatID0: ${self.seatID0}, '
        'seatID1: ${self.seatID1}, '
        'seatID2: ${self.seatID2}, '
        'seatID3: ${self.seatID3}, '
        'seatID4: ${self.seatID4}, '
        'seatID5: ${self.seatID5}, '
        'seatID6: ${self.seatID6}, '
        'seatID7: ${self.seatID7}, '
        'mouseLookOffsetPitch: ${self.mouseLookOffsetPitch}, '
        'cameraFadeDistScalarMin: ${self.cameraFadeDistScalarMin}, '
        'cameraFadeDistScalarMax: ${self.cameraFadeDistScalarMax}, '
        'cameraPitchOffset: ${self.cameraPitchOffset}, '
        'facingLimitRight: ${self.facingLimitRight}, '
        'facingLimitLeft: ${self.facingLimitLeft}, '
        'msslTrgtTurnLingering: ${self.msslTrgtTurnLingering}, '
        'msslTrgtPitchLingering: ${self.msslTrgtPitchLingering}, '
        'msslTrgtMouseLingering: ${self.msslTrgtMouseLingering}, '
        'msslTrgtEndOpacity: ${self.msslTrgtEndOpacity}, '
        'msslTrgtArcSpeed: ${self.msslTrgtArcSpeed}, '
        'msslTrgtArcRepeat: ${self.msslTrgtArcRepeat}, '
        'msslTrgtArcWidth: ${self.msslTrgtArcWidth}, '
        'msslTrgtImpactRadius0: ${self.msslTrgtImpactRadius0}, '
        'msslTrgtImpactRadius1: ${self.msslTrgtImpactRadius1}, '
        'msslTrgtArcTexture: ${self.msslTrgtArcTexture}, '
        'msslTrgtImpactTexture: ${self.msslTrgtImpactTexture}, '
        'msslTrgtImpactModel0: ${self.msslTrgtImpactModel0}, '
        'msslTrgtImpactModel1: ${self.msslTrgtImpactModel1}, '
        'cameraYawOffset: ${self.cameraYawOffset}, '
        'uiLocomotionType: ${self.uiLocomotionType}, '
        'msslTrgtImpactTexRadius: ${self.msslTrgtImpactTexRadius}, '
        'vehicleUIIndicatorID: ${self.vehicleUIIndicatorID}, '
        'powerDisplayID0: ${self.powerDisplayID0}, '
        'powerDisplayID1: ${self.powerDisplayID1}, '
        'powerDisplayID2: ${self.powerDisplayID2}'
        ')';
  }
}

final class BriefVehicleEntity {
  final int id;
  final int flags;
  final double turnSpeed;

  const BriefVehicleEntity({this.id = 0, this.flags = 0, this.turnSpeed = 0.0});

  factory BriefVehicleEntity.fromJson(Map<String, dynamic> json) {
    return BriefVehicleEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      flags: (json['Flags'] as num?)?.toInt() ?? 0,
      turnSpeed: (json['TurnSpeed'] as num?)?.toDouble() ?? 0.0,
    );
  }

  int get key => id;
}
