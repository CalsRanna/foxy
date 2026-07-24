import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'gossip_menu_entity.g.dart';

/// gossip_menu 主表模型（复合键: MenuID + TextID）。

@FoxyBriefEntity()
@FoxyBriefField.text('text00')
@FoxyBriefField.text('text01')
@FoxyBriefField.text('textLocale00')
@FoxyBriefField.text('textLocale01')
@FoxyFullEntity(table: 'gossip_menu')
class GossipMenuEntity with _GossipMenuEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('MenuID', key: true)
  final int menuId;

  @FoxyBriefField()
  @FoxyFullField('TextID', key: true)
  final int textId;

  const GossipMenuEntity({this.menuId = 0, this.textId = 0});

  factory GossipMenuEntity.fromJson(Map<String, dynamic> json) =>
      _GossipMenuEntityMixin.fromJson(json);
}

extension BriefGossipMenuEntityDisplay on BriefGossipMenuEntity {
  String get text {
    if (textLocale00.isNotEmpty) return textLocale00;
    if (textLocale01.isNotEmpty) return textLocale01;
    if (text00.isNotEmpty) return text00;
    if (text01.isNotEmpty) return text01;
    return '';
  }
}
