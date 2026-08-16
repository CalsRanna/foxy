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
  Future<int> countGlyphProperties({GlyphPropertyFilter? filter}) async {
    return _applyFilter(laconic.table('$_table as gp'), filter).count();
  }

  @override
  Future<GlyphPropertyEntity> createGlyphProperty() async {
    return GlyphPropertyEntity(id: await _getNextId());
  }

  @override
  Future<List<BriefGlyphPropertyEntity>> getBriefGlyphProperties({
    int page = 1,
    GlyphPropertyFilter? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table('$_table as gp');
    const fields = [
      'gp.ID',
      'gp.SpellID',
      'gp.GlyphSlotFlags',
      'gp.SpellIconID',
      'sp.Name_lang_enUS as spellName',
      'sp.Name_lang_zhCN as localeSpellName',
      'si.TextureFilename as textureFilename',
    ];
    builder = builder.select(fields);
    builder = builder.leftJoin(
      'foxy.dbc_spell as sp',
      (join) => join.on('gp.SpellID', 'sp.ID'),
    );
    builder = builder.leftJoin(
      'foxy.dbc_spell_icon as si',
      (join) => join.on('gp.SpellIconID', 'si.ID'),
    );
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('gp.ID');
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results.map((e) => BriefGlyphPropertyEntity.fromJson(e.toMap())).toList();
  }

  @override
  QueryBuilder _applyFilter(QueryBuilder builder, GlyphPropertyFilter? filter) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('gp.ID', filter.id);
    }
    return builder;
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
