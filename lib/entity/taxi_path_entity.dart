import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'taxi_path_entity.g.dart';

@FoxyBriefEntity()
@FoxyFullEntity(table: 'foxy.dbc_taxi_path')
class TaxiPathEntity with _TaxiPathEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyBriefField()
  @FoxyFullField('FromTaxiNode')
  final int fromTaxiNode;

  @FoxyBriefField()
  @FoxyFullField('ToTaxiNode')
  final int toTaxiNode;

  @FoxyBriefField()
  @FoxyFullField('Cost')
  final int cost;

  const TaxiPathEntity({
    this.id = 0,
    this.fromTaxiNode = 0,
    this.toTaxiNode = 0,
    this.cost = 0,
  });

  factory TaxiPathEntity.fromJson(Map<String, dynamic> json) =>
      _TaxiPathEntityMixin.fromJson(json);
}
