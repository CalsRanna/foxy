import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'npc_text_entity.g.dart';

@FoxyBriefEntity()
@FoxyBriefField.text('text0')
@FoxyBriefField.text('text1')
@FoxyFullEntity(table: 'npc_text')
class NpcTextEntity with _NpcTextEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyFullField('text0_0')
  final String text00;

  @FoxyFullField('text0_1')
  final String text01;

  @FoxyFullField('BroadcastTextID0')
  final int broadcastTextId0;

  @FoxyFullField('lang0')
  final int lang0;

  @FoxyFullField('Probability0')
  final double probability0;

  @FoxyFullField('em0_0')
  final int em00;

  @FoxyFullField('em0_1')
  final int em01;

  @FoxyFullField('em0_2')
  final int em02;

  @FoxyFullField('em0_3')
  final int em03;

  @FoxyFullField('em0_4')
  final int em04;

  @FoxyFullField('em0_5')
  final int em05;

  @FoxyFullField('text1_0')
  final String text10;

  @FoxyFullField('text1_1')
  final String text11;

  @FoxyFullField('BroadcastTextID1')
  final int broadcastTextId1;

  @FoxyFullField('lang1')
  final int lang1;

  @FoxyFullField('Probability1')
  final double probability1;

  @FoxyFullField('em1_0')
  final int em10;

  @FoxyFullField('em1_1')
  final int em11;

  @FoxyFullField('em1_2')
  final int em12;

  @FoxyFullField('em1_3')
  final int em13;

  @FoxyFullField('em1_4')
  final int em14;

  @FoxyFullField('em1_5')
  final int em15;

  @FoxyFullField('text2_0')
  final String text20;

  @FoxyFullField('text2_1')
  final String text21;

  @FoxyFullField('BroadcastTextID2')
  final int broadcastTextId2;

  @FoxyFullField('lang2')
  final int lang2;

  @FoxyFullField('Probability2')
  final double probability2;

  @FoxyFullField('em2_0')
  final int em20;

  @FoxyFullField('em2_1')
  final int em21;

  @FoxyFullField('em2_2')
  final int em22;

  @FoxyFullField('em2_3')
  final int em23;

  @FoxyFullField('em2_4')
  final int em24;

  @FoxyFullField('em2_5')
  final int em25;

  @FoxyFullField('text3_0')
  final String text30;

  @FoxyFullField('text3_1')
  final String text31;

  @FoxyFullField('BroadcastTextID3')
  final int broadcastTextId3;

  @FoxyFullField('lang3')
  final int lang3;

  @FoxyFullField('Probability3')
  final double probability3;

  @FoxyFullField('em3_0')
  final int em30;

  @FoxyFullField('em3_1')
  final int em31;

  @FoxyFullField('em3_2')
  final int em32;

  @FoxyFullField('em3_3')
  final int em33;

  @FoxyFullField('em3_4')
  final int em34;

  @FoxyFullField('em3_5')
  final int em35;

  @FoxyFullField('text4_0')
  final String text40;

  @FoxyFullField('text4_1')
  final String text41;

  @FoxyFullField('BroadcastTextID4')
  final int broadcastTextId4;

  @FoxyFullField('lang4')
  final int lang4;

  @FoxyFullField('Probability4')
  final double probability4;

  @FoxyFullField('em4_0')
  final int em40;

  @FoxyFullField('em4_1')
  final int em41;

  @FoxyFullField('em4_2')
  final int em42;

  @FoxyFullField('em4_3')
  final int em43;

  @FoxyFullField('em4_4')
  final int em44;

  @FoxyFullField('em4_5')
  final int em45;

  @FoxyFullField('text5_0')
  final String text50;

  @FoxyFullField('text5_1')
  final String text51;

  @FoxyFullField('BroadcastTextID5')
  final int broadcastTextId5;

  @FoxyFullField('lang5')
  final int lang5;

  @FoxyFullField('Probability5')
  final double probability5;

  @FoxyFullField('em5_0')
  final int em50;

  @FoxyFullField('em5_1')
  final int em51;

  @FoxyFullField('em5_2')
  final int em52;

  @FoxyFullField('em5_3')
  final int em53;

  @FoxyFullField('em5_4')
  final int em54;

  @FoxyFullField('em5_5')
  final int em55;

  @FoxyFullField('text6_0')
  final String text60;

  @FoxyFullField('text6_1')
  final String text61;

  @FoxyFullField('BroadcastTextID6')
  final int broadcastTextId6;

  @FoxyFullField('lang6')
  final int lang6;

  @FoxyFullField('Probability6')
  final double probability6;

  @FoxyFullField('em6_0')
  final int em60;

  @FoxyFullField('em6_1')
  final int em61;

  @FoxyFullField('em6_2')
  final int em62;

  @FoxyFullField('em6_3')
  final int em63;

  @FoxyFullField('em6_4')
  final int em64;

  @FoxyFullField('em6_5')
  final int em65;

  @FoxyFullField('text7_0')
  final String text70;

  @FoxyFullField('text7_1')
  final String text71;

  @FoxyFullField('BroadcastTextID7')
  final int broadcastTextId7;

  @FoxyFullField('lang7')
  final int lang7;

  @FoxyFullField('Probability7')
  final double probability7;

  @FoxyFullField('em7_0')
  final int em70;

  @FoxyFullField('em7_1')
  final int em71;

  @FoxyFullField('em7_2')
  final int em72;

  @FoxyFullField('em7_3')
  final int em73;

  @FoxyFullField('em7_4')
  final int em74;

  @FoxyFullField('em7_5')
  final int em75;

  @FoxyFullField('VerifiedBuild')
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

  factory NpcTextEntity.fromJson(Map<String, dynamic> json) =>
      _NpcTextEntityMixin.fromJson(json);
}

extension BriefNpcTextEntityDisplay on BriefNpcTextEntity {
  String get displayText => text0.isNotEmpty ? text0 : text1;
}
