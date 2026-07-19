import 'package:foxy/entity/gossip_menu_key.dart';

class BriefGossipMenuEntity {
  final int menuId;
  final int textId;
  final String text00;
  final String text01;
  final String textLocale00;
  final String textLocale01;

  const BriefGossipMenuEntity({
    this.menuId = 0,
    this.textId = 0,
    this.text00 = '',
    this.text01 = '',
    this.textLocale00 = '',
    this.textLocale01 = '',
  });

  factory BriefGossipMenuEntity.fromJson(Map<String, dynamic> json) {
    return BriefGossipMenuEntity(
      menuId: json['MenuID'] ?? json['menuid'] ?? 0,
      textId: json['TextID'] ?? json['textid'] ?? 0,
      text00: json['text0_0']?.toString() ?? '',
      text01: json['text0_1']?.toString() ?? '',
      textLocale00: json['Text0_0']?.toString() ?? '',
      textLocale01: json['Text0_1']?.toString() ?? '',
    );
  }

  String get text {
    if (textLocale00.isNotEmpty) return textLocale00;
    if (textLocale01.isNotEmpty) return textLocale01;
    if (text00.isNotEmpty) return text00;
    if (text01.isNotEmpty) return text01;
    return '';
  }

  GossipMenuKey get key => GossipMenuKey(menuId: menuId, textId: textId);
}
