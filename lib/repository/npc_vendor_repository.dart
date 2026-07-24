import 'package:foxy/entity/npc_vendor_entity.dart';
import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'npc_vendor_repository.g.dart';

@FoxyRepository(NpcVendorEntity)
class NpcVendorRepository with RepositoryMixin, _NpcVendorRepositoryMixin {
  static const _table = 'npc_vendor';
  static const primaryKeyColumns = {'entry', 'item', 'ExtendedCost'};

  Future<int> countNpcVendors(int entry) {
    return laconic.table(_table).where('entry', entry).count();
  }

  Future<NpcVendorEntity> createNpcVendor(int entry) async {
    final nextSlot = await nextMaxPlusOne(
      _table,
      'slot',
      where: {'entry': entry},
      firstValue: 0,
    );
    return NpcVendorEntity(entry: entry, slot: nextSlot);
  }

  Future<List<BriefNpcVendorEntity>> getBriefNpcVendors(
    int entry, {
    int page = 1,
  }) async {
    var builder = laconic.table('$_table AS nv');
    final fields = <String>[
      'nv.entry',
      'nv.slot',
      'nv.item',
      'nv.maxcount',
      'nv.incrtime',
      'nv.ExtendedCost',
      'it.name AS itemName',
      if (localeEnabled) 'itl.Name AS itemLocaleName',
      'it.Quality AS itemQuality',
    ];
    builder = builder.select(fields);
    builder = builder.leftJoin(
      'item_template AS it',
      (join) => join.on('nv.item', 'it.entry'),
    );
    if (localeEnabled) {
      builder = builder.leftJoin(
        'item_template_locale AS itl',
        (join) => join.on('it.entry', 'itl.ID').where('itl.locale', 'zhCN'),
      );
    }
    builder = builder.where('nv.entry', entry);
    builder = builder.orderBy('nv.slot').orderBy('nv.item');
    builder = builder.limit(kPageSize).offset((page - 1) * kPageSize);
    final results = await builder.get();
    return results
        .map((result) => BriefNpcVendorEntity.fromJson(result.toMap()))
        .toList();
  }
}
