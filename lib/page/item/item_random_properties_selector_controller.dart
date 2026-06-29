import 'package:foxy/controller/selector_controller.dart';
import 'package:foxy/entity/item_random_properties_entity.dart';
import 'package:foxy/repository/item_random_properties_repository.dart';
import 'package:get_it/get_it.dart';

class ItemRandomPropertiesSelectorController extends SelectorController<ItemRandomPropertiesEntity> {
  final _repository = GetIt.instance.get<ItemRandomPropertiesRepository>();

  String idFilter = '';
  String nameFilter = '';

  @override
  String get errorLabel => '搜索随机属性失败';

  @override
  Future<void> performSearch() async {
    final id = idFilter.isEmpty ? null : idFilter;
    final name = nameFilter.isEmpty ? null : nameFilter;
    final result = await _repository.getItemRandomProperties(id: id, name: name, page: page);
    final count = await _repository.countItemRandomProperties(id: id, name: name);
    items = result;
    total = count;
  }

  @override
  void clearFilters() {
    idFilter = '';
    nameFilter = '';
  }
}
