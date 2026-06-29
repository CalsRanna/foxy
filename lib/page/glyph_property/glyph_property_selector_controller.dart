import 'package:foxy/controller/selector_controller.dart';
import 'package:foxy/entity/glyph_property_entity.dart';
import 'package:foxy/entity/glyph_property_filter_entity.dart';
import 'package:foxy/repository/glyph_property_repository.dart';
import 'package:get_it/get_it.dart';

class GlyphPropertySelectorController extends SelectorController<GlyphPropertyEntity> {
  final _repository = GetIt.instance.get<GlyphPropertyRepository>();

  String idFilter = '';

  @override
  String get errorLabel => '搜索雕文属性失败';

  @override
  Future<void> performSearch() async {
    final filter = GlyphPropertyFilterEntity(id: idFilter);
    final result = await _repository.getGlyphProperties(filter: filter, page: page);
    final count = await _repository.countGlyphProperties(filter: filter);
    items = result;
    total = count;
  }

  @override
  void clearFilters() {
    idFilter = '';
  }
}
