// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spell_item_enchantment_repository.dart';

final class SpellItemEnchantmentFilter {
  final String id;
  final String name;

  const SpellItemEnchantmentFilter({this.id = '', this.name = ''});

  factory SpellItemEnchantmentFilter.fromJson(Map<String, dynamic> json) {
    return SpellItemEnchantmentFilter(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  SpellItemEnchantmentFilter copyWith({String? id, String? name}) {
    return SpellItemEnchantmentFilter(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}

mixin _SpellItemEnchantmentRepositoryMixin
    on RepositoryMixin, DbcLocaleRepositoryMixin {
  Future<int> copySpellItemEnchantment(int key) async {
    final source = await getSpellItemEnchantment(key);
    if (source == null) {
      throw RecordNotFoundException(
        'foxy.dbc_spell_item_enchantment record not found',
      );
    }
    final blank = await createSpellItemEnchantment();
    final copied = source.copyWith(id: blank.id);
    await storeSpellItemEnchantment(copied);
    return copied.id;
  }

  Future<int> countSpellItemEnchantments({
    SpellItemEnchantmentFilter? filter,
  }) async {
    return _applyFilter(
      laconic.table('foxy.dbc_spell_item_enchantment'),
      filter,
    ).count();
  }

  Future<SpellItemEnchantmentEntity> createSpellItemEnchantment() async {
    return SpellItemEnchantmentEntity(
      id: await nextMaxPlusOne('foxy.dbc_spell_item_enchantment', '`ID`'),
    );
  }

  Future<void> destroySpellItemEnchantment(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_spell_item_enchantment'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException(
        'foxy.dbc_spell_item_enchantment record not found',
      );
    }
  }

  Future<SpellItemEnchantmentEntity?> getSpellItemEnchantment(int key) async {
    final results = await _whereKey(
      laconic.table('foxy.dbc_spell_item_enchantment'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return SpellItemEnchantmentEntity.fromJson(results.first.toMap());
  }

  Future<List<BriefSpellItemEnchantmentEntity>> getBriefSpellItemEnchantments({
    int page = 1,
    SpellItemEnchantmentFilter? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table('foxy.dbc_spell_item_enchantment').select([
      '`ID`',
      '`Charges`',
      '`Effect0`',
      '`Effect1`',
      '`Effect2`',
      '`Name_lang_zhCN`',
    ]);
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('`ID`');
    builder = builder.limit(kPageSize).offset(offset);
    final results = await builder.get();
    return results
        .map((e) => BriefSpellItemEnchantmentEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<List<SpellItemEnchantmentEntity>> getSpellItemEnchantments() async {
    var builder = laconic
        .table('foxy.dbc_spell_item_enchantment')
        .orderBy('`ID`');
    final results = await builder.get();
    return results
        .map((e) => SpellItemEnchantmentEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<List<DbcLocaleFieldValue>> getSpellItemEnchantmentLocales(
    int id,
    DbcLocaleFieldDefinition field,
  ) => loadDbcLocaleField(id, field);

  Future<void> saveSpellItemEnchantmentLocales(
    int id,
    DbcLocaleFieldDefinition field,
    List<DbcLocaleFieldValue> locales,
  ) => storeDbcLocaleField(id, field, locales);

  Future<void> storeSpellItemEnchantment(
    SpellItemEnchantmentEntity spellItemEnchantment,
  ) async {
    if (spellItemEnchantment.id <= 0) {
      throw InvalidPrimaryKeyException(
        'primary key must be assigned before store',
      );
    }
    await _beforeStore(spellItemEnchantment);
    final json = prepareWriteJson(spellItemEnchantment.toJson());
    try {
      await laconic.table('foxy.dbc_spell_item_enchantment').insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = spellItemEnchantment.copyWith(
        id: await nextMaxPlusOne('foxy.dbc_spell_item_enchantment', '`ID`'),
      );
      try {
        await laconic.table('foxy.dbc_spell_item_enchantment').insert([
          prepareWriteJson(retried.toJson()),
        ]);
        return;
      } catch (retryError) {
        if (MysqlErrorUtil.isDuplicateEntry(retryError)) {
          throw DuplicateKeyException(
            'duplicate key in foxy.dbc_spell_item_enchantment',
          );
        }
        rethrow;
      }
    }
  }

  Future<void> updateSpellItemEnchantment(
    int originalKey,
    SpellItemEnchantmentEntity spellItemEnchantment,
  ) async {
    await _beforeUpdate(originalKey, spellItemEnchantment);
    final json = prepareWriteJson(spellItemEnchantment.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table('foxy.dbc_spell_item_enchantment'),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException(
          'duplicate key in foxy.dbc_spell_item_enchantment',
        );
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException(
        'foxy.dbc_spell_item_enchantment record not found',
      );
    }
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    SpellItemEnchantmentFilter? filter,
  ) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('`ID`', int.tryParse(filter.id) ?? 0);
    }
    if (filter.name.isNotEmpty) {
      builder = builder.where('`Name_lang_zhCN`', filter.name);
    }
    return builder;
  }

  Future<void> _beforeDestroy(int key) async {}

  Future<void> _beforeStore(
    SpellItemEnchantmentEntity spellItemEnchantment,
  ) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    SpellItemEnchantmentEntity spellItemEnchantment,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('`ID`', key);
  }
}
