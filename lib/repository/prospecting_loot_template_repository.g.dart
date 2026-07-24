// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prospecting_loot_template_repository.dart';

mixin _ProspectingLootTemplateRepositoryMixin on RepositoryMixin {
  Future<void> destroyProspectingLootTemplate(
    ProspectingLootTemplateKey key,
  ) async {
    final deletedRows = await _whereKey(
      laconic.table('prospecting_loot_template'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<ProspectingLootTemplateEntity?> getProspectingLootTemplate(
    ProspectingLootTemplateKey key,
  ) async {
    final results = await _whereKey(
      laconic.table('prospecting_loot_template'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return ProspectingLootTemplateEntity.fromJson(results.first.toMap());
  }

  Future<void> storeProspectingLootTemplate(
    ProspectingLootTemplateEntity prospectingLootTemplate,
  ) async {
    await _beforeStore(prospectingLootTemplate);
    final json = _prepareWriteJson(prospectingLootTemplate.toJson());
    try {
      await laconic.table('prospecting_loot_template').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateProspectingLootTemplate(
    ProspectingLootTemplateKey originalKey,
    ProspectingLootTemplateEntity prospectingLootTemplate,
  ) async {
    await _beforeUpdate(originalKey, prospectingLootTemplate);
    final json = _prepareWriteJson(prospectingLootTemplate.toJson());
    try {
      final matchedRows = await _whereKey(
        laconic.table('prospecting_loot_template'),
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
    ProspectingLootTemplateEntity prospectingLootTemplate,
  ) async {}

  Future<void> _beforeUpdate(
    ProspectingLootTemplateKey originalKey,
    ProspectingLootTemplateEntity prospectingLootTemplate,
  ) async {}

  Map<String, dynamic> _prepareWriteJson(Map<String, dynamic> json) {
    for (final key in json.keys.toList()) {
      if (const {'index', 'rank'}.contains(key.toLowerCase())) {
        json['`$key`'] = json.remove(key);
      }
    }
    return json;
  }

  QueryBuilder _whereKey(QueryBuilder builder, ProspectingLootTemplateKey key) {
    var query = builder;
    query = query.where('Entry', key.entry);
    query = query.where('Item', key.item);
    return query;
  }
}

final class ProspectingLootTemplateFilter {
  final String entry;
  final String name;

  const ProspectingLootTemplateFilter({this.entry = '', this.name = ''});

  factory ProspectingLootTemplateFilter.fromJson(Map<String, dynamic> json) {
    return ProspectingLootTemplateFilter(
      entry: json['entry']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  ProspectingLootTemplateFilter copyWith({String? entry, String? name}) {
    return ProspectingLootTemplateFilter(
      entry: entry ?? this.entry,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toJson() {
    return {'entry': entry, 'name': name};
  }
}
