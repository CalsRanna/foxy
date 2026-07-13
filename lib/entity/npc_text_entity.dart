class NpcTextEntity {
  final int id;
  final String text00;
  final String text01;
  final int broadcastTextId0;
  final int lang0;
  final double probability0;
  final int em00;
  final int em01;
  final int em02;
  final int em03;
  final int em04;
  final int em05;
  final String text10;
  final String text11;
  final int broadcastTextId1;
  final int lang1;
  final double probability1;
  final int em10;
  final int em11;
  final int em12;
  final int em13;
  final int em14;
  final int em15;
  final String text20;
  final String text21;
  final int broadcastTextId2;
  final int lang2;
  final double probability2;
  final int em20;
  final int em21;
  final int em22;
  final int em23;
  final int em24;
  final int em25;
  final String text30;
  final String text31;
  final int broadcastTextId3;
  final int lang3;
  final double probability3;
  final int em30;
  final int em31;
  final int em32;
  final int em33;
  final int em34;
  final int em35;
  final String text40;
  final String text41;
  final int broadcastTextId4;
  final int lang4;
  final double probability4;
  final int em40;
  final int em41;
  final int em42;
  final int em43;
  final int em44;
  final int em45;
  final String text50;
  final String text51;
  final int broadcastTextId5;
  final int lang5;
  final double probability5;
  final int em50;
  final int em51;
  final int em52;
  final int em53;
  final int em54;
  final int em55;
  final String text60;
  final String text61;
  final int broadcastTextId6;
  final int lang6;
  final double probability6;
  final int em60;
  final int em61;
  final int em62;
  final int em63;
  final int em64;
  final int em65;
  final String text70;
  final String text71;
  final int broadcastTextId7;
  final int lang7;
  final double probability7;
  final int em70;
  final int em71;
  final int em72;
  final int em73;
  final int em74;
  final int em75;
  final int verifiedBuild;

  const NpcTextEntity({
    this.id = 0,
    this.text00 = '',
    this.text01 = '',
    this.broadcastTextId0 = 0,
    this.lang0 = 0,
    this.probability0 = 0,
    this.em00 = 0,
    this.em01 = 0,
    this.em02 = 0,
    this.em03 = 0,
    this.em04 = 0,
    this.em05 = 0,
    this.text10 = '',
    this.text11 = '',
    this.broadcastTextId1 = 0,
    this.lang1 = 0,
    this.probability1 = 0,
    this.em10 = 0,
    this.em11 = 0,
    this.em12 = 0,
    this.em13 = 0,
    this.em14 = 0,
    this.em15 = 0,
    this.text20 = '',
    this.text21 = '',
    this.broadcastTextId2 = 0,
    this.lang2 = 0,
    this.probability2 = 0,
    this.em20 = 0,
    this.em21 = 0,
    this.em22 = 0,
    this.em23 = 0,
    this.em24 = 0,
    this.em25 = 0,
    this.text30 = '',
    this.text31 = '',
    this.broadcastTextId3 = 0,
    this.lang3 = 0,
    this.probability3 = 0,
    this.em30 = 0,
    this.em31 = 0,
    this.em32 = 0,
    this.em33 = 0,
    this.em34 = 0,
    this.em35 = 0,
    this.text40 = '',
    this.text41 = '',
    this.broadcastTextId4 = 0,
    this.lang4 = 0,
    this.probability4 = 0,
    this.em40 = 0,
    this.em41 = 0,
    this.em42 = 0,
    this.em43 = 0,
    this.em44 = 0,
    this.em45 = 0,
    this.text50 = '',
    this.text51 = '',
    this.broadcastTextId5 = 0,
    this.lang5 = 0,
    this.probability5 = 0,
    this.em50 = 0,
    this.em51 = 0,
    this.em52 = 0,
    this.em53 = 0,
    this.em54 = 0,
    this.em55 = 0,
    this.text60 = '',
    this.text61 = '',
    this.broadcastTextId6 = 0,
    this.lang6 = 0,
    this.probability6 = 0,
    this.em60 = 0,
    this.em61 = 0,
    this.em62 = 0,
    this.em63 = 0,
    this.em64 = 0,
    this.em65 = 0,
    this.text70 = '',
    this.text71 = '',
    this.broadcastTextId7 = 0,
    this.lang7 = 0,
    this.probability7 = 0,
    this.em70 = 0,
    this.em71 = 0,
    this.em72 = 0,
    this.em73 = 0,
    this.em74 = 0,
    this.em75 = 0,
    this.verifiedBuild = 0,
  });

  factory NpcTextEntity.fromJson(Map<String, dynamic> json) {
    return NpcTextEntity(
      id: _int(json['ID'] ?? json['id']),
      text00: json['text0_0']?.toString() ?? '',
      text01: json['text0_1']?.toString() ?? '',
      broadcastTextId0: _int(json['BroadcastTextID0']),
      lang0: _int(json['lang0']),
      probability0: _double(json['Probability0']),
      em00: _int(json['em0_0']),
      em01: _int(json['em0_1']),
      em02: _int(json['em0_2']),
      em03: _int(json['em0_3']),
      em04: _int(json['em0_4']),
      em05: _int(json['em0_5']),
      text10: json['text1_0']?.toString() ?? '',
      text11: json['text1_1']?.toString() ?? '',
      broadcastTextId1: _int(json['BroadcastTextID1']),
      lang1: _int(json['lang1']),
      probability1: _double(json['Probability1']),
      em10: _int(json['em1_0']),
      em11: _int(json['em1_1']),
      em12: _int(json['em1_2']),
      em13: _int(json['em1_3']),
      em14: _int(json['em1_4']),
      em15: _int(json['em1_5']),
      text20: json['text2_0']?.toString() ?? '',
      text21: json['text2_1']?.toString() ?? '',
      broadcastTextId2: _int(json['BroadcastTextID2']),
      lang2: _int(json['lang2']),
      probability2: _double(json['Probability2']),
      em20: _int(json['em2_0']),
      em21: _int(json['em2_1']),
      em22: _int(json['em2_2']),
      em23: _int(json['em2_3']),
      em24: _int(json['em2_4']),
      em25: _int(json['em2_5']),
      text30: json['text3_0']?.toString() ?? '',
      text31: json['text3_1']?.toString() ?? '',
      broadcastTextId3: _int(json['BroadcastTextID3']),
      lang3: _int(json['lang3']),
      probability3: _double(json['Probability3']),
      em30: _int(json['em3_0']),
      em31: _int(json['em3_1']),
      em32: _int(json['em3_2']),
      em33: _int(json['em3_3']),
      em34: _int(json['em3_4']),
      em35: _int(json['em3_5']),
      text40: json['text4_0']?.toString() ?? '',
      text41: json['text4_1']?.toString() ?? '',
      broadcastTextId4: _int(json['BroadcastTextID4']),
      lang4: _int(json['lang4']),
      probability4: _double(json['Probability4']),
      em40: _int(json['em4_0']),
      em41: _int(json['em4_1']),
      em42: _int(json['em4_2']),
      em43: _int(json['em4_3']),
      em44: _int(json['em4_4']),
      em45: _int(json['em4_5']),
      text50: json['text5_0']?.toString() ?? '',
      text51: json['text5_1']?.toString() ?? '',
      broadcastTextId5: _int(json['BroadcastTextID5']),
      lang5: _int(json['lang5']),
      probability5: _double(json['Probability5']),
      em50: _int(json['em5_0']),
      em51: _int(json['em5_1']),
      em52: _int(json['em5_2']),
      em53: _int(json['em5_3']),
      em54: _int(json['em5_4']),
      em55: _int(json['em5_5']),
      text60: json['text6_0']?.toString() ?? '',
      text61: json['text6_1']?.toString() ?? '',
      broadcastTextId6: _int(json['BroadcastTextID6']),
      lang6: _int(json['lang6']),
      probability6: _double(json['Probability6']),
      em60: _int(json['em6_0']),
      em61: _int(json['em6_1']),
      em62: _int(json['em6_2']),
      em63: _int(json['em6_3']),
      em64: _int(json['em6_4']),
      em65: _int(json['em6_5']),
      text70: json['text7_0']?.toString() ?? '',
      text71: json['text7_1']?.toString() ?? '',
      broadcastTextId7: _int(json['BroadcastTextID7']),
      lang7: _int(json['lang7']),
      probability7: _double(json['Probability7']),
      em70: _int(json['em7_0']),
      em71: _int(json['em7_1']),
      em72: _int(json['em7_2']),
      em73: _int(json['em7_3']),
      em74: _int(json['em7_4']),
      em75: _int(json['em7_5']),
      verifiedBuild: _int(json['VerifiedBuild']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'text0_0': text00,
      'text0_1': text01,
      'BroadcastTextID0': broadcastTextId0,
      'lang0': lang0,
      'Probability0': probability0,
      'em0_0': em00,
      'em0_1': em01,
      'em0_2': em02,
      'em0_3': em03,
      'em0_4': em04,
      'em0_5': em05,
      'text1_0': text10,
      'text1_1': text11,
      'BroadcastTextID1': broadcastTextId1,
      'lang1': lang1,
      'Probability1': probability1,
      'em1_0': em10,
      'em1_1': em11,
      'em1_2': em12,
      'em1_3': em13,
      'em1_4': em14,
      'em1_5': em15,
      'text2_0': text20,
      'text2_1': text21,
      'BroadcastTextID2': broadcastTextId2,
      'lang2': lang2,
      'Probability2': probability2,
      'em2_0': em20,
      'em2_1': em21,
      'em2_2': em22,
      'em2_3': em23,
      'em2_4': em24,
      'em2_5': em25,
      'text3_0': text30,
      'text3_1': text31,
      'BroadcastTextID3': broadcastTextId3,
      'lang3': lang3,
      'Probability3': probability3,
      'em3_0': em30,
      'em3_1': em31,
      'em3_2': em32,
      'em3_3': em33,
      'em3_4': em34,
      'em3_5': em35,
      'text4_0': text40,
      'text4_1': text41,
      'BroadcastTextID4': broadcastTextId4,
      'lang4': lang4,
      'Probability4': probability4,
      'em4_0': em40,
      'em4_1': em41,
      'em4_2': em42,
      'em4_3': em43,
      'em4_4': em44,
      'em4_5': em45,
      'text5_0': text50,
      'text5_1': text51,
      'BroadcastTextID5': broadcastTextId5,
      'lang5': lang5,
      'Probability5': probability5,
      'em5_0': em50,
      'em5_1': em51,
      'em5_2': em52,
      'em5_3': em53,
      'em5_4': em54,
      'em5_5': em55,
      'text6_0': text60,
      'text6_1': text61,
      'BroadcastTextID6': broadcastTextId6,
      'lang6': lang6,
      'Probability6': probability6,
      'em6_0': em60,
      'em6_1': em61,
      'em6_2': em62,
      'em6_3': em63,
      'em6_4': em64,
      'em6_5': em65,
      'text7_0': text70,
      'text7_1': text71,
      'BroadcastTextID7': broadcastTextId7,
      'lang7': lang7,
      'Probability7': probability7,
      'em7_0': em70,
      'em7_1': em71,
      'em7_2': em72,
      'em7_3': em73,
      'em7_4': em74,
      'em7_5': em75,
      'VerifiedBuild': verifiedBuild,
    };
  }

  static int _int(dynamic value) => (value as num?)?.toInt() ?? 0;

  static double _double(dynamic value) => (value as num?)?.toDouble() ?? 0;
}

class BriefNpcTextEntity {
  final int id;
  final String text0;
  final String text1;

  const BriefNpcTextEntity({this.id = 0, this.text0 = '', this.text1 = ''});

  factory BriefNpcTextEntity.fromJson(Map<String, dynamic> json) {
    return BriefNpcTextEntity(
      id: (json['ID'] as num?)?.toInt() ?? (json['id'] as num?)?.toInt() ?? 0,
      text0: json['text0_0']?.toString() ?? '',
      text1: json['text0_1']?.toString() ?? '',
    );
  }

  String get displayText => text0.isNotEmpty ? text0 : text1;

  Map<String, dynamic> toJson() => {
    'ID': id,
    'text0_0': text0,
    'text0_1': text1,
  };
}
