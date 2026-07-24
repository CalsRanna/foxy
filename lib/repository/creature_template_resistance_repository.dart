import 'package:foxy/entity/creature_template_resistance_entity.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class CreatureTemplateResistanceRepository with RepositoryMixin {
  static const _table = 'creature_template_resistance';
  static const maxSchool = 6;
  static const minSchool = 1;
  static const primaryKeyColumns = {'CreatureID', 'School'};

  Future<CreatureTemplateResistanceKey> copyCreatureTemplateResistance(
    CreatureTemplateResistanceKey sourceKey,
  ) async {
    final source = await getCreatureTemplateResistance(sourceKey);
    if (source == null) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
    final blank = await createCreatureTemplateResistance(source.creatureID);
    final candidate = source.copyWith(school: blank.school);
    await storeCreatureTemplateResistance(candidate);
    return CreatureTemplateResistanceKey.fromEntity(candidate);
  }

  Future<int> countCreatureTemplateResistances(int creatureID) {
    return laconic.table(_table).where('CreatureID', creatureID).count();
  }

  Future<CreatureTemplateResistanceEntity> createCreatureTemplateResistance(
    int creatureID,
  ) async {
    return CreatureTemplateResistanceEntity(
      creatureID: creatureID,
      school: await getNextSchool(creatureID),
    );
  }

  Future<void> destroyCreatureTemplateResistance(
    CreatureTemplateResistanceKey key,
  ) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<List<BriefCreatureTemplateResistanceEntity>>
  getBriefCreatureTemplateResistances(int creatureID, {int page = 1}) async {
    final results = await laconic
        .table(_table)
        .select(['CreatureID', 'School', 'Resistance', 'VerifiedBuild'])
        .where('CreatureID', creatureID)
        .orderBy('CreatureID')
        .orderBy('School')
        .limit(kPageSize)
        .offset((page - 1) * kPageSize)
        .get();
    return results
        .map(
          (result) =>
              BriefCreatureTemplateResistanceEntity.fromJson(result.toMap()),
        )
        .toList();
  }

  Future<CreatureTemplateResistanceEntity?> getCreatureTemplateResistance(
    CreatureTemplateResistanceKey key,
  ) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return CreatureTemplateResistanceEntity.fromJson(results.first.toMap());
  }

  Future<int> getNextSchool(int creatureID) async {
    final results = await laconic
        .table(_table)
        .select(['School'])
        .where('CreatureID', creatureID)
        .get();
    return nextAvailableSchool(
      results.map((result) => (result.toMap()['School'] as num).toInt()),
    );
  }

  Future<void> storeCreatureTemplateResistance(
    CreatureTemplateResistanceEntity resistance,
  ) async {
    try {
      await laconic.table(_table).insert([resistance.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('生物抗性主键已存在，无法新建');
      }
      rethrow;
    }
  }

  Future<void> updateCreatureTemplateResistance(
    CreatureTemplateResistanceKey originalKey,
    CreatureTemplateResistanceEntity resistance,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(resistance.toJson());
      if (matchedRows == 0) {
        throw StateError('原记录不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的生物抗性主键已存在，无法保存');
      }
      rethrow;
    }
  }

  static int nextAvailableSchool(Iterable<int> usedSchools) {
    final used = usedSchools.toSet();
    for (var school = minSchool; school <= maxSchool; school++) {
      if (!used.contains(school)) return school;
    }
    throw StateError('生物抗性学校已满，只允许 $minSchool-$maxSchool');
  }

  QueryBuilder _whereKey(
    QueryBuilder builder,
    CreatureTemplateResistanceKey key,
  ) {
    return builder
        .where('CreatureID', key.creatureID)
        .where('School', key.school);
  }
}
