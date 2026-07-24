import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/entity/gem_property_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'gem_property_repository.g.dart';

@FoxyRepository(GemPropertyEntity)
@FoxyFilter.text('id')
class GemPropertyRepository with RepositoryMixin, _GemPropertyRepositoryMixin {
  static const _table = 'foxy.dbc_gem_properties';

  Future<int> copyGemProperty(int key) async {
    final source = await getGemProperty(key);
    if (source == null) {
      throw StateError('原宝石属性不存在，可能已被其他操作修改或删除');
    }
    final copied = source.copyWith(id: await _getNextId());
    await storeGemProperty(copied);
    return copied.id;
  }

  Future<int> countGemProperties({GemPropertyFilter? filter}) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<GemPropertyEntity> createGemProperty() async {
    return GemPropertyEntity(id: await _getNextId());
  }

  Future<List<BriefGemPropertyEntity>> getBriefGemProperties({
    int page = 1,
    GemPropertyFilter? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    const fields = [
      'ID',
      'Enchant_ID',
      'Maxcount_inv',
      'Maxcount_item',
      'Type',
    ];
    builder = builder.select(fields);
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('ID');
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results
        .map((e) => BriefGemPropertyEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<List<GemPropertyEntity>> getGemProperties() async {
    var results = await laconic.table(_table).get();
    return results.map((e) => GemPropertyEntity.fromJson(e.toMap())).toList();
  }

  QueryBuilder _applyFilter(QueryBuilder builder, GemPropertyFilter? filter) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('ID', filter.id);
    }
    return builder;
  }

  Future<int> _getNextId() async {
    final id = await nextMaxPlusOne(_table, 'ID');
    if (id > 0x7fffffff) {
      throw StateError('GemProperties ID 已超出 DBC int32 范围');
    }
    return id;
  }
}
