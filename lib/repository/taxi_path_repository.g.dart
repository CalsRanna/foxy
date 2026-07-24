// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'taxi_path_repository.dart';

final class TaxiPathFilter {
  final String id;

  const TaxiPathFilter({this.id = ''});

  factory TaxiPathFilter.fromJson(Map<String, dynamic> json) {
    return TaxiPathFilter(id: json['id']?.toString() ?? '');
  }

  TaxiPathFilter copyWith({String? id}) {
    return TaxiPathFilter(id: id ?? this.id);
  }

  Map<String, dynamic> toJson() {
    return {'id': id};
  }
}
