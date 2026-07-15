import 'package:foxy/constant/gem_property_constants.dart';

class GemPropertyEntity {
  final int id;
  final int enchantId;
  final int maxCountInv;
  final int maxCountItem;
  final int type;

  const GemPropertyEntity({
    this.id = 0,
    this.enchantId = 0,
    this.maxCountInv = 0,
    this.maxCountItem = 0,
    this.type = 0,
  });

  factory GemPropertyEntity.fromJson(Map<String, dynamic> json) {
    return GemPropertyEntity(
      id: json['ID'] ?? 0,
      enchantId: json['Enchant_ID'] ?? 0,
      maxCountInv: json['Maxcount_inv'] ?? 0,
      maxCountItem: json['Maxcount_item'] ?? 0,
      type: json['Type'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Enchant_ID': enchantId,
      'Maxcount_inv': maxCountInv,
      'Maxcount_item': maxCountItem,
      'Type': type,
    };
  }

  void validate() {
    _requireRange(id, 1, 0x7fffffff, 'ID');
    _requireRange(enchantId, 0, 0x7fffffff, 'Enchant_ID');
    _requireRange(maxCountInv, 0, 0x7fffffff, 'Maxcount_inv');
    _requireRange(maxCountItem, 0, 0x7fffffff, 'Maxcount_item');
    if (!kGemPropertyColorOptions.containsKey(type)) {
      throw ArgumentError('Type 必须是有效的 GemProperties SocketColor 组合');
    }
  }

  static void _requireRange(int value, int minimum, int maximum, String name) {
    if (value < minimum || value > maximum) {
      throw ArgumentError('$name 必须在 $minimum..$maximum 范围内');
    }
  }

  GemPropertyEntity copyWith({
    int? id,
    int? enchantId,
    int? maxCountInv,
    int? maxCountItem,
    int? type,
  }) {
    return GemPropertyEntity(
      id: id ?? this.id,
      enchantId: enchantId ?? this.enchantId,
      maxCountInv: maxCountInv ?? this.maxCountInv,
      maxCountItem: maxCountItem ?? this.maxCountItem,
      type: type ?? this.type,
    );
  }
}

class BriefGemPropertyEntity {
  final int id;
  final int enchantId;
  final int maxCountInv;
  final int maxCountItem;
  final int type;

  const BriefGemPropertyEntity({
    this.id = 0,
    this.enchantId = 0,
    this.maxCountInv = 0,
    this.maxCountItem = 0,
    this.type = 0,
  });

  factory BriefGemPropertyEntity.fromJson(Map<String, dynamic> json) {
    return BriefGemPropertyEntity(
      id: json['ID'] ?? 0,
      enchantId: json['Enchant_ID'] ?? 0,
      maxCountInv: json['Maxcount_inv'] ?? 0,
      maxCountItem: json['Maxcount_item'] ?? 0,
      type: json['Type'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Enchant_ID': enchantId,
      'Maxcount_inv': maxCountInv,
      'Maxcount_item': maxCountItem,
      'Type': type,
    };
  }

  BriefGemPropertyEntity copyWith({
    int? id,
    int? enchantId,
    int? maxCountInv,
    int? maxCountItem,
    int? type,
  }) {
    return BriefGemPropertyEntity(
      id: id ?? this.id,
      enchantId: enchantId ?? this.enchantId,
      maxCountInv: maxCountInv ?? this.maxCountInv,
      maxCountItem: maxCountItem ?? this.maxCountItem,
      type: type ?? this.type,
    );
  }
}
