import 'package:signals/signals.dart';
import 'package:foxy/entity/glyph_property_entity.dart';
import 'package:foxy/entity/glyph_property_filter_entity.dart';
import 'package:foxy/repository/glyph_property_repository.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:foxy/util/dialog_util.dart';

class GlyphPropertySelectorViewModel {
  final _repository = GlyphPropertyRepository();

  final idFilter = signal('');
  final items = signal<List<GlyphPropertyEntity>>([]);
  final total = signal(0);
  final page = signal(1);
  final selectedId = signal<int?>(null);

  Future<void> search() async {
    try {
      final filter = GlyphPropertyFilterEntity(id: idFilter.value);
      final items = await _repository.getGlyphProperties(
        filter: filter,
        page: page.value,
      );
      final total = await _repository.countGlyphProperties(filter: filter);
      this.items.value = items;
      this.total.value = total;
    } catch (e) {
      LoggerUtil.instance.e('搜索雕文属性失败: $e');
      DialogUtil.instance.error('搜索雕文属性失败: $e');
    }
  }

  Future<void> paginate(int p) async {
    page.value = p;
    await search();
  }

  void reset() {
    idFilter.value = '';
    page.value = 1;
    search();
  }

  void select(int? id) => selectedId.value = id;

  void dispose() {}
}
