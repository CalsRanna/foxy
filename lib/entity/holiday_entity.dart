class HolidayEntity {
  final Map<String, dynamic> values;

  HolidayEntity.fromJson(Map<String, dynamic> json)
    : values = Map.unmodifiable(Map<String, dynamic>.from(json));

  int get holidayNameId => values['HolidayNameID'] ?? 0;
  int get id => values['ID'] ?? 0;
  String get textureFileName => values['TextureFileName'] ?? '';

  Map<String, dynamic> toJson() => Map<String, dynamic>.from(values);
}
