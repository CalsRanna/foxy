// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
final class BriefItemVisualsEntity {
  final int id;
  final int slot0;
  final int slot1;
  final int slot2;
  final int slot3;
  final int slot4;

  const BriefItemVisualsEntity({
    this.id = 0,
    this.slot0 = 0,
    this.slot1 = 0,
    this.slot2 = 0,
    this.slot3 = 0,
    this.slot4 = 0,
  });

  factory BriefItemVisualsEntity.fromJson(Map<String, dynamic> json) {
    return BriefItemVisualsEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      slot0: (json['Slot0'] as num?)?.toInt() ?? 0,
      slot1: (json['Slot1'] as num?)?.toInt() ?? 0,
      slot2: (json['Slot2'] as num?)?.toInt() ?? 0,
      slot3: (json['Slot3'] as num?)?.toInt() ?? 0,
      slot4: (json['Slot4'] as num?)?.toInt() ?? 0,
    );
  }

  int get key => id;
}
