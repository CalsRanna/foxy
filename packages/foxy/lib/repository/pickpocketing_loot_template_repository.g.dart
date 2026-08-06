// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pickpocketing_loot_template_repository.dart';

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

mixin _PickpocketingLootTemplateRepositoryMixin on RepositoryMixin {
  Future<PickpocketingLootTemplateKey> copyPickpocketingLootTemplate(
    PickpocketingLootTemplateKey key,
  ) async {
    final source = await getPickpocketingLootTemplate(key);
    if (source == null) {
      throw RecordNotFoundException(
        'pickpocketing_loot_template record not found',
      );
    }
    final blank = await createPickpocketingLootTemplate(source.entry);
    final copied = source.copyWith(entry: blank.entry, item: blank.item);
    await storePickpocketingLootTemplate(copied);
    return PickpocketingLootTemplateKey.fromEntity(copied);
  }

  Future<int> countPickpocketingLootTemplates(int entry) async {
    return laconic
        .table('pickpocketing_loot_template')
        .where('`Entry`', entry)
        .count();
  }

  Future<PickpocketingLootTemplateEntity> createPickpocketingLootTemplate(
    int entry,
  ) async {
    return PickpocketingLootTemplateEntity(
      entry: entry,
      item: await nextMaxPlusOne(
        'pickpocketing_loot_template',
        '`Item`',
        where: {'`Entry`': entry},
      ),
    );
  }

  Future<void> destroyPickpocketingLootTemplate(
    PickpocketingLootTemplateKey key,
  ) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(
      laconic.table('pickpocketing_loot_template'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException(
        'pickpocketing_loot_template record not found',
      );
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

  Future<List<BriefPickpocketingLootTemplateEntity>>
  getBriefPickpocketingLootTemplates(int entry, {int page = 1}) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table('pickpocketing_loot_template').select([
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
        .map((e) => BriefPickpocketingLootTemplateEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<void> storePickpocketingLootTemplate(
    PickpocketingLootTemplateEntity pickpocketingLootTemplate,
  ) async {
    await _beforeStore(pickpocketingLootTemplate);
    final json = prepareWriteJson(pickpocketingLootTemplate.toJson());
    try {
      await laconic.table('pickpocketing_loot_template').insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = pickpocketingLootTemplate.copyWith(
        item: await nextMaxPlusOne(
          'pickpocketing_loot_template',
          '`Item`',
          where: {'`Entry`': pickpocketingLootTemplate.entry},
        ),
      );
      try {
        await laconic.table('pickpocketing_loot_template').insert([
          prepareWriteJson(retried.toJson()),
        ]);
        return;
      } catch (retryError) {
        if (MysqlErrorUtil.isDuplicateEntry(retryError)) {
          throw DuplicateKeyException(
            'duplicate key in pickpocketing_loot_template',
          );
        }
        rethrow;
      }
    }
  }

  Future<void> updatePickpocketingLootTemplate(
    PickpocketingLootTemplateKey originalKey,
    PickpocketingLootTemplateEntity pickpocketingLootTemplate,
  ) async {
    await _beforeUpdate(originalKey, pickpocketingLootTemplate);
    final json = prepareWriteJson(pickpocketingLootTemplate.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table('pickpocketing_loot_template'),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException(
          'duplicate key in pickpocketing_loot_template',
        );
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException(
        'pickpocketing_loot_template record not found',
      );
    }
  }

  Future<void> _beforeDestroy(PickpocketingLootTemplateKey key) async {}

  Future<void> _beforeStore(
    PickpocketingLootTemplateEntity pickpocketingLootTemplate,
  ) async {}

  Future<void> _beforeUpdate(
    PickpocketingLootTemplateKey originalKey,
    PickpocketingLootTemplateEntity pickpocketingLootTemplate,
  ) async {}

  QueryBuilder _whereKey(
    QueryBuilder builder,
    PickpocketingLootTemplateKey key,
  ) {
    var query = builder;
    query = query.where('`Entry`', key.entry);
    query = query.where('`Item`', key.item);
    return query;
  }
}
