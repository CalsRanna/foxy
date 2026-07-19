class ItemVisualsEntity {
  final int id;
  final int slot0;
  final int slot1;
  final int slot2;
  final int slot3;
  final int slot4;

  const ItemVisualsEntity({
    this.id = 0,
    this.slot0 = 0,
    this.slot1 = 0,
    this.slot2 = 0,
    this.slot3 = 0,
    this.slot4 = 0,
  });

  factory ItemVisualsEntity.fromJson(Map<String, dynamic> json) {
    return ItemVisualsEntity(
      id: json['ID'] ?? 0,
      slot0: json['Slot0'] ?? 0,
      slot1: json['Slot1'] ?? 0,
      slot2: json['Slot2'] ?? 0,
      slot3: json['Slot3'] ?? 0,
      slot4: json['Slot4'] ?? 0,
    );
  }

  ItemVisualsEntity copyWith({
    int? id,
    int? slot0,
    int? slot1,
    int? slot2,
    int? slot3,
    int? slot4,
  }) {
    return ItemVisualsEntity(
      id: id ?? this.id,
      slot0: slot0 ?? this.slot0,
      slot1: slot1 ?? this.slot1,
      slot2: slot2 ?? this.slot2,
      slot3: slot3 ?? this.slot3,
      slot4: slot4 ?? this.slot4,
    );
  }

  Map<String, dynamic> toJson() => {
    'ID': id,
    'Slot0': slot0,
    'Slot1': slot1,
    'Slot2': slot2,
    'Slot3': slot3,
    'Slot4': slot4,
  };
}
