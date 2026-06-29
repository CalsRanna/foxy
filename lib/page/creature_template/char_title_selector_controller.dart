import 'package:foxy/controller/selector_controller.dart';
import 'package:foxy/entity/char_title_entity.dart';
import 'package:foxy/repository/char_title_repository.dart';
import 'package:get_it/get_it.dart';

class CharTitleSelectorController extends SelectorController<CharTitleEntity> {
  final _repository = GetIt.instance.get<CharTitleRepository>();

  String idFilter = '';
  String nameFilter = '';

  @override
  String get errorLabel => '搜索称号失败';

  @override
  Future<void> performSearch() async {
    final id = idFilter.isEmpty ? null : idFilter;
    final name = nameFilter.isEmpty ? null : nameFilter;
    final result = await _repository.getCharTitles(id: id, name: name, page: page);
    final count = await _repository.countCharTitles(id: id, name: name);
    items = result;
    total = count;
  }

  @override
  void clearFilters() {
    idFilter = '';
    nameFilter = '';
  }
}
