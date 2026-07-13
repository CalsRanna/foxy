import 'package:foxy/entity/item_bag_family_entity.dart';
import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/repository/dbc_locale_repository_mixin.dart';
import 'package:foxy/repository/repository_mixin.dart';

class ItemBagFamilyRepository with RepositoryMixin, DbcLocaleRepositoryMixin {
  static const _table = 'foxy.dbc_item_bag_family';

  @override
  String get dbcLocaleTableName => _table;

  Future<List<ItemBagFamilyEntity>> getItemBagFamilies() async {
    final rows = await laconic.table(_table).get();
    return rows
        .map((row) => ItemBagFamilyEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<int> countItemBagFamilies() => laconic.table(_table).count();

  Future<List<DbcLocaleFieldValue>> getItemBagFamilyLocales(
    int id,
    DbcLocaleFieldDefinition field,
  ) => loadDbcLocaleField(id, field);

  Future<void> saveItemBagFamilyLocales(
    int id,
    DbcLocaleFieldDefinition field,
    List<DbcLocaleFieldValue> locales,
  ) => storeDbcLocaleField(id, field, locales);
}
