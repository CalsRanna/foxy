// ignore_for_file: annotate_overrides

import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'currency_type_entity.g.dart';

@FoxyFullEntity(table: 'foxy.dbc_currency_types')
class CurrencyTypeEntity with _CurrencyTypeEntityMixin {
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyFullField('ItemID')
  final int itemId;

  @FoxyFullField('CategoryID')
  final int categoryId;

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
