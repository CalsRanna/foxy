// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reference_loot_template_repository.dart';

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

mixin _ReferenceLootTemplateRepositoryMixin on RepositoryMixin {
  Future<ReferenceLootTemplateKey> copyReferenceLootTemplate(
    ReferenceLootTemplateKey key,
  ) async {
    final source = await getReferenceLootTemplate(key);
    if (source == null) {
      throw RecordNotFoundException('reference_loot_template record not found');
    }
    final blank = await createReferenceLootTemplate();
    final copied = source.copyWith(entry: blank.entry, item: blank.item);
    await storeReferenceLootTemplate(copied);
    return ReferenceLootTemplateKey.fromEntity(copied);
  }

  Future<int> countReferenceLootTemplates({
    ReferenceLootTemplateFilter? filter,
  }) async {
    return _applyFilter(
      laconic.table('reference_loot_template'),
      filter,
    ).count();
  }

  Future<ReferenceLootTemplateEntity> createReferenceLootTemplate() async {
    return ReferenceLootTemplateEntity(
      entry: await nextMaxPlusOne('reference_loot_template', '`Entry`'),
      item: await nextMaxPlusOne('reference_loot_template', '`Item`'),
    );
  }

  Future<void> destroyReferenceLootTemplate(
    ReferenceLootTemplateKey key,
  ) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(
      laconic.table('reference_loot_template'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException('reference_loot_template record not found');
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

  Future<List<BriefReferenceLootTemplateEntity>>
  getBriefReferenceLootTemplates({
    int page = 1,
    ReferenceLootTemplateFilter? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table('reference_loot_template').select([
      '`Entry`',
      '`Item`',
      '`Reference`',
      '`Chance`',
      '`QuestRequired`',
      '`GroupId`',
      '`MinCount`',
      '`MaxCount`',
    ]);
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('`Entry`').orderBy('`Item`');
    builder = builder.limit(kPageSize).offset(offset);
    final results = await builder.get();
    return results
        .map((e) => BriefReferenceLootTemplateEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<List<ReferenceLootTemplateEntity>> getReferenceLootTemplates() async {
    var builder = laconic
        .table('reference_loot_template')
        .orderBy('`Entry`')
        .orderBy('`Item`');
    final results = await builder.get();
    return results
        .map((e) => ReferenceLootTemplateEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<void> storeReferenceLootTemplate(
    ReferenceLootTemplateEntity referenceLootTemplate,
  ) async {
    await _beforeStore(referenceLootTemplate);
    final json = prepareWriteJson(referenceLootTemplate.toJson());
    try {
      await laconic.table('reference_loot_template').insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = referenceLootTemplate.copyWith(
        item: await nextMaxPlusOne(
          'reference_loot_template',
          '`Item`',
          where: {'`Entry`': referenceLootTemplate.entry},
        ),
      );
      try {
        await laconic.table('reference_loot_template').insert([
          prepareWriteJson(retried.toJson()),
        ]);
        return;
      } catch (retryError) {
        if (MysqlErrorUtil.isDuplicateEntry(retryError)) {
          throw DuplicateKeyException(
            'duplicate key in reference_loot_template',
          );
        }
        rethrow;
      }
    }
  }

  Future<void> updateReferenceLootTemplate(
    ReferenceLootTemplateKey originalKey,
    ReferenceLootTemplateEntity referenceLootTemplate,
  ) async {
    await _beforeUpdate(originalKey, referenceLootTemplate);
    final json = prepareWriteJson(referenceLootTemplate.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table('reference_loot_template'),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException('duplicate key in reference_loot_template');
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException('reference_loot_template record not found');
    }
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    ReferenceLootTemplateFilter? filter,
  ) {
    if (filter == null) return builder;
    if (filter.entry.isNotEmpty) {
      builder = builder.where('`Entry`', int.tryParse(filter.entry) ?? 0);
    }
    if (filter.name.isNotEmpty) {
      builder = builder.where('`it.name`', filter.name);
    }
    return builder;
  }

  Future<void> _beforeDestroy(ReferenceLootTemplateKey key) async {}

  Future<void> _beforeStore(
    ReferenceLootTemplateEntity referenceLootTemplate,
  ) async {}

  Future<void> _beforeUpdate(
    ReferenceLootTemplateKey originalKey,
    ReferenceLootTemplateEntity referenceLootTemplate,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, ReferenceLootTemplateKey key) {
    var query = builder;
    query = query.where('`Entry`', key.entry);
    query = query.where('`Item`', key.item);
    return query;
  }
}
