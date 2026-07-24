import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'gossip_menu_option_entity.g.dart';

/// gossip_menu_option 模型（复合键: MenuID + OptionID）。

@FoxyBriefEntity()
@FoxyBriefField.text('localeOptionText')
@FoxyFullEntity(table: 'gossip_menu_option')
class GossipMenuOptionEntity with _GossipMenuOptionEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('MenuID', key: true)
  final int menuId;

  @FoxyBriefField()
  @FoxyFullField('OptionID', key: true)
  final int optionId;

  @FoxyBriefField()
  @FoxyFullField('OptionIcon')
  final int optionIcon;

  @FoxyBriefField()
  @FoxyFullField('OptionText')
  final String optionText;

  @FoxyFullField('OptionBroadcastTextID')
  final int optionBroadcastTextId;

  @FoxyBriefField()
  @FoxyFullField('OptionType')
  final int optionType;

  @FoxyBriefField()
  @FoxyFullField('OptionNpcFlag')
  final int optionNpcFlag;

  @FoxyFullField('BoxCoded')
  final int boxCoded;

  @FoxyFullField('BoxMoney')
  final int boxMoney;

  @FoxyFullField('BoxText')
  final String boxText;

  @FoxyFullField('BoxBroadcastTextID')
  final int boxBroadcastTextId;

  @FoxyBriefField()
  @FoxyFullField('ActionMenuID')
  final int actionMenuId;

  @FoxyFullField('ActionPoiID')
  final int actionPoiId;

  @FoxyFullField('VerifiedBuild')
  final int verifiedBuild;

  const GossipMenuOptionEntity({
    this.menuId = 0,
    this.optionId = 0,
    this.optionIcon = 0,
    this.optionText = '',
    this.optionBroadcastTextId = 0,
    this.optionType = 0,
    this.optionNpcFlag = 0,
    this.boxCoded = 0,
    this.boxMoney = 0,
    this.boxText = '',
    this.boxBroadcastTextId = 0,
    this.actionMenuId = 0,
    this.actionPoiId = 0,
    this.verifiedBuild = 0,
  });

  factory GossipMenuOptionEntity.fromJson(Map<String, dynamic> json) =>
      _GossipMenuOptionEntityMixin.fromJson(json);
}

extension BriefGossipMenuOptionEntityDisplay on BriefGossipMenuOptionEntity {
  String get displayText =>
      localeOptionText.isNotEmpty ? localeOptionText : optionText;
}
