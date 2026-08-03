// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'light_repository.dart';

final class LightFilter {
  final String id;
  final String continentId;

  const LightFilter({this.id = '', this.continentId = ''});

  factory LightFilter.fromJson(Map<String, dynamic> json) {
    return LightFilter(
      id: json['id']?.toString() ?? '',
      continentId: json['continentId']?.toString() ?? '',
    );
  }

  LightFilter copyWith({String? id, String? continentId}) {
    return LightFilter(
      id: id ?? this.id,
      continentId: continentId ?? this.continentId,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'continentId': continentId};
  }
}

mixin _LightRepositoryMixin on RepositoryMixin {
  Future<void> destroyLight(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_light'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException('foxy.dbc_light record not found');
    }
  }

  Future<LightEntity?> getLight(int key) async {
    final results = await _whereKey(
      laconic.table('foxy.dbc_light'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return LightEntity.fromJson(results.first.toMap());
  }

  Future<void> storeLight(LightEntity light) async {
    if (light.id <= 0) {
      throw InvalidPrimaryKeyException(
        'primary key must be assigned before store',
      );
    }
    await _beforeStore(light);
    final json = prepareWriteJson(light.toJson());
    try {
      await laconic.table('foxy.dbc_light').insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = light.copyWith(
        id: await nextMaxPlusOne('foxy.dbc_light', '`ID`'),
      );
      try {
        await laconic.table('foxy.dbc_light').insert([
          prepareWriteJson(retried.toJson()),
        ]);
        return;
      } catch (retryError) {
        if (MysqlErrorUtil.isDuplicateEntry(retryError)) {
          throw DuplicateKeyException('duplicate key in foxy.dbc_light');
        }
        rethrow;
      }
    }
  }

  Future<void> updateLight(int originalKey, LightEntity light) async {
    await _beforeUpdate(originalKey, light);
    final json = prepareWriteJson(light.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table('foxy.dbc_light'),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException('duplicate key in foxy.dbc_light');
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException('foxy.dbc_light record not found');
    }
  }

  Future<void> _beforeDestroy(int key) async {}

  Future<void> _beforeStore(LightEntity light) async {}

  Future<void> _beforeUpdate(int originalKey, LightEntity light) async {}

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('`ID`', key);
  }
}
