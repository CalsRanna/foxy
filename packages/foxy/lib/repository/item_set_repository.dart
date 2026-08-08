import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/entity/item_set_entity.dart';
import 'package:foxy_annotation/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/infrastructure/util/parse_util.dart';
import 'package:foxy/repository/dbc_locale_repository_mixin.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'item_set_repository.g.dart';

@FoxyRepository()
@FoxyFilter.text('id')
@FoxyFilter.text('name', column: 'Name_lang_zhCN')
class ItemSetRepository
    with RepositoryMixin, DbcLocaleRepositoryMixin, _ItemSetRepositoryMixin {
  static const _table = 'foxy.dbc_item_set';

  @override
  String get dbcLocaleTableName => _table;

  @override
  Future<int> copyItemSet(int key) async {
    final source = await getItemSet(key);
    if (source == null) {
      throw RecordNotFoundException('record not found');
    }
    final copied = source.copyWith(id: await _getNextId());
    await storeItemSet(copied);
    return copied.id;
  }

  @override
  Future<ItemSetEntity> createItemSet() async {
    return ItemSetEntity(id: await _getNextId());
  }

  @override
  QueryBuilder _applyFilter(QueryBuilder builder, ItemSetFilter? filter) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('ID', int.tryParse(filter.id) ?? 0);
    }
    if (filter.name.isNotEmpty) {
      builder = builder.where(
        'Name_lang_zhCN',
        '%${escapeLike(filter.name)}%',
        comparator: 'like',
      );
    }
    return builder;
  }

  Future<int> _getNextId() async {
    final id = await nextMaxPlusOne(_table, 'ID');
    if (id > 0x7FFFFFFF) {
      throw IdExhaustedException('no free int32 ID left in ItemSet.dbc');
    }
    return id;
  }
}
