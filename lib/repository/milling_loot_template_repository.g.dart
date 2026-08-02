// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'milling_loot_template_repository.dart';

final class MillingLootTemplateFilter {
  final String entry;
  final String name;

  const MillingLootTemplateFilter({this.entry = '', this.name = ''});

  factory MillingLootTemplateFilter.fromJson(Map<String, dynamic> json) {
    return MillingLootTemplateFilter(
      entry: json['entry']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  MillingLootTemplateFilter copyWith({String? entry, String? name}) {
    return MillingLootTemplateFilter(
      entry: entry ?? this.entry,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toJson() {
    return {'entry': entry, 'name': name};
  }
}

mixin _MillingLootTemplateRepositoryMixin on RepositoryMixin {
  Future<MillingLootTemplateKey> copyMillingLootTemplate(
    MillingLootTemplateKey key,
  ) async {
    final source = await getMillingLootTemplate(key);
    if (source == null) {
      throw RecordNotFoundException('milling_loot_template record not found');
    }
    final blank = await createMillingLootTemplate(source.entry);
    final copied = source.copyWith(entry: blank.entry, item: blank.item);
    await storeMillingLootTemplate(copied);
    return MillingLootTemplateKey.fromEntity(copied);
  }

  Future<int> countMillingLootTemplates(int entry) async {
    return laconic
        .table('milling_loot_template')
        .where('`Entry`', entry)
        .count();
  }

  Future<MillingLootTemplateEntity> createMillingLootTemplate(int entry) async {
    return MillingLootTemplateEntity(
      entry: entry,
      item: await nextMaxPlusOne(
        'milling_loot_template',
        '`Item`',
        where: {'Entry': entry},
      ),
    );
  }

  Future<void> destroyMillingLootTemplate(MillingLootTemplateKey key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(
      laconic.table('milling_loot_template'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException('milling_loot_template record not found');
    }
  }

  Future<MillingLootTemplateEntity?> getMillingLootTemplate(
    MillingLootTemplateKey key,
  ) async {
    final results = await _whereKey(
      laconic.table('milling_loot_template'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return MillingLootTemplateEntity.fromJson(results.first.toMap());
  }

  Future<List<BriefMillingLootTemplateEntity>> getBriefMillingLootTemplates(
    int entry, {
    int page = 1,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table('milling_loot_template').select([
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
        .map((e) => BriefMillingLootTemplateEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<void> storeMillingLootTemplate(
    MillingLootTemplateEntity millingLootTemplate,
  ) async {
    await _beforeStore(millingLootTemplate);
    final json = prepareWriteJson(millingLootTemplate.toJson());
    try {
      await laconic.table('milling_loot_template').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException('duplicate key in milling_loot_template');
      }
      rethrow;
    }
  }

  Future<void> updateMillingLootTemplate(
    MillingLootTemplateKey originalKey,
    MillingLootTemplateEntity millingLootTemplate,
  ) async {
    await _beforeUpdate(originalKey, millingLootTemplate);
    final json = prepareWriteJson(millingLootTemplate.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table('milling_loot_template'),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException('duplicate key in milling_loot_template');
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException('milling_loot_template record not found');
    }
  }

  Future<void> _beforeDestroy(MillingLootTemplateKey key) async {}

  Future<void> _beforeStore(
    MillingLootTemplateEntity millingLootTemplate,
  ) async {}

  Future<void> _beforeUpdate(
    MillingLootTemplateKey originalKey,
    MillingLootTemplateEntity millingLootTemplate,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, MillingLootTemplateKey key) {
    var query = builder;
    query = query.where('`Entry`', key.entry);
    query = query.where('`Item`', key.item);
    return query;
  }
}
