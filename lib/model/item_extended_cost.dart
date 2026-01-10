/// 扩展价格
class ItemExtendedCost {
  int id = 0;
  int honorPoints = 0;
  int arenaPoints = 0;
  int arenaBracket = 0;

  ItemExtendedCost();

  ItemExtendedCost.fromJson(Map<String, dynamic> json) {
    id = json['ID'] ?? json['id'] ?? 0;
    honorPoints = json['HonorPoints'] ?? json['honorPoints'] ?? 0;
    arenaPoints = json['ArenaPoints'] ?? json['arenaPoints'] ?? 0;
    arenaBracket = json['ArenaBracket'] ?? json['arenaBracket'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'HonorPoints': honorPoints,
      'ArenaPoints': arenaPoints,
      'ArenaBracket': arenaBracket,
    };
  }
}
