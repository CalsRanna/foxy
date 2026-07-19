import 'package:foxy/entity/npc_vendor_key.dart';

/// NPC 商人物品列表展示模型。
///
/// 只携带列表展示列、完整三列行定位器，以及 JOIN 得到的物品展示信息。
class BriefNpcVendorEntity {
  final int entry;
  final int slot;
  final int item;
  final int maxcount;
  final int incrtime;
  final int extendedCost;
  final String itemName;
  final String itemLocaleName;
  final int itemQuality;

  const BriefNpcVendorEntity({
    this.entry = 0,
    this.slot = 0,
    this.item = 0,
    this.maxcount = 0,
    this.incrtime = 0,
    this.extendedCost = 0,
    this.itemName = '',
    this.itemLocaleName = '',
    this.itemQuality = 0,
  });

  factory BriefNpcVendorEntity.fromJson(Map<String, dynamic> json) {
    return BriefNpcVendorEntity(
      entry: json['entry'] ?? 0,
      slot: json['slot'] ?? 0,
      item: json['item'] ?? 0,
      maxcount: json['maxcount'] ?? 0,
      incrtime: json['incrtime'] ?? 0,
      extendedCost: json['ExtendedCost'] ?? 0,
      itemName: json['name'] ?? '',
      itemLocaleName: json['localeName'] ?? '',
      itemQuality: json['Quality'] ?? 0,
    );
  }

  String get displayName =>
      itemLocaleName.isNotEmpty ? itemLocaleName : itemName;

  NpcVendorKey get key =>
      NpcVendorKey(entry: entry, item: item, extendedCost: extendedCost);
}
