// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'npc_vendor_entity.dart';

mixin _NpcVendorEntityMixin {
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
    final self = this as NpcVendorEntity;
    return NpcVendorEntity(
      entry: entry ?? self.entry,
      slot: slot ?? self.slot,
      item: item ?? self.item,
      maxcount: maxcount ?? self.maxcount,
      incrtime: incrtime ?? self.incrtime,
      extendedCost: extendedCost ?? self.extendedCost,
      verifiedBuild: verifiedBuild ?? self.verifiedBuild,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as NpcVendorEntity;
    return {
      'entry': self.entry,
      'slot': self.slot,
      'item': self.item,
      'maxcount': self.maxcount,
      'incrtime': self.incrtime,
      'ExtendedCost': self.extendedCost,
      'VerifiedBuild': self.verifiedBuild,
    };
  }

  @override
  bool operator ==(Object other) {
    final self = this as NpcVendorEntity;
    return identical(self, other) ||
        other is NpcVendorEntity &&
            self.runtimeType == other.runtimeType &&
            self.entry == other.entry &&
            self.slot == other.slot &&
            self.item == other.item &&
            self.maxcount == other.maxcount &&
            self.incrtime == other.incrtime &&
            self.extendedCost == other.extendedCost &&
            self.verifiedBuild == other.verifiedBuild;
  }

  @override
  int get hashCode {
    final self = this as NpcVendorEntity;
    return Object.hashAll([
      self.runtimeType,
      self.entry,
      self.slot,
      self.item,
      self.maxcount,
      self.incrtime,
      self.extendedCost,
      self.verifiedBuild,
    ]);
  }

  @override
  String toString() {
    final self = this as NpcVendorEntity;
    return 'NpcVendorEntity('
        'entry: ${self.entry}, '
        'slot: ${self.slot}, '
        'item: ${self.item}, '
        'maxcount: ${self.maxcount}, '
        'incrtime: ${self.incrtime}, '
        'extendedCost: ${self.extendedCost}, '
        'verifiedBuild: ${self.verifiedBuild}'
        ')';
  }
}

final class NpcVendorKey {
  final int entry;
  final int item;
  final int extendedCost;

  const NpcVendorKey({
    required this.entry,
    required this.item,
    required this.extendedCost,
  });

  factory NpcVendorKey.fromEntity(NpcVendorEntity entity) {
    return NpcVendorKey(
      entry: entity.entry,
      item: entity.item,
      extendedCost: entity.extendedCost,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is NpcVendorKey &&
            entry == other.entry &&
            item == other.item &&
            extendedCost == other.extendedCost;
  }

  @override
  int get hashCode => Object.hashAll([entry, item, extendedCost]);

  @override
  String toString() {
    return 'NpcVendorKey('
        'entry: $entry, '
        'item: $item, '
        'extendedCost: $extendedCost'
        ')';
  }
}
