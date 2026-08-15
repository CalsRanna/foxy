// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spell_duration_repository.dart';

final class SpellDurationFilter {
  final String id;

  const SpellDurationFilter({this.id = ''});

  factory SpellDurationFilter.fromJson(Map<String, dynamic> json) {
    return SpellDurationFilter(id: json['id']?.toString() ?? '');
  }

  SpellDurationFilter copyWith({String? id}) {
    return SpellDurationFilter(id: id ?? this.id);
  }

  Map<String, dynamic> toJson() {
    return {'id': id};
  }
}

mixin _SpellDurationRepositoryMixin on RepositoryMixin {
  String get _table => 'foxy.dbc_spell_duration';

  Future<void> destroySpellDuration(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException('foxy.dbc_spell_duration record not found');
    }
  }

  Future<SpellDurationEntity?> getSpellDuration(int key) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return SpellDurationEntity.fromJson(results.first.toMap());
  }

  Future<int> storeSpellDuration(SpellDurationEntity spellDuration) async {
    if (spellDuration.id <= 0) {
      throw InvalidPrimaryKeyException(
        'primary key must be assigned before store',
      );
    }
    await _beforeStore(spellDuration);
    final json = prepareWriteJson(spellDuration.toJson());
    try {
      await laconic.table(_table).insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = spellDuration.copyWith(
        id: await nextMaxPlusOne(_table, '`ID`'),
      );
      try {
        await laconic.table(_table).insert([
          prepareWriteJson(retried.toJson()),
        ]);
        return retried.id;
      } catch (retryError) {
        if (MysqlErrorUtil.isDuplicateEntry(retryError)) {
          throw DuplicateKeyException(
            'duplicate key in foxy.dbc_spell_duration',
          );
        }
        rethrow;
      }
    }
    return spellDuration.id;
  }

  Future<void> updateSpellDuration(
    int originalKey,
    SpellDurationEntity spellDuration,
  ) async {
    await _beforeUpdate(originalKey, spellDuration);
    final json = prepareWriteJson(spellDuration.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException('duplicate key in foxy.dbc_spell_duration');
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException('foxy.dbc_spell_duration record not found');
    }
  }

  Future<void> _beforeDestroy(int key) async {}

  Future<void> _beforeStore(SpellDurationEntity spellDuration) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    SpellDurationEntity spellDuration,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('`ID`', key);
  }
}
