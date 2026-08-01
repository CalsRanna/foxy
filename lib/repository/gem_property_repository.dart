import 'package:foxy/entity/gem_property_entity.dart';
import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'gem_property_repository.g.dart';

@FoxyRepository(GemPropertyEntity)
@FoxyFilter.text('id')
class GemPropertyRepository with RepositoryMixin, _GemPropertyRepositoryMixin {
  static const _table = 'foxy.dbc_gem_properties';

  @override
  Future<int> copyGemProperty(int key) async {
    final source = await getGemProperty(key);
    if (source == null) {
      throw StateError('原宝石属性不存在，可能已被其他操作修改或删除');
    }
    final copied = source.copyWith(id: await _getNextId());
    await storeGemProperty(copied);
    return copied.id;
  }

  @override
  Future<GemPropertyEntity> createGemProperty() async {
    return GemPropertyEntity(id: await _getNextId());
  }

  Future<int> _getNextId() async {
    final id = await nextMaxPlusOne(_table, 'ID');
    if (id > 0x7fffffff) {
      throw StateError('GemProperties ID 已超出 DBC int32 范围');
    }
    return id;
  }
}
