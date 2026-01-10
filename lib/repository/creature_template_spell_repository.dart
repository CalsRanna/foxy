import 'package:foxy/model/creature_template_spell.dart';
import 'package:foxy/repository/repository_mixin.dart';

class CreatureTemplateSpellRepository with RepositoryMixin {
  static const _table = 'creature_template_spell';

  /// 获取指定生物的所有技能（带技能信息）
  Future<List<CreatureTemplateSpell>> getByEntry(int creatureID) async {
    try {
      var builder = laconic.table('$_table AS cts');
      const fields = [
        'cts.*',
        'ds.Name_Lang_zhCN as spellName',
        'ds.NameSubtext_Lang_zhCN as spellSubtext',
      ];
      builder = builder.select(fields);
      builder = builder.leftJoin(
        'foxy.dbc_spell AS ds',
        (join) => join.on('cts.Spell', 'ds.ID'),
      );
      builder = builder.where('cts.CreatureID', creatureID);
      builder = builder.orderBy('cts.Index');
      var results = await builder.get();
      return results.map((e) => CreatureTemplateSpell.fromJson(e.toMap())).toList();
    } catch (e) {
      return [];
    }
  }

  /// 查找单条记录
  Future<CreatureTemplateSpell?> find(int creatureID, int index) async {
    try {
      var result = await laconic
          .table(_table)
          .where('CreatureID', creatureID)
          .where('Index', index)
          .first();
      return result != null ? CreatureTemplateSpell.fromJson(result.toMap()) : null;
    } catch (e) {
      return null;
    }
  }

  /// 新增技能
  Future<void> store(CreatureTemplateSpell spell) async {
    await laconic.table(_table).insert([spell.toJson()]);
  }

  /// 更新技能
  Future<void> update(CreatureTemplateSpell spell) async {
    var json = spell.toJson();
    json.remove('CreatureID');
    json.remove('Index');
    await laconic
        .table(_table)
        .where('CreatureID', spell.creatureID)
        .where('Index', spell.index)
        .update(json);
  }

  /// 删除技能
  Future<void> delete(int creatureID, int index) async {
    await laconic.table(_table).where('CreatureID', creatureID).where('Index', index).delete();
  }

  /// 复制技能
  Future<CreatureTemplateSpell> copy(int creatureID, int index) async {
    // 获取最大Index
    var maxIndexResult = await laconic
        .table(_table)
        .select(['MAX(`Index`) AS maxIndex'])
        .where('CreatureID', creatureID)
        .first();
    var maxIndex = (maxIndexResult?.toMap()['maxIndex'] ?? 0) as int;

    // 获取源记录
    var source = await find(creatureID, index);
    if (source == null) {
      throw Exception('源记录不存在');
    }

    // 创建新记录
    var newSpell = CreatureTemplateSpell.fromJson(source.toJson());
    newSpell.index = maxIndex + 1;

    await store(newSpell);
    return newSpell;
  }

  /// 获取下一个可用的Index
  Future<int> getNextIndex(int creatureID) async {
    var maxResult = await laconic
        .table(_table)
        .select(['MAX(`Index`) AS maxIndex'])
        .where('CreatureID', creatureID)
        .first();
    var maxIndex = (maxResult?.toMap()['maxIndex'] ?? 0) as int;
    return maxIndex + 1;
  }
}
