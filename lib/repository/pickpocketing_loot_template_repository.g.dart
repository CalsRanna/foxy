// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pickpocketing_loot_template_repository.dart';

mixin _PickpocketingLootTemplateRepositoryMixin on RepositoryMixin {
  Future<void> destroyPickpocketingLootTemplate(
    PickpocketingLootTemplateKey key,
  ) async {
    final deletedRows = await _whereKey(
      laconic.table('pickpocketing_loot_template'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<PickpocketingLootTemplateEntity?> getPickpocketingLootTemplate(
    PickpocketingLootTemplateKey key,
  ) async {
    final results = await _whereKey(
      laconic.table('pickpocketing_loot_template'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return PickpocketingLootTemplateEntity.fromJson(results.first.toMap());
  }

  Future<void> storePickpocketingLootTemplate(
    PickpocketingLootTemplateEntity pickpocketingLootTemplate,
  ) async {
    await _beforeStore(pickpocketingLootTemplate);
    final json = _prepareWriteJson(pickpocketingLootTemplate.toJson());
    try {
      await laconic.table('pickpocketing_loot_template').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updatePickpocketingLootTemplate(
    PickpocketingLootTemplateKey originalKey,
    PickpocketingLootTemplateEntity pickpocketingLootTemplate,
  ) async {
    await _beforeUpdate(originalKey, pickpocketingLootTemplate);
    final json = _prepareWriteJson(pickpocketingLootTemplate.toJson());
    try {
      final matchedRows = await _whereKey(
        laconic.table('pickpocketing_loot_template'),
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
    PickpocketingLootTemplateEntity pickpocketingLootTemplate,
  ) async {}

  Future<void> _beforeUpdate(
    PickpocketingLootTemplateKey originalKey,
    PickpocketingLootTemplateEntity pickpocketingLootTemplate,
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

  QueryBuilder _whereKey(
    QueryBuilder builder,
    PickpocketingLootTemplateKey key,
  ) {
    var query = builder;
    query = query.where('Entry', key.entry);
    query = query.where('Item', key.item);
    return query;
  }
}

final class PickpocketingLootTemplateFilter {
  final String entry;
  final String name;

  const PickpocketingLootTemplateFilter({this.entry = '', this.name = ''});

  factory PickpocketingLootTemplateFilter.fromJson(Map<String, dynamic> json) {
    return PickpocketingLootTemplateFilter(
      entry: json['entry']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  PickpocketingLootTemplateFilter copyWith({String? entry, String? name}) {
    return PickpocketingLootTemplateFilter(
      entry: entry ?? this.entry,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toJson() {
    return {'entry': entry, 'name': name};
  }
}
