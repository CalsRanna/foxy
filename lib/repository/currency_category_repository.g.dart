// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_category_repository.dart';

final class CurrencyCategoryFilter {
  final String id;
  final String name;

  const CurrencyCategoryFilter({this.id = '', this.name = ''});

  factory CurrencyCategoryFilter.fromJson(Map<String, dynamic> json) {
    return CurrencyCategoryFilter(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  CurrencyCategoryFilter copyWith({String? id, String? name}) {
    return CurrencyCategoryFilter(id: id ?? this.id, name: name ?? this.name);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
