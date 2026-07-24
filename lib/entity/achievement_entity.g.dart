// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'achievement_entity.dart';

mixin _AchievementEntityMixin {
  int get id;
  int get faction;
  int get instanceId;
  int get supercedes;
  String get titleLangEnUS;
  String get titleLangKoKR;
  String get titleLangFrFR;
  String get titleLangDeDE;
  String get titleLangZhCN;
  String get titleLangZhTW;
  String get titleLangEsES;
  String get titleLangEsMX;
  String get titleLangRuRU;
  String get titleLangJaJP;
  String get titleLangPtPT;
  String get titleLangPtBR;
  String get titleLangItIT;
  String get titleLangUnk1;
  String get titleLangUnk2;
  String get titleLangUnk3;
  int get titleLangFlags;
  String get descriptionLangEnUS;
  String get descriptionLangKoKR;
  String get descriptionLangFrFR;
  String get descriptionLangDeDE;
  String get descriptionLangZhCN;
  String get descriptionLangZhTW;
  String get descriptionLangEsES;
  String get descriptionLangEsMX;
  String get descriptionLangRuRU;
  String get descriptionLangJaJP;
  String get descriptionLangPtPT;
  String get descriptionLangPtBR;
  String get descriptionLangItIT;
  String get descriptionLangUnk1;
  String get descriptionLangUnk2;
  String get descriptionLangUnk3;
  int get descriptionLangFlags;
  int get category;
  int get points;
  int get uiOrder;
  int get flags;
  int get iconId;
  String get rewardLangEnUS;
  String get rewardLangKoKR;
  String get rewardLangFrFR;
  String get rewardLangDeDE;
  String get rewardLangZhCN;
  String get rewardLangZhTW;
  String get rewardLangEsES;
  String get rewardLangEsMX;
  String get rewardLangRuRU;
  String get rewardLangJaJP;
  String get rewardLangPtPT;
  String get rewardLangPtBR;
  String get rewardLangItIT;
  String get rewardLangUnk1;
  String get rewardLangUnk2;
  String get rewardLangUnk3;
  int get rewardLangFlags;
  int get minimumCriteria;
  int get sharesCriteria;

  static AchievementEntity fromJson(Map<String, dynamic> json) {
    return AchievementEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      faction: (json['Faction'] as num?)?.toInt() ?? -1,
      instanceId: (json['Instance_ID'] as num?)?.toInt() ?? -1,
      supercedes: (json['Supercedes'] as num?)?.toInt() ?? 0,
      titleLangEnUS: json['Title_lang_enUS']?.toString() ?? '',
      titleLangKoKR: json['Title_lang_koKR']?.toString() ?? '',
      titleLangFrFR: json['Title_lang_frFR']?.toString() ?? '',
      titleLangDeDE: json['Title_lang_deDE']?.toString() ?? '',
      titleLangZhCN: json['Title_lang_zhCN']?.toString() ?? '',
      titleLangZhTW: json['Title_lang_zhTW']?.toString() ?? '',
      titleLangEsES: json['Title_lang_esES']?.toString() ?? '',
      titleLangEsMX: json['Title_lang_esMX']?.toString() ?? '',
      titleLangRuRU: json['Title_lang_ruRU']?.toString() ?? '',
      titleLangJaJP: json['Title_lang_jaJP']?.toString() ?? '',
      titleLangPtPT: json['Title_lang_ptPT']?.toString() ?? '',
      titleLangPtBR: json['Title_lang_ptBR']?.toString() ?? '',
      titleLangItIT: json['Title_lang_itIT']?.toString() ?? '',
      titleLangUnk1: json['Title_lang_unk1']?.toString() ?? '',
      titleLangUnk2: json['Title_lang_unk2']?.toString() ?? '',
      titleLangUnk3: json['Title_lang_unk3']?.toString() ?? '',
      titleLangFlags: (json['Title_lang_Flags'] as num?)?.toInt() ?? 0,
      descriptionLangEnUS: json['Description_lang_enUS']?.toString() ?? '',
      descriptionLangKoKR: json['Description_lang_koKR']?.toString() ?? '',
      descriptionLangFrFR: json['Description_lang_frFR']?.toString() ?? '',
      descriptionLangDeDE: json['Description_lang_deDE']?.toString() ?? '',
      descriptionLangZhCN: json['Description_lang_zhCN']?.toString() ?? '',
      descriptionLangZhTW: json['Description_lang_zhTW']?.toString() ?? '',
      descriptionLangEsES: json['Description_lang_esES']?.toString() ?? '',
      descriptionLangEsMX: json['Description_lang_esMX']?.toString() ?? '',
      descriptionLangRuRU: json['Description_lang_ruRU']?.toString() ?? '',
      descriptionLangJaJP: json['Description_lang_jaJP']?.toString() ?? '',
      descriptionLangPtPT: json['Description_lang_ptPT']?.toString() ?? '',
      descriptionLangPtBR: json['Description_lang_ptBR']?.toString() ?? '',
      descriptionLangItIT: json['Description_lang_itIT']?.toString() ?? '',
      descriptionLangUnk1: json['Description_lang_unk1']?.toString() ?? '',
      descriptionLangUnk2: json['Description_lang_unk2']?.toString() ?? '',
      descriptionLangUnk3: json['Description_lang_unk3']?.toString() ?? '',
      descriptionLangFlags:
          (json['Description_lang_Flags'] as num?)?.toInt() ?? 0,
      category: (json['Category'] as num?)?.toInt() ?? 0,
      points: (json['Points'] as num?)?.toInt() ?? 0,
      uiOrder: (json['Ui_order'] as num?)?.toInt() ?? 0,
      flags: (json['Flags'] as num?)?.toInt() ?? 0,
      iconId: (json['IconID'] as num?)?.toInt() ?? 0,
      rewardLangEnUS: json['Reward_lang_enUS']?.toString() ?? '',
      rewardLangKoKR: json['Reward_lang_koKR']?.toString() ?? '',
      rewardLangFrFR: json['Reward_lang_frFR']?.toString() ?? '',
      rewardLangDeDE: json['Reward_lang_deDE']?.toString() ?? '',
      rewardLangZhCN: json['Reward_lang_zhCN']?.toString() ?? '',
      rewardLangZhTW: json['Reward_lang_zhTW']?.toString() ?? '',
      rewardLangEsES: json['Reward_lang_esES']?.toString() ?? '',
      rewardLangEsMX: json['Reward_lang_esMX']?.toString() ?? '',
      rewardLangRuRU: json['Reward_lang_ruRU']?.toString() ?? '',
      rewardLangJaJP: json['Reward_lang_jaJP']?.toString() ?? '',
      rewardLangPtPT: json['Reward_lang_ptPT']?.toString() ?? '',
      rewardLangPtBR: json['Reward_lang_ptBR']?.toString() ?? '',
      rewardLangItIT: json['Reward_lang_itIT']?.toString() ?? '',
      rewardLangUnk1: json['Reward_lang_unk1']?.toString() ?? '',
      rewardLangUnk2: json['Reward_lang_unk2']?.toString() ?? '',
      rewardLangUnk3: json['Reward_lang_unk3']?.toString() ?? '',
      rewardLangFlags: (json['Reward_lang_Flags'] as num?)?.toInt() ?? 0,
      minimumCriteria: (json['Minimum_criteria'] as num?)?.toInt() ?? 0,
      sharesCriteria: (json['Shares_criteria'] as num?)?.toInt() ?? 0,
    );
  }

  AchievementEntity copyWith({
    int? id,
    int? faction,
    int? instanceId,
    int? supercedes,
    String? titleLangEnUS,
    String? titleLangKoKR,
    String? titleLangFrFR,
    String? titleLangDeDE,
    String? titleLangZhCN,
    String? titleLangZhTW,
    String? titleLangEsES,
    String? titleLangEsMX,
    String? titleLangRuRU,
    String? titleLangJaJP,
    String? titleLangPtPT,
    String? titleLangPtBR,
    String? titleLangItIT,
    String? titleLangUnk1,
    String? titleLangUnk2,
    String? titleLangUnk3,
    int? titleLangFlags,
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
    int? category,
    int? points,
    int? uiOrder,
    int? flags,
    int? iconId,
    String? rewardLangEnUS,
    String? rewardLangKoKR,
    String? rewardLangFrFR,
    String? rewardLangDeDE,
    String? rewardLangZhCN,
    String? rewardLangZhTW,
    String? rewardLangEsES,
    String? rewardLangEsMX,
    String? rewardLangRuRU,
    String? rewardLangJaJP,
    String? rewardLangPtPT,
    String? rewardLangPtBR,
    String? rewardLangItIT,
    String? rewardLangUnk1,
    String? rewardLangUnk2,
    String? rewardLangUnk3,
    int? rewardLangFlags,
    int? minimumCriteria,
    int? sharesCriteria,
  }) {
    return AchievementEntity(
      id: id ?? this.id,
      faction: faction ?? this.faction,
      instanceId: instanceId ?? this.instanceId,
      supercedes: supercedes ?? this.supercedes,
      titleLangEnUS: titleLangEnUS ?? this.titleLangEnUS,
      titleLangKoKR: titleLangKoKR ?? this.titleLangKoKR,
      titleLangFrFR: titleLangFrFR ?? this.titleLangFrFR,
      titleLangDeDE: titleLangDeDE ?? this.titleLangDeDE,
      titleLangZhCN: titleLangZhCN ?? this.titleLangZhCN,
      titleLangZhTW: titleLangZhTW ?? this.titleLangZhTW,
      titleLangEsES: titleLangEsES ?? this.titleLangEsES,
      titleLangEsMX: titleLangEsMX ?? this.titleLangEsMX,
      titleLangRuRU: titleLangRuRU ?? this.titleLangRuRU,
      titleLangJaJP: titleLangJaJP ?? this.titleLangJaJP,
      titleLangPtPT: titleLangPtPT ?? this.titleLangPtPT,
      titleLangPtBR: titleLangPtBR ?? this.titleLangPtBR,
      titleLangItIT: titleLangItIT ?? this.titleLangItIT,
      titleLangUnk1: titleLangUnk1 ?? this.titleLangUnk1,
      titleLangUnk2: titleLangUnk2 ?? this.titleLangUnk2,
      titleLangUnk3: titleLangUnk3 ?? this.titleLangUnk3,
      titleLangFlags: titleLangFlags ?? this.titleLangFlags,
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
      category: category ?? this.category,
      points: points ?? this.points,
      uiOrder: uiOrder ?? this.uiOrder,
      flags: flags ?? this.flags,
      iconId: iconId ?? this.iconId,
      rewardLangEnUS: rewardLangEnUS ?? this.rewardLangEnUS,
      rewardLangKoKR: rewardLangKoKR ?? this.rewardLangKoKR,
      rewardLangFrFR: rewardLangFrFR ?? this.rewardLangFrFR,
      rewardLangDeDE: rewardLangDeDE ?? this.rewardLangDeDE,
      rewardLangZhCN: rewardLangZhCN ?? this.rewardLangZhCN,
      rewardLangZhTW: rewardLangZhTW ?? this.rewardLangZhTW,
      rewardLangEsES: rewardLangEsES ?? this.rewardLangEsES,
      rewardLangEsMX: rewardLangEsMX ?? this.rewardLangEsMX,
      rewardLangRuRU: rewardLangRuRU ?? this.rewardLangRuRU,
      rewardLangJaJP: rewardLangJaJP ?? this.rewardLangJaJP,
      rewardLangPtPT: rewardLangPtPT ?? this.rewardLangPtPT,
      rewardLangPtBR: rewardLangPtBR ?? this.rewardLangPtBR,
      rewardLangItIT: rewardLangItIT ?? this.rewardLangItIT,
      rewardLangUnk1: rewardLangUnk1 ?? this.rewardLangUnk1,
      rewardLangUnk2: rewardLangUnk2 ?? this.rewardLangUnk2,
      rewardLangUnk3: rewardLangUnk3 ?? this.rewardLangUnk3,
      rewardLangFlags: rewardLangFlags ?? this.rewardLangFlags,
      minimumCriteria: minimumCriteria ?? this.minimumCriteria,
      sharesCriteria: sharesCriteria ?? this.sharesCriteria,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Faction': faction,
      'Instance_ID': instanceId,
      'Supercedes': supercedes,
      'Title_lang_enUS': titleLangEnUS,
      'Title_lang_koKR': titleLangKoKR,
      'Title_lang_frFR': titleLangFrFR,
      'Title_lang_deDE': titleLangDeDE,
      'Title_lang_zhCN': titleLangZhCN,
      'Title_lang_zhTW': titleLangZhTW,
      'Title_lang_esES': titleLangEsES,
      'Title_lang_esMX': titleLangEsMX,
      'Title_lang_ruRU': titleLangRuRU,
      'Title_lang_jaJP': titleLangJaJP,
      'Title_lang_ptPT': titleLangPtPT,
      'Title_lang_ptBR': titleLangPtBR,
      'Title_lang_itIT': titleLangItIT,
      'Title_lang_unk1': titleLangUnk1,
      'Title_lang_unk2': titleLangUnk2,
      'Title_lang_unk3': titleLangUnk3,
      'Title_lang_Flags': titleLangFlags,
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
      'Category': category,
      'Points': points,
      'Ui_order': uiOrder,
      'Flags': flags,
      'IconID': iconId,
      'Reward_lang_enUS': rewardLangEnUS,
      'Reward_lang_koKR': rewardLangKoKR,
      'Reward_lang_frFR': rewardLangFrFR,
      'Reward_lang_deDE': rewardLangDeDE,
      'Reward_lang_zhCN': rewardLangZhCN,
      'Reward_lang_zhTW': rewardLangZhTW,
      'Reward_lang_esES': rewardLangEsES,
      'Reward_lang_esMX': rewardLangEsMX,
      'Reward_lang_ruRU': rewardLangRuRU,
      'Reward_lang_jaJP': rewardLangJaJP,
      'Reward_lang_ptPT': rewardLangPtPT,
      'Reward_lang_ptBR': rewardLangPtBR,
      'Reward_lang_itIT': rewardLangItIT,
      'Reward_lang_unk1': rewardLangUnk1,
      'Reward_lang_unk2': rewardLangUnk2,
      'Reward_lang_unk3': rewardLangUnk3,
      'Reward_lang_Flags': rewardLangFlags,
      'Minimum_criteria': minimumCriteria,
      'Shares_criteria': sharesCriteria,
    };
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is AchievementEntity &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            faction == other.faction &&
            instanceId == other.instanceId &&
            supercedes == other.supercedes &&
            titleLangEnUS == other.titleLangEnUS &&
            titleLangKoKR == other.titleLangKoKR &&
            titleLangFrFR == other.titleLangFrFR &&
            titleLangDeDE == other.titleLangDeDE &&
            titleLangZhCN == other.titleLangZhCN &&
            titleLangZhTW == other.titleLangZhTW &&
            titleLangEsES == other.titleLangEsES &&
            titleLangEsMX == other.titleLangEsMX &&
            titleLangRuRU == other.titleLangRuRU &&
            titleLangJaJP == other.titleLangJaJP &&
            titleLangPtPT == other.titleLangPtPT &&
            titleLangPtBR == other.titleLangPtBR &&
            titleLangItIT == other.titleLangItIT &&
            titleLangUnk1 == other.titleLangUnk1 &&
            titleLangUnk2 == other.titleLangUnk2 &&
            titleLangUnk3 == other.titleLangUnk3 &&
            titleLangFlags == other.titleLangFlags &&
            descriptionLangEnUS == other.descriptionLangEnUS &&
            descriptionLangKoKR == other.descriptionLangKoKR &&
            descriptionLangFrFR == other.descriptionLangFrFR &&
            descriptionLangDeDE == other.descriptionLangDeDE &&
            descriptionLangZhCN == other.descriptionLangZhCN &&
            descriptionLangZhTW == other.descriptionLangZhTW &&
            descriptionLangEsES == other.descriptionLangEsES &&
            descriptionLangEsMX == other.descriptionLangEsMX &&
            descriptionLangRuRU == other.descriptionLangRuRU &&
            descriptionLangJaJP == other.descriptionLangJaJP &&
            descriptionLangPtPT == other.descriptionLangPtPT &&
            descriptionLangPtBR == other.descriptionLangPtBR &&
            descriptionLangItIT == other.descriptionLangItIT &&
            descriptionLangUnk1 == other.descriptionLangUnk1 &&
            descriptionLangUnk2 == other.descriptionLangUnk2 &&
            descriptionLangUnk3 == other.descriptionLangUnk3 &&
            descriptionLangFlags == other.descriptionLangFlags &&
            category == other.category &&
            points == other.points &&
            uiOrder == other.uiOrder &&
            flags == other.flags &&
            iconId == other.iconId &&
            rewardLangEnUS == other.rewardLangEnUS &&
            rewardLangKoKR == other.rewardLangKoKR &&
            rewardLangFrFR == other.rewardLangFrFR &&
            rewardLangDeDE == other.rewardLangDeDE &&
            rewardLangZhCN == other.rewardLangZhCN &&
            rewardLangZhTW == other.rewardLangZhTW &&
            rewardLangEsES == other.rewardLangEsES &&
            rewardLangEsMX == other.rewardLangEsMX &&
            rewardLangRuRU == other.rewardLangRuRU &&
            rewardLangJaJP == other.rewardLangJaJP &&
            rewardLangPtPT == other.rewardLangPtPT &&
            rewardLangPtBR == other.rewardLangPtBR &&
            rewardLangItIT == other.rewardLangItIT &&
            rewardLangUnk1 == other.rewardLangUnk1 &&
            rewardLangUnk2 == other.rewardLangUnk2 &&
            rewardLangUnk3 == other.rewardLangUnk3 &&
            rewardLangFlags == other.rewardLangFlags &&
            minimumCriteria == other.minimumCriteria &&
            sharesCriteria == other.sharesCriteria;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      runtimeType,
      id,
      faction,
      instanceId,
      supercedes,
      titleLangEnUS,
      titleLangKoKR,
      titleLangFrFR,
      titleLangDeDE,
      titleLangZhCN,
      titleLangZhTW,
      titleLangEsES,
      titleLangEsMX,
      titleLangRuRU,
      titleLangJaJP,
      titleLangPtPT,
      titleLangPtBR,
      titleLangItIT,
      titleLangUnk1,
      titleLangUnk2,
      titleLangUnk3,
      titleLangFlags,
      descriptionLangEnUS,
      descriptionLangKoKR,
      descriptionLangFrFR,
      descriptionLangDeDE,
      descriptionLangZhCN,
      descriptionLangZhTW,
      descriptionLangEsES,
      descriptionLangEsMX,
      descriptionLangRuRU,
      descriptionLangJaJP,
      descriptionLangPtPT,
      descriptionLangPtBR,
      descriptionLangItIT,
      descriptionLangUnk1,
      descriptionLangUnk2,
      descriptionLangUnk3,
      descriptionLangFlags,
      category,
      points,
      uiOrder,
      flags,
      iconId,
      rewardLangEnUS,
      rewardLangKoKR,
      rewardLangFrFR,
      rewardLangDeDE,
      rewardLangZhCN,
      rewardLangZhTW,
      rewardLangEsES,
      rewardLangEsMX,
      rewardLangRuRU,
      rewardLangJaJP,
      rewardLangPtPT,
      rewardLangPtBR,
      rewardLangItIT,
      rewardLangUnk1,
      rewardLangUnk2,
      rewardLangUnk3,
      rewardLangFlags,
      minimumCriteria,
      sharesCriteria,
    ]);
  }

  @override
  String toString() {
    return 'AchievementEntity('
        'id: $id, '
        'faction: $faction, '
        'instanceId: $instanceId, '
        'supercedes: $supercedes, '
        'titleLangEnUS: $titleLangEnUS, '
        'titleLangKoKR: $titleLangKoKR, '
        'titleLangFrFR: $titleLangFrFR, '
        'titleLangDeDE: $titleLangDeDE, '
        'titleLangZhCN: $titleLangZhCN, '
        'titleLangZhTW: $titleLangZhTW, '
        'titleLangEsES: $titleLangEsES, '
        'titleLangEsMX: $titleLangEsMX, '
        'titleLangRuRU: $titleLangRuRU, '
        'titleLangJaJP: $titleLangJaJP, '
        'titleLangPtPT: $titleLangPtPT, '
        'titleLangPtBR: $titleLangPtBR, '
        'titleLangItIT: $titleLangItIT, '
        'titleLangUnk1: $titleLangUnk1, '
        'titleLangUnk2: $titleLangUnk2, '
        'titleLangUnk3: $titleLangUnk3, '
        'titleLangFlags: $titleLangFlags, '
        'descriptionLangEnUS: $descriptionLangEnUS, '
        'descriptionLangKoKR: $descriptionLangKoKR, '
        'descriptionLangFrFR: $descriptionLangFrFR, '
        'descriptionLangDeDE: $descriptionLangDeDE, '
        'descriptionLangZhCN: $descriptionLangZhCN, '
        'descriptionLangZhTW: $descriptionLangZhTW, '
        'descriptionLangEsES: $descriptionLangEsES, '
        'descriptionLangEsMX: $descriptionLangEsMX, '
        'descriptionLangRuRU: $descriptionLangRuRU, '
        'descriptionLangJaJP: $descriptionLangJaJP, '
        'descriptionLangPtPT: $descriptionLangPtPT, '
        'descriptionLangPtBR: $descriptionLangPtBR, '
        'descriptionLangItIT: $descriptionLangItIT, '
        'descriptionLangUnk1: $descriptionLangUnk1, '
        'descriptionLangUnk2: $descriptionLangUnk2, '
        'descriptionLangUnk3: $descriptionLangUnk3, '
        'descriptionLangFlags: $descriptionLangFlags, '
        'category: $category, '
        'points: $points, '
        'uiOrder: $uiOrder, '
        'flags: $flags, '
        'iconId: $iconId, '
        'rewardLangEnUS: $rewardLangEnUS, '
        'rewardLangKoKR: $rewardLangKoKR, '
        'rewardLangFrFR: $rewardLangFrFR, '
        'rewardLangDeDE: $rewardLangDeDE, '
        'rewardLangZhCN: $rewardLangZhCN, '
        'rewardLangZhTW: $rewardLangZhTW, '
        'rewardLangEsES: $rewardLangEsES, '
        'rewardLangEsMX: $rewardLangEsMX, '
        'rewardLangRuRU: $rewardLangRuRU, '
        'rewardLangJaJP: $rewardLangJaJP, '
        'rewardLangPtPT: $rewardLangPtPT, '
        'rewardLangPtBR: $rewardLangPtBR, '
        'rewardLangItIT: $rewardLangItIT, '
        'rewardLangUnk1: $rewardLangUnk1, '
        'rewardLangUnk2: $rewardLangUnk2, '
        'rewardLangUnk3: $rewardLangUnk3, '
        'rewardLangFlags: $rewardLangFlags, '
        'minimumCriteria: $minimumCriteria, '
        'sharesCriteria: $sharesCriteria'
        ')';
  }
}
