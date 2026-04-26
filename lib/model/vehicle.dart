/// 载具数据
class Vehicle {
  int id = 0;
  int flags = 0;
  double turnSpeed = 0;
  double pitchSpeed = 0;
  double pitchMin = 0;
  double pitchMax = 0;
  int seatID0 = 0;
  int seatID1 = 0;
  int seatID2 = 0;
  int seatID3 = 0;
  int seatID4 = 0;
  int seatID5 = 0;
  int seatID6 = 0;
  int seatID7 = 0;
  double mouseLookOffsetPitch = 0;
  double cameraFadeDistScalarMin = 0;
  double cameraFadeDistScalarMax = 0;
  double cameraPitchOffset = 0;
  double facingLimitRight = 0;
  double facingLimitLeft = 0;
  double msslTrgtTurnLingering = 0;
  double msslTrgtPitchLingering = 0;
  double msslTrgtMouseLingering = 0;
  double msslTrgtEndOpacity = 0;
  double msslTrgtArcSpeed = 0;
  double msslTrgtArcRepeat = 0;
  double msslTrgtArcWidth = 0;
  double msslTrgtImpactRadius0 = 0;
  double msslTrgtImpactRadius1 = 0;
  String msslTrgtArcTexture = '';
  String msslTrgtImpactTexture = '';
  String msslTrgtImpactModel0 = '';
  String msslTrgtImpactModel1 = '';
  double cameraYawOffset = 0;
  int uiLocomotionType = 0;
  double msslTrgtImpactTexRadius = 0;
  int vehicleUIIndicatorID = 0;
  int powerDisplayID0 = 0;
  int powerDisplayID1 = 0;
  int powerDisplayID2 = 0;

  Vehicle();

  Vehicle.fromJson(Map<String, dynamic> json) {
    id = json['ID'] ?? json['id'] ?? 0;
    flags = json['Flags'] ?? json['flags'] ?? 0;
    turnSpeed = (json['TurnSpeed'] ?? json['turnSpeed'] ?? 0).toDouble();
    pitchSpeed = (json['PitchSpeed'] ?? json['pitchSpeed'] ?? 0).toDouble();
    pitchMin = (json['PitchMin'] ?? json['pitchMin'] ?? 0).toDouble();
    pitchMax = (json['PitchMax'] ?? json['pitchMax'] ?? 0).toDouble();
    seatID0 = json['SeatID0'] ?? 0;
    seatID1 = json['SeatID1'] ?? 0;
    seatID2 = json['SeatID2'] ?? 0;
    seatID3 = json['SeatID3'] ?? 0;
    seatID4 = json['SeatID4'] ?? 0;
    seatID5 = json['SeatID5'] ?? 0;
    seatID6 = json['SeatID6'] ?? 0;
    seatID7 = json['SeatID7'] ?? 0;
    mouseLookOffsetPitch =
        (json['MouseLookOffsetPitch'] as num?)?.toDouble() ?? 0;
    cameraFadeDistScalarMin =
        (json['CameraFadeDistScalarMin'] as num?)?.toDouble() ?? 0;
    cameraFadeDistScalarMax =
        (json['CameraFadeDistScalarMax'] as num?)?.toDouble() ?? 0;
    cameraPitchOffset =
        (json['CameraPitchOffset'] as num?)?.toDouble() ?? 0;
    facingLimitRight =
        (json['FacingLimitRight'] as num?)?.toDouble() ?? 0;
    facingLimitLeft =
        (json['FacingLimitLeft'] as num?)?.toDouble() ?? 0;
    msslTrgtTurnLingering =
        (json['MsslTrgtTurnLingering'] as num?)?.toDouble() ?? 0;
    msslTrgtPitchLingering =
        (json['MsslTrgtPitchLingering'] as num?)?.toDouble() ?? 0;
    msslTrgtMouseLingering =
        (json['MsslTrgtMouseLingering'] as num?)?.toDouble() ?? 0;
    msslTrgtEndOpacity =
        (json['MsslTrgtEndOpacity'] as num?)?.toDouble() ?? 0;
    msslTrgtArcSpeed =
        (json['MsslTrgtArcSpeed'] as num?)?.toDouble() ?? 0;
    msslTrgtArcRepeat =
        (json['MsslTrgtArcRepeat'] as num?)?.toDouble() ?? 0;
    msslTrgtArcWidth =
        (json['MsslTrgtArcWidth'] as num?)?.toDouble() ?? 0;
    msslTrgtImpactRadius0 =
        (json['MsslTrgtImpactRadius0'] as num?)?.toDouble() ?? 0;
    msslTrgtImpactRadius1 =
        (json['MsslTrgtImpactRadius1'] as num?)?.toDouble() ?? 0;
    msslTrgtArcTexture = json['MsslTrgtArcTexture'] ?? '';
    msslTrgtImpactTexture = json['MsslTrgtImpactTexture'] ?? '';
    msslTrgtImpactModel0 = json['MsslTrgtImpactModel0'] ?? '';
    msslTrgtImpactModel1 = json['MsslTrgtImpactModel1'] ?? '';
    cameraYawOffset =
        (json['CameraYawOffset'] as num?)?.toDouble() ?? 0;
    uiLocomotionType = json['UiLocomotionType'] ?? 0;
    msslTrgtImpactTexRadius =
        (json['MsslTrgtImpactTexRadius'] as num?)?.toDouble() ?? 0;
    vehicleUIIndicatorID = json['VehicleUIIndicatorID'] ?? 0;
    powerDisplayID0 = json['PowerDisplayID0'] ?? 0;
    powerDisplayID1 = json['PowerDisplayID1'] ?? 0;
    powerDisplayID2 = json['PowerDisplayID2'] ?? 0;
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
}
