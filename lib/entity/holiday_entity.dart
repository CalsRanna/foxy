class BriefHolidayEntity {
  final int id;
  final int holidayNameId;
  final String textureFileName;

  const BriefHolidayEntity({
    this.id = 0,
    this.holidayNameId = 0,
    this.textureFileName = '',
  });

  factory BriefHolidayEntity.fromJson(Map<String, dynamic> json) =>
      BriefHolidayEntity(
        id: json['ID'] ?? 0,
        holidayNameId: json['HolidayNameID'] ?? 0,
        textureFileName: json['TextureFileName'] ?? '',
      );
}

class HolidayEntity {
  final Map<String, dynamic> values;

  HolidayEntity.fromJson(Map<String, dynamic> json)
    : values = Map.unmodifiable(Map<String, dynamic>.from(json));

  int get holidayNameId => values['HolidayNameID'] ?? 0;
  int get id => values['ID'] ?? 0;
  String get textureFileName => values['TextureFileName'] ?? '';

  Map<String, dynamic> toJson() => Map<String, dynamic>.from(values);
}
