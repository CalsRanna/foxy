/// 载具数据
class VehicleEntity {
  final int id;
  final int flags;
  final double turnSpeed;
  final double pitchSpeed;
  final double pitchMin;
  final double pitchMax;
  final int seatID0;
  final int seatID1;
  final int seatID2;
  final int seatID3;
  final int seatID4;
  final int seatID5;
  final int seatID6;
  final int seatID7;
  final double mouseLookOffsetPitch;
  final double cameraFadeDistScalarMin;
  final double cameraFadeDistScalarMax;
  final double cameraPitchOffset;
  final double facingLimitRight;
  final double facingLimitLeft;
  final double msslTrgtTurnLingering;
  final double msslTrgtPitchLingering;
  final double msslTrgtMouseLingering;
  final double msslTrgtEndOpacity;
  final double msslTrgtArcSpeed;
  final double msslTrgtArcRepeat;
  final double msslTrgtArcWidth;
  final double msslTrgtImpactRadius0;
  final double msslTrgtImpactRadius1;
  final String msslTrgtArcTexture;
  final String msslTrgtImpactTexture;
  final String msslTrgtImpactModel0;
  final String msslTrgtImpactModel1;
  final double cameraYawOffset;
  final int uiLocomotionType;
  final double msslTrgtImpactTexRadius;
  final int vehicleUIIndicatorID;
  final int powerDisplayID0;
  final int powerDisplayID1;
  final int powerDisplayID2;

  const VehicleEntity({
    this.id = 0,
    this.flags = 0,
    this.turnSpeed = 0,
    this.pitchSpeed = 0,
    this.pitchMin = 0,
    this.pitchMax = 0,
    this.seatID0 = 0,
    this.seatID1 = 0,
    this.seatID2 = 0,
    this.seatID3 = 0,
    this.seatID4 = 0,
    this.seatID5 = 0,
    this.seatID6 = 0,
    this.seatID7 = 0,
    this.mouseLookOffsetPitch = 0,
    this.cameraFadeDistScalarMin = 0,
    this.cameraFadeDistScalarMax = 0,
    this.cameraPitchOffset = 0,
    this.facingLimitRight = 0,
    this.facingLimitLeft = 0,
    this.msslTrgtTurnLingering = 0,
    this.msslTrgtPitchLingering = 0,
    this.msslTrgtMouseLingering = 0,
    this.msslTrgtEndOpacity = 0,
    this.msslTrgtArcSpeed = 0,
    this.msslTrgtArcRepeat = 0,
    this.msslTrgtArcWidth = 0,
    this.msslTrgtImpactRadius0 = 0,
    this.msslTrgtImpactRadius1 = 0,
    this.msslTrgtArcTexture = '',
    this.msslTrgtImpactTexture = '',
    this.msslTrgtImpactModel0 = '',
    this.msslTrgtImpactModel1 = '',
    this.cameraYawOffset = 0,
    this.uiLocomotionType = 0,
    this.msslTrgtImpactTexRadius = 0,
    this.vehicleUIIndicatorID = 0,
    this.powerDisplayID0 = 0,
    this.powerDisplayID1 = 0,
    this.powerDisplayID2 = 0,
  });

