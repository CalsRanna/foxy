// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
final class BriefTaxiPathEntity {
  final int id;
  final int fromTaxiNode;
  final int toTaxiNode;
  final int cost;

  const BriefTaxiPathEntity({
    this.id = 0,
    this.fromTaxiNode = 0,
    this.toTaxiNode = 0,
    this.cost = 0,
  });

  factory BriefTaxiPathEntity.fromJson(Map<String, dynamic> json) {
    return BriefTaxiPathEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      fromTaxiNode: (json['FromTaxiNode'] as num?)?.toInt() ?? 0,
      toTaxiNode: (json['ToTaxiNode'] as num?)?.toInt() ?? 0,
      cost: (json['Cost'] as num?)?.toInt() ?? 0,
    );
  }

  int get key => id;
}
