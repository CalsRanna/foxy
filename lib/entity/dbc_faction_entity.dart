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
  final String nameLangZhCn;
  final String descriptionLangZhCn;
  final int nameLangFlags;
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
    this.nameLangZhCn = '',
    this.descriptionLangZhCn = '',
    this.nameLangFlags = 0,
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
      nameLangZhCn: json['Name_lang_zhCN'] ?? '',
      descriptionLangZhCn: json['Description_lang_zhCN'] ?? '',
      nameLangFlags: json['Name_lang_Flags'] ?? 0,
      descriptionLangFlags: json['Description_lang_Flags'] ?? 0,
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
      'Name_lang_zhCN': nameLangZhCn,
      'Description_lang_zhCN': descriptionLangZhCn,
      'Name_lang_Flags': nameLangFlags,
      'Description_lang_Flags': descriptionLangFlags,
    };
  }
}
