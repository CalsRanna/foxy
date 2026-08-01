// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_template_repository.dart';

final class CreatureTemplateFilter {
  final String entry;
  final String name;
  final String subName;

  const CreatureTemplateFilter({
    this.entry = '',
    this.name = '',
    this.subName = '',
  });

  factory CreatureTemplateFilter.fromJson(Map<String, dynamic> json) {
    return CreatureTemplateFilter(
      entry: json['entry']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      subName: json['subName']?.toString() ?? '',
    );
  }

  CreatureTemplateFilter copyWith({
    String? entry,
    String? name,
    String? subName,
  }) {
    return CreatureTemplateFilter(
      entry: entry ?? this.entry,
      name: name ?? this.name,
      subName: subName ?? this.subName,
    );
  }

  Map<String, dynamic> toJson() {
    return {'entry': entry, 'name': name, 'subName': subName};
  }
}

mixin _CreatureTemplateRepositoryMixin on RepositoryMixin {
  Future<int> copyCreatureTemplate(int key) async {
    final source = await getCreatureTemplate(key);
    if (source == null) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
    final blank = await createCreatureTemplate();
    final copied = source.copyWith(entry: blank.entry);
    await storeCreatureTemplate(copied);
    return copied.entry;
  }

  Future<int> countCreatureTemplates({CreatureTemplateFilter? filter}) async {
    return _applyFilter(laconic.table('creature_template'), filter).count();
  }

  Future<CreatureTemplateEntity> createCreatureTemplate() async {
    return CreatureTemplateEntity(
      entry: await nextMaxPlusOne('creature_template', '`entry`'),
    );
  }

  Future<void> destroyCreatureTemplate(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(
      laconic.table('creature_template'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<CreatureTemplateEntity?> getCreatureTemplate(int key) async {
    final results = await _whereKey(
      laconic.table('creature_template'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return CreatureTemplateEntity.fromJson(results.first.toMap());
  }

  Future<List<BriefCreatureTemplateEntity>> getBriefCreatureTemplates({
    int page = 1,
    CreatureTemplateFilter? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table('creature_template').select([
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
    var builder = laconic.table('creature_template').orderBy('`entry`');
    final results = await builder.get();
    return results
        .map((e) => CreatureTemplateEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<void> storeCreatureTemplate(
    CreatureTemplateEntity creatureTemplate,
  ) async {
    if (creatureTemplate.entry <= 0) {
      throw StateError('主键必须在新建时显式分配');
    }
    await _beforeStore(creatureTemplate);
    final json = prepareWriteJson(creatureTemplate.toJson());
    try {
      await laconic.table('creature_template').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateCreatureTemplate(
    int originalKey,
    CreatureTemplateEntity creatureTemplate,
  ) async {
    await _beforeUpdate(originalKey, creatureTemplate);
    final json = prepareWriteJson(creatureTemplate.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table('creature_template'),
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
    if (filter.subName.isNotEmpty) {
      builder = builder.where('`subname`', filter.subName);
    }
    return builder;
  }

  Future<void> _beforeDestroy(int key) async {}

  Future<void> _beforeStore(CreatureTemplateEntity creatureTemplate) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    CreatureTemplateEntity creatureTemplate,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('`entry`', key);
  }
}
