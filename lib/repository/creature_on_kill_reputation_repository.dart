import 'package:foxy/model/creature_onkill_reputation.dart';
import 'package:foxy/repository/repository_mixin.dart';

class CreatureOnKillReputationRepository with RepositoryMixin {
  static const _table = 'creature_onkill_reputation';

  /// 获取指定生物的击杀声望
  Future<CreatureOnKillReputation?> getByEntry(int creatureID) async {
    try {
      var builder = laconic.table(_table);
      builder = builder.select(['*']);
      builder = builder.where('creature_id', creatureID);
      var result = await builder.first();
      return CreatureOnKillReputation.fromJson(result.toMap());
    } catch (e) {
      return null;
    }
  }

  /// 查找单条记录
  Future<CreatureOnKillReputation?> find(int creatureID) async {
    try {
      var result = await laconic
          .table(_table)
          .where('creature_id', creatureID)
          .first();
      return CreatureOnKillReputation.fromJson(result.toMap());
    } catch (e) {
      return null;
    }
  }

  /// 新增击杀声望
  Future<void> store(CreatureOnKillReputation rep) async {
    await laconic.table(_table).insert([rep.toJson()]);
  }

  /// 更新击杀声望
  Future<void> update(CreatureOnKillReputation rep) async {
    var json = rep.toJson();
    json.remove('creature_id');
    await laconic
        .table(_table)
        .where('creature_id', rep.creatureID)
        .update(json);
  }

  /// 保存（新增或更新）
  Future<void> save(CreatureOnKillReputation rep) async {
    var existing = await find(rep.creatureID);
    if (existing == null) {
      await store(rep);
    } else {
      await update(rep);
    }
  }
}
