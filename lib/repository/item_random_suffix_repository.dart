import 'package:foxy/entity/item_random_suffix_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class ItemRandomSuffixRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_item_random_suffix';

  Future<List<ItemRandomSuffixEntity>> getItemRandomSuffixes({
    String? id,
    String? name,
    required int page,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, id: id, name: name);
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results
        .map((e) => ItemRandomSuffixEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<int> countItemRandomSuffixes({String? id, String? name}) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, id: id, name: name);
    return builder.count();
  }

  dynamic _applyFilter(dynamic builder, {String? id, String? name}) {
    if (id != null && id.isNotEmpty) {
      builder = builder.where('ID', id);
    }
    if (name != null && name.isNotEmpty) {
      builder = builder.where('Name_lang_zhCN', '%$name%', comparator: 'like');
    }
    return builder;
  }
}
