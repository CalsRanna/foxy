import 'package:foxy/entity/spell_custom_attr_entity.dart';
import 'package:foxy_annotation/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'spell_custom_attr_repository.g.dart';

@FoxyRepository()
class SpellCustomAttrRepository
    with RepositoryMixin, _SpellCustomAttrRepositoryMixin {
  Future<void> copySpellCustomAttr(int key) async {
    throw CopyNotSupportedException(
      'spell custom attribute records cannot be auto-copied; add a new record for a valid spell',
    );
  }

  Future<int> countSpellCustomAttrs() {
    return laconic.table(_table).count();
  }

  Future<SpellCustomAttrEntity> createSpellCustomAttr([int? spellId]) async {
    return SpellCustomAttrEntity(
      spellId: spellId ?? await nextMaxPlusOne(_table, 'spell_id'),
    );
  }

  Future<List<BriefSpellCustomAttrEntity>> getBriefSpellCustomAttrs({
    int page = 1,
  }) async {
    final results = await laconic
        .table(_table)
        .select(['spell_id', 'attributes'])
        .orderBy('spell_id')
        .limit(kPageSize)
        .offset((page - 1) * kPageSize)
        .get();
    return results
        .map((row) => BriefSpellCustomAttrEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<List<SpellCustomAttrEntity>> getSpellCustomAttrs() async {
    final results = await laconic.table(_table).get();
    return results
        .map((row) => SpellCustomAttrEntity.fromJson(row.toMap()))
        .toList();
  }
}
