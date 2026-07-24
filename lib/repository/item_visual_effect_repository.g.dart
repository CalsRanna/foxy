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

  Future<void> updateItemVisualEffect(
    int originalKey,
    ItemVisualEffectEntity entity,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table('foxy.dbc_item_visual_effects'),
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
