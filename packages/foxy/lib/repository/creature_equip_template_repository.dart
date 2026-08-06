import 'package:foxy/entity/creature_equip_template_entity.dart';
import 'package:foxy_annotation/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'creature_equip_template_repository.g.dart';

@FoxyRepository(CreatureEquipTemplateEntity, linkKey: ['creatureID'])
class CreatureEquipTemplateRepository
    with RepositoryMixin, _CreatureEquipTemplateRepositoryMixin {
  static const _table = 'creature_equip_template';
  static const primaryKeyColumns = {'CreatureID', 'ID'};

  @override
  Future<CreatureEquipTemplateKey> copyCreatureEquipTemplate(
    CreatureEquipTemplateKey key,
  ) async {
    final source = await getCreatureEquipTemplate(key);
    if (source == null) {
      throw RecordNotFoundException('record not found');
    }
    final blank = await createCreatureEquipTemplate(source.creatureID);
    final candidate = source.copyWith(id: blank.id);
    await storeCreatureEquipTemplate(candidate);
    return CreatureEquipTemplateKey.fromEntity(candidate);
  }

  @override
  Future<int> countCreatureEquipTemplates(int creatureID) {
    return laconic.table(_table).where('CreatureID', creatureID).count();
  }

  @override
  Future<CreatureEquipTemplateEntity> createCreatureEquipTemplate(
    int creatureID,
  ) async {
    return CreatureEquipTemplateEntity(
      creatureID: creatureID,
      id: await getNextId(creatureID),
    );
  }

  @override
  Future<List<BriefCreatureEquipTemplateEntity>> getBriefCreatureEquipTemplates(
    int creatureID, {
    int page = 1,
  }) async {
    var builder = laconic.table('$_table as cet');
    final fields = <String>[
      'cet.CreatureID',
      'cet.ID',
      'cet.ItemID1',
      'cet.ItemID2',
      'cet.ItemID3',
      'cet.VerifiedBuild',
      'it1.name as name1',
      if (localeEnabled) 'itl1.Name as localeName1',
      'it1.Quality as quality1',
      'didi1.InventoryIcon0 as icon1',
      'it2.name as name2',
      if (localeEnabled) 'itl2.Name as localeName2',
      'it2.Quality as quality2',
      'didi2.InventoryIcon0 as icon2',
      'it3.name as name3',
      if (localeEnabled) 'itl3.Name as localeName3',
      'it3.Quality as quality3',
      'didi3.InventoryIcon0 as icon3',
    ];
    builder = builder.select(fields);
    builder = builder.leftJoin(
      'item_template as it1',
      (join) => join.on('cet.ItemID1', 'it1.entry'),
    );
    if (localeEnabled) {
      builder = builder.leftJoin(
        'item_template_locale as itl1',
        (join) =>
            join.on('cet.ItemID1', 'itl1.ID').where('itl1.locale', 'zhCN'),
      );
    }
    builder = builder.leftJoin(
      'foxy.dbc_item_display_info as didi1',
      (join) => join.on('it1.displayid', 'didi1.ID'),
    );
    builder = builder.leftJoin(
      'item_template as it2',
      (join) => join.on('cet.ItemID2', 'it2.entry'),
    );
    if (localeEnabled) {
      builder = builder.leftJoin(
        'item_template_locale as itl2',
        (join) =>
            join.on('cet.ItemID2', 'itl2.ID').where('itl2.locale', 'zhCN'),
      );
    }
    builder = builder.leftJoin(
      'foxy.dbc_item_display_info as didi2',
      (join) => join.on('it2.displayid', 'didi2.ID'),
    );
    builder = builder.leftJoin(
      'item_template as it3',
      (join) => join.on('cet.ItemID3', 'it3.entry'),
    );
    if (localeEnabled) {
      builder = builder.leftJoin(
        'item_template_locale as itl3',
        (join) =>
            join.on('cet.ItemID3', 'itl3.ID').where('itl3.locale', 'zhCN'),
      );
    }
    builder = builder.leftJoin(
      'foxy.dbc_item_display_info as didi3',
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

  Future<int> getNextId(int creatureID) =>
      nextMaxPlusOne(_table, 'ID', where: {'CreatureID': creatureID});
}
