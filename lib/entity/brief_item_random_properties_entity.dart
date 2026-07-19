import 'package:foxy/entity/item_random_properties_key.dart';

class BriefItemRandomPropertiesEntity {
  final int id;
  final String name;
  final String nameLangZhCN;

  const BriefItemRandomPropertiesEntity({
    this.id = 0,
    this.name = '',
    this.nameLangZhCN = '',
  });

  factory BriefItemRandomPropertiesEntity.fromJson(Map<String, dynamic> json) {
    return BriefItemRandomPropertiesEntity(
      id: json['ID'] ?? 0,
      name: json['Name'] ?? '',
      nameLangZhCN: json['Name_lang_zhCN'] ?? '',
    );
  }

  ItemRandomPropertiesKey get key => ItemRandomPropertiesKey(id: id);
}
