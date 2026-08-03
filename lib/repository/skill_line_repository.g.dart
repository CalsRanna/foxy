// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skill_line_repository.dart';

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

mixin _SkillLineRepositoryMixin on RepositoryMixin {
  Future<void> destroySkillLine(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_skill_line'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException('foxy.dbc_skill_line record not found');
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
      throw InvalidPrimaryKeyException(
        'primary key must be assigned before store',
      );
    }
    await _beforeStore(skillLine);
    final json = prepareWriteJson(skillLine.toJson());
    try {
      await laconic.table('foxy.dbc_skill_line').insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = skillLine.copyWith(
        id: await nextMaxPlusOne('foxy.dbc_skill_line', '`ID`'),
      );
      try {
        await laconic.table('foxy.dbc_skill_line').insert([
          prepareWriteJson(retried.toJson()),
        ]);
        return;
      } catch (retryError) {
        if (MysqlErrorUtil.isDuplicateEntry(retryError)) {
          throw DuplicateKeyException('duplicate key in foxy.dbc_skill_line');
        }
        rethrow;
      }
    }
  }

  Future<void> updateSkillLine(
    int originalKey,
    SkillLineEntity skillLine,
  ) async {
    await _beforeUpdate(originalKey, skillLine);
    final json = prepareWriteJson(skillLine.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table('foxy.dbc_skill_line'),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException('duplicate key in foxy.dbc_skill_line');
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException('foxy.dbc_skill_line record not found');
    }
  }

  Future<void> _beforeDestroy(int key) async {}

  Future<void> _beforeStore(SkillLineEntity skillLine) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    SkillLineEntity skillLine,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('`ID`', key);
  }
}
