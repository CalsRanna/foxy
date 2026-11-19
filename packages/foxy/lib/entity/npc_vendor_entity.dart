import 'package:foxy_annotation/entity_annotations.dart';
import 'package:foxy_annotation/semantic_annotations.dart';

part 'npc_vendor_entity.g.dart';

/// NPC vendor items — maps to the npc_vendor table (composite key: entry +
/// item + ExtendedCost)

@FoxyBriefEntity()
@FoxyBriefField.text('itemName')
@FoxyBriefField.text('itemLocaleName')
@FoxyBriefField.integer('itemQuality')
@FoxyBriefField.text('itemIcon')
@FoxyFullEntity()
class NpcVendorEntity with _NpcVendorEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('entry', key: true)
  final int entry;

  @FoxyBriefField()
  @FoxyFullField('slot')
  final int slot;

  @FoxyBriefField()
  @FoxyFieldMeaning.reference('物品', table: 'item_template', column: 'entry')
  @FoxyFullField('item', key: true)
  final int item;

  @FoxyBriefField()
  @FoxyFullField('maxcount')
  final int maxcount;

  @FoxyBriefField()
  @FoxyFullField('incrtime')
  final int incrtime;

  @FoxyBriefField()
  @FoxyFieldMeaning.reference(
    '兑换费用',
    table: 'foxy.dbc_item_extended_cost',
    column: 'ID',
  )
  @FoxyFullField('ExtendedCost', key: true)
  final int extendedCost;

  @FoxyFullField('VerifiedBuild')
  final int verifiedBuild;

  const NpcVendorEntity({
    this.entry = 0,
    this.slot = 0,
    this.item = 0,
    this.maxcount = 0,
    this.incrtime = 0,
    this.extendedCost = 0,
    this.verifiedBuild = 0,
  });

  factory NpcVendorEntity.fromJson(Map<String, dynamic> json) =>
      _NpcVendorEntityMixin.fromJson(json);
}

extension BriefNpcVendorEntityDisplay on BriefNpcVendorEntity {
  String get displayName =>
      itemLocaleName.isNotEmpty ? itemLocaleName : itemName;
}
