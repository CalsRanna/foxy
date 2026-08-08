// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quest_sort_repository.dart';

final class QuestSortFilter {
  final String id;
  final String name;

  const QuestSortFilter({this.id = '', this.name = ''});

  factory QuestSortFilter.fromJson(Map<String, dynamic> json) {
    return QuestSortFilter(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  QuestSortFilter copyWith({String? id, String? name}) {
    return QuestSortFilter(id: id ?? this.id, name: name ?? this.name);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}

mixin _QuestSortRepositoryMixin on RepositoryMixin, DbcLocaleRepositoryMixin {
  Future<int> copyQuestSort(int key) async {
    final source = await getQuestSort(key);
    if (source == null) {
      throw RecordNotFoundException('foxy.dbc_quest_sort record not found');
    }
    final blank = await createQuestSort();
    final copied = source.copyWith(id: blank.id);
    await storeQuestSort(copied);
    return copied.id;
  }

  Future<int> countQuestSorts({QuestSortFilter? filter}) async {
    return _applyFilter(laconic.table(_table), filter).count();
  }

  Future<QuestSortEntity> createQuestSort() async {
    return QuestSortEntity(id: await nextMaxPlusOne(_table, '`ID`'));
  }

  Future<void> destroyQuestSort(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException('foxy.dbc_quest_sort record not found');
    }
  }

  Future<QuestSortEntity?> getQuestSort(int key) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return QuestSortEntity.fromJson(results.first.toMap());
  }

  Future<List<BriefQuestSortEntity>> getBriefQuestSorts({
    int page = 1,
    QuestSortFilter? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table).select([
      '`ID`',
      '`SortName_lang_zhCN`',
    ]);
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('`ID`');
    builder = builder.limit(kPageSize).offset(offset);
    final results = await builder.get();
    return results
        .map((e) => BriefQuestSortEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<List<QuestSortEntity>> getQuestSorts() async {
    var builder = laconic.table(_table).orderBy('`ID`');
    final results = await builder.get();
    return results.map((e) => QuestSortEntity.fromJson(e.toMap())).toList();
  }

  Future<List<DbcLocaleFieldValue>> getQuestSortLocales(
    int id,
    DbcLocaleFieldDefinition field,
  ) => loadDbcLocaleField(id, field);

  Future<void> saveQuestSortLocales(
    int id,
    DbcLocaleFieldDefinition field,
    List<DbcLocaleFieldValue> locales,
  ) => storeDbcLocaleField(id, field, locales);

  Future<int> storeQuestSort(QuestSortEntity questSort) async {
    if (questSort.id <= 0) {
      throw InvalidPrimaryKeyException(
        'primary key must be assigned before store',
      );
    }
    await _beforeStore(questSort);
    final json = prepareWriteJson(questSort.toJson());
    try {
      await laconic.table(_table).insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = questSort.copyWith(
        id: await nextMaxPlusOne(_table, '`ID`'),
      );
      try {
        await laconic.table(_table).insert([
          prepareWriteJson(retried.toJson()),
        ]);
        return retried.id;
      } catch (retryError) {
        if (MysqlErrorUtil.isDuplicateEntry(retryError)) {
          throw DuplicateKeyException('duplicate key in foxy.dbc_quest_sort');
        }
        rethrow;
      }
    }
    return questSort.id;
  }

  Future<void> updateQuestSort(
    int originalKey,
    QuestSortEntity questSort,
  ) async {
    await _beforeUpdate(originalKey, questSort);
    final json = prepareWriteJson(questSort.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException('duplicate key in foxy.dbc_quest_sort');
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException('foxy.dbc_quest_sort record not found');
    }
  }

  QueryBuilder _applyFilter(QueryBuilder builder, QuestSortFilter? filter) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('`ID`', filter.id);
    }
    if (filter.name.isNotEmpty) {
      builder = builder.where('`SortName_lang_zhCN`', filter.name);
    }
    return builder;
  }

  Future<void> _beforeDestroy(int key) async {}

  Future<void> _beforeStore(QuestSortEntity questSort) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    QuestSortEntity questSort,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('`ID`', key);
  }
}

const _table = 'foxy.dbc_quest_sort';
