// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'disenchant_loot_template_repository.dart';

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

mixin _DisenchantLootTemplateRepositoryMixin on RepositoryMixin {
  Future<DisenchantLootTemplateKey> copyDisenchantLootTemplate(
    DisenchantLootTemplateKey key,
  ) async {
    final source = await getDisenchantLootTemplate(key);
    if (source == null) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
    final blank = await createDisenchantLootTemplate(source.entry);
    final copied = source.copyWith(entry: blank.entry, item: blank.item);
    await storeDisenchantLootTemplate(copied);
    return DisenchantLootTemplateKey.fromEntity(copied);
  }

  Future<int> countDisenchantLootTemplates(int entry) async {
    return laconic
        .table('disenchant_loot_template')
        .where('`Entry`', entry)
        .count();
  }

  Future<DisenchantLootTemplateEntity> createDisenchantLootTemplate(
    int entry,
  ) async {
    return DisenchantLootTemplateEntity(
      entry: entry,
      item: await nextMaxPlusOne(
        'disenchant_loot_template',
        '`Item`',
        where: {'Entry': entry},
      ),
    );
  }

  Future<void> destroyDisenchantLootTemplate(
    DisenchantLootTemplateKey key,
  ) async {
    await _beforeDestroy(key);
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

  Future<List<BriefDisenchantLootTemplateEntity>>
  getBriefDisenchantLootTemplates(int entry, {int page = 1}) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table('disenchant_loot_template').select([
      '`Entry`',
      '`Item`',
      '`Reference`',
      '`Chance`',
      '`QuestRequired`',
      '`GroupId`',
      '`MinCount`',
      '`MaxCount`',
    ]);
    builder = builder.where('`Entry`', entry);
    builder = builder.orderBy('`Entry`').orderBy('`Item`');
    builder = builder.limit(kPageSize).offset(offset);
    final results = await builder.get();
    return results
        .map((e) => BriefDisenchantLootTemplateEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<void> storeDisenchantLootTemplate(
    DisenchantLootTemplateEntity disenchantLootTemplate,
  ) async {
    await _beforeStore(disenchantLootTemplate);
    final json = prepareWriteJson(disenchantLootTemplate.toJson());
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
    final json = prepareWriteJson(disenchantLootTemplate.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table('disenchant_loot_template'),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的主键已存在');
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<void> _beforeDestroy(DisenchantLootTemplateKey key) async {}

  Future<void> _beforeStore(
    DisenchantLootTemplateEntity disenchantLootTemplate,
  ) async {}

  Future<void> _beforeUpdate(
    DisenchantLootTemplateKey originalKey,
    DisenchantLootTemplateEntity disenchantLootTemplate,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, DisenchantLootTemplateKey key) {
    var query = builder;
    query = query.where('`Entry`', key.entry);
    query = query.where('`Item`', key.item);
    return query;
  }
}
