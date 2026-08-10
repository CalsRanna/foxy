import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/entity/spell_item_enchantment_entity.dart';
import 'package:foxy_annotation/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/infrastructure/util/parse_util.dart';
import 'package:foxy/repository/dbc_locale_repository_mixin.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'spell_item_enchantment_repository.g.dart';

@FoxyRepository()
@FoxyFilter.text('id')
@FoxyFilter.text('name', column: 'Name_lang_zhCN')
class SpellItemEnchantmentRepository
    with
        RepositoryMixin,
        DbcLocaleRepositoryMixin,
        _SpellItemEnchantmentRepositoryMixin {
  @override
  String get dbcLocaleTableName => _table;

  @override
  Future<int> copySpellItemEnchantment(int key) async {
    final source = await getSpellItemEnchantment(key);
    if (source == null) {
      throw RecordNotFoundException('record not found');
    }
    final copied = source.copyWith(id: await _getNextId());
    await storeSpellItemEnchantment(copied);
    return copied.id;
  }

  @override
  Future<SpellItemEnchantmentEntity> createSpellItemEnchantment() async {
    return SpellItemEnchantmentEntity(id: await _getNextId());
  }

  @override
  QueryBuilder _applyFilter(
    QueryBuilder builder,
    SpellItemEnchantmentFilter? filter,
  ) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('ID', int.tryParse(filter.id) ?? 0);
    }
    if (filter.name.isNotEmpty) {
      builder = builder.where(
        'Name_lang_zhCN',
        '%${ParseUtil.escapeLike(filter.name)}%',
        comparator: 'like',
      );
    }
    return builder;
  }

  Future<int> _getNextId() async {
    final id = await nextMaxPlusOne(_table, 'ID');
    if (id > 0x7fffffff) {
      throw IdExhaustedException(
        'SpellItemEnchantment ID exceeds DBC int32 range',
      );
    }
    return id;
  }
}
