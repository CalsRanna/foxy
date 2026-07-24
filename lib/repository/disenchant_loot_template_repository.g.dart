// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'disenchant_loot_template_repository.dart';

mixin _DisenchantLootTemplateRepositoryMixin on RepositoryMixin {
  Future<void> destroyDisenchantLootTemplate(
    DisenchantLootTemplateKey key,
  ) async {
    final deletedRows = await _whereKey(
      laconic.table('disenchant_loot_template'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<DisenchantLootTemplateEntity?> getDisenchantLootTemplate(
    DisenchantLootTemplateKey key,
  ) async {
    final results = await _whereKey(
      laconic.table('disenchant_loot_template'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return DisenchantLootTemplateEntity.fromJson(results.first.toMap());
  }

  Future<void> storeDisenchantLootTemplate(
    DisenchantLootTemplateEntity disenchantLootTemplate,
  ) async {
    await _beforeStore(disenchantLootTemplate);
    final json = _prepareWriteJson(disenchantLootTemplate.toJson());
    try {
      await laconic.table('disenchant_loot_template').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateDisenchantLootTemplate(
    DisenchantLootTemplateKey originalKey,
    DisenchantLootTemplateEntity disenchantLootTemplate,
  ) async {
    await _beforeUpdate(originalKey, disenchantLootTemplate);
    final json = _prepareWriteJson(disenchantLootTemplate.toJson());
    try {
      final matchedRows = await _whereKey(
        laconic.table('disenchant_loot_template'),
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
    DisenchantLootTemplateEntity disenchantLootTemplate,
  ) async {}

  Future<void> _beforeUpdate(
    DisenchantLootTemplateKey originalKey,
    DisenchantLootTemplateEntity disenchantLootTemplate,
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

  QueryBuilder _whereKey(QueryBuilder builder, DisenchantLootTemplateKey key) {
    var query = builder;
    query = query.where('Entry', key.entry);
    query = query.where('Item', key.item);
    return query;
  }
}

final class DisenchantLootTemplateFilter {
  final String entry;
  final String name;

  const DisenchantLootTemplateFilter({this.entry = '', this.name = ''});

  factory DisenchantLootTemplateFilter.fromJson(Map<String, dynamic> json) {
    return DisenchantLootTemplateFilter(
      entry: json['entry']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  DisenchantLootTemplateFilter copyWith({String? entry, String? name}) {
    return DisenchantLootTemplateFilter(
      entry: entry ?? this.entry,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toJson() {
    return {'entry': entry, 'name': name};
  }
}
