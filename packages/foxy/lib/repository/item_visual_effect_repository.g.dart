// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_visual_effect_repository.dart';

final class ItemVisualEffectFilter {
  final String id;
  final String model;

  const ItemVisualEffectFilter({this.id = '', this.model = ''});

  factory ItemVisualEffectFilter.fromJson(Map<String, dynamic> json) {
    return ItemVisualEffectFilter(
      id: json['id']?.toString() ?? '',
      model: json['model']?.toString() ?? '',
    );
  }

  ItemVisualEffectFilter copyWith({String? id, String? model}) {
    return ItemVisualEffectFilter(
      id: id ?? this.id,
      model: model ?? this.model,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'model': model};
  }
}

mixin _ItemVisualEffectRepositoryMixin on RepositoryMixin {
  Future<void> destroyItemVisualEffect(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException(
        'foxy.dbc_item_visual_effects record not found',
      );
    }
  }

  Future<ItemVisualEffectEntity?> getItemVisualEffect(int key) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return ItemVisualEffectEntity.fromJson(results.first.toMap());
  }

  Future<int> storeItemVisualEffect(
    ItemVisualEffectEntity itemVisualEffect,
  ) async {
    if (itemVisualEffect.id <= 0) {
      throw InvalidPrimaryKeyException(
        'primary key must be assigned before store',
      );
    }
    await _beforeStore(itemVisualEffect);
    final json = prepareWriteJson(itemVisualEffect.toJson());
    try {
      await laconic.table(_table).insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = itemVisualEffect.copyWith(
        id: await nextMaxPlusOne(_table, '`ID`'),
      );
      try {
        await laconic.table(_table).insert([
          prepareWriteJson(retried.toJson()),
        ]);
        return retried.id;
      } catch (retryError) {
        if (MysqlErrorUtil.isDuplicateEntry(retryError)) {
          throw DuplicateKeyException(
            'duplicate key in foxy.dbc_item_visual_effects',
          );
        }
        rethrow;
      }
    }
    return itemVisualEffect.id;
  }

  Future<void> updateItemVisualEffect(
    int originalKey,
    ItemVisualEffectEntity itemVisualEffect,
  ) async {
    await _beforeUpdate(originalKey, itemVisualEffect);
    final json = prepareWriteJson(itemVisualEffect.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException(
          'duplicate key in foxy.dbc_item_visual_effects',
        );
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException(
        'foxy.dbc_item_visual_effects record not found',
      );
    }
  }

  Future<void> _beforeDestroy(int key) async {}

  Future<void> _beforeStore(ItemVisualEffectEntity itemVisualEffect) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    ItemVisualEffectEntity itemVisualEffect,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('`ID`', key);
  }
}

const _table = 'foxy.dbc_item_visual_effects';
