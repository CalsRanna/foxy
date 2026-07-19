import 'package:foxy/entity/item_purchase_group_key.dart';

class BriefItemPurchaseGroupEntity {
  final int id;
  final String nameLangZhCN;

  const BriefItemPurchaseGroupEntity({this.id = 0, this.nameLangZhCN = ''});

  factory BriefItemPurchaseGroupEntity.fromJson(Map<String, dynamic> json) {
    return BriefItemPurchaseGroupEntity(
      id: json['ID'] ?? 0,
      nameLangZhCN: json['Name_lang_zhCN'] ?? '',
    );
  }

  ItemPurchaseGroupKey get key => ItemPurchaseGroupKey(id: id);
}
