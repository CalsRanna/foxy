import 'package:foxy/controller/selector_controller.dart';
import 'package:foxy/entity/npc_text_entity.dart';
import 'package:foxy/repository/npc_text_repository.dart';
import 'package:get_it/get_it.dart';

class NpcTextSelectorController extends SelectorController<NpcTextEntity> {
  final _repository = GetIt.instance.get<NpcTextRepository>();

  String idFilter = '';
  String textFilter = '';

  @override
  String get errorLabel => '搜索NPC文本失败';

  @override
  Future<void> performSearch() async {
    final id = idFilter.isEmpty ? null : idFilter;
    final text = textFilter.isEmpty ? null : textFilter;
    final result = await _repository.getNpcTextsPaginated(id: id, text: text, page: page);
    final count = await _repository.countNpcTexts(id: id, text: text);
    items = result;
    total = count;
  }

  @override
  void clearFilters() {
    idFilter = '';
    textFilter = '';
  }
}
