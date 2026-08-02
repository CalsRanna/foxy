// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_template_resistance_repository.dart';

mixin _CreatureTemplateResistanceRepositoryMixin on RepositoryMixin {
  Future<CreatureTemplateResistanceKey> copyCreatureTemplateResistance(
    CreatureTemplateResistanceKey key,
  ) async {
    final source = await getCreatureTemplateResistance(key);
    if (source == null) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
    final blank = await createCreatureTemplateResistance(source.creatureID);
    final copied = source.copyWith(
      creatureID: blank.creatureID,
      school: blank.school,
    );
    await storeCreatureTemplateResistance(copied);
    return CreatureTemplateResistanceKey.fromEntity(copied);
  }

  Future<int> countCreatureTemplateResistances(int creatureID) async {
    return laconic
        .table('creature_template_resistance')
        .where('`CreatureID`', creatureID)
        .count();
  }

  Future<CreatureTemplateResistanceEntity> createCreatureTemplateResistance(
    int creatureID,
  ) async {
    return CreatureTemplateResistanceEntity(
      creatureID: creatureID,
      school: await nextMaxPlusOne(
        'creature_template_resistance',
        '`School`',
        where: {'CreatureID': creatureID},
      ),
    );
  }

  Future<void> destroyCreatureTemplateResistance(
    CreatureTemplateResistanceKey key,
  ) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(
      laconic.table('creature_template_resistance'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<CreatureTemplateResistanceEntity?> getCreatureTemplateResistance(
    CreatureTemplateResistanceKey key,
  ) async {
    final results = await _whereKey(
      laconic.table('creature_template_resistance'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return CreatureTemplateResistanceEntity.fromJson(results.first.toMap());
  }

  Future<List<BriefCreatureTemplateResistanceEntity>>
  getBriefCreatureTemplateResistances(int creatureID, {int page = 1}) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table('creature_template_resistance').select([
      '`CreatureID`',
      '`School`',
      '`Resistance`',
      '`VerifiedBuild`',
    ]);
    builder = builder.where('`CreatureID`', creatureID);
    builder = builder.orderBy('`CreatureID`').orderBy('`School`');
    builder = builder.limit(kPageSize).offset(offset);
    final results = await builder.get();
    return results
        .map((e) => BriefCreatureTemplateResistanceEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<void> storeCreatureTemplateResistance(
    CreatureTemplateResistanceEntity creatureTemplateResistance,
  ) async {
    await _beforeStore(creatureTemplateResistance);
    final json = prepareWriteJson(creatureTemplateResistance.toJson());
    try {
      await laconic.table('creature_template_resistance').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateCreatureTemplateResistance(
    CreatureTemplateResistanceKey originalKey,
    CreatureTemplateResistanceEntity creatureTemplateResistance,
  ) async {
    await _beforeUpdate(originalKey, creatureTemplateResistance);
    final json = prepareWriteJson(creatureTemplateResistance.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table('creature_template_resistance'),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的主键已存在');
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<void> _beforeDestroy(CreatureTemplateResistanceKey key) async {}

  Future<void> _beforeStore(
    CreatureTemplateResistanceEntity creatureTemplateResistance,
  ) async {}

  Future<void> _beforeUpdate(
    CreatureTemplateResistanceKey originalKey,
    CreatureTemplateResistanceEntity creatureTemplateResistance,
  ) async {}

  QueryBuilder _whereKey(
    QueryBuilder builder,
    CreatureTemplateResistanceKey key,
  ) {
    var query = builder;
    query = query.where('`CreatureID`', key.creatureID);
    query = query.where('`School`', key.school);
    return query;
  }
}
