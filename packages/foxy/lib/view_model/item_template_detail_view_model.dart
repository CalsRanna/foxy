import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/item_template_entity.dart';
import 'package:foxy_annotation/form_annotations.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/item_template_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'item_template_detail_view_model.g.dart';

@FoxyDetailViewModel(
  entity: ItemTemplateEntity,
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
    'ammoType': 0,
    'bonding': 0,
    'className': 0,
    'dmgType1': 0,
    'dmgType2': 0,
    'foodType': 0,
    'inventoryType': 0,
    'languageId': 0,
    'material': 0,
    'pageMaterial': 0,
    'quality': 0,
    'requiredReputationRank': 0,
    'sheath': 0,
    'spellTrigger1': 0,
    'spellTrigger2': 0,
    'spellTrigger3': 0,
    'spellTrigger4': 0,
    'spellTrigger5': 0,
    'statType1': 0,
    'statType10': 0,
    'statType2': 0,
    'statType3': 0,
    'statType4': 0,
    'statType5': 0,
    'statType6': 0,
    'statType7': 0,
    'statType8': 0,
    'statType9': 0,
    'subclass': 0,
  },
  repository: ItemTemplateRepository,
)
class ItemTemplateDetailViewModel
    with FieldControllerMixin, _ItemTemplateDetailViewModelMixin {
  final _activityLogService = GetIt.instance.get<ActivityLogService>();

  /// Signals

  bool get hasDisenchantLoot => (entity.value?.disenchantId ?? 0) != 0;

  /// Computed conditions
  bool get hasEnchantment =>
      (entity.value?.randomProperty ?? 0) != 0 ||
      (entity.value?.randomSuffix ?? 0) != 0;

  bool get hasItemLoot => ((entity.value?.flags ?? 0) & 4) != 0;

  bool get hasMillingLoot => ((entity.value?.flags ?? 0) & 536870912) != 0;

  bool get hasProspectingLoot => ((entity.value?.flags ?? 0) & 262144) != 0;

  @override
  void _logActivity(
    ActivityActionType action,
    ItemTemplateEntity itemTemplate,
  ) {
    final log = ActivityLogEntity(
      module: 'item_template',
      actionType: action,
      entityName: itemTemplate.name,
      createdAt: DateTime.now(),
    );
    _activityLogService.recordBestEffort(log);
  }
}
