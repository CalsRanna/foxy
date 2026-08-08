import 'package:foxy/entity/item_extended_cost_entity.dart';
import 'package:foxy_annotation/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'item_extended_cost_repository.g.dart';

@FoxyRepository()
@FoxyFilter.text('id')
class ItemExtendedCostRepository
    with RepositoryMixin, _ItemExtendedCostRepositoryMixin {
  static const _table = 'foxy.dbc_item_extended_cost';

  @override
  Future<int> copyItemExtendedCost(int key) async {
    final source = await getItemExtendedCost(key);
    if (source == null) {
      throw RecordNotFoundException('record not found');
    }
    final copied = source.copyWith(id: await _getNextId());
    await storeItemExtendedCost(copied);
    return copied.id;
  }

  @override
  Future<ItemExtendedCostEntity> createItemExtendedCost() async {
    return ItemExtendedCostEntity(id: await _getNextId());
  }

  Future<int> _getNextId() async {
    final id = await nextMaxPlusOne(_table, 'ID');
    if (id > 2147483647) {
      throw IdExhaustedException('extended cost ID exceeds signed int32 range');
    }
    return id;
  }
}
