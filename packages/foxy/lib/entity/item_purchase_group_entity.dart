import 'package:foxy_annotation/entity_annotations.dart';
import 'package:foxy_annotation/semantic_annotations.dart';

part 'item_purchase_group_entity.g.dart';

@FoxyBriefEntity()
@FoxyFullEntity(table: 'foxy.dbc_item_purchase_group')
class ItemPurchaseGroupEntity with _ItemPurchaseGroupEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyFieldMeaning.reference('物品0', table: 'item_template', column: 'entry')
  @FoxyFullField('ItemID0')
  final int itemID0;

  @FoxyFieldMeaning.reference('物品1', table: 'item_template', column: 'entry')
  @FoxyFullField('ItemID1')
  final int itemID1;

  @FoxyFieldMeaning.reference('物品2', table: 'item_template', column: 'entry')
  @FoxyFullField('ItemID2')
  final int itemID2;

  @FoxyFieldMeaning.reference('物品3', table: 'item_template', column: 'entry')
  @FoxyFullField('ItemID3')
  final int itemID3;

  @FoxyFieldMeaning.reference('物品4', table: 'item_template', column: 'entry')
  @FoxyFullField('ItemID4')
  final int itemID4;

  @FoxyFieldMeaning.reference('物品5', table: 'item_template', column: 'entry')
  @FoxyFullField('ItemID5')
  final int itemID5;

  @FoxyFieldMeaning.reference('物品6', table: 'item_template', column: 'entry')
  @FoxyFullField('ItemID6')
  final int itemID6;

  @FoxyFieldMeaning.reference('物品7', table: 'item_template', column: 'entry')
  @FoxyFullField('ItemID7')
  final int itemID7;

  @FoxyFullField('Name_lang_enUS')
  final String nameLangEnUS;

  @FoxyFullField('Name_lang_koKR')
  final String nameLangKoKR;

  @FoxyFullField('Name_lang_frFR')
  final String nameLangFrFR;

  @FoxyFullField('Name_lang_deDE')
  final String nameLangDeDE;

  @FoxyBriefField()
  @FoxyFullField('Name_lang_zhCN')
  final String nameLangZhCN;

  @FoxyFullField('Name_lang_zhTW')
  final String nameLangZhTW;

  @FoxyFullField('Name_lang_esES')
  final String nameLangEsES;

  @FoxyFullField('Name_lang_esMX')
  final String nameLangEsMX;

  @FoxyFullField('Name_lang_ruRU')
  final String nameLangRuRU;

  @FoxyFullField('Name_lang_jaJP')
  final String nameLangJaJP;

  @FoxyFullField('Name_lang_ptPT')
  final String nameLangPtPT;

  @FoxyFullField('Name_lang_ptBR')
  final String nameLangPtBR;

  @FoxyFullField('Name_lang_itIT')
  final String nameLangItIT;

  @FoxyFullField('Name_lang_unk1')
  final String nameLangUnk1;

  @FoxyFullField('Name_lang_unk2')
  final String nameLangUnk2;

  @FoxyFullField('Name_lang_unk3')
  final String nameLangUnk3;

  @FoxyFullField('Name_lang_Flags')
  final int nameLangFlags;

  const ItemPurchaseGroupEntity({
    this.id = 0,
    this.itemID0 = 0,
    this.itemID1 = 0,
    this.itemID2 = 0,
    this.itemID3 = 0,
    this.itemID4 = 0,
    this.itemID5 = 0,
    this.itemID6 = 0,
    this.itemID7 = 0,
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
  });

  factory ItemPurchaseGroupEntity.fromJson(Map<String, dynamic> json) =>
      _ItemPurchaseGroupEntityMixin.fromJson(json);
}
