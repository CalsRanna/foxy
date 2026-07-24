// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'point_of_interest_entity.dart';

mixin _PointOfInterestEntityMixin {
  static PointOfInterestEntity fromJson(Map<String, dynamic> json) {
    return PointOfInterestEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      positionX: (json['PositionX'] as num?)?.toDouble() ?? 0.0,
      positionY: (json['PositionY'] as num?)?.toDouble() ?? 0.0,
      icon: (json['Icon'] as num?)?.toInt() ?? 0,
      flags: (json['Flags'] as num?)?.toInt() ?? 0,
      importance: (json['Importance'] as num?)?.toInt() ?? 0,
      name: json['Name']?.toString() ?? '',
    );
  }

  PointOfInterestEntity copyWith({
    int? id,
    double? positionX,
    double? positionY,
    int? icon,
    int? flags,
    int? importance,
    String? name,
  }) {
    final self = this as PointOfInterestEntity;
    return PointOfInterestEntity(
      id: id ?? self.id,
      positionX: positionX ?? self.positionX,
      positionY: positionY ?? self.positionY,
      icon: icon ?? self.icon,
      flags: flags ?? self.flags,
      importance: importance ?? self.importance,
      name: name ?? self.name,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as PointOfInterestEntity;
    return {
      'ID': self.id,
      'PositionX': self.positionX,
      'PositionY': self.positionY,
      'Icon': self.icon,
      'Flags': self.flags,
      'Importance': self.importance,
      'Name': self.name,
    };
  }

  @override
  bool operator ==(Object other) {
    final self = this as PointOfInterestEntity;
    return identical(self, other) ||
        other is PointOfInterestEntity &&
            self.runtimeType == other.runtimeType &&
            self.id == other.id &&
            self.positionX == other.positionX &&
            self.positionY == other.positionY &&
            self.icon == other.icon &&
            self.flags == other.flags &&
            self.importance == other.importance &&
            self.name == other.name;
  }

  @override
  int get hashCode {
    final self = this as PointOfInterestEntity;
    return Object.hashAll([
      self.runtimeType,
      self.id,
      self.positionX,
      self.positionY,
      self.icon,
      self.flags,
      self.importance,
      self.name,
    ]);
  }

  @override
  String toString() {
    final self = this as PointOfInterestEntity;
    return 'PointOfInterestEntity('
        'id: ${self.id}, '
        'positionX: ${self.positionX}, '
        'positionY: ${self.positionY}, '
        'icon: ${self.icon}, '
        'flags: ${self.flags}, '
        'importance: ${self.importance}, '
        'name: ${self.name}'
        ')';
  }
}

final class BriefPointOfInterestEntity {
  final int id;
  final String name;
  final String localeName;

  const BriefPointOfInterestEntity({
    this.id = 0,
    this.name = '',
    this.localeName = '',
  });

  factory BriefPointOfInterestEntity.fromJson(Map<String, dynamic> json) {
    return BriefPointOfInterestEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      name: json['Name']?.toString() ?? '',
      localeName: json['localeName']?.toString() ?? '',
    );
  }

  int get key => id;
}
