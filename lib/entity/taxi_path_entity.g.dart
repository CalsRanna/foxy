// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'taxi_path_entity.dart';

mixin _TaxiPathEntityMixin {
  int get id;
  int get fromTaxiNode;
  int get toTaxiNode;
  int get cost;

  static TaxiPathEntity fromJson(Map<String, dynamic> json) {
    return TaxiPathEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      fromTaxiNode: (json['FromTaxiNode'] as num?)?.toInt() ?? 0,
      toTaxiNode: (json['ToTaxiNode'] as num?)?.toInt() ?? 0,
      cost: (json['Cost'] as num?)?.toInt() ?? 0,
    );
  }

  TaxiPathEntity copyWith({
    int? id,
    int? fromTaxiNode,
    int? toTaxiNode,
    int? cost,
  }) {
    return TaxiPathEntity(
      id: id ?? this.id,
      fromTaxiNode: fromTaxiNode ?? this.fromTaxiNode,
      toTaxiNode: toTaxiNode ?? this.toTaxiNode,
      cost: cost ?? this.cost,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'FromTaxiNode': fromTaxiNode,
      'ToTaxiNode': toTaxiNode,
      'Cost': cost,
    };
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is TaxiPathEntity &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            fromTaxiNode == other.fromTaxiNode &&
            toTaxiNode == other.toTaxiNode &&
            cost == other.cost;
  }

  @override
  int get hashCode {
    return Object.hashAll([runtimeType, id, fromTaxiNode, toTaxiNode, cost]);
  }

  @override
  String toString() {
    return 'TaxiPathEntity('
        'id: $id, '
        'fromTaxiNode: $fromTaxiNode, '
        'toTaxiNode: $toTaxiNode, '
        'cost: $cost'
        ')';
  }
}
