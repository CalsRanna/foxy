// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lock_repository.dart';

final class LockFilter {
  final String id;

  const LockFilter({this.id = ''});

  factory LockFilter.fromJson(Map<String, dynamic> json) {
    return LockFilter(id: json['id']?.toString() ?? '');
  }

  LockFilter copyWith({String? id}) {
    return LockFilter(id: id ?? this.id);
  }

  Map<String, dynamic> toJson() {
    return {'id': id};
  }
}
