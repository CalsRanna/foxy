import 'package:foxy/controller/selector_controller.dart';
import 'package:foxy/entity/item_extended_cost_entity.dart';
import 'package:foxy/entity/item_extended_cost_filter_entity.dart';
import 'package:foxy/repository/item_extended_cost_repository.dart';
import 'package:get_it/get_it.dart';

class ItemExtendedCostSelectorController extends SelectorController<ItemExtendedCostEntity> {
  final _repository = GetIt.instance.get<ItemExtendedCostRepository>();

  String idFilter = '';

  @override
  String get errorLabel => '搜索扩展价格失败';

  @override
  Future<void> performSearch() async {
    final filter = ItemExtendedCostFilterEntity(id: idFilter);
    final result = await _repository.getItemExtendedCosts(filter: filter, page: page);
    final count = await _repository.countItemExtendedCosts(filter: filter);
    items = result;
    total = count;
  }

  @override
  void clearFilters() {
    idFilter = '';
  }
}
