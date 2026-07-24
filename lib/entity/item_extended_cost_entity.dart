import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'item_extended_cost_entity.g.dart';

/// 扩展价格

@FoxyFilterEntity()
@FoxyFullEntity(table: 'foxy.dbc_item_extended_cost')
class ItemExtendedCostEntity with _ItemExtendedCostEntityMixin {
  @FoxyFilterField(defaultValue: '', type: FoxyFilterFieldType.text)
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyFullField('HonorPoints')
  final int honorPoints;

  @FoxyFullField('ArenaPoints')
  final int arenaPoints;

  @FoxyFullField('ArenaBracket')
  final int arenaBracket;

  @FoxyFullField('ItemID0')
  final int itemID0;

  @FoxyFullField('ItemID1')
  final int itemID1;

  @FoxyFullField('ItemID2')
  final int itemID2;

  @FoxyFullField('ItemID3')
  final int itemID3;

  @FoxyFullField('ItemID4')
  final int itemID4;

  @FoxyFullField('ItemCount0')
  final int itemCount0;

  @FoxyFullField('ItemCount1')
  final int itemCount1;

  @FoxyFullField('ItemCount2')
  final int itemCount2;

  @FoxyFullField('ItemCount3')
  final int itemCount3;

  @FoxyFullField('ItemCount4')
  final int itemCount4;

  @FoxyFullField('RequiredArenaRating')
  final int requiredArenaRating;

  @FoxyFullField('ItemPurchaseGroup')
  final int itemPurchaseGroup;

  const ItemExtendedCostEntity({
    this.id = 0,
    this.honorPoints = 0,
    this.arenaPoints = 0,
    this.arenaBracket = 0,
    this.itemID0 = 0,
    this.itemID1 = 0,
    this.itemID2 = 0,
    this.itemID3 = 0,
    this.itemID4 = 0,
    this.itemCount0 = 0,
    this.itemCount1 = 0,
    this.itemCount2 = 0,
    this.itemCount3 = 0,
    this.itemCount4 = 0,
    this.requiredArenaRating = 0,
    this.itemPurchaseGroup = 0,
  });

  factory ItemExtendedCostEntity.fromJson(Map<String, dynamic> json) =>
      _ItemExtendedCostEntityMixin.fromJson(json);
}
