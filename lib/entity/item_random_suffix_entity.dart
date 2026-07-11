class ItemRandomSuffixEntity {
  final int id;
  final String nameLangEnUS;
  final String nameLangKoKR;
  final String nameLangFrFR;
  final String nameLangDeDE;
  final String nameLangZhCN;
  final String nameLangZhTW;
  final String nameLangEsES;
  final String nameLangEsMX;
  final String nameLangRuRU;
  final String nameLangJaJP;
  final String nameLangPtPT;
  final String nameLangPtBR;
  final String nameLangItIT;
  final String nameLangUnk1;
  final String nameLangUnk2;
  final String nameLangUnk3;
  final int nameLangFlags;
  final String internalName;
  final int enchantment0;
  final int enchantment1;
  final int enchantment2;
  final int enchantment3;
  final int enchantment4;
  final int allocationPct0;
  final int allocationPct1;
  final int allocationPct2;
  final int allocationPct3;
  final int allocationPct4;

  const ItemRandomSuffixEntity({
    this.id = 0,
    this.nameLangEnUS = '',
    this.nameLangKoKR = '',
    this.nameLangFrFR = '',
    this.nameLangDeDE = '',
    this.nameLangZhCN = '',
    this.nameLangZhTW = '',
    this.nameLangEsES = '',
    this.nameLangEsMX = '',
    this.nameLangRuRU = '',
    this.nameLangJaJP = '',
    this.nameLangPtPT = '',
    this.nameLangPtBR = '',
    this.nameLangItIT = '',
    this.nameLangUnk1 = '',
    this.nameLangUnk2 = '',
    this.nameLangUnk3 = '',
    this.nameLangFlags = 0,
    this.internalName = '',
    this.enchantment0 = 0,
    this.enchantment1 = 0,
    this.enchantment2 = 0,
    this.enchantment3 = 0,
    this.enchantment4 = 0,
    this.allocationPct0 = 0,
    this.allocationPct1 = 0,
    this.allocationPct2 = 0,
    this.allocationPct3 = 0,
    this.allocationPct4 = 0,
  });

  factory ItemRandomSuffixEntity.fromJson(Map<String, dynamic> json) {
    return ItemRandomSuffixEntity(
      id: json['ID'] ?? 0,
      nameLangEnUS: json['Name_lang_enUS'] ?? '',
      nameLangKoKR: json['Name_lang_koKR'] ?? '',
      nameLangFrFR: json['Name_lang_frFR'] ?? '',
      nameLangDeDE: json['Name_lang_deDE'] ?? '',
      nameLangZhCN: json['Name_lang_zhCN'] ?? '',
      nameLangZhTW: json['Name_lang_zhTW'] ?? '',
      nameLangEsES: json['Name_lang_esES'] ?? '',
      nameLangEsMX: json['Name_lang_esMX'] ?? '',
      nameLangRuRU: json['Name_lang_ruRU'] ?? '',
      nameLangJaJP: json['Name_lang_jaJP'] ?? '',
      nameLangPtPT: json['Name_lang_ptPT'] ?? '',
      nameLangPtBR: json['Name_lang_ptBR'] ?? '',
      nameLangItIT: json['Name_lang_itIT'] ?? '',
      nameLangUnk1: json['Name_lang_unk1'] ?? '',
      nameLangUnk2: json['Name_lang_unk2'] ?? '',
      nameLangUnk3: json['Name_lang_unk3'] ?? '',
      nameLangFlags: json['Name_lang_Flags'] ?? 0,
      internalName: json['InternalName'] ?? '',
      enchantment0: json['Enchantment0'] ?? 0,
      enchantment1: json['Enchantment1'] ?? 0,
      enchantment2: json['Enchantment2'] ?? 0,
      enchantment3: json['Enchantment3'] ?? 0,
      enchantment4: json['Enchantment4'] ?? 0,
      allocationPct0: json['AllocationPct0'] ?? 0,
      allocationPct1: json['AllocationPct1'] ?? 0,
      allocationPct2: json['AllocationPct2'] ?? 0,
      allocationPct3: json['AllocationPct3'] ?? 0,
      allocationPct4: json['AllocationPct4'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Name_lang_enUS': nameLangEnUS,
      'Name_lang_koKR': nameLangKoKR,
      'Name_lang_frFR': nameLangFrFR,
      'Name_lang_deDE': nameLangDeDE,
      'Name_lang_zhCN': nameLangZhCN,
      'Name_lang_zhTW': nameLangZhTW,
      'Name_lang_esES': nameLangEsES,
      'Name_lang_esMX': nameLangEsMX,
      'Name_lang_ruRU': nameLangRuRU,
      'Name_lang_jaJP': nameLangJaJP,
      'Name_lang_ptPT': nameLangPtPT,
      'Name_lang_ptBR': nameLangPtBR,
      'Name_lang_itIT': nameLangItIT,
      'Name_lang_unk1': nameLangUnk1,
      'Name_lang_unk2': nameLangUnk2,
      'Name_lang_unk3': nameLangUnk3,
      'Name_lang_Flags': nameLangFlags,
      'InternalName': internalName,
      'Enchantment0': enchantment0,
      'Enchantment1': enchantment1,
      'Enchantment2': enchantment2,
      'Enchantment3': enchantment3,
      'Enchantment4': enchantment4,
      'AllocationPct0': allocationPct0,
      'AllocationPct1': allocationPct1,
      'AllocationPct2': allocationPct2,
      'AllocationPct3': allocationPct3,
      'AllocationPct4': allocationPct4,
    };
  }

  ItemRandomSuffixEntity copyWith({
    int? id,
    String? nameLangEnUS,
    String? nameLangKoKR,
    String? nameLangFrFR,
    String? nameLangDeDE,
    String? nameLangZhCN,
    String? nameLangZhTW,
    String? nameLangEsES,
    String? nameLangEsMX,
    String? nameLangRuRU,
    String? nameLangJaJP,
    String? nameLangPtPT,
    String? nameLangPtBR,
    String? nameLangItIT,
    String? nameLangUnk1,
    String? nameLangUnk2,
    String? nameLangUnk3,
    int? nameLangFlags,
    String? internalName,
    int? enchantment0,
    int? enchantment1,
    int? enchantment2,
    int? enchantment3,
    int? enchantment4,
    int? allocationPct0,
    int? allocationPct1,
    int? allocationPct2,
    int? allocationPct3,
    int? allocationPct4,
  }) {
    return ItemRandomSuffixEntity(
      id: id ?? this.id,
      nameLangEnUS: nameLangEnUS ?? this.nameLangEnUS,
      nameLangKoKR: nameLangKoKR ?? this.nameLangKoKR,
      nameLangFrFR: nameLangFrFR ?? this.nameLangFrFR,
      nameLangDeDE: nameLangDeDE ?? this.nameLangDeDE,
      nameLangZhCN: nameLangZhCN ?? this.nameLangZhCN,
      nameLangZhTW: nameLangZhTW ?? this.nameLangZhTW,
      nameLangEsES: nameLangEsES ?? this.nameLangEsES,
      nameLangEsMX: nameLangEsMX ?? this.nameLangEsMX,
      nameLangRuRU: nameLangRuRU ?? this.nameLangRuRU,
      nameLangJaJP: nameLangJaJP ?? this.nameLangJaJP,
      nameLangPtPT: nameLangPtPT ?? this.nameLangPtPT,
      nameLangPtBR: nameLangPtBR ?? this.nameLangPtBR,
      nameLangItIT: nameLangItIT ?? this.nameLangItIT,
      nameLangUnk1: nameLangUnk1 ?? this.nameLangUnk1,
      nameLangUnk2: nameLangUnk2 ?? this.nameLangUnk2,
      nameLangUnk3: nameLangUnk3 ?? this.nameLangUnk3,
      nameLangFlags: nameLangFlags ?? this.nameLangFlags,
      internalName: internalName ?? this.internalName,
      enchantment0: enchantment0 ?? this.enchantment0,
      enchantment1: enchantment1 ?? this.enchantment1,
      enchantment2: enchantment2 ?? this.enchantment2,
      enchantment3: enchantment3 ?? this.enchantment3,
      enchantment4: enchantment4 ?? this.enchantment4,
      allocationPct0: allocationPct0 ?? this.allocationPct0,
      allocationPct1: allocationPct1 ?? this.allocationPct1,
      allocationPct2: allocationPct2 ?? this.allocationPct2,
      allocationPct3: allocationPct3 ?? this.allocationPct3,
      allocationPct4: allocationPct4 ?? this.allocationPct4,
    );
  }
}


/// 随机后缀列表/Picker 展示模型
class BriefItemRandomSuffixEntity {
  final int id;
  final String nameLangZhCN;
  final String internalName;

  const BriefItemRandomSuffixEntity({
    this.id = 0,
    this.nameLangZhCN = '',
    this.internalName = '',
  });

  factory BriefItemRandomSuffixEntity.fromJson(Map<String, dynamic> json) {
    return BriefItemRandomSuffixEntity(
      id: json['ID'] ?? 0,
      nameLangZhCN: json['Name_lang_zhCN'] ?? '',
      internalName: json['InternalName'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Name_lang_zhCN': nameLangZhCN,
      'InternalName': internalName,
    };
  }

  BriefItemRandomSuffixEntity copyWith({
    int? id,
    String? nameLangZhCN,
    String? internalName,
  }) {
    return BriefItemRandomSuffixEntity(
      id: id ?? this.id,
      nameLangZhCN: nameLangZhCN ?? this.nameLangZhCN,
      internalName: internalName ?? this.internalName,
    );
  }
}
