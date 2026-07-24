// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'point_of_interest_repository.dart';

mixin _PointOfInterestRepositoryMixin on RepositoryMixin {
  Future<void> destroyPointOfInterest(int key) async {
    final deletedRows = await _whereKey(
      laconic.table('points_of_interest'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<PointOfInterestEntity?> getPointOfInterest(int key) async {
    final results = await _whereKey(
      laconic.table('points_of_interest'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return PointOfInterestEntity.fromJson(results.first.toMap());
  }

  Future<void> updatePointOfInterest(
    int originalKey,
    PointOfInterestEntity entity,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table('points_of_interest'),
        originalKey,
      ).update(entity.toJson());
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

final class PointOfInterestFilter {
  final String id;
  final String name;

  const PointOfInterestFilter({this.id = '', this.name = ''});

  factory PointOfInterestFilter.fromJson(Map<String, dynamic> json) {
    return PointOfInterestFilter(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  PointOfInterestFilter copyWith({String? id, String? name}) {
    return PointOfInterestFilter(id: id ?? this.id, name: name ?? this.name);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
