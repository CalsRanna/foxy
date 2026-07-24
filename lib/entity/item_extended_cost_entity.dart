import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'item_extended_cost_entity.g.dart';

/// 扩展价格

@FoxyBriefEntity()
@FoxyFilterEntity()
@FoxyFullEntity(table: 'foxy.dbc_item_extended_cost')
class ItemExtendedCostEntity with _ItemExtendedCostEntityMixin {
  @FoxyBriefField()
  @FoxyFilterField(defaultValue: '', type: FoxyFilterFieldType.text)
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyBriefField()
  @FoxyFullField('HonorPoints')
  final int honorPoints;

  @FoxyBriefField()
  @FoxyFullField('ArenaPoints')
  final int arenaPoints;

  @FoxyBriefField()
  @FoxyFullField('ArenaBracket')
  final int arenaBracket;

  @FoxyBriefField()
  @FoxyFullField('ItemID0')
  final int itemID0;

  @FoxyBriefField()
  @FoxyFullField('ItemID1')
  final int itemID1;

  @FoxyBriefField()
  @FoxyFullField('ItemID2')
  final int itemID2;

  @FoxyBriefField()
  @FoxyFullField('ItemID3')
  final int itemID3;

  @FoxyBriefField()
  @FoxyFullField('ItemID4')
  final int itemID4;

  @FoxyBriefField()
  @FoxyFullField('ItemCount0')
  final int itemCount0;

  @FoxyBriefField()
  @FoxyFullField('ItemCount1')
  final int itemCount1;

  @FoxyBriefField()
  @FoxyFullField('ItemCount2')
  final int itemCount2;

  @FoxyBriefField()
  @FoxyFullField('ItemCount3')
  final int itemCount3;

  @FoxyBriefField()
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

String _appendDisplayItem(String current, int itemId, int count) {
  if (itemId == 0) return current;
  final value = '${itemId}x$count';
  return current.isEmpty ? value : '$current, $value';
}

extension BriefItemExtendedCostEntityDisplay on BriefItemExtendedCostEntity {
  String get displayItems {
    var result = '';
    result = _appendDisplayItem(result, itemID0, itemCount0);
    result = _appendDisplayItem(result, itemID1, itemCount1);
    result = _appendDisplayItem(result, itemID2, itemCount2);
    result = _appendDisplayItem(result, itemID3, itemCount3);
    result = _appendDisplayItem(result, itemID4, itemCount4);
    return result.isEmpty ? '-' : result;
  }
}
