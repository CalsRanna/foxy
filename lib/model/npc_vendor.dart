/// NPC商人物品
class NpcVendor {
  final int entry;
  final int slot;
  final int item;
  final int maxcount;
  final int incrtime;
  final int extendedCost;
  final int verifiedBuild;

  // 关联字段（物品信息）
  final String itemName;
  final String itemLocaleName;
  final int itemQuality;
  final String itemIcon;

  /// 显示名称（优先显示本地化名称）
  String get displayName =>
      itemLocaleName.isNotEmpty ? itemLocaleName : itemName;

  const NpcVendor({
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

  factory NpcVendor.fromJson(Map<String, dynamic> json) {
    return NpcVendor(
      entry: json['entry'] ?? 0,
      slot: json['slot'] ?? 0,
      item: json['item'] ?? 0,
      maxcount: json['maxcount'] ?? 0,
      incrtime: json['incrtime'] ?? 0,
      extendedCost: json['ExtendedCost'] ?? json['extendedCost'] ?? 0,
      verifiedBuild: json['VerifiedBuild'] ?? json['verifiedBuild'] ?? 0,
      itemName: json['name'] ?? '',
      itemLocaleName: json['localeName'] ?? '',
      itemQuality: json['Quality'] ?? 0,
      itemIcon: json['InventoryIcon0'] ?? '',
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
