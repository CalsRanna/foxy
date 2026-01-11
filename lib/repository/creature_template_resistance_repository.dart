import 'package:foxy/model/creature_template_resistance.dart';
import 'package:foxy/repository/repository_mixin.dart';

class CreatureTemplateResistanceRepository with RepositoryMixin {
  static const _table = 'creature_template_resistance';

  /// 获取指定生物的所有抗性
  Future<List<CreatureTemplateResistance>> getByEntry(int creatureID) async {
    try {
      var builder = laconic.table(_table);
      builder = builder.select(['*']);
      builder = builder.where('CreatureID', creatureID);
      builder = builder.orderBy('School');
      var results = await builder.get();
      return results
          .map((e) => CreatureTemplateResistance.fromJson(e.toMap()))
          .toList();
    } catch (e) {
      return [];
    }
  }

  /// 查找单条记录
  Future<CreatureTemplateResistance?> find(int creatureID, int school) async {
    try {
      var result = await laconic
          .table(_table)
          .where('CreatureID', creatureID)
          .where('School', school)
          .first();
      return CreatureTemplateResistance.fromJson(result.toMap());
    } catch (e) {
      return null;
    }
  }

  /// 新增抗性
  Future<void> store(CreatureTemplateResistance resistance) async {
    await laconic.table(_table).insert([resistance.toJson()]);
  }

  /// 更新抗性
  Future<void> update(CreatureTemplateResistance resistance) async {
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
  Future<void> delete(int creatureID, int school) async {
    await laconic
        .table(_table)
        .where('CreatureID', creatureID)
        .where('School', school)
        .delete();
  }

  /// 复制抗性
  Future<CreatureTemplateResistance> copy(int creatureID, int school) async {
    // 获取最大School
    var maxSchoolResult = await laconic
        .table(_table)
        .select(['MAX(School) AS maxSchool'])
        .where('CreatureID', creatureID)
        .first();
    var maxSchool = (maxSchoolResult.toMap()['maxSchool'] ?? 0) as int;

    // 获取源记录
    var source = await find(creatureID, school);
    if (source == null) {
      throw Exception('源记录不存在');
    }

    // 创建新记录
    var newResistance = CreatureTemplateResistance.fromJson(source.toJson());
    newResistance.school = maxSchool + 1;

    await store(newResistance);
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
