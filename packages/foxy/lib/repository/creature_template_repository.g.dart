// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_template_repository.dart';

final class CreatureTemplateFilter {
  final String entry;
  final String name;

  const CreatureTemplateFilter({this.entry = '', this.name = ''});

  factory CreatureTemplateFilter.fromJson(Map<String, dynamic> json) {
    return CreatureTemplateFilter(
      entry: json['entry']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  CreatureTemplateFilter copyWith({String? entry, String? name}) {
    return CreatureTemplateFilter(
      entry: entry ?? this.entry,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toJson() {
    return {'entry': entry, 'name': name};
  }
}

mixin _CreatureTemplateRepositoryMixin on RepositoryMixin {
  String get _table => 'creature_template';

  Future<int> copyCreatureTemplate(int key) async {
    final source = await getCreatureTemplate(key);
    if (source == null) {
      throw RecordNotFoundException('creature_template record not found');
    }
    final blank = await createCreatureTemplate();
    final copied = source.copyWith(entry: blank.entry);
    return storeCreatureTemplate(copied);
  }

  Future<int> countCreatureTemplates({CreatureTemplateFilter? filter}) async {
    return _applyFilter(laconic.table(_table), filter).count();
  }

  Future<CreatureTemplateEntity> createCreatureTemplate() async {
    return CreatureTemplateEntity(
      entry: await nextMaxPlusOne(_table, '`entry`'),
    );
  }

  Future<void> destroyCreatureTemplate(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await trackActivityWrite(
      _table,
      beforeKey: activityKey(key),
      write: () => _whereKey(laconic.table(_table), key).delete(),
    );
    if (deletedRows == 0) {
      throw RecordNotFoundException('creature_template record not found');
    }
  }

  Future<CreatureTemplateEntity?> getCreatureTemplate(int key) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return CreatureTemplateEntity.fromJson(results.first.toMap());
  }

  Future<List<BriefCreatureTemplateEntity>> getBriefCreatureTemplates({
    int page = 1,
    CreatureTemplateFilter? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table).select([
      '`entry`',
      '`maxlevel`',
      '`minlevel`',
      '`name`',
      '`subname`',
    ]);
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('`entry`');
    builder = builder.limit(kPageSize).offset(offset);
    final results = await builder.get();
    return results
        .map((e) => BriefCreatureTemplateEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<List<CreatureTemplateEntity>> getCreatureTemplates() async {
    var builder = laconic.table(_table).orderBy('`entry`');
    final results = await builder.get();
    return results
        .map((e) => CreatureTemplateEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<int> storeCreatureTemplate(
    CreatureTemplateEntity creatureTemplate,
  ) async {
    if (creatureTemplate.entry <= 0) {
      throw InvalidPrimaryKeyException(
        'primary key must be assigned before store',
      );
    }
    await _beforeStore(creatureTemplate);
    final json = prepareWriteJson(creatureTemplate.toJson());
    try {
      await trackActivityWrite(
        _table,
        afterKey: activityKey(creatureTemplate.entry),
        write: () => laconic.table(_table).insert([json]),
      );
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = creatureTemplate.copyWith(
        entry: await nextMaxPlusOne(_table, '`entry`'),
      );
      try {
        await trackActivityWrite(
          _table,
          afterKey: activityKey(retried.entry),
          write: () => laconic.table(_table).insert([
            prepareWriteJson(retried.toJson()),
          ]),
        );
        return retried.entry;
      } catch (retryError) {
        if (MysqlErrorUtil.isDuplicateEntry(retryError)) {
          throw DuplicateKeyException('duplicate key in creature_template');
        }
        rethrow;
      }
    }
    return creatureTemplate.entry;
  }

  Future<void> updateCreatureTemplate(
    int originalKey,
    CreatureTemplateEntity creatureTemplate,
  ) async {
    await _beforeUpdate(originalKey, creatureTemplate);
    final values = creatureTemplate.toJson();
    final json = prepareWriteJson(values);
    final int matchedRows;
    try {
      matchedRows = await trackActivityWrite(
        _table,
        beforeKey: activityKey(originalKey),
        afterKey: activityKey(creatureTemplate.entry),
        columns: values.keys,
        write: () => _whereKey(laconic.table(_table), originalKey).update(json),
      );
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException('duplicate key in creature_template');
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException('creature_template record not found');
    }
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    CreatureTemplateFilter? filter,
  ) {
    if (filter == null) return builder;
    if (filter.entry.isNotEmpty) {
      builder = builder.where('`entry`', filter.entry);
    }
    if (filter.name.isNotEmpty) {
      builder = builder.where('`name`', filter.name);
    }
    return builder;
  }

  Future<void> _beforeDestroy(int key) async {}

  Future<void> _beforeStore(CreatureTemplateEntity creatureTemplate) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    CreatureTemplateEntity creatureTemplate,
  ) async {}

  Map<String, Object?> activityKey(int key) => {'entry': key};

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('`entry`', key);
  }
}