  factory VehicleEntity.fromJson(Map<String, dynamic> json) {
    return VehicleEntity(
      id: json['ID'] ?? json['id'] ?? 0,
      flags: json['Flags'] ?? json['flags'] ?? 0,
      turnSpeed: json['TurnSpeed'] ?? json['turnSpeed'] ?? 0,
      pitchSpeed: json['PitchSpeed'] ?? json['pitchSpeed'] ?? 0,
      pitchMin: json['PitchMin'] ?? json['pitchMin'] ?? 0,
      pitchMax: json['PitchMax'] ?? json['pitchMax'] ?? 0,
      seatID0: json['SeatID0'] ?? 0,
      seatID1: json['SeatID1'] ?? 0,
      seatID2: json['SeatID2'] ?? 0,
      seatID3: json['SeatID3'] ?? 0,
      seatID4: json['SeatID4'] ?? 0,
      seatID5: json['SeatID5'] ?? 0,
      seatID6: json['SeatID6'] ?? 0,
      seatID7: json['SeatID7'] ?? 0,
      mouseLookOffsetPitch: json['MouseLookOffsetPitch'] ?? 0,
      cameraFadeDistScalarMin: json['CameraFadeDistScalarMin'] ?? 0,
      cameraFadeDistScalarMax: json['CameraFadeDistScalarMax'] ?? 0,
      cameraPitchOffset: json['CameraPitchOffset'] ?? 0,
      facingLimitRight: json['FacingLimitRight'] ?? 0,
      facingLimitLeft: json['FacingLimitLeft'] ?? 0,
      msslTrgtTurnLingering: json['MsslTrgtTurnLingering'] ?? 0,
      msslTrgtPitchLingering: json['MsslTrgtPitchLingering'] ?? 0,
      msslTrgtMouseLingering: json['MsslTrgtMouseLingering'] ?? 0,
      msslTrgtEndOpacity: json['MsslTrgtEndOpacity'] ?? 0,
      msslTrgtArcSpeed: json['MsslTrgtArcSpeed'] ?? 0,
      msslTrgtArcRepeat: json['MsslTrgtArcRepeat'] ?? 0,
      msslTrgtArcWidth: json['MsslTrgtArcWidth'] ?? 0,
      msslTrgtImpactRadius0: json['MsslTrgtImpactRadius0'] ?? 0,
      msslTrgtImpactRadius1: json['MsslTrgtImpactRadius1'] ?? 0,
      msslTrgtArcTexture: json['MsslTrgtArcTexture'] ?? '',
      msslTrgtImpactTexture: json['MsslTrgtImpactTexture'] ?? '',
      msslTrgtImpactModel0: json['MsslTrgtImpactModel0'] ?? '',
      msslTrgtImpactModel1: json['MsslTrgtImpactModel1'] ?? '',
      cameraYawOffset: json['CameraYawOffset'] ?? 0,
      uiLocomotionType: json['UiLocomotionType'] ?? 0,
      msslTrgtImpactTexRadius: json['MsslTrgtImpactTexRadius'] ?? 0,
      vehicleUIIndicatorID: json['VehicleUIIndicatorID'] ?? 0,
      powerDisplayID0: json['PowerDisplayID0'] ?? 0,
      powerDisplayID1: json['PowerDisplayID1'] ?? 0,
      powerDisplayID2: json['PowerDisplayID2'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Flags': flags,
      'TurnSpeed': turnSpeed,
      'PitchSpeed': pitchSpeed,
      'PitchMin': pitchMin,
      'PitchMax': pitchMax,
      'SeatID0': seatID0,
      'SeatID1': seatID1,
      'SeatID2': seatID2,
      'SeatID3': seatID3,
      'SeatID4': seatID4,
      'SeatID5': seatID5,
      'SeatID6': seatID6,
      'SeatID7': seatID7,
      'MouseLookOffsetPitch': mouseLookOffsetPitch,
      'CameraFadeDistScalarMin': cameraFadeDistScalarMin,
      'CameraFadeDistScalarMax': cameraFadeDistScalarMax,
      'CameraPitchOffset': cameraPitchOffset,
      'FacingLimitRight': facingLimitRight,
      'FacingLimitLeft': facingLimitLeft,
      'MsslTrgtTurnLingering': msslTrgtTurnLingering,
      'MsslTrgtPitchLingering': msslTrgtPitchLingering,
      'MsslTrgtMouseLingering': msslTrgtMouseLingering,
      'MsslTrgtEndOpacity': msslTrgtEndOpacity,
      'MsslTrgtArcSpeed': msslTrgtArcSpeed,
      'MsslTrgtArcRepeat': msslTrgtArcRepeat,
      'MsslTrgtArcWidth': msslTrgtArcWidth,
      'MsslTrgtImpactRadius0': msslTrgtImpactRadius0,
      'MsslTrgtImpactRadius1': msslTrgtImpactRadius1,
      'MsslTrgtArcTexture': msslTrgtArcTexture,
      'MsslTrgtImpactTexture': msslTrgtImpactTexture,
      'MsslTrgtImpactModel0': msslTrgtImpactModel0,
      'MsslTrgtImpactModel1': msslTrgtImpactModel1,
      'CameraYawOffset': cameraYawOffset,
      'UiLocomotionType': uiLocomotionType,
      'MsslTrgtImpactTexRadius': msslTrgtImpactTexRadius,
      'VehicleUIIndicatorID': vehicleUIIndicatorID,
      'PowerDisplayID0': powerDisplayID0,
      'PowerDisplayID1': powerDisplayID1,
      'PowerDisplayID2': powerDisplayID2,
    };
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
    return VehicleEntity(
      id: id ?? this.id,
      flags: flags ?? this.flags,
      turnSpeed: turnSpeed ?? this.turnSpeed,
      pitchSpeed: pitchSpeed ?? this.pitchSpeed,
      pitchMin: pitchMin ?? this.pitchMin,
      pitchMax: pitchMax ?? this.pitchMax,
      seatID0: seatID0 ?? this.seatID0,
      seatID1: seatID1 ?? this.seatID1,
      seatID2: seatID2 ?? this.seatID2,
      seatID3: seatID3 ?? this.seatID3,
      seatID4: seatID4 ?? this.seatID4,
      seatID5: seatID5 ?? this.seatID5,
      seatID6: seatID6 ?? this.seatID6,
      seatID7: seatID7 ?? this.seatID7,
      mouseLookOffsetPitch: mouseLookOffsetPitch ?? this.mouseLookOffsetPitch,
      cameraFadeDistScalarMin:
          cameraFadeDistScalarMin ?? this.cameraFadeDistScalarMin,
      cameraFadeDistScalarMax:
          cameraFadeDistScalarMax ?? this.cameraFadeDistScalarMax,
      cameraPitchOffset: cameraPitchOffset ?? this.cameraPitchOffset,
      facingLimitRight: facingLimitRight ?? this.facingLimitRight,
      facingLimitLeft: facingLimitLeft ?? this.facingLimitLeft,
      msslTrgtTurnLingering:
          msslTrgtTurnLingering ?? this.msslTrgtTurnLingering,
      msslTrgtPitchLingering:
          msslTrgtPitchLingering ?? this.msslTrgtPitchLingering,
      msslTrgtMouseLingering:
          msslTrgtMouseLingering ?? this.msslTrgtMouseLingering,
      msslTrgtEndOpacity: msslTrgtEndOpacity ?? this.msslTrgtEndOpacity,
      msslTrgtArcSpeed: msslTrgtArcSpeed ?? this.msslTrgtArcSpeed,
      msslTrgtArcRepeat: msslTrgtArcRepeat ?? this.msslTrgtArcRepeat,
      msslTrgtArcWidth: msslTrgtArcWidth ?? this.msslTrgtArcWidth,
      msslTrgtImpactRadius0:
          msslTrgtImpactRadius0 ?? this.msslTrgtImpactRadius0,
      msslTrgtImpactRadius1:
          msslTrgtImpactRadius1 ?? this.msslTrgtImpactRadius1,
      msslTrgtArcTexture: msslTrgtArcTexture ?? this.msslTrgtArcTexture,
      msslTrgtImpactTexture:
          msslTrgtImpactTexture ?? this.msslTrgtImpactTexture,
      msslTrgtImpactModel0: msslTrgtImpactModel0 ?? this.msslTrgtImpactModel0,
      msslTrgtImpactModel1: msslTrgtImpactModel1 ?? this.msslTrgtImpactModel1,
      cameraYawOffset: cameraYawOffset ?? this.cameraYawOffset,
      uiLocomotionType: uiLocomotionType ?? this.uiLocomotionType,
      msslTrgtImpactTexRadius:
          msslTrgtImpactTexRadius ?? this.msslTrgtImpactTexRadius,
      vehicleUIIndicatorID: vehicleUIIndicatorID ?? this.vehicleUIIndicatorID,
      powerDisplayID0: powerDisplayID0 ?? this.powerDisplayID0,
      powerDisplayID1: powerDisplayID1 ?? this.powerDisplayID1,
      powerDisplayID2: powerDisplayID2 ?? this.powerDisplayID2,
    );
  }
}
