import 'package:foxy/entity/glyph_property_entity.dart';
import 'package:foxy_annotation/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'glyph_property_repository.g.dart';

@FoxyRepository()
@FoxyFilter.text('id')
class GlyphPropertyRepository
    with RepositoryMixin, _GlyphPropertyRepositoryMixin {
  @override
  Future<int> copyGlyphProperty(int key) async {
    final source = await getGlyphProperty(key);
    if (source == null) {
      throw RecordNotFoundException('record not found');
    }
    final copied = source.copyWith(id: await _getNextId());
    await storeGlyphProperty(copied);
    return copied.id;
  }

  @override
  Future<GlyphPropertyEntity> createGlyphProperty() async {
    return GlyphPropertyEntity(id: await _getNextId());
  }

  Future<int> _getNextId() async {
    final id = await nextMaxPlusOne(_table, 'ID');
    if (id > 0xffff) {
      throw IdExhaustedException(
        'GlyphProperties ID exceeds the uint16 range of character data and client protocol',
      );
    }
    return id;
  }
}
