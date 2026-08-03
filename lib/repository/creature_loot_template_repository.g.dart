// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_loot_template_repository.dart';

final class CreatureLootTemplateFilter {
  final String entry;
  final String name;

  const CreatureLootTemplateFilter({this.entry = '', this.name = ''});

  factory CreatureLootTemplateFilter.fromJson(Map<String, dynamic> json) {
    return CreatureLootTemplateFilter(
      entry: json['entry']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  CreatureLootTemplateFilter copyWith({String? entry, String? name}) {
    return CreatureLootTemplateFilter(
      entry: entry ?? this.entry,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toJson() {
    return {'entry': entry, 'name': name};
  }
}

mixin _CreatureLootTemplateRepositoryMixin on RepositoryMixin {
  Future<CreatureLootTemplateKey> copyCreatureLootTemplate(
    CreatureLootTemplateKey key,
  ) async {
    final source = await getCreatureLootTemplate(key);
    if (source == null) {
      throw RecordNotFoundException('creature_loot_template record not found');
    }
    final blank = await createCreatureLootTemplate(source.entry);
    final copied = source.copyWith(
      entry: blank.entry,
      item: blank.item,
      reference: blank.reference,
      groupId: blank.groupId,
    );
    await storeCreatureLootTemplate(copied);
    return CreatureLootTemplateKey.fromEntity(copied);
  }

  Future<int> countCreatureLootTemplates(int entry) async {
    return laconic
        .table('creature_loot_template')
        .where('`Entry`', entry)
        .count();
  }

  Future<CreatureLootTemplateEntity> createCreatureLootTemplate(
    int entry,
  ) async {
    return CreatureLootTemplateEntity(
      entry: entry,
      item: await nextMaxPlusOne(
        'creature_loot_template',
        '`Item`',
        where: {'Entry': entry},
      ),
      reference: await nextMaxPlusOne(
        'creature_loot_template',
        '`Reference`',
        where: {'Entry': entry},
      ),
      groupId: await nextMaxPlusOne(
        'creature_loot_template',
        '`GroupId`',
        where: {'Entry': entry},
      ),
    );
  }

  Future<void> destroyCreatureLootTemplate(CreatureLootTemplateKey key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(
      laconic.table('creature_loot_template'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException('creature_loot_template record not found');
    }
  }

  Future<CreatureLootTemplateEntity?> getCreatureLootTemplate(
    CreatureLootTemplateKey key,
  ) async {
    final results = await _whereKey(
      laconic.table('creature_loot_template'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return CreatureLootTemplateEntity.fromJson(results.first.toMap());
  }

  Future<List<BriefCreatureLootTemplateEntity>> getBriefCreatureLootTemplates(
    int entry, {
    int page = 1,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table('creature_loot_template').select([
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
    builder = builder
        .orderBy('`Entry`')
        .orderBy('`Item`')
        .orderBy('`Reference`')
        .orderBy('`GroupId`');
    builder = builder.limit(kPageSize).offset(offset);
    final results = await builder.get();
    return results
        .map((e) => BriefCreatureLootTemplateEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<void> storeCreatureLootTemplate(
    CreatureLootTemplateEntity creatureLootTemplate,
  ) async {
    await _beforeStore(creatureLootTemplate);
    final json = prepareWriteJson(creatureLootTemplate.toJson());
    try {
      await laconic.table('creature_loot_template').insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = creatureLootTemplate.copyWith(
        item: await nextMaxPlusOne(
          'creature_loot_template',
          '`Item`',
          where: {'`Entry`': creatureLootTemplate.entry},
        ),
      );
      try {
        await laconic.table('creature_loot_template').insert([
          prepareWriteJson(retried.toJson()),
        ]);
        return;
      } catch (retryError) {
        if (MysqlErrorUtil.isDuplicateEntry(retryError)) {
          throw DuplicateKeyException(
            'duplicate key in creature_loot_template',
          );
        }
        rethrow;
      }
    }
  }

  Future<void> updateCreatureLootTemplate(
    CreatureLootTemplateKey originalKey,
    CreatureLootTemplateEntity creatureLootTemplate,
  ) async {
    await _beforeUpdate(originalKey, creatureLootTemplate);
    final json = prepareWriteJson(creatureLootTemplate.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table('creature_loot_template'),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException('duplicate key in creature_loot_template');
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException('creature_loot_template record not found');
    }
  }

  Future<void> _beforeDestroy(CreatureLootTemplateKey key) async {}

  Future<void> _beforeStore(
    CreatureLootTemplateEntity creatureLootTemplate,
  ) async {}

  Future<void> _beforeUpdate(
    CreatureLootTemplateKey originalKey,
    CreatureLootTemplateEntity creatureLootTemplate,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, CreatureLootTemplateKey key) {
    var query = builder;
    query = query.where('`Entry`', key.entry);
    query = query.where('`Item`', key.item);
    query = query.where('`Reference`', key.reference);
    query = query.where('`GroupId`', key.groupId);
    return query;
  }
}
