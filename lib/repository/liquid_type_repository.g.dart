// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'liquid_type_repository.dart';

mixin _LiquidTypeRepositoryMixin on RepositoryMixin {
  Future<void> destroyLiquidType(int key) async {
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_liquid_type'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<LiquidTypeEntity?> getLiquidType(int key) async {
    final results = await _whereKey(
      laconic.table('foxy.dbc_liquid_type'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return LiquidTypeEntity.fromJson(results.first.toMap());
  }

  Future<void> updateLiquidType(
    int originalKey,
    LiquidTypeEntity entity,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table('foxy.dbc_liquid_type'),
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

final class LiquidTypeFilter {
  final String id;
  final String name;

  const LiquidTypeFilter({this.id = '', this.name = ''});

  factory LiquidTypeFilter.fromJson(Map<String, dynamic> json) {
    return LiquidTypeFilter(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  LiquidTypeFilter copyWith({String? id, String? name}) {
    return LiquidTypeFilter(id: id ?? this.id, name: name ?? this.name);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
