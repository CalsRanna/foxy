// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'taxi_path_entity.dart';

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

  @override
  int get hashCode => Object.hashAll([id, fromTaxiNode, toTaxiNode, cost]);

  int get key => id;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is BriefTaxiPathEntity &&
            id == other.id &&
            fromTaxiNode == other.fromTaxiNode &&
            toTaxiNode == other.toTaxiNode &&
            cost == other.cost;
  }

  @override
  String toString() {
    return 'BriefTaxiPathEntity('
        'id: $id, '
        'fromTaxiNode: $fromTaxiNode, '
        'toTaxiNode: $toTaxiNode, '
        'cost: $cost'
        ')';
  }
}

mixin _TaxiPathEntityMixin {
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
  String toString() {
    final self = this as TaxiPathEntity;
    return 'TaxiPathEntity('
        'id: ${self.id}, '
        'fromTaxiNode: ${self.fromTaxiNode}, '
        'toTaxiNode: ${self.toTaxiNode}, '
        'cost: ${self.cost}'
        ')';
  }

  static TaxiPathEntity fromJson(Map<String, dynamic> json) {
    return TaxiPathEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      fromTaxiNode: (json['FromTaxiNode'] as num?)?.toInt() ?? 0,
      toTaxiNode: (json['ToTaxiNode'] as num?)?.toInt() ?? 0,
      cost: (json['Cost'] as num?)?.toInt() ?? 0,
    );
  }
}
