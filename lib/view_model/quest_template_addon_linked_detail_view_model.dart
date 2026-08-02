import 'package:foxy/entity/quest_template_addon_entity.dart';
import 'package:foxy/infrastructure/codegen/form_annotations.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/quest_template_addon_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'quest_template_addon_linked_detail_view_model.g.dart';

@FoxyLinkedDetailViewModel(
  entity: QuestTemplateAddonEntity,
  repository: QuestTemplateAddonRepository,
  flags: {'allowableClasses', 'specialFlags'},
)
class QuestTemplateAddonLinkedDetailViewModel
    with FieldControllerMixin, _QuestTemplateAddonLinkedDetailViewModelMixin {}
