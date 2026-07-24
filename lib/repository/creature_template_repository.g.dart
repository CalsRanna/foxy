// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_template_repository.dart';

mixin _CreatureTemplateRepositoryMixin on RepositoryMixin {
  Future<void> destroyCreatureTemplate(int key) async {
    final deletedRows = await _whereKey(
      laconic.table('creature_template'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<CreatureTemplateEntity?> getCreatureTemplate(int key) async {
    final results = await _whereKey(
      laconic.table('creature_template'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return CreatureTemplateEntity.fromJson(results.first.toMap());
  }

  Future<void> storeCreatureTemplate(
    CreatureTemplateEntity creatureTemplate,
  ) async {
    if (creatureTemplate.entry <= 0) {
      throw StateError('主键必须在新建时显式分配');
    }
    await _beforeStore(creatureTemplate);
    final json = _prepareWriteJson(creatureTemplate.toJson());
    try {
      await laconic.table('creature_template').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateCreatureTemplate(
    int originalKey,
    CreatureTemplateEntity creatureTemplate,
  ) async {
    await _beforeUpdate(originalKey, creatureTemplate);
    final json = _prepareWriteJson(creatureTemplate.toJson());
    try {
      final matchedRows = await _whereKey(
        laconic.table('creature_template'),
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

  Future<void> _beforeStore(CreatureTemplateEntity creatureTemplate) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    CreatureTemplateEntity creatureTemplate,
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
    return builder.where('entry', key);
  }
}

final class CreatureTemplateFilter {
  final String entry;
  final String name;
  final String subName;

  const CreatureTemplateFilter({
    this.entry = '',
    this.name = '',
    this.subName = '',
  });

  factory CreatureTemplateFilter.fromJson(Map<String, dynamic> json) {
    return CreatureTemplateFilter(
      entry: json['entry']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      subName: json['subName']?.toString() ?? '',
    );
  }

  CreatureTemplateFilter copyWith({
    String? entry,
    String? name,
    String? subName,
  }) {
    return CreatureTemplateFilter(
      entry: entry ?? this.entry,
      name: name ?? this.name,
      subName: subName ?? this.subName,
    );
  }

  Map<String, dynamic> toJson() {
    return {'entry': entry, 'name': name, 'subName': subName};
  }
}
