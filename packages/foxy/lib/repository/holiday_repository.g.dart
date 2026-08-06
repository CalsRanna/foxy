// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'holiday_repository.dart';

final class HolidayFilter {
  final String id;

  const HolidayFilter({this.id = ''});

  factory HolidayFilter.fromJson(Map<String, dynamic> json) {
    return HolidayFilter(id: json['id']?.toString() ?? '');
  }

  HolidayFilter copyWith({String? id}) {
    return HolidayFilter(id: id ?? this.id);
  }

  Map<String, dynamic> toJson() {
    return {'id': id};
  }
}
