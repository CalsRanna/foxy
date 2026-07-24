// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'achievement_entity.dart';

mixin _AchievementEntityMixin {
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
    final self = this as AchievementEntity;
    return AchievementEntity(
      id: id ?? self.id,
      faction: faction ?? self.faction,
      instanceId: instanceId ?? self.instanceId,
      supercedes: supercedes ?? self.supercedes,
      titleLangEnUS: titleLangEnUS ?? self.titleLangEnUS,
      titleLangKoKR: titleLangKoKR ?? self.titleLangKoKR,
      titleLangFrFR: titleLangFrFR ?? self.titleLangFrFR,
      titleLangDeDE: titleLangDeDE ?? self.titleLangDeDE,
      titleLangZhCN: titleLangZhCN ?? self.titleLangZhCN,
      titleLangZhTW: titleLangZhTW ?? self.titleLangZhTW,
      titleLangEsES: titleLangEsES ?? self.titleLangEsES,
      titleLangEsMX: titleLangEsMX ?? self.titleLangEsMX,
      titleLangRuRU: titleLangRuRU ?? self.titleLangRuRU,
      titleLangJaJP: titleLangJaJP ?? self.titleLangJaJP,
      titleLangPtPT: titleLangPtPT ?? self.titleLangPtPT,
      titleLangPtBR: titleLangPtBR ?? self.titleLangPtBR,
      titleLangItIT: titleLangItIT ?? self.titleLangItIT,
      titleLangUnk1: titleLangUnk1 ?? self.titleLangUnk1,
      titleLangUnk2: titleLangUnk2 ?? self.titleLangUnk2,
      titleLangUnk3: titleLangUnk3 ?? self.titleLangUnk3,
      titleLangFlags: titleLangFlags ?? self.titleLangFlags,
      descriptionLangEnUS: descriptionLangEnUS ?? self.descriptionLangEnUS,
      descriptionLangKoKR: descriptionLangKoKR ?? self.descriptionLangKoKR,
      descriptionLangFrFR: descriptionLangFrFR ?? self.descriptionLangFrFR,
      descriptionLangDeDE: descriptionLangDeDE ?? self.descriptionLangDeDE,
      descriptionLangZhCN: descriptionLangZhCN ?? self.descriptionLangZhCN,
      descriptionLangZhTW: descriptionLangZhTW ?? self.descriptionLangZhTW,
      descriptionLangEsES: descriptionLangEsES ?? self.descriptionLangEsES,
      descriptionLangEsMX: descriptionLangEsMX ?? self.descriptionLangEsMX,
      descriptionLangRuRU: descriptionLangRuRU ?? self.descriptionLangRuRU,
      descriptionLangJaJP: descriptionLangJaJP ?? self.descriptionLangJaJP,
      descriptionLangPtPT: descriptionLangPtPT ?? self.descriptionLangPtPT,
      descriptionLangPtBR: descriptionLangPtBR ?? self.descriptionLangPtBR,
      descriptionLangItIT: descriptionLangItIT ?? self.descriptionLangItIT,
      descriptionLangUnk1: descriptionLangUnk1 ?? self.descriptionLangUnk1,
      descriptionLangUnk2: descriptionLangUnk2 ?? self.descriptionLangUnk2,
      descriptionLangUnk3: descriptionLangUnk3 ?? self.descriptionLangUnk3,
      descriptionLangFlags: descriptionLangFlags ?? self.descriptionLangFlags,
      category: category ?? self.category,
      points: points ?? self.points,
      uiOrder: uiOrder ?? self.uiOrder,
      flags: flags ?? self.flags,
      iconId: iconId ?? self.iconId,
      rewardLangEnUS: rewardLangEnUS ?? self.rewardLangEnUS,
      rewardLangKoKR: rewardLangKoKR ?? self.rewardLangKoKR,
      rewardLangFrFR: rewardLangFrFR ?? self.rewardLangFrFR,
      rewardLangDeDE: rewardLangDeDE ?? self.rewardLangDeDE,
      rewardLangZhCN: rewardLangZhCN ?? self.rewardLangZhCN,
      rewardLangZhTW: rewardLangZhTW ?? self.rewardLangZhTW,
      rewardLangEsES: rewardLangEsES ?? self.rewardLangEsES,
      rewardLangEsMX: rewardLangEsMX ?? self.rewardLangEsMX,
      rewardLangRuRU: rewardLangRuRU ?? self.rewardLangRuRU,
      rewardLangJaJP: rewardLangJaJP ?? self.rewardLangJaJP,
      rewardLangPtPT: rewardLangPtPT ?? self.rewardLangPtPT,
      rewardLangPtBR: rewardLangPtBR ?? self.rewardLangPtBR,
      rewardLangItIT: rewardLangItIT ?? self.rewardLangItIT,
      rewardLangUnk1: rewardLangUnk1 ?? self.rewardLangUnk1,
      rewardLangUnk2: rewardLangUnk2 ?? self.rewardLangUnk2,
      rewardLangUnk3: rewardLangUnk3 ?? self.rewardLangUnk3,
      rewardLangFlags: rewardLangFlags ?? self.rewardLangFlags,
      minimumCriteria: minimumCriteria ?? self.minimumCriteria,
      sharesCriteria: sharesCriteria ?? self.sharesCriteria,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as AchievementEntity;
    return {
      'ID': self.id,
      'Faction': self.faction,
      'Instance_ID': self.instanceId,
      'Supercedes': self.supercedes,
      'Title_lang_enUS': self.titleLangEnUS,
      'Title_lang_koKR': self.titleLangKoKR,
      'Title_lang_frFR': self.titleLangFrFR,
      'Title_lang_deDE': self.titleLangDeDE,
      'Title_lang_zhCN': self.titleLangZhCN,
      'Title_lang_zhTW': self.titleLangZhTW,
      'Title_lang_esES': self.titleLangEsES,
      'Title_lang_esMX': self.titleLangEsMX,
      'Title_lang_ruRU': self.titleLangRuRU,
      'Title_lang_jaJP': self.titleLangJaJP,
      'Title_lang_ptPT': self.titleLangPtPT,
      'Title_lang_ptBR': self.titleLangPtBR,
      'Title_lang_itIT': self.titleLangItIT,
      'Title_lang_unk1': self.titleLangUnk1,
      'Title_lang_unk2': self.titleLangUnk2,
      'Title_lang_unk3': self.titleLangUnk3,
      'Title_lang_Flags': self.titleLangFlags,
      'Description_lang_enUS': self.descriptionLangEnUS,
      'Description_lang_koKR': self.descriptionLangKoKR,
      'Description_lang_frFR': self.descriptionLangFrFR,
      'Description_lang_deDE': self.descriptionLangDeDE,
      'Description_lang_zhCN': self.descriptionLangZhCN,
      'Description_lang_zhTW': self.descriptionLangZhTW,
      'Description_lang_esES': self.descriptionLangEsES,
      'Description_lang_esMX': self.descriptionLangEsMX,
      'Description_lang_ruRU': self.descriptionLangRuRU,
      'Description_lang_jaJP': self.descriptionLangJaJP,
      'Description_lang_ptPT': self.descriptionLangPtPT,
      'Description_lang_ptBR': self.descriptionLangPtBR,
      'Description_lang_itIT': self.descriptionLangItIT,
      'Description_lang_unk1': self.descriptionLangUnk1,
      'Description_lang_unk2': self.descriptionLangUnk2,
      'Description_lang_unk3': self.descriptionLangUnk3,
      'Description_lang_Flags': self.descriptionLangFlags,
      'Category': self.category,
      'Points': self.points,
      'Ui_order': self.uiOrder,
      'Flags': self.flags,
      'IconID': self.iconId,
      'Reward_lang_enUS': self.rewardLangEnUS,
      'Reward_lang_koKR': self.rewardLangKoKR,
      'Reward_lang_frFR': self.rewardLangFrFR,
      'Reward_lang_deDE': self.rewardLangDeDE,
      'Reward_lang_zhCN': self.rewardLangZhCN,
      'Reward_lang_zhTW': self.rewardLangZhTW,
      'Reward_lang_esES': self.rewardLangEsES,
      'Reward_lang_esMX': self.rewardLangEsMX,
      'Reward_lang_ruRU': self.rewardLangRuRU,
      'Reward_lang_jaJP': self.rewardLangJaJP,
      'Reward_lang_ptPT': self.rewardLangPtPT,
      'Reward_lang_ptBR': self.rewardLangPtBR,
      'Reward_lang_itIT': self.rewardLangItIT,
      'Reward_lang_unk1': self.rewardLangUnk1,
      'Reward_lang_unk2': self.rewardLangUnk2,
      'Reward_lang_unk3': self.rewardLangUnk3,
      'Reward_lang_Flags': self.rewardLangFlags,
      'Minimum_criteria': self.minimumCriteria,
      'Shares_criteria': self.sharesCriteria,
    };
  }

  @override
  bool operator ==(Object other) {
    final self = this as AchievementEntity;
    return identical(self, other) ||
        other is AchievementEntity &&
            self.runtimeType == other.runtimeType &&
            self.id == other.id &&
            self.faction == other.faction &&
            self.instanceId == other.instanceId &&
            self.supercedes == other.supercedes &&
            self.titleLangEnUS == other.titleLangEnUS &&
            self.titleLangKoKR == other.titleLangKoKR &&
            self.titleLangFrFR == other.titleLangFrFR &&
            self.titleLangDeDE == other.titleLangDeDE &&
            self.titleLangZhCN == other.titleLangZhCN &&
            self.titleLangZhTW == other.titleLangZhTW &&
            self.titleLangEsES == other.titleLangEsES &&
            self.titleLangEsMX == other.titleLangEsMX &&
            self.titleLangRuRU == other.titleLangRuRU &&
            self.titleLangJaJP == other.titleLangJaJP &&
            self.titleLangPtPT == other.titleLangPtPT &&
            self.titleLangPtBR == other.titleLangPtBR &&
            self.titleLangItIT == other.titleLangItIT &&
            self.titleLangUnk1 == other.titleLangUnk1 &&
            self.titleLangUnk2 == other.titleLangUnk2 &&
            self.titleLangUnk3 == other.titleLangUnk3 &&
            self.titleLangFlags == other.titleLangFlags &&
            self.descriptionLangEnUS == other.descriptionLangEnUS &&
            self.descriptionLangKoKR == other.descriptionLangKoKR &&
            self.descriptionLangFrFR == other.descriptionLangFrFR &&
            self.descriptionLangDeDE == other.descriptionLangDeDE &&
            self.descriptionLangZhCN == other.descriptionLangZhCN &&
            self.descriptionLangZhTW == other.descriptionLangZhTW &&
            self.descriptionLangEsES == other.descriptionLangEsES &&
            self.descriptionLangEsMX == other.descriptionLangEsMX &&
            self.descriptionLangRuRU == other.descriptionLangRuRU &&
            self.descriptionLangJaJP == other.descriptionLangJaJP &&
            self.descriptionLangPtPT == other.descriptionLangPtPT &&
            self.descriptionLangPtBR == other.descriptionLangPtBR &&
            self.descriptionLangItIT == other.descriptionLangItIT &&
            self.descriptionLangUnk1 == other.descriptionLangUnk1 &&
            self.descriptionLangUnk2 == other.descriptionLangUnk2 &&
            self.descriptionLangUnk3 == other.descriptionLangUnk3 &&
            self.descriptionLangFlags == other.descriptionLangFlags &&
            self.category == other.category &&
            self.points == other.points &&
            self.uiOrder == other.uiOrder &&
            self.flags == other.flags &&
            self.iconId == other.iconId &&
            self.rewardLangEnUS == other.rewardLangEnUS &&
            self.rewardLangKoKR == other.rewardLangKoKR &&
            self.rewardLangFrFR == other.rewardLangFrFR &&
            self.rewardLangDeDE == other.rewardLangDeDE &&
            self.rewardLangZhCN == other.rewardLangZhCN &&
            self.rewardLangZhTW == other.rewardLangZhTW &&
            self.rewardLangEsES == other.rewardLangEsES &&
            self.rewardLangEsMX == other.rewardLangEsMX &&
            self.rewardLangRuRU == other.rewardLangRuRU &&
            self.rewardLangJaJP == other.rewardLangJaJP &&
            self.rewardLangPtPT == other.rewardLangPtPT &&
            self.rewardLangPtBR == other.rewardLangPtBR &&
            self.rewardLangItIT == other.rewardLangItIT &&
            self.rewardLangUnk1 == other.rewardLangUnk1 &&
            self.rewardLangUnk2 == other.rewardLangUnk2 &&
            self.rewardLangUnk3 == other.rewardLangUnk3 &&
            self.rewardLangFlags == other.rewardLangFlags &&
            self.minimumCriteria == other.minimumCriteria &&
            self.sharesCriteria == other.sharesCriteria;
  }

  @override
  int get hashCode {
    final self = this as AchievementEntity;
    return Object.hashAll([
      self.runtimeType,
      self.id,
      self.faction,
      self.instanceId,
      self.supercedes,
      self.titleLangEnUS,
      self.titleLangKoKR,
      self.titleLangFrFR,
      self.titleLangDeDE,
      self.titleLangZhCN,
      self.titleLangZhTW,
      self.titleLangEsES,
      self.titleLangEsMX,
      self.titleLangRuRU,
      self.titleLangJaJP,
      self.titleLangPtPT,
      self.titleLangPtBR,
      self.titleLangItIT,
      self.titleLangUnk1,
      self.titleLangUnk2,
      self.titleLangUnk3,
      self.titleLangFlags,
      self.descriptionLangEnUS,
      self.descriptionLangKoKR,
      self.descriptionLangFrFR,
      self.descriptionLangDeDE,
      self.descriptionLangZhCN,
      self.descriptionLangZhTW,
      self.descriptionLangEsES,
      self.descriptionLangEsMX,
      self.descriptionLangRuRU,
      self.descriptionLangJaJP,
      self.descriptionLangPtPT,
      self.descriptionLangPtBR,
      self.descriptionLangItIT,
      self.descriptionLangUnk1,
      self.descriptionLangUnk2,
      self.descriptionLangUnk3,
      self.descriptionLangFlags,
      self.category,
      self.points,
      self.uiOrder,
      self.flags,
      self.iconId,
      self.rewardLangEnUS,
      self.rewardLangKoKR,
      self.rewardLangFrFR,
      self.rewardLangDeDE,
      self.rewardLangZhCN,
      self.rewardLangZhTW,
      self.rewardLangEsES,
      self.rewardLangEsMX,
      self.rewardLangRuRU,
      self.rewardLangJaJP,
      self.rewardLangPtPT,
      self.rewardLangPtBR,
      self.rewardLangItIT,
      self.rewardLangUnk1,
      self.rewardLangUnk2,
      self.rewardLangUnk3,
      self.rewardLangFlags,
      self.minimumCriteria,
      self.sharesCriteria,
    ]);
  }

  @override
  String toString() {
    final self = this as AchievementEntity;
    return 'AchievementEntity('
        'id: ${self.id}, '
        'faction: ${self.faction}, '
        'instanceId: ${self.instanceId}, '
        'supercedes: ${self.supercedes}, '
        'titleLangEnUS: ${self.titleLangEnUS}, '
        'titleLangKoKR: ${self.titleLangKoKR}, '
        'titleLangFrFR: ${self.titleLangFrFR}, '
        'titleLangDeDE: ${self.titleLangDeDE}, '
        'titleLangZhCN: ${self.titleLangZhCN}, '
        'titleLangZhTW: ${self.titleLangZhTW}, '
        'titleLangEsES: ${self.titleLangEsES}, '
        'titleLangEsMX: ${self.titleLangEsMX}, '
        'titleLangRuRU: ${self.titleLangRuRU}, '
        'titleLangJaJP: ${self.titleLangJaJP}, '
        'titleLangPtPT: ${self.titleLangPtPT}, '
        'titleLangPtBR: ${self.titleLangPtBR}, '
        'titleLangItIT: ${self.titleLangItIT}, '
        'titleLangUnk1: ${self.titleLangUnk1}, '
        'titleLangUnk2: ${self.titleLangUnk2}, '
        'titleLangUnk3: ${self.titleLangUnk3}, '
        'titleLangFlags: ${self.titleLangFlags}, '
        'descriptionLangEnUS: ${self.descriptionLangEnUS}, '
        'descriptionLangKoKR: ${self.descriptionLangKoKR}, '
        'descriptionLangFrFR: ${self.descriptionLangFrFR}, '
        'descriptionLangDeDE: ${self.descriptionLangDeDE}, '
        'descriptionLangZhCN: ${self.descriptionLangZhCN}, '
        'descriptionLangZhTW: ${self.descriptionLangZhTW}, '
        'descriptionLangEsES: ${self.descriptionLangEsES}, '
        'descriptionLangEsMX: ${self.descriptionLangEsMX}, '
        'descriptionLangRuRU: ${self.descriptionLangRuRU}, '
        'descriptionLangJaJP: ${self.descriptionLangJaJP}, '
        'descriptionLangPtPT: ${self.descriptionLangPtPT}, '
        'descriptionLangPtBR: ${self.descriptionLangPtBR}, '
        'descriptionLangItIT: ${self.descriptionLangItIT}, '
        'descriptionLangUnk1: ${self.descriptionLangUnk1}, '
        'descriptionLangUnk2: ${self.descriptionLangUnk2}, '
        'descriptionLangUnk3: ${self.descriptionLangUnk3}, '
        'descriptionLangFlags: ${self.descriptionLangFlags}, '
        'category: ${self.category}, '
        'points: ${self.points}, '
        'uiOrder: ${self.uiOrder}, '
        'flags: ${self.flags}, '
        'iconId: ${self.iconId}, '
        'rewardLangEnUS: ${self.rewardLangEnUS}, '
        'rewardLangKoKR: ${self.rewardLangKoKR}, '
        'rewardLangFrFR: ${self.rewardLangFrFR}, '
        'rewardLangDeDE: ${self.rewardLangDeDE}, '
        'rewardLangZhCN: ${self.rewardLangZhCN}, '
        'rewardLangZhTW: ${self.rewardLangZhTW}, '
        'rewardLangEsES: ${self.rewardLangEsES}, '
        'rewardLangEsMX: ${self.rewardLangEsMX}, '
        'rewardLangRuRU: ${self.rewardLangRuRU}, '
        'rewardLangJaJP: ${self.rewardLangJaJP}, '
        'rewardLangPtPT: ${self.rewardLangPtPT}, '
        'rewardLangPtBR: ${self.rewardLangPtBR}, '
        'rewardLangItIT: ${self.rewardLangItIT}, '
        'rewardLangUnk1: ${self.rewardLangUnk1}, '
        'rewardLangUnk2: ${self.rewardLangUnk2}, '
        'rewardLangUnk3: ${self.rewardLangUnk3}, '
        'rewardLangFlags: ${self.rewardLangFlags}, '
        'minimumCriteria: ${self.minimumCriteria}, '
        'sharesCriteria: ${self.sharesCriteria}'
        ')';
  }
}
