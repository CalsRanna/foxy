import 'package:foxy/entity/creature_onkill_reputation.dart';
import 'package:foxy/repository/repository_mixin.dart';

class CreatureOnKillReputationRepository with RepositoryMixin {
  static const _table = 'creature_onkill_reputation';

  /// 获取指定生物的击杀声望
  Future<CreatureOnKillReputation?> getCreatureOnKillReputation(
    int creatureID,
  ) async {
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

  /// 新增击杀声望
  Future<void> storeCreatureOnKillReputation(
    CreatureOnKillReputation rep,
  ) async {
    await laconic.table(_table).insert([rep.toJson()]);
  }

  /// 更新击杀声望
  Future<void> updateCreatureOnKillReputation(
    CreatureOnKillReputation rep,
  ) async {
    var json = rep.toJson();
    json.remove('creature_id');
    await laconic
        .table(_table)
        .where('creature_id', rep.creatureID)
        .update(json);
  }

  /// 保存（新增或更新）
  Future<void> saveCreatureOnKillReputation(
    CreatureOnKillReputation rep,
  ) async {
    var existing = await getCreatureOnKillReputation(rep.creatureID);
    if (existing == null) {
      await storeCreatureOnKillReputation(rep);
    } else {
      await updateCreatureOnKillReputation(rep);
    }
  }
}
