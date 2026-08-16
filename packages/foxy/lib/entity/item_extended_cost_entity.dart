import 'package:foxy_annotation/entity_annotations.dart';

part 'item_extended_cost_entity.g.dart';

/// Extended cost

@FoxyBriefEntity()
@FoxyBriefField.text('itemName0')
@FoxyBriefField.text('itemLocaleName0')
@FoxyBriefField.text('itemIcon0')
@FoxyBriefField.integer('itemQuality0')
@FoxyBriefField.text('itemName1')
@FoxyBriefField.text('itemLocaleName1')
@FoxyBriefField.text('itemIcon1')
@FoxyBriefField.integer('itemQuality1')
@FoxyFullEntity(table: 'foxy.dbc_item_extended_cost')
class ItemExtendedCostEntity with _ItemExtendedCostEntityMixin {

  @FoxyBriefField()
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

extension BriefItemExtendedCostEntityDisplay on BriefItemExtendedCostEntity {
  /// Display name for the item at [index] (0 or 1): zhCN when available,
  /// enUS otherwise; falls back to `#ID` when the item is not resolvable,
  /// and `-` when there is no item.
  String displayItemName(int index) {
    final itemId = index == 0 ? itemID0 : itemID1;
    if (itemId == 0) return '-';
    final locale = index == 0 ? itemLocaleName0 : itemLocaleName1;
    final name = index == 0 ? itemName0 : itemName1;
    final resolved = locale.isNotEmpty ? locale : name;
    return resolved.isNotEmpty ? resolved : '#$itemId';
  }

  /// Count for the item at [index] (0 or 1); `-` when there is no item.
  String displayItemCount(int index) {
    final itemId = index == 0 ? itemID0 : itemID1;
    if (itemId == 0) return '-';
    return (index == 0 ? itemCount0 : itemCount1).toString();
  }

  /// Icon path for the item at [index] (0 or 1).
  String displayItemIcon(int index) =>
      index == 0 ? itemIcon0 : itemIcon1;

  /// Quality for the item at [index] (0 or 1).
  int displayItemQuality(int index) =>
      index == 0 ? itemQuality0 : itemQuality1;
}
