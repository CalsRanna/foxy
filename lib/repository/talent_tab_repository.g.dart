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
  Future<void> destroyTalentTab(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_talent_tab'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<TalentTabEntity?> getTalentTab(int key) async {
    final results = await _whereKey(
      laconic.table('foxy.dbc_talent_tab'),
      key,
    ).limit(1).get();
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

  Future<void> storeTalentTab(TalentTabEntity talentTab) async {
    if (talentTab.id <= 0) {
      throw StateError('主键必须在新建时显式分配');
    }
    await _beforeStore(talentTab);
    final json = prepareWriteJson(talentTab.toJson());
    try {
      await laconic.table('foxy.dbc_talent_tab').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateTalentTab(
    int originalKey,
    TalentTabEntity talentTab,
  ) async {
    await _beforeUpdate(originalKey, talentTab);
    final json = prepareWriteJson(talentTab.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table('foxy.dbc_talent_tab'),
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

  Future<void> _beforeDestroy(int key) async {}

  Future<void> _beforeStore(TalentTabEntity talentTab) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    TalentTabEntity talentTab,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('`ID`', key);
  }
}
