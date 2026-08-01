// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spell_repository.dart';

final class SpellFilter {
  final String id;
  final String name;

  const SpellFilter({this.id = '', this.name = ''});

  factory SpellFilter.fromJson(Map<String, dynamic> json) {
    return SpellFilter(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  SpellFilter copyWith({String? id, String? name}) {
    return SpellFilter(id: id ?? this.id, name: name ?? this.name);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}

mixin _SpellRepositoryMixin on RepositoryMixin {
  Future<int> copySpell(int key) async {
    final source = await getSpell(key);
    if (source == null) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
    final blank = await createSpell();
    final copied = source.copyWith(id: blank.id);
    await storeSpell(copied);
    return copied.id;
  }

  Future<int> countSpells({SpellFilter? filter}) async {
    return _applyFilter(laconic.table('foxy.dbc_spell'), filter).count();
  }

  Future<SpellEntity> createSpell() async {
    return SpellEntity(id: await nextMaxPlusOne('foxy.dbc_spell', '`ID`'));
  }

  Future<void> destroySpell(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_spell'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<SpellEntity?> getSpell(int key) async {
    final results = await _whereKey(
      laconic.table('foxy.dbc_spell'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return SpellEntity.fromJson(results.first.toMap());
  }

  Future<List<BriefSpellEntity>> getBriefSpells({
    int page = 1,
    SpellFilter? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table('foxy.dbc_spell').select(['`ID`']);
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('`ID`');
    builder = builder.limit(kPageSize).offset(offset);
    final results = await builder.get();
    return results.map((e) => BriefSpellEntity.fromJson(e.toMap())).toList();
  }

  Future<List<SpellEntity>> getSpells() async {
    var builder = laconic.table('foxy.dbc_spell').orderBy('`ID`');
    final results = await builder.get();
    return results.map((e) => SpellEntity.fromJson(e.toMap())).toList();
  }

  Future<void> storeSpell(SpellEntity spell) async {
    if (spell.id <= 0) {
      throw StateError('主键必须在新建时显式分配');
    }
    await _beforeStore(spell);
    final json = prepareWriteJson(spell.toJson());
    try {
      await laconic.table('foxy.dbc_spell').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateSpell(int originalKey, SpellEntity spell) async {
    await _beforeUpdate(originalKey, spell);
    final json = prepareWriteJson(spell.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table('foxy.dbc_spell'),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的主键已存在');
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  QueryBuilder _applyFilter(QueryBuilder builder, SpellFilter? filter) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('`ID`', filter.id);
    }
    if (filter.name.isNotEmpty) {
      builder = builder.where('`ds.Name_lang_zhCN`', filter.name);
    }
    return builder;
  }

  Future<void> _beforeDestroy(int key) async {}

  Future<void> _beforeStore(SpellEntity spell) async {}

  Future<void> _beforeUpdate(int originalKey, SpellEntity spell) async {}

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('`ID`', key);
  }
}
