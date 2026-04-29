/// NPC商人物品 — 对应 npc_vendor 表（复合键: entry + slot）
class NpcVendorEntity {
  final int entry;
  final int slot;
  final int item;
  final int maxcount;
  final int incrtime;
  final int extendedCost;
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

  factory NpcVendorEntity.fromJson(Map<String, dynamic> json) {
    return NpcVendorEntity(
      entry: json['entry'] ?? 0,
      slot: json['slot'] ?? 0,
      item: json['item'] ?? 0,
      maxcount: json['maxcount'] ?? 0,
      incrtime: json['incrtime'] ?? 0,
      extendedCost: json['ExtendedCost'] ?? 0,
      verifiedBuild: json['VerifiedBuild'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'entry': entry,
      'slot': slot,
      'item': item,
      'maxcount': maxcount,
      'incrtime': incrtime,
      'ExtendedCost': extendedCost,
      'VerifiedBuild': verifiedBuild,
    };
  }
}

/// NPC商人物品列表展示模型（含 LEFT JOIN item_template + item_display_info 的物品信息）
class BriefNpcVendorEntity {
  final int entry;
  final int slot;
  final int item;
  final int maxcount;
  final int incrtime;
  final int extendedCost;
  final int verifiedBuild;
  final String itemName;
  final String itemLocaleName;
  final int itemQuality;
  final String itemIcon;

  String get displayName =>
      itemLocaleName.isNotEmpty ? itemLocaleName : itemName;

  const BriefNpcVendorEntity({
    this.entry = 0,
    this.slot = 0,
    this.item = 0,
    this.maxcount = 0,
    this.incrtime = 0,
    this.extendedCost = 0,
    this.verifiedBuild = 0,
    this.itemName = '',
    this.itemLocaleName = '',
    this.itemQuality = 0,
    this.itemIcon = '',
  });

  factory BriefNpcVendorEntity.fromJson(Map<String, dynamic> json) {
    return BriefNpcVendorEntity(
      entry: json['entry'] ?? 0,
      slot: json['slot'] ?? 0,
      item: json['item'] ?? 0,
      maxcount: json['maxcount'] ?? 0,
      incrtime: json['incrtime'] ?? 0,
      extendedCost: json['ExtendedCost'] ?? 0,
      verifiedBuild: json['VerifiedBuild'] ?? 0,
      itemName: json['name'] ?? '',
      itemLocaleName: json['localeName'] ?? '',
      itemQuality: json['Quality'] ?? 0,
      itemIcon: json['InventoryIcon0'] ?? '',
    );
  }
}
