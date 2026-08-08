import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/event/event_bus.dart';
import 'package:foxy/event/entity_written_event.dart';
import 'package:foxy/entity/item_template_entity.dart';
import 'package:foxy_annotation/form_annotations.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/item_template_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'item_template_detail_view_model.g.dart';

@FoxyDetailViewModel(
  flags: {
    'allowableClass',
    'allowableRace',
    'bagFamily',
    'flags',
    'flagsCustom',
    'flagsExtra',
    'scalingStatValue',
    'socketColor1',
    'socketColor2',
    'socketColor3',
  },
  selects: {
    'ammoType',
    'bonding',
    'className',
    'dmgType1',
    'dmgType2',
    'foodType',
    'inventoryType',
    'languageId',
    'material',
    'pageMaterial',
    'quality',
    'requiredReputationRank',
    'sheath',
    'spellTrigger1',
    'spellTrigger2',
    'spellTrigger3',
    'spellTrigger4',
    'spellTrigger5',
    'statType1',
    'statType10',
    'statType2',
    'statType3',
    'statType4',
    'statType5',
    'statType6',
    'statType7',
    'statType8',
    'statType9',
    'subclass',
  },
)
class ItemTemplateDetailViewModel
    with FieldControllerMixin, _ItemTemplateDetailViewModelMixin {
  /// Signals

  bool get hasDisenchantLoot => (entity.value?.disenchantId ?? 0) != 0;

  /// Computed conditions
  bool get hasEnchantment =>
      (entity.value?.randomProperty ?? 0) != 0 ||
      (entity.value?.randomSuffix ?? 0) != 0;

  bool get hasItemLoot => ((entity.value?.flags ?? 0) & 4) != 0;

  bool get hasMillingLoot => ((entity.value?.flags ?? 0) & 536870912) != 0;

  bool get hasProspectingLoot => ((entity.value?.flags ?? 0) & 262144) != 0;
}
