import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'vehicle_entity.g.dart';

/// 载具数据

@FoxyBriefEntity()
@FoxyFilterEntity()
@FoxyFullEntity(table: 'foxy.dbc_vehicle')
class VehicleEntity with _VehicleEntityMixin {
  @FoxyBriefField()
  @FoxyFilterField(defaultValue: '', type: FoxyFilterFieldType.text)
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyBriefField()
  @FoxyFullField('Flags')
  final int flags;

  @FoxyBriefField()
  @FoxyFullField('TurnSpeed')
  final double turnSpeed;

  @FoxyFullField('PitchSpeed')
  final double pitchSpeed;

  @FoxyFullField('PitchMin')
  final double pitchMin;

  @FoxyFullField('PitchMax')
  final double pitchMax;

  @FoxyFullField('SeatID0')
  final int seatID0;

  @FoxyFullField('SeatID1')
  final int seatID1;

  @FoxyFullField('SeatID2')
  final int seatID2;

  @FoxyFullField('SeatID3')
  final int seatID3;

  @FoxyFullField('SeatID4')
  final int seatID4;

  @FoxyFullField('SeatID5')
  final int seatID5;

  @FoxyFullField('SeatID6')
  final int seatID6;

  @FoxyFullField('SeatID7')
  final int seatID7;

  @FoxyFullField('MouseLookOffsetPitch')
  final double mouseLookOffsetPitch;

  @FoxyFullField('CameraFadeDistScalarMin')
  final double cameraFadeDistScalarMin;

  @FoxyFullField('CameraFadeDistScalarMax')
  final double cameraFadeDistScalarMax;

  @FoxyFullField('CameraPitchOffset')
  final double cameraPitchOffset;

  @FoxyFullField('FacingLimitRight')
  final double facingLimitRight;

  @FoxyFullField('FacingLimitLeft')
  final double facingLimitLeft;

  @FoxyFullField('MsslTrgtTurnLingering')
  final double msslTrgtTurnLingering;

  @FoxyFullField('MsslTrgtPitchLingering')
  final double msslTrgtPitchLingering;

  @FoxyFullField('MsslTrgtMouseLingering')
  final double msslTrgtMouseLingering;

  @FoxyFullField('MsslTrgtEndOpacity')
  final double msslTrgtEndOpacity;

  @FoxyFullField('MsslTrgtArcSpeed')
  final double msslTrgtArcSpeed;

  @FoxyFullField('MsslTrgtArcRepeat')
  final double msslTrgtArcRepeat;

  @FoxyFullField('MsslTrgtArcWidth')
  final double msslTrgtArcWidth;

  @FoxyFullField('MsslTrgtImpactRadius0')
  final double msslTrgtImpactRadius0;

  @FoxyFullField('MsslTrgtImpactRadius1')
  final double msslTrgtImpactRadius1;

  @FoxyFullField('MsslTrgtArcTexture')
  final String msslTrgtArcTexture;

  @FoxyFullField('MsslTrgtImpactTexture')
  final String msslTrgtImpactTexture;

  @FoxyFullField('MsslTrgtImpactModel0')
  final String msslTrgtImpactModel0;

  @FoxyFullField('MsslTrgtImpactModel1')
  final String msslTrgtImpactModel1;

  @FoxyFullField('CameraYawOffset')
  final double cameraYawOffset;

  @FoxyFullField('UiLocomotionType')
  final int uiLocomotionType;

  @FoxyFullField('MsslTrgtImpactTexRadius')
  final double msslTrgtImpactTexRadius;

  @FoxyFullField('VehicleUIIndicatorID')
  final int vehicleUIIndicatorID;

  @FoxyFullField('PowerDisplayID0')
  final int powerDisplayID0;

  @FoxyFullField('PowerDisplayID1')
  final int powerDisplayID1;

  @FoxyFullField('PowerDisplayID2')
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

  factory VehicleEntity.fromJson(Map<String, dynamic> json) =>
      _VehicleEntityMixin.fromJson(json);
}
