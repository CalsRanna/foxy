class BriefTaxiPathEntity {
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
      id: json['ID'] ?? 0,
      fromTaxiNode: json['FromTaxiNode'] ?? 0,
      toTaxiNode: json['ToTaxiNode'] ?? 0,
      cost: json['Cost'] ?? 0,
    );
  }

  int get key => id;
}
