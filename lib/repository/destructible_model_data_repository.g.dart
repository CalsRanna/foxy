// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'destructible_model_data_repository.dart';

final class DestructibleModelDataFilter {
  final String id;

  const DestructibleModelDataFilter({this.id = ''});

  factory DestructibleModelDataFilter.fromJson(Map<String, dynamic> json) {
    return DestructibleModelDataFilter(id: json['id']?.toString() ?? '');
  }

  DestructibleModelDataFilter copyWith({String? id}) {
    return DestructibleModelDataFilter(id: id ?? this.id);
  }

  Map<String, dynamic> toJson() {
    return {'id': id};
  }
}
