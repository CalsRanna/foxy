// ignore_for_file: annotate_overrides

import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'gossip_menu_option_locale_entity.g.dart';

/// gossip_menu_option_locale 本地化模型
/// 复合键: MenuID + OptionID + Locale

@FoxyBriefEntity()
@FoxyFullEntity(table: 'gossip_menu_option_locale')
class GossipMenuOptionLocaleEntity with _GossipMenuOptionLocaleEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('MenuID', key: true)
  final int menuId;

  @FoxyBriefField()
  @FoxyFullField('OptionID', key: true)
  final int optionId;

  @FoxyBriefField()
  @FoxyFullField('Locale', key: true)
  final String locale;

  @FoxyBriefField()
  @FoxyFullField('OptionText')
  final String optionText;

  @FoxyFullField('BoxText')
  final String boxText;

  const GossipMenuOptionLocaleEntity({
    this.menuId = 0,
    this.optionId = 0,
    this.locale = 'zhCN',
    this.optionText = '',
    this.boxText = '',
  });

  factory GossipMenuOptionLocaleEntity.fromJson(Map<String, dynamic> json) =>
      _GossipMenuOptionLocaleEntityMixin.fromJson(json);
}
