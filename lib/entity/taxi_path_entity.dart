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

  factory BriefTaxiPathEntity.fromJson(Map<String, dynamic> json) =>
      BriefTaxiPathEntity(
        id: json['ID'] ?? 0,
        fromTaxiNode: json['FromTaxiNode'] ?? 0,
        toTaxiNode: json['ToTaxiNode'] ?? 0,
        cost: json['Cost'] ?? 0,
      );
}

class TaxiPathEntity {
  final int id;
  final int fromTaxiNode;
  final int toTaxiNode;
  final int cost;

  const TaxiPathEntity({
    this.id = 0,
    this.fromTaxiNode = 0,
    this.toTaxiNode = 0,
    this.cost = 0,
  });

  factory TaxiPathEntity.fromJson(Map<String, dynamic> json) => TaxiPathEntity(
    id: json['ID'] ?? 0,
    fromTaxiNode: json['FromTaxiNode'] ?? 0,
    toTaxiNode: json['ToTaxiNode'] ?? 0,
    cost: json['Cost'] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    'ID': id,
    'FromTaxiNode': fromTaxiNode,
    'ToTaxiNode': toTaxiNode,
    'Cost': cost,
  };
}
