class AchievementEntity {
  final int id;
  final int faction;
  final int instanceId;
  final int supercedes;
  final String titleLangEnUS;
  final String titleLangKoKR;
  final String titleLangFrFR;
  final String titleLangDeDE;
  final String titleLangZhCN;
  final String titleLangZhTW;
  final String titleLangEsES;
  final String titleLangEsMX;
  final String titleLangRuRU;
  final String titleLangJaJP;
  final String titleLangPtPT;
  final String titleLangPtBR;
  final String titleLangItIT;
  final String titleLangUnk1;
  final String titleLangUnk2;
  final String titleLangUnk3;
  final int titleLangFlags;
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
  final int category;
  final int points;
  final int uiOrder;
  final int flags;
  final int iconId;
  final String rewardLangEnUS;
  final String rewardLangKoKR;
  final String rewardLangFrFR;
  final String rewardLangDeDE;
  final String rewardLangZhCN;
  final String rewardLangZhTW;
  final String rewardLangEsES;
  final String rewardLangEsMX;
  final String rewardLangRuRU;
  final String rewardLangJaJP;
  final String rewardLangPtPT;
  final String rewardLangPtBR;
  final String rewardLangItIT;
  final String rewardLangUnk1;
  final String rewardLangUnk2;
  final String rewardLangUnk3;
  final int rewardLangFlags;
  final int minimumCriteria;
  final int sharesCriteria;

  const AchievementEntity({
    this.id = 0,
    this.faction = 0,
    this.instanceId = 0,
    this.supercedes = 0,
    this.titleLangEnUS = '',
    this.titleLangKoKR = '',
    this.titleLangFrFR = '',
    this.titleLangDeDE = '',
    this.titleLangZhCN = '',
    this.titleLangZhTW = '',
    this.titleLangEsES = '',
    this.titleLangEsMX = '',
    this.titleLangRuRU = '',
    this.titleLangJaJP = '',
    this.titleLangPtPT = '',
    this.titleLangPtBR = '',
    this.titleLangItIT = '',
    this.titleLangUnk1 = '',
    this.titleLangUnk2 = '',
    this.titleLangUnk3 = '',
    this.titleLangFlags = 0,
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
    this.category = 0,
    this.points = 0,
    this.uiOrder = 0,
    this.flags = 0,
    this.iconId = 0,
    this.rewardLangEnUS = '',
    this.rewardLangKoKR = '',
    this.rewardLangFrFR = '',
    this.rewardLangDeDE = '',
    this.rewardLangZhCN = '',
    this.rewardLangZhTW = '',
    this.rewardLangEsES = '',
    this.rewardLangEsMX = '',
    this.rewardLangRuRU = '',
    this.rewardLangJaJP = '',
    this.rewardLangPtPT = '',
    this.rewardLangPtBR = '',
    this.rewardLangItIT = '',
    this.rewardLangUnk1 = '',
    this.rewardLangUnk2 = '',
    this.rewardLangUnk3 = '',
    this.rewardLangFlags = 0,
    this.minimumCriteria = 0,
    this.sharesCriteria = 0,
  });

  factory AchievementEntity.fromJson(Map<String, dynamic> json) {
    return AchievementEntity(
      id: json['ID'] ?? 0,
      faction: json['Faction'] ?? 0,
      instanceId: json['Instance_ID'] ?? 0,
      supercedes: json['Supercedes'] ?? 0,
      titleLangEnUS: json['Title_lang_enUS'] ?? '',
      titleLangKoKR: json['Title_lang_koKR'] ?? '',
      titleLangFrFR: json['Title_lang_frFR'] ?? '',
      titleLangDeDE: json['Title_lang_deDE'] ?? '',
      titleLangZhCN: json['Title_lang_zhCN'] ?? '',
      titleLangZhTW: json['Title_lang_zhTW'] ?? '',
      titleLangEsES: json['Title_lang_esES'] ?? '',
      titleLangEsMX: json['Title_lang_esMX'] ?? '',
      titleLangRuRU: json['Title_lang_ruRU'] ?? '',
      titleLangJaJP: json['Title_lang_jaJP'] ?? '',
      titleLangPtPT: json['Title_lang_ptPT'] ?? '',
      titleLangPtBR: json['Title_lang_ptBR'] ?? '',
      titleLangItIT: json['Title_lang_itIT'] ?? '',
      titleLangUnk1: json['Title_lang_unk1'] ?? '',
      titleLangUnk2: json['Title_lang_unk2'] ?? '',
      titleLangUnk3: json['Title_lang_unk3'] ?? '',
      titleLangFlags: json['Title_lang_Flags'] ?? 0,
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
      category: json['Category'] ?? 0,
      points: json['Points'] ?? 0,
      uiOrder: json['Ui_order'] ?? 0,
      flags: json['Flags'] ?? 0,
      iconId: json['IconID'] ?? 0,
      rewardLangEnUS: json['Reward_lang_enUS'] ?? '',
      rewardLangKoKR: json['Reward_lang_koKR'] ?? '',
      rewardLangFrFR: json['Reward_lang_frFR'] ?? '',
      rewardLangDeDE: json['Reward_lang_deDE'] ?? '',
      rewardLangZhCN: json['Reward_lang_zhCN'] ?? '',
      rewardLangZhTW: json['Reward_lang_zhTW'] ?? '',
      rewardLangEsES: json['Reward_lang_esES'] ?? '',
      rewardLangEsMX: json['Reward_lang_esMX'] ?? '',
      rewardLangRuRU: json['Reward_lang_ruRU'] ?? '',
      rewardLangJaJP: json['Reward_lang_jaJP'] ?? '',
      rewardLangPtPT: json['Reward_lang_ptPT'] ?? '',
      rewardLangPtBR: json['Reward_lang_ptBR'] ?? '',
      rewardLangItIT: json['Reward_lang_itIT'] ?? '',
      rewardLangUnk1: json['Reward_lang_unk1'] ?? '',
      rewardLangUnk2: json['Reward_lang_unk2'] ?? '',
      rewardLangUnk3: json['Reward_lang_unk3'] ?? '',
      rewardLangFlags: json['Reward_lang_Flags'] ?? 0,
      minimumCriteria: json['Minimum_criteria'] ?? 0,
      sharesCriteria: json['Shares_criteria'] ?? 0,
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
}

class BriefAchievementEntity {
  final int id;
  final String titleLangZhCN;
  final String descriptionLangZhCN;
  final String rewardLangZhCN;

  const BriefAchievementEntity({
    this.id = 0,
    this.titleLangZhCN = '',
    this.descriptionLangZhCN = '',
    this.rewardLangZhCN = '',
  });

  factory BriefAchievementEntity.fromJson(Map<String, dynamic> json) {
    return BriefAchievementEntity(
      id: json['ID'] ?? 0,
      titleLangZhCN: json['Title_lang_zhCN'] ?? '',
      descriptionLangZhCN: json['Description_lang_zhCN'] ?? '',
      rewardLangZhCN: json['Reward_lang_zhCN'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Title_lang_zhCN': titleLangZhCN,
      'Description_lang_zhCN': descriptionLangZhCN,
      'Reward_lang_zhCN': rewardLangZhCN,
    };
  }
}
