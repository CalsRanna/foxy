import 'package:foxy/entity/spell_custom_attr_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class SpellCustomAttrRepository with RepositoryMixin {
  static const _table = 'spell_custom_attr';

  Future<SpellCustomAttrEntity?> getSpellCustomAttr(int spellId) async {
    var results = await laconic
        .table(_table)
        .where('spell_id', spellId)
        .limit(1)
        .get();
    if (results.isEmpty) return null;
    return SpellCustomAttrEntity.fromJson(results.first.toMap());
  }

  Future<SpellCustomAttrEntity> createSpellCustomAttr([
    int spellId = 0,
  ]) async {
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
    var source = await getSpellCustomAttr(spellId);
    if (source == null) return;
    var json = source.toJson();
    var nextId = await _getNextSpellId();
    json['spell_id'] = nextId;
    await laconic.table(_table).insert([json]);
  }

  Future<void> saveSpellCustomAttr(SpellCustomAttrEntity data) async {
    var existing = await getSpellCustomAttr(data.spellId);
    if (existing != null) {
      await updateSpellCustomAttr(data);
    } else {
      await storeSpellCustomAttr(data);
    }
  }

  Future<int> _getNextSpellId() async {
    var result = await laconic.table(_table).select([
      'MAX(spell_id) as max_id',
    ]).first();
    var maxId = result.toMap()['max_id'] as int?;
    return (maxId ?? 0) + 1;
  }
}
