// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'point_of_interest_repository.dart';

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

mixin _PointOfInterestRepositoryMixin on RepositoryMixin {
  Future<void> destroyPointOfInterest(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(
      laconic.table('points_of_interest'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException('points_of_interest record not found');
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

  Future<void> storePointOfInterest(
    PointOfInterestEntity pointOfInterest,
  ) async {
    if (pointOfInterest.id <= 0) {
      throw InvalidPrimaryKeyException(
        'primary key must be assigned before store',
      );
    }
    await _beforeStore(pointOfInterest);
    final json = prepareWriteJson(pointOfInterest.toJson());
    try {
      await laconic.table('points_of_interest').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException('duplicate key in points_of_interest');
      }
      rethrow;
    }
  }

  Future<void> updatePointOfInterest(
    int originalKey,
    PointOfInterestEntity pointOfInterest,
  ) async {
    await _beforeUpdate(originalKey, pointOfInterest);
    final json = prepareWriteJson(pointOfInterest.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table('points_of_interest'),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException('duplicate key in points_of_interest');
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException('points_of_interest record not found');
    }
  }

  Future<void> _beforeDestroy(int key) async {}

  Future<void> _beforeStore(PointOfInterestEntity pointOfInterest) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    PointOfInterestEntity pointOfInterest,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('`ID`', key);
  }
}
