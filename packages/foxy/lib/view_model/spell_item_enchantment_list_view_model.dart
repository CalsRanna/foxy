import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/spell_item_enchantment_entity.dart';
import 'package:foxy_annotation/list_annotations.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/spell_item_enchantment_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/query_version_mixin.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'spell_item_enchantment_list_view_model.g.dart';

@FoxyListViewModel(entity: SpellItemEnchantmentEntity, repository: SpellItemEnchantmentRepository)
class SpellItemEnchantmentListViewModel
    with
        FieldControllerMixin,
        QueryVersionMixin,
        _SpellItemEnchantmentListViewModelMixin {
  @override
  void _logActivity(ActivityActionType action, int key) {
    final items = this.items.value;
    final enchantment = items.where((e) => e.key == key).firstOrNull;
    final name = enchantment?.nameLangZhCN ?? '';
    final log = ActivityLogEntity(
      module: 'spell_item_enchantment',
      actionType: action,
      entityName: name,
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogService>().recordBestEffort(log);
  }
}
