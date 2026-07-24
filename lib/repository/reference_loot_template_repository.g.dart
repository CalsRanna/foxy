// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reference_loot_template_repository.dart';

mixin _ReferenceLootTemplateRepositoryMixin on RepositoryMixin {
  Future<void> destroyReferenceLootTemplate(
    ReferenceLootTemplateKey key,
  ) async {
    final deletedRows = await _whereKey(
      laconic.table('reference_loot_template'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<ReferenceLootTemplateEntity?> getReferenceLootTemplate(
    ReferenceLootTemplateKey key,
  ) async {
    final results = await _whereKey(
      laconic.table('reference_loot_template'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return ReferenceLootTemplateEntity.fromJson(results.first.toMap());
  }

  Future<void> storeReferenceLootTemplate(
    ReferenceLootTemplateEntity referenceLootTemplate,
  ) async {
    await _beforeStore(referenceLootTemplate);
    final json = _prepareWriteJson(referenceLootTemplate.toJson());
    try {
      await laconic.table('reference_loot_template').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateReferenceLootTemplate(
    ReferenceLootTemplateKey originalKey,
    ReferenceLootTemplateEntity referenceLootTemplate,
  ) async {
    await _beforeUpdate(originalKey, referenceLootTemplate);
    final json = _prepareWriteJson(referenceLootTemplate.toJson());
    try {
      final matchedRows = await _whereKey(
        laconic.table('reference_loot_template'),
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
    ReferenceLootTemplateEntity referenceLootTemplate,
  ) async {}

  Future<void> _beforeUpdate(
    ReferenceLootTemplateKey originalKey,
    ReferenceLootTemplateEntity referenceLootTemplate,
  ) async {}

  Map<String, dynamic> _prepareWriteJson(Map<String, dynamic> json) {
    for (final key in json.keys.toList()) {
      if (const {'index', 'rank'}.contains(key.toLowerCase())) {
        json['`$key`'] = json.remove(key);
      }
    }
    return json;
  }

  QueryBuilder _whereKey(QueryBuilder builder, ReferenceLootTemplateKey key) {
    var query = builder;
    query = query.where('Entry', key.entry);
    query = query.where('Item', key.item);
    return query;
  }
}

final class ReferenceLootTemplateFilter {
  final String entry;
  final String name;

  const ReferenceLootTemplateFilter({this.entry = '', this.name = ''});

  factory ReferenceLootTemplateFilter.fromJson(Map<String, dynamic> json) {
    return ReferenceLootTemplateFilter(
      entry: json['entry']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  ReferenceLootTemplateFilter copyWith({String? entry, String? name}) {
    return ReferenceLootTemplateFilter(
      entry: entry ?? this.entry,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toJson() {
    return {'entry': entry, 'name': name};
  }
}
