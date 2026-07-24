import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/entity/spell_icon_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'spell_icon_repository.g.dart';

@FoxyRepository(SpellIconEntity)
@FoxyFilter.text('id')
@FoxyFilter.text('name')
class SpellIconRepository with RepositoryMixin, _SpellIconRepositoryMixin {
  static const _table = 'foxy.dbc_spell_icon';

  Future<int> copySpellIcon(int key) async {
    final source = await getSpellIcon(key);
    if (source == null) {
      throw StateError('原法术图标不存在，可能已被其他操作修改或删除');
    }
    final copied = source.copyWith(id: await nextMaxPlusOne(_table, 'ID'));
    await storeSpellIcon(copied);
    return copied.id;
  }

  Future<int> countSpellIcons({SpellIconFilter? filter}) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<SpellIconEntity> createSpellIcon() async {
    return SpellIconEntity(id: await nextMaxPlusOne(_table, 'ID'));
  }

  Future<List<BriefSpellIconEntity>> getBriefSpellIcons({
    int page = 1,
    SpellIconFilter? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    builder = builder.select(['ID', 'TextureFilename']);
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('ID');
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results
        .map((e) => BriefSpellIconEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<List<SpellIconEntity>> getSpellIcons() async {
    var results = await laconic.table(_table).get();
    return results.map((e) => SpellIconEntity.fromJson(e.toMap())).toList();
  }

  QueryBuilder _applyFilter(QueryBuilder builder, SpellIconFilter? filter) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('ID', filter.id);
    }
    if (filter.name.isNotEmpty) {
      builder = builder.where(
        'TextureFilename',
        '%${filter.name}%',
        comparator: 'like',
      );
    }
    return builder;
  }
}
