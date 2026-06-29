import 'package:foxy/controller/selector_controller.dart';
import 'package:foxy/entity/broadcast_text_entity.dart';
import 'package:foxy/repository/broadcast_text_repository.dart';
import 'package:get_it/get_it.dart';

class BroadcastTextSelectorController extends SelectorController<BroadcastTextEntity> {
  final _repository = GetIt.instance.get<BroadcastTextRepository>();

  String idFilter = '';
  String textFilter = '';

  @override
  String get errorLabel => '搜索广播文本失败';

  @override
  Future<void> performSearch() async {
    final id = idFilter.isEmpty ? null : idFilter;
    final text = textFilter.isEmpty ? null : textFilter;
    final result = await _repository.getBroadcastTexts(id: id, text: text, page: page);
    final count = await _repository.countBroadcastTexts(id: id, text: text);
    items = result;
    total = count;
  }

  @override
  void clearFilters() {
    idFilter = '';
    textFilter = '';
  }
}
