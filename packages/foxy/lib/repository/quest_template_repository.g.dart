// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quest_template_repository.dart';

final class QuestTemplateFilter {
  final String id;
  final String title;

  const QuestTemplateFilter({this.id = '', this.title = ''});

  factory QuestTemplateFilter.fromJson(Map<String, dynamic> json) {
    return QuestTemplateFilter(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
    );
  }

  QuestTemplateFilter copyWith({String? id, String? title}) {
    return QuestTemplateFilter(id: id ?? this.id, title: title ?? this.title);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title};
  }
}

mixin _QuestTemplateRepositoryMixin on RepositoryMixin {
  Future<int> copyQuestTemplate(int key) async {
    final source = await getQuestTemplate(key);
    if (source == null) {
      throw RecordNotFoundException('quest_template record not found');
    }
    final blank = await createQuestTemplate();
    final copied = source.copyWith(id: blank.id);
    await storeQuestTemplate(copied);
    return copied.id;
  }

  Future<int> countQuestTemplates({QuestTemplateFilter? filter}) async {
    return _applyFilter(laconic.table(_table), filter).count();
  }

  Future<QuestTemplateEntity> createQuestTemplate() async {
    return QuestTemplateEntity(id: await nextMaxPlusOne(_table, '`ID`'));
  }

  Future<void> destroyQuestTemplate(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException('quest_template record not found');
    }
  }

  Future<QuestTemplateEntity?> getQuestTemplate(int key) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return QuestTemplateEntity.fromJson(results.first.toMap());
  }

  Future<List<BriefQuestTemplateEntity>> getBriefQuestTemplates({
    int page = 1,
    QuestTemplateFilter? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table).select([
      '`ID`',
      '`QuestType`',
      '`QuestLevel`',
      '`MinLevel`',
      '`LogTitle`',
      '`QuestDescription`',
    ]);
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('`ID`');
    builder = builder.limit(kPageSize).offset(offset);
    final results = await builder.get();
    return results
        .map((e) => BriefQuestTemplateEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<List<QuestTemplateEntity>> getQuestTemplates() async {
    var builder = laconic.table(_table).orderBy('`ID`');
    final results = await builder.get();
    return results.map((e) => QuestTemplateEntity.fromJson(e.toMap())).toList();
  }

  Future<int> storeQuestTemplate(QuestTemplateEntity questTemplate) async {
    if (questTemplate.id <= 0) {
      throw InvalidPrimaryKeyException(
        'primary key must be assigned before store',
      );
    }
    await _beforeStore(questTemplate);
    final json = prepareWriteJson(questTemplate.toJson());
    try {
      await laconic.table(_table).insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = questTemplate.copyWith(
        id: await nextMaxPlusOne(_table, '`ID`'),
      );
      try {
        await laconic.table(_table).insert([
          prepareWriteJson(retried.toJson()),
        ]);
        return retried.id;
      } catch (retryError) {
        if (MysqlErrorUtil.isDuplicateEntry(retryError)) {
          throw DuplicateKeyException('duplicate key in quest_template');
        }
        rethrow;
      }
    }
    return questTemplate.id;
  }

  Future<void> updateQuestTemplate(
    int originalKey,
    QuestTemplateEntity questTemplate,
  ) async {
    await _beforeUpdate(originalKey, questTemplate);
    final json = prepareWriteJson(questTemplate.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException('duplicate key in quest_template');
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException('quest_template record not found');
    }
  }

  QueryBuilder _applyFilter(QueryBuilder builder, QuestTemplateFilter? filter) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('`ID`', filter.id);
    }
    if (filter.title.isNotEmpty) {
      builder = builder.where('`qt`.`LogTitle`', filter.title);
    }
    return builder;
  }

  Future<void> _beforeDestroy(int key) async {}

  Future<void> _beforeStore(QuestTemplateEntity questTemplate) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    QuestTemplateEntity questTemplate,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('`ID`', key);
  }
}

const _table = 'quest_template';
