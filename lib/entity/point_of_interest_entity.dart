class PointOfInterestEntity {
  final int id;
  final double positionX;
  final double positionY;
  final int icon;
  final int flags;
  final int importance;
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

  factory PointOfInterestEntity.fromJson(Map<String, dynamic> json) {
    return PointOfInterestEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      positionX: (json['PositionX'] as num?)?.toDouble() ?? 0,
      positionY: (json['PositionY'] as num?)?.toDouble() ?? 0,
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
    return PointOfInterestEntity(
      id: id ?? this.id,
      positionX: positionX ?? this.positionX,
      positionY: positionY ?? this.positionY,
      icon: icon ?? this.icon,
      flags: flags ?? this.flags,
      importance: importance ?? this.importance,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toJson() => {
    'ID': id,
    'PositionX': positionX,
    'PositionY': positionY,
    'Icon': icon,
    'Flags': flags,
    'Importance': importance,
    'Name': name,
  };
}
