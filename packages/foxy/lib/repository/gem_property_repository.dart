import 'package:foxy/entity/gem_property_entity.dart';
import 'package:foxy_annotation/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'gem_property_repository.g.dart';

@FoxyRepository()
@FoxyFilter.text('id')
class GemPropertyRepository with RepositoryMixin, _GemPropertyRepositoryMixin {
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
  Future<int> countGemProperties({GemPropertyFilter? filter}) async {
    return _applyFilter(laconic.table('$_table as gp'), filter).count();
  }

  @override
  Future<GemPropertyEntity> createGemProperty() async {
    return GemPropertyEntity(id: await _getNextId());
  }

  @override
  Future<List<BriefGemPropertyEntity>> getBriefGemProperties({
    int page = 1,
    GemPropertyFilter? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table('$_table as gp');
    const fields = [
      'gp.ID',
      'gp.Enchant_ID',
      'gp.Maxcount_inv',
      'gp.Maxcount_item',
      'gp.Type',
      'sie.Name_lang_enUS as enchantName',
      'sie.Name_lang_zhCN as localeEnchantName',
    ];
    builder = builder.select(fields);
    builder = builder.leftJoin(
      'foxy.dbc_spell_item_enchantment as sie',
      (join) => join.on('gp.Enchant_ID', 'sie.ID'),
    );
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('gp.ID');
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results.map((e) => BriefGemPropertyEntity.fromJson(e.toMap())).toList();
  }

  @override
  QueryBuilder _applyFilter(QueryBuilder builder, GemPropertyFilter? filter) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('gp.ID', filter.id);
    }
    return builder;
  }

  Future<int> _getNextId() async {
    final id = await nextMaxPlusOne(_table, 'ID');
    if (id > 0x7fffffff) {
      throw IdExhaustedException('GemProperties ID exceeds DBC int32 range');
    }
    return id;
  }
}
