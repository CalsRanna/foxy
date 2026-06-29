import 'package:foxy/controller/selector_controller.dart';
import 'package:foxy/entity/item_enchantment_template_entity.dart';
import 'package:foxy/repository/item_enchantment_template_repository.dart';
import 'package:get_it/get_it.dart';

class ItemEnchantmentTemplateSelectorController extends SelectorController<BriefItemEnchantmentTemplateEntity> {
  final _repository = GetIt.instance.get<ItemEnchantmentTemplateRepository>();

  String idFilter = '';
  String nameFilter = '';

  @override
  String get errorLabel => '搜索附魔失败';

  @override
  Future<void> performSearch() async {
    final entry = idFilter.isEmpty ? null : idFilter;
    final result = await _repository.getItemEnchantmentTemplates(entry: entry, page: page);
    final count = await _repository.countItemEnchantmentTemplates(entry: entry);
    items = result;
    total = count;
  }

  @override
  void clearFilters() {
    idFilter = '';
    nameFilter = '';
  }
}
