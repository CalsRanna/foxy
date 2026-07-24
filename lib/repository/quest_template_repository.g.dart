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

  Future<void> updateQuestTemplate(
    int originalKey,
    QuestTemplateEntity template,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table('quest_template'),
        originalKey,
      ).update(template.toJson());
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
