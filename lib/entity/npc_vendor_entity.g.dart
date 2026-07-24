// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'npc_vendor_entity.dart';

mixin _NpcVendorEntityMixin {
  int get entry;
  int get slot;
  int get item;
  int get maxcount;
  int get incrtime;
  int get extendedCost;
  int get verifiedBuild;

  static NpcVendorEntity fromJson(Map<String, dynamic> json) {
    return NpcVendorEntity(
      entry: (json['entry'] as num?)?.toInt() ?? 0,
      slot: (json['slot'] as num?)?.toInt() ?? 0,
      item: (json['item'] as num?)?.toInt() ?? 0,
      maxcount: (json['maxcount'] as num?)?.toInt() ?? 0,
      incrtime: (json['incrtime'] as num?)?.toInt() ?? 0,
      extendedCost: (json['ExtendedCost'] as num?)?.toInt() ?? 0,
      verifiedBuild: (json['VerifiedBuild'] as num?)?.toInt() ?? 0,
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

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is NpcVendorEntity &&
            runtimeType == other.runtimeType &&
            entry == other.entry &&
            slot == other.slot &&
            item == other.item &&
            maxcount == other.maxcount &&
            incrtime == other.incrtime &&
            extendedCost == other.extendedCost &&
            verifiedBuild == other.verifiedBuild;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      runtimeType,
      entry,
      slot,
      item,
      maxcount,
      incrtime,
      extendedCost,
      verifiedBuild,
    ]);
  }

  @override
  String toString() {
    return 'NpcVendorEntity('
        'entry: $entry, '
        'slot: $slot, '
        'item: $item, '
        'maxcount: $maxcount, '
        'incrtime: $incrtime, '
        'extendedCost: $extendedCost, '
        'verifiedBuild: $verifiedBuild'
        ')';
  }
}
