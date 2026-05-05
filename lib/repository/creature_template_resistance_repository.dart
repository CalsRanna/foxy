import 'package:foxy/entity/creature_template_resistance_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class CreatureTemplateResistanceRepository with RepositoryMixin {
  static const _table = 'creature_template_resistance';

  /// 获取指定生物的所有抗性
  Future<List<CreatureTemplateResistanceEntity>> getCreatureTemplateResistances(
    int creatureID,
  ) async {
    var builder = laconic.table(_table);
    builder = builder.select(['*']);
    builder = builder.where('CreatureID', creatureID);
    builder = builder.orderBy('School');
    var results = await builder.get();
    return results
        .map((e) => CreatureTemplateResistanceEntity.fromJson(e.toMap()))
        .toList();
  }

  /// 查找单条记录
  Future<CreatureTemplateResistanceEntity?> getCreatureTemplateResistance(
    int creatureID,
    int school,
  ) async {
    var result = await laconic
        .table(_table)
        .where('CreatureID', creatureID)
        .where('School', school)
        .first();
    return CreatureTemplateResistanceEntity.fromJson(result.toMap());
  }

  /// 新增抗性
  Future<void> storeCreatureTemplateResistance(
    CreatureTemplateResistanceEntity resistance,
  ) async {
    await laconic.table(_table).insert([resistance.toJson()]);
  }

  /// 更新抗性
  Future<void> updateCreatureTemplateResistance(
    CreatureTemplateResistanceEntity resistance,
  ) async {
    var json = resistance.toJson();
    json.remove('CreatureID');
    json.remove('School');
    await laconic
        .table(_table)
        .where('CreatureID', resistance.creatureID)
        .where('School', resistance.school)
        .update(json);
  }

  /// 删除抗性
  Future<void> destroyCreatureTemplateResistance(
    int creatureID,
    int school,
  ) async {
    await laconic
        .table(_table)
        .where('CreatureID', creatureID)
        .where('School', school)
        .delete();
  }

  /// 复制抗性
  Future<CreatureTemplateResistanceEntity> copyCreatureTemplateResistance(
    int creatureID,
    int school,
  ) async {
    // 获取最大School
    var maxSchoolResult = await laconic
        .table(_table)
        .select(['MAX(School) AS maxSchool'])
        .where('CreatureID', creatureID)
        .first();
    var maxSchool = (maxSchoolResult.toMap()['maxSchool'] ?? 0) as int;

    // 获取源记录
    var source = await getCreatureTemplateResistance(creatureID, school);
    if (source == null) {
      throw Exception('源记录不存在');
    }

    // 创建新记录
    var newResistance = CreatureTemplateResistanceEntity(
      creatureID: source.creatureID,
      school: maxSchool + 1,
      resistance: source.resistance,
      verifiedBuild: source.verifiedBuild,
    );

    await storeCreatureTemplateResistance(newResistance);
    return newResistance;
  }

  /// 获取下一个可用的School
  Future<int> getNextSchool(int creatureID) async {
    var maxResult = await laconic
        .table(_table)
        .select(['MAX(School) AS maxSchool'])
        .where('CreatureID', creatureID)
        .first();
    var maxSchool = (maxResult.toMap()['maxSchool'] ?? 0) as int;
    return maxSchool + 1;
  }
}
