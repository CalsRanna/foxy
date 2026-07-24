// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_visual_effect_repository.dart';

mixin _ItemVisualEffectRepositoryMixin on RepositoryMixin {
  Future<void> destroyItemVisualEffect(int key) async {
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_item_visual_effects'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
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
      throw StateError('主键必须在新建时显式分配');
    }
    await _beforeStore(itemVisualEffect);
    final json = _prepareWriteJson(itemVisualEffect.toJson());
    try {
      await laconic.table('foxy.dbc_item_visual_effects').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateItemVisualEffect(
    int originalKey,
    ItemVisualEffectEntity itemVisualEffect,
  ) async {
    await _beforeUpdate(originalKey, itemVisualEffect);
    final json = _prepareWriteJson(itemVisualEffect.toJson());
    try {
      final matchedRows = await _whereKey(
        laconic.table('foxy.dbc_item_visual_effects'),
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

  Future<void> _beforeStore(ItemVisualEffectEntity itemVisualEffect) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    ItemVisualEffectEntity itemVisualEffect,
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
