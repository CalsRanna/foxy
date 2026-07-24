// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'taxi_path_entity.dart';

mixin _TaxiPathEntityMixin {
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
    final self = this as TaxiPathEntity;
    return TaxiPathEntity(
      id: id ?? self.id,
      fromTaxiNode: fromTaxiNode ?? self.fromTaxiNode,
      toTaxiNode: toTaxiNode ?? self.toTaxiNode,
      cost: cost ?? self.cost,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as TaxiPathEntity;
    return {
      'ID': self.id,
      'FromTaxiNode': self.fromTaxiNode,
      'ToTaxiNode': self.toTaxiNode,
      'Cost': self.cost,
    };
  }

  @override
  bool operator ==(Object other) {
    final self = this as TaxiPathEntity;
    return identical(self, other) ||
        other is TaxiPathEntity &&
            self.runtimeType == other.runtimeType &&
            self.id == other.id &&
            self.fromTaxiNode == other.fromTaxiNode &&
            self.toTaxiNode == other.toTaxiNode &&
            self.cost == other.cost;
  }

  @override
  int get hashCode {
    final self = this as TaxiPathEntity;
    return Object.hashAll([
      self.runtimeType,
      self.id,
      self.fromTaxiNode,
      self.toTaxiNode,
      self.cost,
    ]);
  }

  @override
  String toString() {
    final self = this as TaxiPathEntity;
    return 'TaxiPathEntity('
        'id: ${self.id}, '
        'fromTaxiNode: ${self.fromTaxiNode}, '
        'toTaxiNode: ${self.toTaxiNode}, '
        'cost: ${self.cost}'
        ')';
  }
}
