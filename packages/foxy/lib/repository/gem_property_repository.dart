import 'package:foxy/entity/gem_property_entity.dart';
import 'package:foxy_annotation/repository_annotations.dart';
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
      throw RecordNotFoundException('record not found');
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
      throw IdExhaustedException('GemProperties ID exceeds DBC int32 range');
    }
    return id;
  }
}
