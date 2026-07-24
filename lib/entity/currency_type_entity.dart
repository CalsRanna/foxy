import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'currency_type_entity.g.dart';

@FoxyBriefEntity()
@FoxyBriefField.text('itemName')
@FoxyBriefField.text('localeItemName')
@FoxyFullEntity(table: 'foxy.dbc_currency_types')
class CurrencyTypeEntity with _CurrencyTypeEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyBriefField()
  @FoxyFullField('ItemID')
  final int itemId;

  @FoxyBriefField()
  @FoxyFullField('CategoryID')
  final int categoryId;

  @FoxyBriefField()
  @FoxyFullField('BitIndex')
  final int bitIndex;

  const CurrencyTypeEntity({
    this.id = 0,
    this.itemId = 0,
    this.categoryId = 0,
    this.bitIndex = 0,
  });

  factory CurrencyTypeEntity.fromJson(Map<String, dynamic> json) =>
      _CurrencyTypeEntityMixin.fromJson(json);
}

extension BriefCurrencyTypeEntityDisplay on BriefCurrencyTypeEntity {
  String get displayItemName =>
      localeItemName.isNotEmpty ? localeItemName : itemName;
}
