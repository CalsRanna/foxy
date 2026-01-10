import 'package:foxy/model/npc_trainer.dart';
import 'package:foxy/repository/repository_mixin.dart';

class NpcTrainerRepository with RepositoryMixin {
  static const _table = 'npc_trainer';

  /// 获取指定训练师的所有技能（带技能信息）
  Future<List<NpcTrainer>> getByEntry(int id) async {
    try {
      var builder = laconic.table('$_table AS nt');
      const fields = [
        'nt.*',
        'ds.Name_Lang_zhCN as spellName',
        'ds.NameSubtext_Lang_zhCN as spellSubtext',
      ];
      builder = builder.select(fields);
      builder = builder.leftJoin(
        'foxy.dbc_spell AS ds',
        (join) => join.on('nt.SpellID', 'ds.ID'),
      );
      builder = builder.where('nt.ID', id);
      builder = builder.orderBy('nt.SpellID');
      var results = await builder.get();
      return results.map((e) => NpcTrainer.fromJson(e.toMap())).toList();
    } catch (e) {
      return [];
    }
  }

  /// 查找单条记录
  Future<NpcTrainer?> find(int id, int spellID) async {
    try {
      var result = await laconic
          .table(_table)
          .where('ID', id)
          .where('SpellID', spellID)
          .first();
      return result != null ? NpcTrainer.fromJson(result.toMap()) : null;
    } catch (e) {
      return null;
    }
  }

  /// 新增训练师技能
  Future<void> store(NpcTrainer trainer) async {
    await laconic.table(_table).insert([trainer.toJson()]);
  }

  /// 更新训练师技能
  Future<void> update(NpcTrainer trainer) async {
    var json = trainer.toJson();
    json.remove('ID');
    json.remove('SpellID');
    await laconic
        .table(_table)
        .where('ID', trainer.id)
        .where('SpellID', trainer.spellID)
        .update(json);
  }

  /// 删除训练师技能
  Future<void> delete(int id, int spellID) async {
    await laconic.table(_table).where('ID', id).where('SpellID', spellID).delete();
  }

  /// 复制训练师技能
  Future<NpcTrainer> copy(int id, int spellID) async {
    // 获取最大SpellID
    var maxSpellResult = await laconic
        .table(_table)
        .select(['MAX(SpellID) AS maxSpellID'])
        .where('ID', id)
        .first();
    var maxSpellID = (maxSpellResult?.toMap()['maxSpellID'] ?? 0) as int;

    // 获取源记录
    var source = await find(id, spellID);
    if (source == null) {
      throw Exception('源记录不存在');
    }

    // 创建新记录
    var newTrainer = NpcTrainer.fromJson(source.toJson());
    newTrainer.spellID = maxSpellID + 1;

    await store(newTrainer);
    return newTrainer;
  }
}
