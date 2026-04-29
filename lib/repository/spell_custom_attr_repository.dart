import 'package:foxy/entity/spell_custom_attr_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class SpellCustomAttrRepository with RepositoryMixin {
  static const _table = 'spell_custom_attr';

  Future<SpellCustomAttrEntity?> getSpellCustomAttr(int spellId) async {
    try {
      var result = await laconic
          .table(_table)
          .where('spell_id', spellId)
          .first();
      return SpellCustomAttrEntity.fromJson(result.toMap());
    } catch (e) {
      return null;
    }
  }

  Future<void> storeSpellCustomAttr(SpellCustomAttrEntity data) async {
    await laconic.table(_table).insert([data.toJson()]);
  }

  Future<void> updateSpellCustomAttr(SpellCustomAttrEntity data) async {
    var json = data.toJson();
    json.remove('spell_id');
    await laconic.table(_table).where('spell_id', data.spellId).update(json);
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
