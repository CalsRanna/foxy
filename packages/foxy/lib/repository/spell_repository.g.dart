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

mixin _SpellRepositoryMixin on RepositoryMixin, DbcLocaleRepositoryMixin {
  Future<int> copySpell(int key) async {
    final source = await getSpell(key);
    if (source == null) {
      throw RecordNotFoundException('foxy.dbc_spell record not found');
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
      throw RecordNotFoundException('foxy.dbc_spell record not found');
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

  Future<List<DbcLocaleFieldValue>> getSpellLocales(
    int id,
    DbcLocaleFieldDefinition field,
  ) => loadDbcLocaleField(id, field);

  Future<void> saveSpellLocales(
    int id,
    DbcLocaleFieldDefinition field,
    List<DbcLocaleFieldValue> locales,
  ) => storeDbcLocaleField(id, field, locales);

  Future<int> storeSpell(SpellEntity spell) async {
    if (spell.id <= 0) {
      throw InvalidPrimaryKeyException(
        'primary key must be assigned before store',
      );
    }
    await _beforeStore(spell);
    final json = prepareWriteJson(spell.toJson());
    try {
      await laconic.table('foxy.dbc_spell').insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = spell.copyWith(
        id: await nextMaxPlusOne('foxy.dbc_spell', '`ID`'),
      );
      try {
        await laconic.table('foxy.dbc_spell').insert([
          prepareWriteJson(retried.toJson()),
        ]);
        return retried.id;
      } catch (retryError) {
        if (MysqlErrorUtil.isDuplicateEntry(retryError)) {
          throw DuplicateKeyException('duplicate key in foxy.dbc_spell');
        }
        rethrow;
      }
    }
    return spell.id;
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
        throw DuplicateKeyException('duplicate key in foxy.dbc_spell');
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException('foxy.dbc_spell record not found');
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
