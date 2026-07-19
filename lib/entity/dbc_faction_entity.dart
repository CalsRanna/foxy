/// DBC 阵营 — 对应 foxy.dbc_faction 表
class DbcFactionEntity {
  final int id;
  final int reputationIndex;
  final int reputationRaceMask0;
  final int reputationRaceMask1;
  final int reputationRaceMask2;
  final int reputationRaceMask3;
  final int reputationClassMask0;
  final int reputationClassMask1;
  final int reputationClassMask2;
  final int reputationClassMask3;
  final int reputationBase0;
  final int reputationBase1;
  final int reputationBase2;
  final int reputationBase3;
  final int reputationFlags0;
  final int reputationFlags1;
  final int reputationFlags2;
  final int reputationFlags3;
  final int parentFactionId;
  final double parentFactionMod0;
  final double parentFactionMod1;
  final int parentFactionCap0;
  final int parentFactionCap1;
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
  final String descriptionLangEnUS;
  final String descriptionLangKoKR;
  final String descriptionLangFrFR;
  final String descriptionLangDeDE;
  final String descriptionLangZhCN;
  final String descriptionLangZhTW;
  final String descriptionLangEsES;
  final String descriptionLangEsMX;
  final String descriptionLangRuRU;
  final String descriptionLangJaJP;
  final String descriptionLangPtPT;
  final String descriptionLangPtBR;
  final String descriptionLangItIT;
  final String descriptionLangUnk1;
  final String descriptionLangUnk2;
  final String descriptionLangUnk3;
  final int descriptionLangFlags;

  const DbcFactionEntity({
    this.id = 0,
    this.reputationIndex = 0,
    this.reputationRaceMask0 = 0,
    this.reputationRaceMask1 = 0,
    this.reputationRaceMask2 = 0,
    this.reputationRaceMask3 = 0,
    this.reputationClassMask0 = 0,
    this.reputationClassMask1 = 0,
    this.reputationClassMask2 = 0,
    this.reputationClassMask3 = 0,
    this.reputationBase0 = 0,
    this.reputationBase1 = 0,
    this.reputationBase2 = 0,
    this.reputationBase3 = 0,
    this.reputationFlags0 = 0,
    this.reputationFlags1 = 0,
    this.reputationFlags2 = 0,
    this.reputationFlags3 = 0,
    this.parentFactionId = 0,
    this.parentFactionMod0 = 0.0,
    this.parentFactionMod1 = 0.0,
    this.parentFactionCap0 = 0,
    this.parentFactionCap1 = 0,
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
    this.descriptionLangEnUS = '',
    this.descriptionLangKoKR = '',
    this.descriptionLangFrFR = '',
    this.descriptionLangDeDE = '',
    this.descriptionLangZhCN = '',
    this.descriptionLangZhTW = '',
    this.descriptionLangEsES = '',
    this.descriptionLangEsMX = '',
    this.descriptionLangRuRU = '',
    this.descriptionLangJaJP = '',
    this.descriptionLangPtPT = '',
    this.descriptionLangPtBR = '',
    this.descriptionLangItIT = '',
    this.descriptionLangUnk1 = '',
    this.descriptionLangUnk2 = '',
    this.descriptionLangUnk3 = '',
    this.descriptionLangFlags = 0,
  });

