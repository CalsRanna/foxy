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

  Map<String, dynamic> toJson() => {
    'ID': id,
    'Slot0': slot0,
    'Slot1': slot1,
    'Slot2': slot2,
    'Slot3': slot3,
    'Slot4': slot4,
  };

  void validate() {
    if (id <= 0 || id > 0x7fffffff) {
      throw ArgumentError('ItemVisuals ID 必须在 1..2147483647 范围内');
    }
    _validateSlot(slot0, 'Slot0');
    _validateSlot(slot1, 'Slot1');
    _validateSlot(slot2, 'Slot2');
    _validateSlot(slot3, 'Slot3');
    _validateSlot(slot4, 'Slot4');
  }

  static void _validateSlot(int value, String name) {
    if (value < 0 || value > 0x7fffffff) {
      throw ArgumentError('$name 必须是有效的 ItemVisualEffects ID');
    }
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
}

class BriefItemVisualsEntity {
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
      id: json['ID'] ?? 0,
      slot0: json['Slot0'] ?? 0,
      slot1: json['Slot1'] ?? 0,
      slot2: json['Slot2'] ?? 0,
      slot3: json['Slot3'] ?? 0,
      slot4: json['Slot4'] ?? 0,
    );
  }
}
