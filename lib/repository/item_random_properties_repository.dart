import 'package:foxy/entity/item_random_properties_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class ItemRandomPropertiesRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_item_random_properties';

  Future<List<BriefItemRandomPropertiesEntity>>
  getBriefItemRandomProperties({
    int page = 1,
    String? id,
    String? name,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    builder = builder.select(['ID', 'Name', 'Name_lang_zhCN']);
    builder = _applyFilter(builder, id: id, name: name);
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results
        .map((e) => BriefItemRandomPropertiesEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<List<ItemRandomPropertiesEntity>> getItemRandomProperties() async {
    var results = await laconic.table(_table).get();
    return results
        .map((e) => ItemRandomPropertiesEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<int> countItemRandomProperties({String? id, String? name}) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, id: id, name: name);
    return builder.count();
  }

  Future<ItemRandomPropertiesEntity?> getItemRandomProperty(int id) async {
    var results = await laconic.table(_table).where('ID', id).limit(1).get();
    if (results.isEmpty) return null;
    return ItemRandomPropertiesEntity.fromJson(results.first.toMap());
  }

  Future<ItemRandomPropertiesEntity> createItemRandomProperty() async {
    return const ItemRandomPropertiesEntity();
  }

  Future<int> storeItemRandomProperty(
    ItemRandomPropertiesEntity property,
  ) async {
    var json = property.toJson();
    var nextId = await _getNextId();
    json['ID'] = nextId;
    await laconic.table(_table).insert([json]);
    return nextId;
  }

  Future<void> updateItemRandomProperty(
    ItemRandomPropertiesEntity property,
  ) async {
    var json = property.toJson();
    json.remove('ID');
    await laconic.table(_table).where('ID', property.id).update(json);
  }

  Future<void> destroyItemRandomProperty(int id) async {
    await laconic.table(_table).where('ID', id).delete();
  }

  Future<void> copyItemRandomProperty(int id) async {
    var source = await getItemRandomProperty(id);
    if (source == null) return;
    var json = source.toJson();
    var nextId = await _getNextId();
    json['ID'] = nextId;
    await laconic.table(_table).insert([json]);
  }

  Future<void> saveItemRandomProperty(
    ItemRandomPropertiesEntity property,
  ) async {
    if (property.id == 0) {
      await storeItemRandomProperty(property);
      return;
    }
    var existing = await getItemRandomProperty(property.id);
    if (existing != null) {
      await updateItemRandomProperty(property);
    } else {
      await laconic.table(_table).insert([property.toJson()]);
    }
  }

  Future<int> _getNextId() async {
    var result = await laconic.table(_table).select([
      'MAX(ID) as max_id',
    ]).first();
    var maxId = result.toMap()['max_id'] as int?;
    return (maxId ?? 0) + 1;
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder, {
    String? id,
    String? name,
  }) {
    if (id != null && id.isNotEmpty) {
      builder = builder.where('ID', id);
    }
    if (name != null && name.isNotEmpty) {
      builder = builder.where(
        'Name_lang_zhCN',
        '%$name%',
        comparator: 'like',
      );
    }
    return builder;
  }
}
