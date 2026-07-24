import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'point_of_interest_entity.g.dart';

@FoxyBriefEntity()
@FoxyBriefField.text('localeName')
@FoxyFullEntity(table: 'points_of_interest')
class PointOfInterestEntity with _PointOfInterestEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyFullField('PositionX')
  final double positionX;

  @FoxyFullField('PositionY')
  final double positionY;

  @FoxyFullField('Icon')
  final int icon;

  @FoxyFullField('Flags')
  final int flags;

  @FoxyFullField('Importance')
  final int importance;

  @FoxyBriefField()
  @FoxyFullField('Name')
  final String name;

  const PointOfInterestEntity({
    this.id = 0,
    this.positionX = 0,
    this.positionY = 0,
    this.icon = 0,
    this.flags = 0,
    this.importance = 0,
    this.name = '',
  });

  factory PointOfInterestEntity.fromJson(Map<String, dynamic> json) =>
      _PointOfInterestEntityMixin.fromJson(json);
}

extension BriefPointOfInterestEntityDisplay on BriefPointOfInterestEntity {
  String get displayName => localeName.isNotEmpty ? localeName : name;
}
