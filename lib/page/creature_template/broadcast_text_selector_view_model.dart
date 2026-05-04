import 'package:signals/signals.dart';
import 'package:foxy/entity/broadcast_text_entity.dart';
import 'package:foxy/repository/broadcast_text_repository.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:foxy/util/dialog_util.dart';

class BroadcastTextSelectorViewModel {
  final _repository = BroadcastTextRepository();

  final idFilter = signal('');
  final textFilter = signal('');
  final items = signal<List<BroadcastTextEntity>>([]);
  final total = signal(0);
  final page = signal(1);
  final selectedId = signal<int?>(null);

  Future<void> search() async {
    try {
      final id = idFilter.value.isEmpty ? null : idFilter.value;
      final text = textFilter.value.isEmpty ? null : textFilter.value;
      final result = await _repository.getBroadcastTexts(
        id: id,
        text: text,
        page: page.value,
      );
      final count = await _repository.countBroadcastTexts(id: id, text: text);
      items.value = result;
      total.value = count;
    } catch (e) {
      LoggerUtil.instance.e('搜索广播文本失败: $e');
      DialogUtil.instance.error('搜索广播文本失败: $e');
    }
  }

  Future<void> paginate(int p) async {
    page.value = p;
    await search();
  }

  void reset() {
    idFilter.value = '';
    textFilter.value = '';
    page.value = 1;
    search();
  }

  void select(int? id) => selectedId.value = id;

  void dispose() {}
}
