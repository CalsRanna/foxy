import 'package:foxy/model/spell_custom_attr.dart';
import 'package:foxy/repository/repository_mixin.dart';

class SpellCustomAttrRepository with RepositoryMixin {
  static const _table = 'spell_custom_attr';

  Future<SpellCustomAttr?> find(int spellId) async {
    try {
      var result = await laconic
          .table(_table)
          .where('spell_id', spellId)
          .first();
      return SpellCustomAttr.fromJson(result.toMap());
    } catch (e) {
      return null;
    }
  }

  Future<void> store(SpellCustomAttr data) async {
    await laconic.table(_table).insert([data.toJson()]);
  }

  Future<void> update(SpellCustomAttr data) async {
    var json = data.toJson();
    json.remove('spell_id');
    await laconic
        .table(_table)
        .where('spell_id', data.spellId)
        .update(json);
  }

  Future<void> save(SpellCustomAttr data) async {
    var existing = await find(data.spellId);
    if (existing != null) {
      await update(data);
    } else {
      await store(data);
    }
  }
}
