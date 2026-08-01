import 'package:foxy/entity/glyph_property_entity.dart';
import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'glyph_property_repository.g.dart';

@FoxyRepository(GlyphPropertyEntity)
@FoxyFilter.text('id')
class GlyphPropertyRepository
    with RepositoryMixin, _GlyphPropertyRepositoryMixin {
  static const _table = 'foxy.dbc_glyph_properties';

  @override
  Future<int> copyGlyphProperty(int key) async {
    final source = await getGlyphProperty(key);
    if (source == null) {
      throw StateError('原雕文属性不存在，可能已被其他操作修改或删除');
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
      throw StateError('GlyphProperties ID 已超出角色数据和客户端协议的 uint16 范围');
    }
    return id;
  }
}
