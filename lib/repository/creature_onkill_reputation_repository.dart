import 'package:foxy/model/creature_onkill_reputation.dart';
import 'package:foxy/repository/repository_mixin.dart';

class CreatureOnkillReputationRepository with RepositoryMixin {
  static const _table = 'creature_onkill_reputation';

  /// 获取指定生物的击杀声望
  Future<CreatureOnkillReputation?> getByEntry(int creatureID) async {
    try {
      var builder = laconic.table(_table);
      builder = builder.select(['*']);
      builder = builder.where('creature_id', creatureID);
      var result = await builder.first();
      return result != null ? CreatureOnkillReputation.fromJson(result.toMap()) : null;
    } catch (e) {
      return null;
    }
  }

  /// 查找单条记录
  Future<CreatureOnkillReputation?> find(int creatureID) async {
    try {
      var result = await laconic
          .table(_table)
          .where('creature_id', creatureID)
          .first();
      return result != null ? CreatureOnkillReputation.fromJson(result.toMap()) : null;
    } catch (e) {
      return null;
    }
  }

  /// 新增击杀声望
  Future<void> store(CreatureOnkillReputation rep) async {
    await laconic.table(_table).insert([rep.toJson()]);
  }

  /// 更新击杀声望
  Future<void> update(CreatureOnkillReputation rep) async {
    var json = rep.toJson();
    json.remove('creature_id');
    await laconic
        .table(_table)
        .where('creature_id', rep.creatureID)
        .update(json);
  }

  /// 保存（新增或更新）
  Future<void> save(CreatureOnkillReputation rep) async {
    var existing = await find(rep.creatureID);
    if (existing == null) {
      await store(rep);
    } else {
      await update(rep);
    }
  }
}
