// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'talent_tab_repository.dart';

final class TalentTabFilter {
  final String id;
  final String name;

  const TalentTabFilter({this.id = '', this.name = ''});

  factory TalentTabFilter.fromJson(Map<String, dynamic> json) {
    return TalentTabFilter(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  TalentTabFilter copyWith({String? id, String? name}) {
    return TalentTabFilter(id: id ?? this.id, name: name ?? this.name);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}

mixin _TalentTabRepositoryMixin on RepositoryMixin, DbcLocaleRepositoryMixin {
  String get _table => 'foxy.dbc_talent_tab';

  Future<void> destroyTalentTab(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await trackActivityWrite(
      _table,
      beforeKey: activityKey(key),
      write: () => _whereKey(laconic.table(_table), key).delete(),
    );
    if (deletedRows == 0) {
      throw RecordNotFoundException('foxy.dbc_talent_tab record not found');
    }
  }

  Future<TalentTabEntity?> getTalentTab(int key) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return TalentTabEntity.fromJson(results.first.toMap());
  }

  Future<List<DbcLocaleFieldValue>> getTalentTabLocales(
    int id,
    DbcLocaleFieldDefinition field,
  ) => loadDbcLocaleField(id, field);

  Future<void> saveTalentTabLocales(
    int id,
    DbcLocaleFieldDefinition field,
    List<DbcLocaleFieldValue> locales,
  ) => storeDbcLocaleField(id, field, locales);

  Future<int> storeTalentTab(TalentTabEntity talentTab) async {
    if (talentTab.id <= 0) {
      throw InvalidPrimaryKeyException(
        'primary key must be assigned before store',
      );
    }
    await _beforeStore(talentTab);
    final json = prepareWriteJson(talentTab.toJson());
    try {
      await trackActivityWrite(
        _table,
        afterKey: activityKey(talentTab.id),
        write: () => laconic.table(_table).insert([json]),
      );
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = talentTab.copyWith(
        id: await nextMaxPlusOne(_table, '`ID`'),
      );
      try {
        await trackActivityWrite(
          _table,
          afterKey: activityKey(retried.id),
          write: () => laconic.table(_table).insert([
            prepareWriteJson(retried.toJson()),
          ]),
        );
        return retried.id;
      } catch (retryError) {
        if (MysqlErrorUtil.isDuplicateEntry(retryError)) {
          throw DuplicateKeyException('duplicate key in foxy.dbc_talent_tab');
        }
        rethrow;
      }
    }
    return talentTab.id;
  }

  Future<void> updateTalentTab(
    int originalKey,
    TalentTabEntity talentTab,
  ) async {
    await _beforeUpdate(originalKey, talentTab);
    final values = talentTab.toJson();
    final json = prepareWriteJson(values);
    final int matchedRows;
    try {
      matchedRows = await trackActivityWrite(
        _table,
        beforeKey: activityKey(originalKey),
        afterKey: activityKey(talentTab.id),
        columns: values.keys,
        write: () => _whereKey(laconic.table(_table), originalKey).update(json),
      );
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException('duplicate key in foxy.dbc_talent_tab');
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException('foxy.dbc_talent_tab record not found');
    }
  }

  Future<void> _beforeDestroy(int key) async {}

  Future<void> _beforeStore(TalentTabEntity talentTab) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    TalentTabEntity talentTab,
  ) async {}

  Map<String, Object?> activityKey(int key) => {'ID': key};

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('`ID`', key);
  }
}
