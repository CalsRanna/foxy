// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skinning_loot_template_repository.dart';

mixin _SkinningLootTemplateRepositoryMixin on RepositoryMixin {
  Future<void> destroySkinningLootTemplate(SkinningLootTemplateKey key) async {
    final deletedRows = await _whereKey(
      laconic.table('skinning_loot_template'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<SkinningLootTemplateEntity?> getSkinningLootTemplate(
    SkinningLootTemplateKey key,
  ) async {
    final results = await _whereKey(
      laconic.table('skinning_loot_template'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return SkinningLootTemplateEntity.fromJson(results.first.toMap());
  }

  Future<void> storeSkinningLootTemplate(
    SkinningLootTemplateEntity skinningLootTemplate,
  ) async {
    await _beforeStore(skinningLootTemplate);
    final json = _prepareWriteJson(skinningLootTemplate.toJson());
    try {
      await laconic.table('skinning_loot_template').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateSkinningLootTemplate(
    SkinningLootTemplateKey originalKey,
    SkinningLootTemplateEntity skinningLootTemplate,
  ) async {
    await _beforeUpdate(originalKey, skinningLootTemplate);
    final json = _prepareWriteJson(skinningLootTemplate.toJson());
    try {
      final matchedRows = await _whereKey(
        laconic.table('skinning_loot_template'),
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
    SkinningLootTemplateEntity skinningLootTemplate,
  ) async {}

  Future<void> _beforeUpdate(
    SkinningLootTemplateKey originalKey,
    SkinningLootTemplateEntity skinningLootTemplate,
  ) async {}

  Map<String, dynamic> _prepareWriteJson(Map<String, dynamic> json) {
    for (final key in json.keys.toList()) {
      if (const {'index', 'rank'}.contains(key.toLowerCase())) {
        json['`$key`'] = json.remove(key);
      }
    }
    return json;
  }

  QueryBuilder _whereKey(QueryBuilder builder, SkinningLootTemplateKey key) {
    var query = builder;
    query = query.where('Entry', key.entry);
    query = query.where('Item', key.item);
    return query;
  }
}

final class SkinningLootTemplateFilter {
  final String entry;
  final String name;

  const SkinningLootTemplateFilter({this.entry = '', this.name = ''});

  factory SkinningLootTemplateFilter.fromJson(Map<String, dynamic> json) {
    return SkinningLootTemplateFilter(
      entry: json['entry']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  SkinningLootTemplateFilter copyWith({String? entry, String? name}) {
    return SkinningLootTemplateFilter(
      entry: entry ?? this.entry,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toJson() {
    return {'entry': entry, 'name': name};
  }
}
