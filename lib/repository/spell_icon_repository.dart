import 'package:foxy/entity/spell_icon_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class SpellIconRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_spell_icon';

  Future<List<SpellIconEntity>> getSpellIcons({
    String? id,
    String? name,
    required int page,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, id: id, name: name);
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results.map((e) => SpellIconEntity.fromJson(e.toMap())).toList();
  }

  Future<int> countSpellIcons({String? id, String? name}) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, id: id, name: name);
    return builder.count();
  }

  dynamic _applyFilter(dynamic builder, {String? id, String? name}) {
    if (id != null && id.isNotEmpty) {
      builder = builder.where('ID', id);
    }
    if (name != null && name.isNotEmpty) {
      builder = builder.where('TextureFilename', '%$name%', comparator: 'like');
    }
    return builder;
  }
}
