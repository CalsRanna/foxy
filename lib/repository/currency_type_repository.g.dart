// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_type_repository.dart';

final class CurrencyTypeFilter {
  final String id;
  final String name;

  const CurrencyTypeFilter({this.id = '', this.name = ''});

  factory CurrencyTypeFilter.fromJson(Map<String, dynamic> json) {
    return CurrencyTypeFilter(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  CurrencyTypeFilter copyWith({String? id, String? name}) {
    return CurrencyTypeFilter(id: id ?? this.id, name: name ?? this.name);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
