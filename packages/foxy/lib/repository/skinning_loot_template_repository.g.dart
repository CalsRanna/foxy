// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skinning_loot_template_repository.dart';

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

mixin _SkinningLootTemplateRepositoryMixin on RepositoryMixin {
  Future<SkinningLootTemplateKey> copySkinningLootTemplate(
    SkinningLootTemplateKey key,
  ) async {
    final source = await getSkinningLootTemplate(key);
    if (source == null) {
      throw RecordNotFoundException('skinning_loot_template record not found');
    }
    final blank = await createSkinningLootTemplate(source.entry);
    final copied = source.copyWith(entry: blank.entry, item: blank.item);
    await storeSkinningLootTemplate(copied);
    return SkinningLootTemplateKey.fromEntity(copied);
  }

  Future<int> countSkinningLootTemplates(int entry) async {
    return laconic
        .table('skinning_loot_template')
        .where('`Entry`', entry)
        .count();
  }

  Future<SkinningLootTemplateEntity> createSkinningLootTemplate(
    int entry,
  ) async {
    return SkinningLootTemplateEntity(
      entry: entry,
      item: await nextMaxPlusOne(
        'skinning_loot_template',
        '`Item`',
        where: {'`Entry`': entry},
      ),
    );
  }

  Future<void> destroySkinningLootTemplate(SkinningLootTemplateKey key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(
      laconic.table('skinning_loot_template'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException('skinning_loot_template record not found');
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

  Future<List<BriefSkinningLootTemplateEntity>> getBriefSkinningLootTemplates(
    int entry, {
    int page = 1,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table('skinning_loot_template').select([
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
        .map((e) => BriefSkinningLootTemplateEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<void> storeSkinningLootTemplate(
    SkinningLootTemplateEntity skinningLootTemplate,
  ) async {
    await _beforeStore(skinningLootTemplate);
    final json = prepareWriteJson(skinningLootTemplate.toJson());
    try {
      await laconic.table('skinning_loot_template').insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = skinningLootTemplate.copyWith(
        item: await nextMaxPlusOne(
          'skinning_loot_template',
          '`Item`',
          where: {'`Entry`': skinningLootTemplate.entry},
        ),
      );
      try {
        await laconic.table('skinning_loot_template').insert([
          prepareWriteJson(retried.toJson()),
        ]);
        return;
      } catch (retryError) {
        if (MysqlErrorUtil.isDuplicateEntry(retryError)) {
          throw DuplicateKeyException(
            'duplicate key in skinning_loot_template',
          );
        }
        rethrow;
      }
    }
  }

  Future<void> updateSkinningLootTemplate(
    SkinningLootTemplateKey originalKey,
    SkinningLootTemplateEntity skinningLootTemplate,
  ) async {
    await _beforeUpdate(originalKey, skinningLootTemplate);
    final json = prepareWriteJson(skinningLootTemplate.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table('skinning_loot_template'),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException('duplicate key in skinning_loot_template');
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException('skinning_loot_template record not found');
    }
  }

  Future<void> _beforeDestroy(SkinningLootTemplateKey key) async {}

  Future<void> _beforeStore(
    SkinningLootTemplateEntity skinningLootTemplate,
  ) async {}

  Future<void> _beforeUpdate(
    SkinningLootTemplateKey originalKey,
    SkinningLootTemplateEntity skinningLootTemplate,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, SkinningLootTemplateKey key) {
    var query = builder;
    query = query.where('`Entry`', key.entry);
    query = query.where('`Item`', key.item);
    return query;
  }
}
