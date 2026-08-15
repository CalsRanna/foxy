// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'liquid_type_repository.dart';

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

mixin _LiquidTypeRepositoryMixin on RepositoryMixin {
  String get _table => 'foxy.dbc_liquid_type';

  Future<void> destroyLiquidType(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException('foxy.dbc_liquid_type record not found');
    }
  }

  Future<LiquidTypeEntity?> getLiquidType(int key) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return LiquidTypeEntity.fromJson(results.first.toMap());
  }

  Future<int> storeLiquidType(LiquidTypeEntity liquidType) async {
    if (liquidType.id <= 0) {
      throw InvalidPrimaryKeyException(
        'primary key must be assigned before store',
      );
    }
    await _beforeStore(liquidType);
    final json = prepareWriteJson(liquidType.toJson());
    try {
      await laconic.table(_table).insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = liquidType.copyWith(
        id: await nextMaxPlusOne(_table, '`ID`'),
      );
      try {
        await laconic.table(_table).insert([
          prepareWriteJson(retried.toJson()),
        ]);
        return retried.id;
      } catch (retryError) {
        if (MysqlErrorUtil.isDuplicateEntry(retryError)) {
          throw DuplicateKeyException('duplicate key in foxy.dbc_liquid_type');
        }
        rethrow;
      }
    }
    return liquidType.id;
  }

  Future<void> updateLiquidType(
    int originalKey,
    LiquidTypeEntity liquidType,
  ) async {
    await _beforeUpdate(originalKey, liquidType);
    final json = prepareWriteJson(liquidType.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException('duplicate key in foxy.dbc_liquid_type');
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException('foxy.dbc_liquid_type record not found');
    }
  }

  Future<void> _beforeDestroy(int key) async {}

  Future<void> _beforeStore(LiquidTypeEntity liquidType) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    LiquidTypeEntity liquidType,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('`ID`', key);
  }
}
