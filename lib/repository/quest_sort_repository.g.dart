// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quest_sort_repository.dart';

mixin _QuestSortRepositoryMixin on RepositoryMixin {
  Future<void> destroyQuestSort(int key) async {
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_quest_sort'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<QuestSortEntity?> getQuestSort(int key) async {
    final results = await _whereKey(
      laconic.table('foxy.dbc_quest_sort'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return QuestSortEntity.fromJson(results.first.toMap());
  }

  Future<void> updateQuestSort(
    int originalKey,
    QuestSortEntity questSort,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table('foxy.dbc_quest_sort'),
        originalKey,
      ).update(questSort.toJson());
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
