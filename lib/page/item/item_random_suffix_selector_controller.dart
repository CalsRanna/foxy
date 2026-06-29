import 'package:foxy/controller/selector_controller.dart';
import 'package:foxy/entity/item_random_suffix_entity.dart';
import 'package:foxy/repository/item_random_suffix_repository.dart';
import 'package:get_it/get_it.dart';

class ItemRandomSuffixSelectorController extends SelectorController<ItemRandomSuffixEntity> {
  final _repository = GetIt.instance.get<ItemRandomSuffixRepository>();

  String idFilter = '';
  String nameFilter = '';

  @override
  String get errorLabel => '搜索随机后缀失败';

  @override
  Future<void> performSearch() async {
    final id = idFilter.isEmpty ? null : idFilter;
    final name = nameFilter.isEmpty ? null : nameFilter;
    final result = await _repository.getItemRandomSuffixes(id: id, name: name, page: page);
    final count = await _repository.countItemRandomSuffixes(id: id, name: name);
    items = result;
    total = count;
  }

  @override
  void clearFilters() {
    idFilter = '';
    nameFilter = '';
  }
}
