import 'package:foxy/controller/selector_controller.dart';
import 'package:foxy/entity/emote_text_entity.dart';
import 'package:foxy/entity/emote_text_filter_entity.dart';
import 'package:foxy/repository/emote_text_repository.dart';
import 'package:get_it/get_it.dart';

class EmoteSelectorController extends SelectorController<EmoteTextEntity> {
  final _repository = GetIt.instance.get<EmoteTextRepository>();

  String idFilter = '';
  String nameFilter = '';

  @override
  String get errorLabel => '搜索表情失败';

  @override
  Future<void> performSearch() async {
    final filter = EmoteTextFilterEntity(id: idFilter, name: nameFilter);
    final result = await _repository.getEmoteTexts(filter: filter, page: page);
    final count = await _repository.countEmoteTexts(filter: filter);
    items = result;
    total = count;
  }

  @override
  void clearFilters() {
    idFilter = '';
    nameFilter = '';
  }
}
