// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prospecting_loot_template_repository.dart';

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

mixin _ProspectingLootTemplateRepositoryMixin on RepositoryMixin {
  String get _table => 'prospecting_loot_template';

  Future<ProspectingLootTemplateKey> copyProspectingLootTemplate(
    ProspectingLootTemplateKey key,
  ) async {
    final source = await getProspectingLootTemplate(key);
    if (source == null) {
      throw RecordNotFoundException(
        'prospecting_loot_template record not found',
      );
    }
    final blank = await createProspectingLootTemplate(source.entry);
    final copied = source.copyWith(entry: blank.entry, item: blank.item);
    await storeProspectingLootTemplate(copied);
    return ProspectingLootTemplateKey.fromEntity(copied);
  }

  Future<int> countProspectingLootTemplates(int entry) async {
    return laconic.table(_table).where('`Entry`', entry).count();
  }

  Future<ProspectingLootTemplateEntity> createProspectingLootTemplate(
    int entry,
  ) async {
    return ProspectingLootTemplateEntity(
      entry: entry,
      item: await nextMaxPlusOne(_table, '`Item`', where: {'`Entry`': entry}),
    );
  }

  Future<void> destroyProspectingLootTemplate(
    ProspectingLootTemplateKey key,
  ) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException(
        'prospecting_loot_template record not found',
      );
    }
  }

  Future<ProspectingLootTemplateEntity?> getProspectingLootTemplate(
    ProspectingLootTemplateKey key,
  ) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return ProspectingLootTemplateEntity.fromJson(results.first.toMap());
  }

  Future<List<BriefProspectingLootTemplateEntity>>
  getBriefProspectingLootTemplates(int entry, {int page = 1}) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table).select([
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
        .map((e) => BriefProspectingLootTemplateEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<void> storeProspectingLootTemplate(
    ProspectingLootTemplateEntity prospectingLootTemplate,
  ) async {
    await _beforeStore(prospectingLootTemplate);
    final json = prepareWriteJson(prospectingLootTemplate.toJson());
    try {
      await laconic.table(_table).insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = prospectingLootTemplate.copyWith(
        item: await nextMaxPlusOne(
          _table,
          '`Item`',
          where: {'`Entry`': prospectingLootTemplate.entry},
        ),
      );
      try {
        await laconic.table(_table).insert([
          prepareWriteJson(retried.toJson()),
        ]);
        return;
      } catch (retryError) {
        if (MysqlErrorUtil.isDuplicateEntry(retryError)) {
          throw DuplicateKeyException(
            'duplicate key in prospecting_loot_template',
          );
        }
        rethrow;
      }
    }
  }

  Future<void> updateProspectingLootTemplate(
    ProspectingLootTemplateKey originalKey,
    ProspectingLootTemplateEntity prospectingLootTemplate,
  ) async {
    await _beforeUpdate(originalKey, prospectingLootTemplate);
    final json = prepareWriteJson(prospectingLootTemplate.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException(
          'duplicate key in prospecting_loot_template',
        );
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException(
        'prospecting_loot_template record not found',
      );
    }
  }

  Future<void> _beforeDestroy(ProspectingLootTemplateKey key) async {}

  Future<void> _beforeStore(
    ProspectingLootTemplateEntity prospectingLootTemplate,
  ) async {}

  Future<void> _beforeUpdate(
    ProspectingLootTemplateKey originalKey,
    ProspectingLootTemplateEntity prospectingLootTemplate,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, ProspectingLootTemplateKey key) {
    var query = builder;
    query = query.where('`Entry`', key.entry);
    query = query.where('`Item`', key.item);
    return query;
  }
}
