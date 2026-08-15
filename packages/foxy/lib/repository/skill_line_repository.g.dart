// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skill_line_repository.dart';

final class SkillLineFilter {
  final String id;
  final String name;

  const SkillLineFilter({this.id = '', this.name = ''});

  factory SkillLineFilter.fromJson(Map<String, dynamic> json) {
    return SkillLineFilter(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  SkillLineFilter copyWith({String? id, String? name}) {
    return SkillLineFilter(id: id ?? this.id, name: name ?? this.name);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}

mixin _SkillLineRepositoryMixin on RepositoryMixin, DbcLocaleRepositoryMixin {
  String get _table => 'foxy.dbc_skill_line';

  Future<int> copySkillLine(int key) async {
    final source = await getSkillLine(key);
    if (source == null) {
      throw RecordNotFoundException('foxy.dbc_skill_line record not found');
    }
    final blank = await createSkillLine();
    final copied = source.copyWith(id: blank.id);
    await storeSkillLine(copied);
    return copied.id;
  }

  Future<int> countSkillLines({SkillLineFilter? filter}) async {
    return _applyFilter(laconic.table(_table), filter).count();
  }

  Future<SkillLineEntity> createSkillLine() async {
    return SkillLineEntity(id: await nextMaxPlusOne(_table, '`ID`'));
  }

  Future<void> destroySkillLine(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException('foxy.dbc_skill_line record not found');
    }
  }

  Future<SkillLineEntity?> getSkillLine(int key) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return SkillLineEntity.fromJson(results.first.toMap());
  }

  Future<List<BriefSkillLineEntity>> getBriefSkillLines({
    int page = 1,
    SkillLineFilter? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table).select(['`ID`', '`CategoryID`']);
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('`ID`');
    builder = builder.limit(kPageSize).offset(offset);
    final results = await builder.get();
    return results
        .map((e) => BriefSkillLineEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<List<SkillLineEntity>> getSkillLines() async {
    var builder = laconic.table(_table).orderBy('`ID`');
    final results = await builder.get();
    return results.map((e) => SkillLineEntity.fromJson(e.toMap())).toList();
  }

  Future<List<DbcLocaleFieldValue>> getSkillLineLocales(
    int id,
    DbcLocaleFieldDefinition field,
  ) => loadDbcLocaleField(id, field);

  Future<void> saveSkillLineLocales(
    int id,
    DbcLocaleFieldDefinition field,
    List<DbcLocaleFieldValue> locales,
  ) => storeDbcLocaleField(id, field, locales);

  Future<int> storeSkillLine(SkillLineEntity skillLine) async {
    if (skillLine.id <= 0) {
      throw InvalidPrimaryKeyException(
        'primary key must be assigned before store',
      );
    }
    await _beforeStore(skillLine);
    final json = prepareWriteJson(skillLine.toJson());
    try {
      await laconic.table(_table).insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = skillLine.copyWith(
        id: await nextMaxPlusOne(_table, '`ID`'),
      );
      try {
        await laconic.table(_table).insert([
          prepareWriteJson(retried.toJson()),
        ]);
        return retried.id;
      } catch (retryError) {
        if (MysqlErrorUtil.isDuplicateEntry(retryError)) {
          throw DuplicateKeyException('duplicate key in foxy.dbc_skill_line');
        }
        rethrow;
      }
    }
    return skillLine.id;
  }

  Future<void> updateSkillLine(
    int originalKey,
    SkillLineEntity skillLine,
  ) async {
    await _beforeUpdate(originalKey, skillLine);
    final json = prepareWriteJson(skillLine.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException('duplicate key in foxy.dbc_skill_line');
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException('foxy.dbc_skill_line record not found');
    }
  }

  QueryBuilder _applyFilter(QueryBuilder builder, SkillLineFilter? filter) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('`ID`', filter.id);
    }
    if (filter.name.isNotEmpty) {
      builder = builder.where('`DisplayName_lang_zhCN`', filter.name);
    }
    return builder;
  }

  Future<void> _beforeDestroy(int key) async {}

  Future<void> _beforeStore(SkillLineEntity skillLine) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    SkillLineEntity skillLine,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('`ID`', key);
  }
}
