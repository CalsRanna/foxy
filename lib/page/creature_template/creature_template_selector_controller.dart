import 'package:foxy/controller/selector_controller.dart';
import 'package:foxy/entity/creature_template_entity.dart';
import 'package:foxy/entity/creature_template_filter_entity.dart';
import 'package:foxy/repository/creature_template_repository.dart';
import 'package:get_it/get_it.dart';

class CreatureTemplateSelectorController extends SelectorController<BriefCreatureTemplateEntity> {
  final _repository = GetIt.instance.get<CreatureTemplateRepository>();

  String entryFilter = '';
  String nameFilter = '';

  @override
  String get errorLabel => '搜索生物模板失败';

  @override
  Future<void> performSearch() async {
    final filter = CreatureTemplateFilterEntity(entry: entryFilter, name: nameFilter);
    final result = await _repository.getBriefCreatureTemplates(page: page, filter: filter);
    final count = await _repository.countCreatureTemplates(filter: filter);
    items = result;
    total = count;
  }

  @override
  void clearFilters() {
    entryFilter = '';
    nameFilter = '';
  }
}
