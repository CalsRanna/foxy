import 'package:foxy/entity/item_extended_cost_entity.dart';
import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'item_extended_cost_repository.g.dart';

@FoxyRepository(ItemExtendedCostEntity)
@FoxyFilter.text('id')
class ItemExtendedCostRepository
    with RepositoryMixin, _ItemExtendedCostRepositoryMixin {
  static const _table = 'foxy.dbc_item_extended_cost';

  @override
  Future<int> copyItemExtendedCost(int key) async {
    final source = await getItemExtendedCost(key);
    if (source == null) {
      throw StateError('原扩展价格不存在，可能已被其他操作修改或删除');
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
      throw StateError('扩展价格编号已超出 signed int32 范围');
    }
    return id;
  }
}
