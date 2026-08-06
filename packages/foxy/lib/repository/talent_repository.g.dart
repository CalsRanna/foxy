// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'talent_repository.dart';

final class TalentFilter {
  final String id;
  final String spell;

  const TalentFilter({this.id = '', this.spell = ''});

  factory TalentFilter.fromJson(Map<String, dynamic> json) {
    return TalentFilter(
      id: json['id']?.toString() ?? '',
      spell: json['spell']?.toString() ?? '',
    );
  }

  TalentFilter copyWith({String? id, String? spell}) {
    return TalentFilter(id: id ?? this.id, spell: spell ?? this.spell);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'spell': spell};
  }
}

mixin _TalentRepositoryMixin on RepositoryMixin {
  Future<int> copyTalent(int key) async {
    final source = await getTalent(key);
    if (source == null) {
      throw RecordNotFoundException('foxy.dbc_talent record not found');
    }
    final blank = await createTalent();
    final copied = source.copyWith(id: blank.id);
    await storeTalent(copied);
    return copied.id;
  }

  Future<int> countTalents({TalentFilter? filter}) async {
    return _applyFilter(laconic.table('foxy.dbc_talent'), filter).count();
  }

  Future<TalentEntity> createTalent() async {
    return TalentEntity(id: await nextMaxPlusOne('foxy.dbc_talent', '`ID`'));
  }

  Future<void> destroyTalent(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_talent'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException('foxy.dbc_talent record not found');
    }
  }

  Future<TalentEntity?> getTalent(int key) async {
    final results = await _whereKey(
      laconic.table('foxy.dbc_talent'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return TalentEntity.fromJson(results.first.toMap());
  }

  Future<List<BriefTalentEntity>> getBriefTalents({
    int page = 1,
    TalentFilter? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table('foxy.dbc_talent').select([
      '`ID`',
      '`TabID`',
      '`TierID`',
      '`ColumnIndex`',
      '`SpellRank0`',
    ]);
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('`ID`');
    builder = builder.limit(kPageSize).offset(offset);
    final results = await builder.get();
    return results.map((e) => BriefTalentEntity.fromJson(e.toMap())).toList();
  }

  Future<List<TalentEntity>> getTalents() async {
    var builder = laconic.table('foxy.dbc_talent').orderBy('`ID`');
    final results = await builder.get();
    return results.map((e) => TalentEntity.fromJson(e.toMap())).toList();
  }

  Future<int> storeTalent(TalentEntity talent) async {
    if (talent.id <= 0) {
      throw InvalidPrimaryKeyException(
        'primary key must be assigned before store',
      );
    }
    await _beforeStore(talent);
    final json = prepareWriteJson(talent.toJson());
    try {
      await laconic.table('foxy.dbc_talent').insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = talent.copyWith(
        id: await nextMaxPlusOne('foxy.dbc_talent', '`ID`'),
      );
      try {
        await laconic.table('foxy.dbc_talent').insert([
          prepareWriteJson(retried.toJson()),
        ]);
        return retried.id;
      } catch (retryError) {
        if (MysqlErrorUtil.isDuplicateEntry(retryError)) {
          throw DuplicateKeyException('duplicate key in foxy.dbc_talent');
        }
        rethrow;
      }
    }
    return talent.id;
  }

  Future<void> updateTalent(int originalKey, TalentEntity talent) async {
    await _beforeUpdate(originalKey, talent);
    final json = prepareWriteJson(talent.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table('foxy.dbc_talent'),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException('duplicate key in foxy.dbc_talent');
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException('foxy.dbc_talent record not found');
    }
  }

  QueryBuilder _applyFilter(QueryBuilder builder, TalentFilter? filter) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('`ID`', filter.id);
    }
    if (filter.spell.isNotEmpty) {
      builder = builder.where('`SpellRank0`', filter.spell);
    }
    return builder;
  }

  Future<void> _beforeDestroy(int key) async {}

  Future<void> _beforeStore(TalentEntity talent) async {}

  Future<void> _beforeUpdate(int originalKey, TalentEntity talent) async {}

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('`ID`', key);
  }
}
