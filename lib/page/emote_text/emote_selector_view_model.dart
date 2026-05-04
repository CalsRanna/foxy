import 'package:signals/signals.dart';
import 'package:foxy/entity/emote_text_entity.dart';
import 'package:foxy/entity/emote_text_filter_entity.dart';
import 'package:foxy/repository/emote_text_repository.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:foxy/util/dialog_util.dart';

class EmoteSelectorViewModel {
  final _repository = EmoteTextRepository();

  final idFilter = signal('');
  final nameFilter = signal('');
  final items = signal<List<EmoteTextEntity>>([]);
  final total = signal(0);
  final page = signal(1);
  final selectedId = signal<int?>(null);

  Future<void> search() async {
    try {
      final filter = EmoteTextFilterEntity(
        id: idFilter.value,
        name: nameFilter.value,
      );
      final items = await _repository.getEmoteTexts(filter: filter, page: page.value);
      final total = await _repository.countEmoteTexts(filter: filter);
      this.items.value = items;
      this.total.value = total;
    } catch (e) {
      LoggerUtil.instance.e('搜索表情失败: $e');
      DialogUtil.instance.error('搜索表情失败: $e');
    }
  }

  Future<void> paginate(int p) async {
    page.value = p;
    await search();
  }

  void reset() {
    idFilter.value = '';
    nameFilter.value = '';
    page.value = 1;
    search();
  }

  void select(int? id) => selectedId.value = id;

  void dispose() {}
}
