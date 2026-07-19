import 'package:foxy/entity/holiday_key.dart';

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

  HolidayKey get key => HolidayKey(id: id);
}
