import 'package:foxy/model/spell.dart';
import 'package:foxy/model/spell_filter_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class SpellRepository with RepositoryMixin {
  final String _table = 'foxy.dbc_spell';

  Future<int> count({SpellFilterEntity? filter}) async {
    var builder = laconic.table(_table);
    if (filter?.id.isNotEmpty == true) {
      builder = builder.where('ID', filter!.id);
    }
    if (filter?.name.isNotEmpty == true) {
      builder = builder.where('Name_Lang_zhCN', '%${filter!.name}%');
    }
    return builder.count();
  }

  Future<void> copySpell(int id) async {
    var template = await getSpell(id);
    var json = template.toJson();
    var newId = await _getNextId();
    json['ID'] = newId;
    await laconic.table(_table).insert([json]);
  }

  Future<void> destroySpell(int id) async {
    await laconic.table(_table).where('ID', id).delete();
  }

  Future<List<BriefSpell>> getBriefSpells({
    int page = 1,
    SpellFilterEntity? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table('$_table AS ds');
    const fields = [
      'ds.ID',
      'ds.Name_Lang_zhCN',
      'ds.NameSubtext_Lang_zhCN',
      'ds.Description_Lang_zhCN',
      'ds.AuraDescription_Lang_zhCN',
      'dsd.Duration',
      'dsi.TextureFilename',
    ];
    builder = builder.select(fields);
    builder = builder.leftJoin(
      'foxy.dbc_spell_duration AS dsd',
      (join) => join.on('ds.DurationIndex', 'dsd.ID'),
    );
    builder = builder.leftJoin(
      'foxy.dbc_spell_icon AS dsi',
      (join) => join.on('ds.SpellIconID', 'dsi.ID'),
    );
    if (filter?.id.isNotEmpty == true) {
      builder = builder.where('ds.ID', filter!.id);
    }
    if (filter?.name.isNotEmpty == true) {
      builder = builder.where('ds.Name_Lang_zhCN', '%${filter!.name}%');
    }
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results.map((e) => BriefSpell.fromJson(e.toMap())).toList();
  }

  Future<Spell> getSpell(int id) async {
    var result = await laconic.table(_table).where('ID', id).first();
    return Spell.fromJson(result.toMap());
  }

  Future<void> storeSpell(Spell template) async {
    var json = template.toJson();
    json.remove('ID');
    await laconic.table(_table).insert([json]);
  }

  Future<void> updateSpell(Spell template) async {
    var json = template.toJson();
    json.remove('ID');
    await laconic.table(_table).where('ID', template.id).update(json);
  }

  Future<int> _getNextId() async {
    var result = await laconic.table(_table).select([
      'MAX(ID) as max_id',
    ]).first();
    var maxId = result.toMap()['max_id'] as int?;
    return (maxId ?? 0) + 1;
  }
}
