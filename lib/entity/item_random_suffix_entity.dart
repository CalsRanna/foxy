// ignore_for_file: annotate_overrides

import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'item_random_suffix_entity.g.dart';

@FoxyBriefEntity()
@FoxyFullEntity(table: 'foxy.dbc_item_random_suffix')
class ItemRandomSuffixEntity with _ItemRandomSuffixEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('ID', key: true)
  final int id;

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

  @FoxyBriefField()
  @FoxyFullField('InternalName')
  final String internalName;

  @FoxyFullField('Enchantment0')
  final int enchantment0;

  @FoxyFullField('Enchantment1')
  final int enchantment1;

  @FoxyFullField('Enchantment2')
  final int enchantment2;

  @FoxyFullField('Enchantment3')
  final int enchantment3;

  @FoxyFullField('Enchantment4')
  final int enchantment4;

  @FoxyFullField('AllocationPct0')
  final int allocationPct0;

  @FoxyFullField('AllocationPct1')
  final int allocationPct1;

  @FoxyFullField('AllocationPct2')
  final int allocationPct2;

  @FoxyFullField('AllocationPct3')
  final int allocationPct3;

  @FoxyFullField('AllocationPct4')
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

  factory ItemRandomSuffixEntity.fromJson(Map<String, dynamic> json) =>
      _ItemRandomSuffixEntityMixin.fromJson(json);
}