  factory DbcFactionEntity.fromJson(Map<String, dynamic> json) {
    return DbcFactionEntity(
      id: json['ID'] ?? 0,
      reputationIndex: json['ReputationIndex'] ?? 0,
      reputationRaceMask0: json['ReputationRaceMask0'] ?? 0,
      reputationRaceMask1: json['ReputationRaceMask1'] ?? 0,
      reputationRaceMask2: json['ReputationRaceMask2'] ?? 0,
      reputationRaceMask3: json['ReputationRaceMask3'] ?? 0,
      reputationClassMask0: json['ReputationClassMask0'] ?? 0,
      reputationClassMask1: json['ReputationClassMask1'] ?? 0,
      reputationClassMask2: json['ReputationClassMask2'] ?? 0,
      reputationClassMask3: json['ReputationClassMask3'] ?? 0,
      reputationBase0: json['ReputationBase0'] ?? 0,
      reputationBase1: json['ReputationBase1'] ?? 0,
      reputationBase2: json['ReputationBase2'] ?? 0,
      reputationBase3: json['ReputationBase3'] ?? 0,
      reputationFlags0: json['ReputationFlags0'] ?? 0,
      reputationFlags1: json['ReputationFlags1'] ?? 0,
      reputationFlags2: json['ReputationFlags2'] ?? 0,
      reputationFlags3: json['ReputationFlags3'] ?? 0,
      parentFactionId: json['ParentFactionID'] ?? 0,
      parentFactionMod0: (json['ParentFactionMod0'] as num?)?.toDouble() ?? 0.0,
      parentFactionMod1: (json['ParentFactionMod1'] as num?)?.toDouble() ?? 0.0,
      parentFactionCap0: json['ParentFactionCap0'] ?? 0,
      parentFactionCap1: json['ParentFactionCap1'] ?? 0,
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
      descriptionLangEnUS: json['Description_lang_enUS'] ?? '',
      descriptionLangKoKR: json['Description_lang_koKR'] ?? '',
      descriptionLangFrFR: json['Description_lang_frFR'] ?? '',
      descriptionLangDeDE: json['Description_lang_deDE'] ?? '',
      descriptionLangZhCN: json['Description_lang_zhCN'] ?? '',
      descriptionLangZhTW: json['Description_lang_zhTW'] ?? '',
      descriptionLangEsES: json['Description_lang_esES'] ?? '',
      descriptionLangEsMX: json['Description_lang_esMX'] ?? '',
      descriptionLangRuRU: json['Description_lang_ruRU'] ?? '',
      descriptionLangJaJP: json['Description_lang_jaJP'] ?? '',
      descriptionLangPtPT: json['Description_lang_ptPT'] ?? '',
      descriptionLangPtBR: json['Description_lang_ptBR'] ?? '',
      descriptionLangItIT: json['Description_lang_itIT'] ?? '',
      descriptionLangUnk1: json['Description_lang_unk1'] ?? '',
      descriptionLangUnk2: json['Description_lang_unk2'] ?? '',
      descriptionLangUnk3: json['Description_lang_unk3'] ?? '',
      descriptionLangFlags: json['Description_lang_Flags'] ?? 0,
    );
  }

