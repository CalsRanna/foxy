// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'talent_tab_repository.dart';

mixin _TalentTabRepositoryMixin on RepositoryMixin {
  Future<void> destroyTalentTab(int key) async {
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

  Future<void> storeTalentTab(TalentTabEntity talentTab) async {
    if (talentTab.id <= 0) {
      throw StateError('主键必须在新建时显式分配');
    }
    await _beforeStore(talentTab);
    final json = _prepareWriteJson(talentTab.toJson());
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
    final json = _prepareWriteJson(talentTab.toJson());
    try {
      final matchedRows = await _whereKey(
        laconic.table('foxy.dbc_talent_tab'),
        originalKey,
      ).update(json);
      if (matchedRows == 0) {
        throw StateError('原记录不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的主键已存在');
      }
      rethrow;
    }
  }

  Future<void> _beforeStore(TalentTabEntity talentTab) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    TalentTabEntity talentTab,
  ) async {}

  Map<String, dynamic> _prepareWriteJson(Map<String, dynamic> json) {
    return {
      for (final entry in json.entries)
        if (const {'index', 'rank'}.contains(entry.key.toLowerCase()))
          '`${entry.key}`': entry.value
        else
          entry.key: entry.value,
    };
  }

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('ID', key);
  }
}

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
