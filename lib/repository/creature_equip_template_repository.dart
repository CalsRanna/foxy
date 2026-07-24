import 'package:foxy/entity/brief_creature_equip_template_entity.dart';
import 'package:foxy/entity/creature_equip_template_entity.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class CreatureEquipTemplateRepository with RepositoryMixin {
  static const _table = 'creature_equip_template';
  static const primaryKeyColumns = {'CreatureID', 'ID'};

  Future<CreatureEquipTemplateKey> copyCreatureEquipTemplate(
    CreatureEquipTemplateKey sourceKey,
  ) async {
    final source = await getCreatureEquipTemplate(sourceKey);
    if (source == null) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
    final blank = await createCreatureEquipTemplate(source.creatureID);
    final candidate = source.copyWith(id: blank.id);
    await storeCreatureEquipTemplate(candidate);
    return CreatureEquipTemplateKey.fromEntity(candidate);
  }

  Future<int> countCreatureEquipTemplates(int creatureID) {
    return laconic.table(_table).where('CreatureID', creatureID).count();
  }

  Future<CreatureEquipTemplateEntity> createCreatureEquipTemplate(
    int creatureID,
  ) async {
    return CreatureEquipTemplateEntity(
      creatureID: creatureID,
      id: await getNextId(creatureID),
    );
  }

  Future<void> destroyCreatureEquipTemplate(
    CreatureEquipTemplateKey key,
  ) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<List<BriefCreatureEquipTemplateEntity>> getBriefCreatureEquipTemplates(
    int creatureID, {
    int page = 1,
  }) async {
    var builder = laconic.table('$_table AS cet');
    final fields = <String>[
      'cet.CreatureID',
      'cet.ID',
      'cet.ItemID1',
      'cet.ItemID2',
      'cet.ItemID3',
      'cet.VerifiedBuild',
      'it1.name as name_1',
      if (localeEnabled) 'itl1.Name as localeName_1',
      'it1.Quality as Quality_1',
      'didi1.InventoryIcon0 as Icon_1',
      'it2.name as name_2',
      if (localeEnabled) 'itl2.Name as localeName_2',
      'it2.Quality as Quality_2',
      'didi2.InventoryIcon0 as Icon_2',
      'it3.name as name_3',
      if (localeEnabled) 'itl3.Name as localeName_3',
      'it3.Quality as Quality_3',
      'didi3.InventoryIcon0 as Icon_3',
    ];
    builder = builder.select(fields);
    builder = builder.leftJoin(
      'item_template AS it1',
      (join) => join.on('cet.ItemID1', 'it1.entry'),
    );
    if (localeEnabled) {
      builder = builder.leftJoin(
        'item_template_locale AS itl1',
        (join) =>
            join.on('cet.ItemID1', 'itl1.ID').where('itl1.locale', 'zhCN'),
      );
    }
    builder = builder.leftJoin(
      'foxy.dbc_item_display_info AS didi1',
      (join) => join.on('it1.displayid', 'didi1.ID'),
    );
    builder = builder.leftJoin(
      'item_template AS it2',
      (join) => join.on('cet.ItemID2', 'it2.entry'),
    );
    if (localeEnabled) {
      builder = builder.leftJoin(
        'item_template_locale AS itl2',
        (join) =>
            join.on('cet.ItemID2', 'itl2.ID').where('itl2.locale', 'zhCN'),
      );
    }
    builder = builder.leftJoin(
      'foxy.dbc_item_display_info AS didi2',
      (join) => join.on('it2.displayid', 'didi2.ID'),
    );
    builder = builder.leftJoin(
      'item_template AS it3',
      (join) => join.on('cet.ItemID3', 'it3.entry'),
    );
    if (localeEnabled) {
      builder = builder.leftJoin(
        'item_template_locale AS itl3',
        (join) =>
            join.on('cet.ItemID3', 'itl3.ID').where('itl3.locale', 'zhCN'),
      );
    }
    builder = builder.leftJoin(
      'foxy.dbc_item_display_info AS didi3',
      (join) => join.on('it3.displayid', 'didi3.ID'),
    );
    builder = builder.where('cet.CreatureID', creatureID);
    builder = builder.orderBy('cet.CreatureID').orderBy('cet.ID');
    builder = builder.limit(kPageSize).offset((page - 1) * kPageSize);
    final results = await builder.get();
    return results
        .map((e) => BriefCreatureEquipTemplateEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<CreatureEquipTemplateEntity?> getCreatureEquipTemplate(
    CreatureEquipTemplateKey key,
  ) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return CreatureEquipTemplateEntity.fromJson(results.first.toMap());
  }

  Future<int> getNextId(int creatureID) =>
      nextMaxPlusOne(_table, 'ID', where: {'CreatureID': creatureID});

  Future<void> storeCreatureEquipTemplate(
    CreatureEquipTemplateEntity equip,
  ) async {
    try {
      await laconic.table(_table).insert([equip.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('生物装备模板主键已存在，无法新建');
      }
      rethrow;
    }
  }

  Future<void> updateCreatureEquipTemplate(
    CreatureEquipTemplateKey originalKey,
    CreatureEquipTemplateEntity equip,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(equip.toJson());
      if (matchedRows == 0) {
        throw StateError('原记录不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的生物装备模板主键已存在，无法保存');
      }
      rethrow;
    }
  }

  QueryBuilder _whereKey(QueryBuilder builder, CreatureEquipTemplateKey key) {
    return builder.where('CreatureID', key.creatureID).where('ID', key.id);
  }
}
