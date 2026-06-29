import 'package:foxy/controller/selector_controller.dart';
import 'package:foxy/entity/page_text_entity.dart';
import 'package:foxy/entity/page_text_filter_entity.dart';
import 'package:foxy/repository/page_text_repository.dart';
import 'package:get_it/get_it.dart';

class PageTextSelectorController extends SelectorController<PageTextEntity> {
  final _repository = GetIt.instance.get<PageTextRepository>();

  String idFilter = '';

  @override
  String get errorLabel => '搜索页面文本失败';

  @override
  Future<void> performSearch() async {
    final filter = PageTextFilterEntity(id: idFilter, text: '');
    final result = await _repository.getPageTexts(filter: filter, page: page);
    final count = await _repository.countPageTexts(filter: filter);
    items = result;
    total = count;
  }

  @override
  void clearFilters() {
    idFilter = '';
  }
}
