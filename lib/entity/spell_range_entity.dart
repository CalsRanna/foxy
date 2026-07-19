class SpellRangeEntity {
  final int id;
  final double rangeMin0;
  final double rangeMin1;
  final double rangeMax0;
  final double rangeMax1;
  final int flags;
  final String displayNameLangEnUS;
  final String displayNameLangKoKR;
  final String displayNameLangFrFR;
  final String displayNameLangDeDE;
  final String displayNameLangZhCN;
  final String displayNameLangZhTW;
  final String displayNameLangEsES;
  final String displayNameLangEsMX;
  final String displayNameLangRuRU;
  final String displayNameLangJaJP;
  final String displayNameLangPtPT;
  final String displayNameLangPtBR;
  final String displayNameLangItIT;
  final String displayNameLangUnk1;
  final String displayNameLangUnk2;
  final String displayNameLangUnk3;
  final int displayNameLangFlags;
  final String displayNameShortLangEnUS;
  final String displayNameShortLangKoKR;
  final String displayNameShortLangFrFR;
  final String displayNameShortLangDeDE;
  final String displayNameShortLangZhCN;
  final String displayNameShortLangZhTW;
  final String displayNameShortLangEsES;
  final String displayNameShortLangEsMX;
  final String displayNameShortLangRuRU;
  final String displayNameShortLangJaJP;
  final String displayNameShortLangPtPT;
  final String displayNameShortLangPtBR;
  final String displayNameShortLangItIT;
  final String displayNameShortLangUnk1;
  final String displayNameShortLangUnk2;
  final String displayNameShortLangUnk3;
  final int displayNameShortLangFlags;

  const SpellRangeEntity({
    this.id = 0,
    this.rangeMin0 = 0.0,
    this.rangeMin1 = 0.0,
    this.rangeMax0 = 0.0,
    this.rangeMax1 = 0.0,
    this.flags = 0,
    this.displayNameLangEnUS = '',
    this.displayNameLangKoKR = '',
    this.displayNameLangFrFR = '',
    this.displayNameLangDeDE = '',
    this.displayNameLangZhCN = '',
    this.displayNameLangZhTW = '',
    this.displayNameLangEsES = '',
    this.displayNameLangEsMX = '',
    this.displayNameLangRuRU = '',
    this.displayNameLangJaJP = '',
    this.displayNameLangPtPT = '',
    this.displayNameLangPtBR = '',
    this.displayNameLangItIT = '',
    this.displayNameLangUnk1 = '',
    this.displayNameLangUnk2 = '',
    this.displayNameLangUnk3 = '',
    this.displayNameLangFlags = 0,
    this.displayNameShortLangEnUS = '',
    this.displayNameShortLangKoKR = '',
    this.displayNameShortLangFrFR = '',
    this.displayNameShortLangDeDE = '',
    this.displayNameShortLangZhCN = '',
    this.displayNameShortLangZhTW = '',
    this.displayNameShortLangEsES = '',
    this.displayNameShortLangEsMX = '',
    this.displayNameShortLangRuRU = '',
    this.displayNameShortLangJaJP = '',
    this.displayNameShortLangPtPT = '',
    this.displayNameShortLangPtBR = '',
    this.displayNameShortLangItIT = '',
    this.displayNameShortLangUnk1 = '',
    this.displayNameShortLangUnk2 = '',
    this.displayNameShortLangUnk3 = '',
    this.displayNameShortLangFlags = 0,
  });

  factory SpellRangeEntity.fromJson(Map<String, dynamic> json) {
    return SpellRangeEntity(
      id: json['ID'] ?? 0,
      rangeMin0: (json['RangeMin0'] as num?)?.toDouble() ?? 0.0,
      rangeMin1: (json['RangeMin1'] as num?)?.toDouble() ?? 0.0,
      rangeMax0: (json['RangeMax0'] as num?)?.toDouble() ?? 0.0,
      rangeMax1: (json['RangeMax1'] as num?)?.toDouble() ?? 0.0,
      flags: json['Flags'] ?? 0,
      displayNameLangEnUS: json['DisplayName_lang_enUS'] ?? '',
      displayNameLangKoKR: json['DisplayName_lang_koKR'] ?? '',
      displayNameLangFrFR: json['DisplayName_lang_frFR'] ?? '',
      displayNameLangDeDE: json['DisplayName_lang_deDE'] ?? '',
      displayNameLangZhCN: json['DisplayName_lang_zhCN'] ?? '',
      displayNameLangZhTW: json['DisplayName_lang_zhTW'] ?? '',
      displayNameLangEsES: json['DisplayName_lang_esES'] ?? '',
      displayNameLangEsMX: json['DisplayName_lang_esMX'] ?? '',
      displayNameLangRuRU: json['DisplayName_lang_ruRU'] ?? '',
      displayNameLangJaJP: json['DisplayName_lang_jaJP'] ?? '',
      displayNameLangPtPT: json['DisplayName_lang_ptPT'] ?? '',
      displayNameLangPtBR: json['DisplayName_lang_ptBR'] ?? '',
      displayNameLangItIT: json['DisplayName_lang_itIT'] ?? '',
      displayNameLangUnk1: json['DisplayName_lang_unk1'] ?? '',
      displayNameLangUnk2: json['DisplayName_lang_unk2'] ?? '',
      displayNameLangUnk3: json['DisplayName_lang_unk3'] ?? '',
      displayNameLangFlags: json['DisplayName_lang_Flags'] ?? 0,
      displayNameShortLangEnUS: json['DisplayNameShort_lang_enUS'] ?? '',
      displayNameShortLangKoKR: json['DisplayNameShort_lang_koKR'] ?? '',
      displayNameShortLangFrFR: json['DisplayNameShort_lang_frFR'] ?? '',
      displayNameShortLangDeDE: json['DisplayNameShort_lang_deDE'] ?? '',
      displayNameShortLangZhCN: json['DisplayNameShort_lang_zhCN'] ?? '',
      displayNameShortLangZhTW: json['DisplayNameShort_lang_zhTW'] ?? '',
      displayNameShortLangEsES: json['DisplayNameShort_lang_esES'] ?? '',
      displayNameShortLangEsMX: json['DisplayNameShort_lang_esMX'] ?? '',
      displayNameShortLangRuRU: json['DisplayNameShort_lang_ruRU'] ?? '',
      displayNameShortLangJaJP: json['DisplayNameShort_lang_jaJP'] ?? '',
      displayNameShortLangPtPT: json['DisplayNameShort_lang_ptPT'] ?? '',
      displayNameShortLangPtBR: json['DisplayNameShort_lang_ptBR'] ?? '',
      displayNameShortLangItIT: json['DisplayNameShort_lang_itIT'] ?? '',
      displayNameShortLangUnk1: json['DisplayNameShort_lang_unk1'] ?? '',
      displayNameShortLangUnk2: json['DisplayNameShort_lang_unk2'] ?? '',
      displayNameShortLangUnk3: json['DisplayNameShort_lang_unk3'] ?? '',
      displayNameShortLangFlags: json['DisplayNameShort_lang_Flags'] ?? 0,
    );
  }

  SpellRangeEntity copyWith({
    int? id,
    double? rangeMin0,
    double? rangeMin1,
    double? rangeMax0,
    double? rangeMax1,
    int? flags,
    String? displayNameLangEnUS,
    String? displayNameLangKoKR,
    String? displayNameLangFrFR,
    String? displayNameLangDeDE,
    String? displayNameLangZhCN,
    String? displayNameLangZhTW,
    String? displayNameLangEsES,
    String? displayNameLangEsMX,
    String? displayNameLangRuRU,
    String? displayNameLangJaJP,
    String? displayNameLangPtPT,
    String? displayNameLangPtBR,
    String? displayNameLangItIT,
    String? displayNameLangUnk1,
    String? displayNameLangUnk2,
    String? displayNameLangUnk3,
    int? displayNameLangFlags,
    String? displayNameShortLangEnUS,
    String? displayNameShortLangKoKR,
    String? displayNameShortLangFrFR,
    String? displayNameShortLangDeDE,
    String? displayNameShortLangZhCN,
    String? displayNameShortLangZhTW,
    String? displayNameShortLangEsES,
    String? displayNameShortLangEsMX,
    String? displayNameShortLangRuRU,
    String? displayNameShortLangJaJP,
    String? displayNameShortLangPtPT,
    String? displayNameShortLangPtBR,
    String? displayNameShortLangItIT,
    String? displayNameShortLangUnk1,
    String? displayNameShortLangUnk2,
    String? displayNameShortLangUnk3,
    int? displayNameShortLangFlags,
  }) {
    return SpellRangeEntity(
      id: id ?? this.id,
      rangeMin0: rangeMin0 ?? this.rangeMin0,
      rangeMin1: rangeMin1 ?? this.rangeMin1,
      rangeMax0: rangeMax0 ?? this.rangeMax0,
      rangeMax1: rangeMax1 ?? this.rangeMax1,
      flags: flags ?? this.flags,
      displayNameLangEnUS: displayNameLangEnUS ?? this.displayNameLangEnUS,
      displayNameLangKoKR: displayNameLangKoKR ?? this.displayNameLangKoKR,
      displayNameLangFrFR: displayNameLangFrFR ?? this.displayNameLangFrFR,
      displayNameLangDeDE: displayNameLangDeDE ?? this.displayNameLangDeDE,
      displayNameLangZhCN: displayNameLangZhCN ?? this.displayNameLangZhCN,
      displayNameLangZhTW: displayNameLangZhTW ?? this.displayNameLangZhTW,
      displayNameLangEsES: displayNameLangEsES ?? this.displayNameLangEsES,
      displayNameLangEsMX: displayNameLangEsMX ?? this.displayNameLangEsMX,
      displayNameLangRuRU: displayNameLangRuRU ?? this.displayNameLangRuRU,
      displayNameLangJaJP: displayNameLangJaJP ?? this.displayNameLangJaJP,
      displayNameLangPtPT: displayNameLangPtPT ?? this.displayNameLangPtPT,
      displayNameLangPtBR: displayNameLangPtBR ?? this.displayNameLangPtBR,
      displayNameLangItIT: displayNameLangItIT ?? this.displayNameLangItIT,
      displayNameLangUnk1: displayNameLangUnk1 ?? this.displayNameLangUnk1,
      displayNameLangUnk2: displayNameLangUnk2 ?? this.displayNameLangUnk2,
      displayNameLangUnk3: displayNameLangUnk3 ?? this.displayNameLangUnk3,
      displayNameLangFlags: displayNameLangFlags ?? this.displayNameLangFlags,
      displayNameShortLangEnUS:
          displayNameShortLangEnUS ?? this.displayNameShortLangEnUS,
      displayNameShortLangKoKR:
          displayNameShortLangKoKR ?? this.displayNameShortLangKoKR,
      displayNameShortLangFrFR:
          displayNameShortLangFrFR ?? this.displayNameShortLangFrFR,
      displayNameShortLangDeDE:
          displayNameShortLangDeDE ?? this.displayNameShortLangDeDE,
      displayNameShortLangZhCN:
          displayNameShortLangZhCN ?? this.displayNameShortLangZhCN,
      displayNameShortLangZhTW:
          displayNameShortLangZhTW ?? this.displayNameShortLangZhTW,
      displayNameShortLangEsES:
          displayNameShortLangEsES ?? this.displayNameShortLangEsES,
      displayNameShortLangEsMX:
          displayNameShortLangEsMX ?? this.displayNameShortLangEsMX,
      displayNameShortLangRuRU:
          displayNameShortLangRuRU ?? this.displayNameShortLangRuRU,
      displayNameShortLangJaJP:
          displayNameShortLangJaJP ?? this.displayNameShortLangJaJP,
      displayNameShortLangPtPT:
          displayNameShortLangPtPT ?? this.displayNameShortLangPtPT,
      displayNameShortLangPtBR:
          displayNameShortLangPtBR ?? this.displayNameShortLangPtBR,
      displayNameShortLangItIT:
          displayNameShortLangItIT ?? this.displayNameShortLangItIT,
      displayNameShortLangUnk1:
          displayNameShortLangUnk1 ?? this.displayNameShortLangUnk1,
      displayNameShortLangUnk2:
          displayNameShortLangUnk2 ?? this.displayNameShortLangUnk2,
      displayNameShortLangUnk3:
          displayNameShortLangUnk3 ?? this.displayNameShortLangUnk3,
      displayNameShortLangFlags:
          displayNameShortLangFlags ?? this.displayNameShortLangFlags,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'RangeMin0': rangeMin0,
      'RangeMin1': rangeMin1,
      'RangeMax0': rangeMax0,
      'RangeMax1': rangeMax1,
      'Flags': flags,
      'DisplayName_lang_enUS': displayNameLangEnUS,
      'DisplayName_lang_koKR': displayNameLangKoKR,
      'DisplayName_lang_frFR': displayNameLangFrFR,
      'DisplayName_lang_deDE': displayNameLangDeDE,
      'DisplayName_lang_zhCN': displayNameLangZhCN,
      'DisplayName_lang_zhTW': displayNameLangZhTW,
      'DisplayName_lang_esES': displayNameLangEsES,
      'DisplayName_lang_esMX': displayNameLangEsMX,
      'DisplayName_lang_ruRU': displayNameLangRuRU,
      'DisplayName_lang_jaJP': displayNameLangJaJP,
      'DisplayName_lang_ptPT': displayNameLangPtPT,
      'DisplayName_lang_ptBR': displayNameLangPtBR,
      'DisplayName_lang_itIT': displayNameLangItIT,
      'DisplayName_lang_unk1': displayNameLangUnk1,
      'DisplayName_lang_unk2': displayNameLangUnk2,
      'DisplayName_lang_unk3': displayNameLangUnk3,
      'DisplayName_lang_Flags': displayNameLangFlags,
      'DisplayNameShort_lang_enUS': displayNameShortLangEnUS,
      'DisplayNameShort_lang_koKR': displayNameShortLangKoKR,
      'DisplayNameShort_lang_frFR': displayNameShortLangFrFR,
      'DisplayNameShort_lang_deDE': displayNameShortLangDeDE,
      'DisplayNameShort_lang_zhCN': displayNameShortLangZhCN,
      'DisplayNameShort_lang_zhTW': displayNameShortLangZhTW,
      'DisplayNameShort_lang_esES': displayNameShortLangEsES,
      'DisplayNameShort_lang_esMX': displayNameShortLangEsMX,
      'DisplayNameShort_lang_ruRU': displayNameShortLangRuRU,
      'DisplayNameShort_lang_jaJP': displayNameShortLangJaJP,
      'DisplayNameShort_lang_ptPT': displayNameShortLangPtPT,
      'DisplayNameShort_lang_ptBR': displayNameShortLangPtBR,
      'DisplayNameShort_lang_itIT': displayNameShortLangItIT,
      'DisplayNameShort_lang_unk1': displayNameShortLangUnk1,
      'DisplayNameShort_lang_unk2': displayNameShortLangUnk2,
      'DisplayNameShort_lang_unk3': displayNameShortLangUnk3,
      'DisplayNameShort_lang_Flags': displayNameShortLangFlags,
    };
  }
}
