// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_loot_template_repository.dart';

mixin _CreatureLootTemplateRepositoryMixin on RepositoryMixin {
  Future<void> destroyCreatureLootTemplate(CreatureLootTemplateKey key) async {
    final deletedRows = await _whereKey(
      laconic.table('creature_loot_template'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<CreatureLootTemplateEntity?> getCreatureLootTemplate(
    CreatureLootTemplateKey key,
  ) async {
    final results = await _whereKey(
      laconic.table('creature_loot_template'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return CreatureLootTemplateEntity.fromJson(results.first.toMap());
  }

  Future<void> storeCreatureLootTemplate(
    CreatureLootTemplateEntity creatureLootTemplate,
  ) async {
    await _beforeStore(creatureLootTemplate);
    final json = _prepareWriteJson(creatureLootTemplate.toJson());
    try {
      await laconic.table('creature_loot_template').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateCreatureLootTemplate(
    CreatureLootTemplateKey originalKey,
    CreatureLootTemplateEntity creatureLootTemplate,
  ) async {
    await _beforeUpdate(originalKey, creatureLootTemplate);
    final json = _prepareWriteJson(creatureLootTemplate.toJson());
    try {
      final matchedRows = await _whereKey(
        laconic.table('creature_loot_template'),
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

  Future<void> _beforeStore(
    CreatureLootTemplateEntity creatureLootTemplate,
  ) async {}

  Future<void> _beforeUpdate(
    CreatureLootTemplateKey originalKey,
    CreatureLootTemplateEntity creatureLootTemplate,
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

  QueryBuilder _whereKey(QueryBuilder builder, CreatureLootTemplateKey key) {
    var query = builder;
    query = query.where('Entry', key.entry);
    query = query.where('Item', key.item);
    query = query.where('Reference', key.reference);
    query = query.where('GroupId', key.groupId);
    return query;
  }
}

final class CreatureLootTemplateFilter {
  final String entry;
  final String name;

  const CreatureLootTemplateFilter({this.entry = '', this.name = ''});

  factory CreatureLootTemplateFilter.fromJson(Map<String, dynamic> json) {
    return CreatureLootTemplateFilter(
      entry: json['entry']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  CreatureLootTemplateFilter copyWith({String? entry, String? name}) {
    return CreatureLootTemplateFilter(
      entry: entry ?? this.entry,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toJson() {
    return {'entry': entry, 'name': name};
  }
}
