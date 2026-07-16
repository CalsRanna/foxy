import 'package:foxy/entity/spell_icon_entity.dart';
import 'package:foxy/entity/spell_icon_filter_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class SpellIconRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_spell_icon';

  Future<void> copySpellIcon(int id) async {
    var source = await getSpellIcon(id);
    if (source == null) return;
    var json = source.toJson();
    var nextId = await nextMaxPlusOne(_table, 'ID');
    json['ID'] = nextId;
    await laconic.table(_table).insert([json]);
  }

  Future<int> countSpellIcons({SpellIconFilterEntity? filter}) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<SpellIconEntity> createSpellIcon() async {
    return SpellIconEntity(id: await nextMaxPlusOne(_table, 'ID'));
  }

  Future<void> destroySpellIcon(int id) async {
    await laconic.table(_table).where('ID', id).delete();
  }

  Future<List<BriefSpellIconEntity>> getBriefSpellIcons({
    int page = 1,
    SpellIconFilterEntity? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    builder = builder.select(['ID', 'TextureFilename']);
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('ID');
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results
        .map((e) => BriefSpellIconEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<SpellIconEntity?> getSpellIcon(int id) async {
    var results = await laconic.table(_table).where('ID', id).limit(1).get();
    if (results.isEmpty) return null;
    return SpellIconEntity.fromJson(results.first.toMap());
  }

  Future<List<SpellIconEntity>> getSpellIcons() async {
    var results = await laconic.table(_table).get();
    return results.map((e) => SpellIconEntity.fromJson(e.toMap())).toList();
  }

  Future<void> saveSpellIcon(SpellIconEntity icon) async {
    if (icon.id == 0) {
      await storeSpellIcon(icon);
      return;
    }
    var existing = await getSpellIcon(icon.id);
    if (existing != null) {
      await updateSpellIcon(icon);
    } else {
      await laconic.table(_table).insert([icon.toJson()]);
    }
  }

  Future<int> storeSpellIcon(SpellIconEntity icon) async {
    var json = icon.toJson();
    final nextId = icon.id > 0 ? icon.id : await nextMaxPlusOne(_table, 'ID');
    json['ID'] = nextId;
    await laconic.table(_table).insert([json]);
    return nextId;
  }

  Future<void> updateSpellIcon(SpellIconEntity icon) async {
    var json = icon.toJson();
    json.remove('ID');
    await laconic.table(_table).where('ID', icon.id).update(json);
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    SpellIconFilterEntity? filter,
  ) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('ID', filter.id);
    }
    if (filter.name.isNotEmpty) {
      builder = builder.where(
        'TextureFilename',
        '%${filter.name}%',
        comparator: 'like',
      );
    }
    return builder;
  }
}
