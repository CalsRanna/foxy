import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'npc_vendor_entity.g.dart';

/// NPC商人物品 — 对应 npc_vendor 表（复合键: entry + item + ExtendedCost）

@FoxyBriefEntity()
@FoxyBriefField.text('itemName')
@FoxyBriefField.text('itemLocaleName')
@FoxyBriefField.integer('itemQuality')
@FoxyFullEntity(table: 'npc_vendor')
class NpcVendorEntity with _NpcVendorEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('entry', key: true)
  final int entry;

  @FoxyBriefField()
  @FoxyFullField('slot')
  final int slot;

  @FoxyBriefField()
  @FoxyFullField('item', key: true)
  final int item;

  @FoxyBriefField()
  @FoxyFullField('maxcount')
  final int maxcount;

  @FoxyBriefField()
  @FoxyFullField('incrtime')
  final int incrtime;

  @FoxyBriefField()
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