  DbcFactionEntity copyWith({
    int? id,
    int? reputationIndex,
    int? reputationRaceMask0,
    int? reputationRaceMask1,
    int? reputationRaceMask2,
    int? reputationRaceMask3,
    int? reputationClassMask0,
    int? reputationClassMask1,
    int? reputationClassMask2,
    int? reputationClassMask3,
    int? reputationBase0,
    int? reputationBase1,
    int? reputationBase2,
    int? reputationBase3,
    int? reputationFlags0,
    int? reputationFlags1,
    int? reputationFlags2,
    int? reputationFlags3,
    int? parentFactionId,
    double? parentFactionMod0,
    double? parentFactionMod1,
    int? parentFactionCap0,
    int? parentFactionCap1,
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
    String? descriptionLangEnUS,
    String? descriptionLangKoKR,
    String? descriptionLangFrFR,
    String? descriptionLangDeDE,
    String? descriptionLangZhCN,
    String? descriptionLangZhTW,
    String? descriptionLangEsES,
    String? descriptionLangEsMX,
    String? descriptionLangRuRU,
    String? descriptionLangJaJP,
    String? descriptionLangPtPT,
    String? descriptionLangPtBR,
    String? descriptionLangItIT,
    String? descriptionLangUnk1,
    String? descriptionLangUnk2,
    String? descriptionLangUnk3,
    int? descriptionLangFlags,
  }) {
    return DbcFactionEntity(
      id: id ?? this.id,
      reputationIndex: reputationIndex ?? this.reputationIndex,
      reputationRaceMask0: reputationRaceMask0 ?? this.reputationRaceMask0,
      reputationRaceMask1: reputationRaceMask1 ?? this.reputationRaceMask1,
      reputationRaceMask2: reputationRaceMask2 ?? this.reputationRaceMask2,
      reputationRaceMask3: reputationRaceMask3 ?? this.reputationRaceMask3,
      reputationClassMask0: reputationClassMask0 ?? this.reputationClassMask0,
      reputationClassMask1: reputationClassMask1 ?? this.reputationClassMask1,
      reputationClassMask2: reputationClassMask2 ?? this.reputationClassMask2,
      reputationClassMask3: reputationClassMask3 ?? this.reputationClassMask3,
      reputationBase0: reputationBase0 ?? this.reputationBase0,
      reputationBase1: reputationBase1 ?? this.reputationBase1,
      reputationBase2: reputationBase2 ?? this.reputationBase2,
      reputationBase3: reputationBase3 ?? this.reputationBase3,
      reputationFlags0: reputationFlags0 ?? this.reputationFlags0,
      reputationFlags1: reputationFlags1 ?? this.reputationFlags1,
      reputationFlags2: reputationFlags2 ?? this.reputationFlags2,
      reputationFlags3: reputationFlags3 ?? this.reputationFlags3,
      parentFactionId: parentFactionId ?? this.parentFactionId,
      parentFactionMod0: parentFactionMod0 ?? this.parentFactionMod0,
      parentFactionMod1: parentFactionMod1 ?? this.parentFactionMod1,
      parentFactionCap0: parentFactionCap0 ?? this.parentFactionCap0,
      parentFactionCap1: parentFactionCap1 ?? this.parentFactionCap1,
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
      descriptionLangEnUS: descriptionLangEnUS ?? this.descriptionLangEnUS,
      descriptionLangKoKR: descriptionLangKoKR ?? this.descriptionLangKoKR,
      descriptionLangFrFR: descriptionLangFrFR ?? this.descriptionLangFrFR,
      descriptionLangDeDE: descriptionLangDeDE ?? this.descriptionLangDeDE,
      descriptionLangZhCN: descriptionLangZhCN ?? this.descriptionLangZhCN,
      descriptionLangZhTW: descriptionLangZhTW ?? this.descriptionLangZhTW,
      descriptionLangEsES: descriptionLangEsES ?? this.descriptionLangEsES,
      descriptionLangEsMX: descriptionLangEsMX ?? this.descriptionLangEsMX,
      descriptionLangRuRU: descriptionLangRuRU ?? this.descriptionLangRuRU,
      descriptionLangJaJP: descriptionLangJaJP ?? this.descriptionLangJaJP,
      descriptionLangPtPT: descriptionLangPtPT ?? this.descriptionLangPtPT,
      descriptionLangPtBR: descriptionLangPtBR ?? this.descriptionLangPtBR,
      descriptionLangItIT: descriptionLangItIT ?? this.descriptionLangItIT,
      descriptionLangUnk1: descriptionLangUnk1 ?? this.descriptionLangUnk1,
      descriptionLangUnk2: descriptionLangUnk2 ?? this.descriptionLangUnk2,
      descriptionLangUnk3: descriptionLangUnk3 ?? this.descriptionLangUnk3,
      descriptionLangFlags: descriptionLangFlags ?? this.descriptionLangFlags,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'ReputationIndex': reputationIndex,
      'ReputationRaceMask0': reputationRaceMask0,
      'ReputationRaceMask1': reputationRaceMask1,
      'ReputationRaceMask2': reputationRaceMask2,
      'ReputationRaceMask3': reputationRaceMask3,
      'ReputationClassMask0': reputationClassMask0,
      'ReputationClassMask1': reputationClassMask1,
      'ReputationClassMask2': reputationClassMask2,
      'ReputationClassMask3': reputationClassMask3,
      'ReputationBase0': reputationBase0,
      'ReputationBase1': reputationBase1,
      'ReputationBase2': reputationBase2,
      'ReputationBase3': reputationBase3,
      'ReputationFlags0': reputationFlags0,
      'ReputationFlags1': reputationFlags1,
      'ReputationFlags2': reputationFlags2,
      'ReputationFlags3': reputationFlags3,
      'ParentFactionID': parentFactionId,
      'ParentFactionMod0': parentFactionMod0,
      'ParentFactionMod1': parentFactionMod1,
      'ParentFactionCap0': parentFactionCap0,
      'ParentFactionCap1': parentFactionCap1,
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
      'Description_lang_enUS': descriptionLangEnUS,
      'Description_lang_koKR': descriptionLangKoKR,
      'Description_lang_frFR': descriptionLangFrFR,
      'Description_lang_deDE': descriptionLangDeDE,
      'Description_lang_zhCN': descriptionLangZhCN,
      'Description_lang_zhTW': descriptionLangZhTW,
      'Description_lang_esES': descriptionLangEsES,
      'Description_lang_esMX': descriptionLangEsMX,
      'Description_lang_ruRU': descriptionLangRuRU,
      'Description_lang_jaJP': descriptionLangJaJP,
      'Description_lang_ptPT': descriptionLangPtPT,
      'Description_lang_ptBR': descriptionLangPtBR,
      'Description_lang_itIT': descriptionLangItIT,
      'Description_lang_unk1': descriptionLangUnk1,
      'Description_lang_unk2': descriptionLangUnk2,
      'Description_lang_unk3': descriptionLangUnk3,
      'Description_lang_Flags': descriptionLangFlags,
    };
  }
}
