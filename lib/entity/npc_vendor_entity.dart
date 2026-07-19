/// NPC商人物品 — 对应 npc_vendor 表（复合键: entry + item + ExtendedCost）
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

  NpcVendorEntity copyWith({
    int? entry,
    int? slot,
    int? item,
    int? maxcount,
    int? incrtime,
    int? extendedCost,
    int? verifiedBuild,
  }) {
    return NpcVendorEntity(
      entry: entry ?? this.entry,
      slot: slot ?? this.slot,
      item: item ?? this.item,
      maxcount: maxcount ?? this.maxcount,
      incrtime: incrtime ?? this.incrtime,
      extendedCost: extendedCost ?? this.extendedCost,
      verifiedBuild: verifiedBuild ?? this.verifiedBuild,
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
