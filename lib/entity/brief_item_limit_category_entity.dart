import 'package:foxy/entity/item_limit_category_key.dart';

class BriefItemLimitCategoryEntity {
  final int id;
  final String name;
  final int quantity;
  final int flags;

  const BriefItemLimitCategoryEntity({
    this.id = 0,
    this.name = '',
    this.quantity = 0,
    this.flags = 0,
  });

  factory BriefItemLimitCategoryEntity.fromJson(Map<String, dynamic> json) =>
      BriefItemLimitCategoryEntity(
        id: json['ID'] ?? 0,
        name: json['Name_lang_zhCN'] ?? '',
        quantity: json['Quantity'] ?? 0,
        flags: json['Flags'] ?? 0,
      );

  ItemLimitCategoryKey get key => ItemLimitCategoryKey(id: id);
}
