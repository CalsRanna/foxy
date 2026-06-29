import 'package:foxy/controller/selector_controller.dart';
import 'package:foxy/entity/item_display_info_entity.dart';
import 'package:foxy/repository/item_display_info_repository.dart';
import 'package:get_it/get_it.dart';

class ItemDisplayInfoSelectorController extends SelectorController<ItemDisplayInfoEntity> {
  final _repository = GetIt.instance.get<ItemDisplayInfoRepository>();

  String idFilter = '';
  String nameFilter = '';

  @override
  String get errorLabel => '搜索显示信息失败';

  @override
  Future<void> performSearch() async {
    final id = idFilter.isEmpty ? null : idFilter;
    final name = nameFilter.isEmpty ? null : nameFilter;
    final result = await _repository.getItemDisplayInfos(id: id, name: name, page: page);
    final count = await _repository.countItemDisplayInfos(id: id, name: name);
    items = result;
    total = count;
  }

  @override
  void clearFilters() {
    idFilter = '';
    nameFilter = '';
  }
}
