// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dbc_item_repository.dart';

final class DbcItemFilter {
  final String id;
  final bool handEquippableOnly;

  const DbcItemFilter({this.id = '', this.handEquippableOnly = false});

  factory DbcItemFilter.fromJson(Map<String, dynamic> json) {
    return DbcItemFilter(
      id: json['id']?.toString() ?? '',
      handEquippableOnly: json['handEquippableOnly'] as bool? ?? false,
    );
  }

  DbcItemFilter copyWith({String? id, bool? handEquippableOnly}) {
    return DbcItemFilter(
      id: id ?? this.id,
      handEquippableOnly: handEquippableOnly ?? this.handEquippableOnly,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'handEquippableOnly': handEquippableOnly};
  }
}
