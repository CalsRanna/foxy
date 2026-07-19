import 'package:foxy/entity/item_template_key.dart';

class BriefItemTemplateEntity {
  final int entry;
  final String name;
  final String localeName;
  final int quality;
  final int classId;
  final int subclass;
  final int inventoryType;
  final int itemLevel;
  final int requiredLevel;
  final String inventoryIcon;

  const BriefItemTemplateEntity({
    this.entry = 0,
    this.name = '',
    this.localeName = '',
    this.quality = 0,
    this.classId = 0,
    this.subclass = 0,
    this.inventoryType = 0,
    this.itemLevel = 0,
    this.requiredLevel = 0,
    this.inventoryIcon = '',
  });

  factory BriefItemTemplateEntity.fromJson(Map<String, dynamic> json) {
    return BriefItemTemplateEntity(
      entry: json['entry'] ?? 0,
      name: json['name'] ?? '',
      localeName: json['localeName'] ?? json['Name'] ?? '',
      quality: json['Quality'] ?? json['quality'] ?? 0,
      classId: json['class'] ?? json['classId'] ?? 0,
      subclass: json['subclass'] ?? 0,
      inventoryType: json['InventoryType'] ?? json['inventoryType'] ?? 0,
      itemLevel: json['ItemLevel'] ?? json['itemLevel'] ?? 0,
      requiredLevel: json['RequiredLevel'] ?? json['requiredLevel'] ?? 0,
      inventoryIcon: json['InventoryIcon0'] ?? json['inventoryIcon'] ?? '',
    );
  }

  String get displayName => localeName.isNotEmpty ? localeName : name;

  ItemTemplateKey get key => ItemTemplateKey(entry: entry);
}
