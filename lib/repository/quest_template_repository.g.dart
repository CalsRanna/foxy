// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quest_template_repository.dart';

mixin _QuestTemplateRepositoryMixin on RepositoryMixin {
  Future<void> destroyQuestTemplate(int key) async {
    final deletedRows = await _whereKey(
      laconic.table('quest_template'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<QuestTemplateEntity?> getQuestTemplate(int key) async {
    final results = await _whereKey(
      laconic.table('quest_template'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return QuestTemplateEntity.fromJson(results.first.toMap());
  }

  Future<void> storeQuestTemplate(QuestTemplateEntity questTemplate) async {
    if (questTemplate.id <= 0) {
      throw StateError('主键必须在新建时显式分配');
    }
    await _beforeStore(questTemplate);
    final json = _prepareWriteJson(questTemplate.toJson());
    try {
      await laconic.table('quest_template').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateQuestTemplate(
    int originalKey,
    QuestTemplateEntity questTemplate,
  ) async {
    await _beforeUpdate(originalKey, questTemplate);
    final json = _prepareWriteJson(questTemplate.toJson());
    try {
      final matchedRows = await _whereKey(
        laconic.table('quest_template'),
        originalKey,
      ).update(json);
      if (matchedRows == 0) {
        throw StateError('原记录不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的主键已存在');
      }
      rethrow;
    }
  }

  Future<void> _beforeStore(QuestTemplateEntity questTemplate) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    QuestTemplateEntity questTemplate,
  ) async {}

  Map<String, dynamic> _prepareWriteJson(Map<String, dynamic> json) {
    return {
      for (final entry in json.entries)
        if (const {'index', 'rank'}.contains(entry.key.toLowerCase()))
          '`${entry.key}`': entry.value
        else
          entry.key: entry.value,
    };
  }

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('ID', key);
  }
}

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
