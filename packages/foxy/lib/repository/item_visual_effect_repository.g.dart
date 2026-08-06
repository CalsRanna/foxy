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
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_item_visual_effects'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException(
        'foxy.dbc_item_visual_effects record not found',
      );
    }
  }

  Future<ItemVisualEffectEntity?> getItemVisualEffect(int key) async {
    final results = await _whereKey(
      laconic.table('foxy.dbc_item_visual_effects'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return ItemVisualEffectEntity.fromJson(results.first.toMap());
  }

  Future<void> storeItemVisualEffect(
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
      await laconic.table('foxy.dbc_item_visual_effects').insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = itemVisualEffect.copyWith(
        id: await nextMaxPlusOne('foxy.dbc_item_visual_effects', '`ID`'),
      );
      try {
        await laconic.table('foxy.dbc_item_visual_effects').insert([
          prepareWriteJson(retried.toJson()),
        ]);
        return;
      } catch (retryError) {
        if (MysqlErrorUtil.isDuplicateEntry(retryError)) {
          throw DuplicateKeyException(
            'duplicate key in foxy.dbc_item_visual_effects',
          );
        }
        rethrow;
      }
    }
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
        laconic.table('foxy.dbc_item_visual_effects'),
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
