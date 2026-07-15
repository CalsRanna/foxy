import 'package:foxy/entity/spell_custom_attr_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class SpellCustomAttrRepository with RepositoryMixin {
  static const _table = 'spell_custom_attr';

  Future<List<BriefSpellCustomAttrEntity>> getBriefSpellCustomAttrs({
    int page = 1,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    builder = builder.select(['spell_id', 'attributes']);
    builder = builder.orderBy('spell_id');
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results
        .map((e) => BriefSpellCustomAttrEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<List<SpellCustomAttrEntity>> getSpellCustomAttrs() async {
    var results = await laconic.table(_table).get();
    return results
        .map((e) => SpellCustomAttrEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<int> countSpellCustomAttrs() async {
    return laconic.table(_table).count();
  }

  Future<SpellCustomAttrEntity?> getSpellCustomAttr(int spellId) async {
    var results = await laconic
        .table(_table)
        .where('spell_id', spellId)
        .limit(1)
        .get();
    if (results.isEmpty) return null;
    return SpellCustomAttrEntity.fromJson(results.first.toMap());
  }

  Future<SpellCustomAttrEntity> createSpellCustomAttr([int spellId = 0]) async {
    return SpellCustomAttrEntity(spellId: spellId);
  }

  Future<void> storeSpellCustomAttr(SpellCustomAttrEntity data) async {
    await laconic.table(_table).insert([data.toJson()]);
  }

  Future<void> updateSpellCustomAttr(SpellCustomAttrEntity data) async {
    var json = data.toJson();
    json.remove('spell_id');
    await laconic.table(_table).where('spell_id', data.spellId).update(json);
  }

  Future<void> destroySpellCustomAttr(int spellId) async {
    await laconic.table(_table).where('spell_id', spellId).delete();
  }

  Future<void> copySpellCustomAttr(int spellId) async {
    throw UnsupportedError('法术自定义属性记录不能自动复制，请为有效法术新增记录。');
  }

  Future<void> saveSpellCustomAttr(SpellCustomAttrEntity data) async {
    var existing = await getSpellCustomAttr(data.spellId);
    if (existing != null) {
      await updateSpellCustomAttr(data);
    } else {
      await storeSpellCustomAttr(data);
    }
  }
}
