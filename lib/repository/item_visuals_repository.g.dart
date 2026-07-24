// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_visuals_repository.dart';

mixin _ItemVisualsRepositoryMixin on RepositoryMixin {
  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('ID', key);
  }
}

final class ItemVisualsFilter {
  final String id;

  const ItemVisualsFilter({this.id = ''});

  factory ItemVisualsFilter.fromJson(Map<String, dynamic> json) {
    return ItemVisualsFilter(id: json['id']?.toString() ?? '');
  }

  ItemVisualsFilter copyWith({String? id}) {
    return ItemVisualsFilter(id: id ?? this.id);
  }

  Map<String, dynamic> toJson() {
    return {'id': id};
  }
}
