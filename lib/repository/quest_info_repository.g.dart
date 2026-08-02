// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quest_info_repository.dart';

final class QuestInfoFilter {
  final String id;
  final String name;

  const QuestInfoFilter({this.id = '', this.name = ''});

  factory QuestInfoFilter.fromJson(Map<String, dynamic> json) {
    return QuestInfoFilter(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  QuestInfoFilter copyWith({String? id, String? name}) {
    return QuestInfoFilter(id: id ?? this.id, name: name ?? this.name);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}

mixin _QuestInfoRepositoryMixin on RepositoryMixin, DbcLocaleRepositoryMixin {
  Future<int> copyQuestInfo(int key) async {
    final source = await getQuestInfo(key);
    if (source == null) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
    final blank = await createQuestInfo();
    final copied = source.copyWith(id: blank.id);
    await storeQuestInfo(copied);
    return copied.id;
  }

  Future<int> countQuestInfos({QuestInfoFilter? filter}) async {
    return _applyFilter(laconic.table('foxy.dbc_quest_info'), filter).count();
  }

  Future<QuestInfoEntity> createQuestInfo() async {
    return QuestInfoEntity(
      id: await nextMaxPlusOne('foxy.dbc_quest_info', '`ID`'),
    );
  }

  Future<void> destroyQuestInfo(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_quest_info'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<QuestInfoEntity?> getQuestInfo(int key) async {
    final results = await _whereKey(
      laconic.table('foxy.dbc_quest_info'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return QuestInfoEntity.fromJson(results.first.toMap());
  }

  Future<List<BriefQuestInfoEntity>> getBriefQuestInfos({
    int page = 1,
    QuestInfoFilter? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table('foxy.dbc_quest_info').select([
      '`ID`',
      '`InfoName_lang_zhCN`',
    ]);
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('`ID`');
    builder = builder.limit(kPageSize).offset(offset);
    final results = await builder.get();
    return results
        .map((e) => BriefQuestInfoEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<List<QuestInfoEntity>> getQuestInfos() async {
    var builder = laconic.table('foxy.dbc_quest_info').orderBy('`ID`');
    final results = await builder.get();
    return results.map((e) => QuestInfoEntity.fromJson(e.toMap())).toList();
  }

  Future<List<DbcLocaleFieldValue>> getQuestInfoLocales(
    int id,
    DbcLocaleFieldDefinition field,
  ) => loadDbcLocaleField(id, field);

  Future<void> saveQuestInfoLocales(
    int id,
    DbcLocaleFieldDefinition field,
    List<DbcLocaleFieldValue> locales,
  ) => storeDbcLocaleField(id, field, locales);

  Future<void> storeQuestInfo(QuestInfoEntity questInfo) async {
    if (questInfo.id <= 0) {
      throw StateError('主键必须在新建时显式分配');
    }
    await _beforeStore(questInfo);
    final json = prepareWriteJson(questInfo.toJson());
    try {
      await laconic.table('foxy.dbc_quest_info').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateQuestInfo(
    int originalKey,
    QuestInfoEntity questInfo,
  ) async {
    await _beforeUpdate(originalKey, questInfo);
    final json = prepareWriteJson(questInfo.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table('foxy.dbc_quest_info'),
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

  QueryBuilder _applyFilter(QueryBuilder builder, QuestInfoFilter? filter) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('`ID`', filter.id);
    }
    if (filter.name.isNotEmpty) {
      builder = builder.where('`InfoName_lang_zhCN`', filter.name);
    }
    return builder;
  }

  Future<void> _beforeDestroy(int key) async {}

  Future<void> _beforeStore(QuestInfoEntity questInfo) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    QuestInfoEntity questInfo,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('`ID`', key);
  }
}
