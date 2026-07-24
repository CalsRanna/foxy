// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skill_line_repository.dart';

mixin _SkillLineRepositoryMixin on RepositoryMixin {
  Future<void> destroySkillLine(int key) async {
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_skill_line'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<SkillLineEntity?> getSkillLine(int key) async {
    final results = await _whereKey(
      laconic.table('foxy.dbc_skill_line'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return SkillLineEntity.fromJson(results.first.toMap());
  }

  Future<void> storeSkillLine(SkillLineEntity skillLine) async {
    if (skillLine.id <= 0) {
      throw StateError('主键必须在新建时显式分配');
    }
    await _beforeStore(skillLine);
    final json = _prepareWriteJson(skillLine.toJson());
    try {
      await laconic.table('foxy.dbc_skill_line').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateSkillLine(
    int originalKey,
    SkillLineEntity skillLine,
  ) async {
    await _beforeUpdate(originalKey, skillLine);
    final json = _prepareWriteJson(skillLine.toJson());
    try {
      final matchedRows = await _whereKey(
        laconic.table('foxy.dbc_skill_line'),
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

  Future<void> _beforeStore(SkillLineEntity skillLine) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    SkillLineEntity skillLine,
  ) async {}

  Map<String, dynamic> _prepareWriteJson(Map<String, dynamic> json) {
    for (final key in json.keys.toList()) {
      if (const {'index', 'rank'}.contains(key.toLowerCase())) {
        json['`$key`'] = json.remove(key);
      }
    }
    return json;
  }

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('ID', key);
  }
}

final class SkillLineFilter {
  final String id;
  final String name;

  const SkillLineFilter({this.id = '', this.name = ''});

  factory SkillLineFilter.fromJson(Map<String, dynamic> json) {
    return SkillLineFilter(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  SkillLineFilter copyWith({String? id, String? name}) {
    return SkillLineFilter(id: id ?? this.id, name: name ?? this.name);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
