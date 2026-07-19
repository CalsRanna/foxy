import 'package:foxy/entity/creature_default_trainer_entity.dart';
import 'package:foxy/entity/creature_default_trainer_key.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class CreatureDefaultTrainerRepository with RepositoryMixin {
  static const _table = 'creature_default_trainer';
  static const primaryKeyColumns = {'CreatureId'};

  Future<CreatureDefaultTrainerEntity> createCreatureDefaultTrainer(
    int creatureId,
  ) async {
    return CreatureDefaultTrainerEntity(creatureId: creatureId);
  }

  Future<void> destroyCreatureDefaultTrainer(
    CreatureDefaultTrainerKey key,
  ) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<CreatureDefaultTrainerEntity?> getCreatureDefaultTrainer(
    CreatureDefaultTrainerKey key,
  ) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return CreatureDefaultTrainerEntity.fromJson(results.first.toMap());
  }

  Future<void> storeCreatureDefaultTrainer(
    CreatureDefaultTrainerEntity relation,
  ) async {
    try {
      await laconic.table(_table).insert([relation.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('生物默认训练师主键已存在，无法新建');
      }
      rethrow;
    }
  }

  Future<void> updateCreatureDefaultTrainer(
    CreatureDefaultTrainerKey originalKey,
    CreatureDefaultTrainerEntity relation,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(relation.toJson());
      if (matchedRows == 0) {
        throw StateError('原记录不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的主键已存在，无法保存');
      }
      rethrow;
    }
  }

  QueryBuilder _whereKey(QueryBuilder builder, CreatureDefaultTrainerKey key) {
    return builder.where('CreatureId', key.creatureId);
  }
}
