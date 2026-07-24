import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/entity/item_visual_effect_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'item_visual_effect_repository.g.dart';

@FoxyRepository(ItemVisualEffectEntity)
@FoxyFilter.text('id')
@FoxyFilter.text('model')
class ItemVisualEffectRepository
    with RepositoryMixin, _ItemVisualEffectRepositoryMixin {
  static const _table = 'foxy.dbc_item_visual_effects';

  Future<int> copyItemVisualEffect(int key) async {
    final source = await getItemVisualEffect(key);
    if (source == null) {
      throw StateError('原物品视觉效果不存在，可能已被其他操作修改或删除');
    }
    final copied = source.copyWith(id: await nextMaxPlusOne(_table, 'ID'));
    await storeItemVisualEffect(copied);
    return copied.id;
  }

  Future<int> countItemVisualEffects({ItemVisualEffectFilter? filter}) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<ItemVisualEffectEntity> createItemVisualEffect() async {
    return ItemVisualEffectEntity(id: await nextMaxPlusOne(_table, 'ID'));
  }

  Future<List<BriefItemVisualEffectEntity>> getBriefItemVisualEffects({
    int page = 1,
    ItemVisualEffectFilter? filter,
  }) async {
    var builder = laconic.table(_table).select(const ['ID', 'Model']);
    builder = _applyFilter(builder, filter);
    final results = await builder
        .orderBy('ID')
        .limit(kPageSize)
        .offset((page - 1) * kPageSize)
        .get();
    return results
        .map((row) => BriefItemVisualEffectEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<List<ItemVisualEffectEntity>> getItemVisualEffects() async {
    final results = await laconic.table(_table).get();
    return results
        .map((row) => ItemVisualEffectEntity.fromJson(row.toMap()))
        .toList();
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    ItemVisualEffectFilter? filter,
  ) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('ID', filter.id);
    }
    if (filter.model.isNotEmpty) {
      builder = builder.where('Model', '%${filter.model}%', comparator: 'like');
    }
    return builder;
  }
}
