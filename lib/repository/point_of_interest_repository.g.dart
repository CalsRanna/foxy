// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'point_of_interest_repository.dart';

final class PointOfInterestFilter {
  final String id;
  final String name;

  const PointOfInterestFilter({this.id = '', this.name = ''});

  factory PointOfInterestFilter.fromJson(Map<String, dynamic> json) {
    return PointOfInterestFilter(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  PointOfInterestFilter copyWith({String? id, String? name}) {
    return PointOfInterestFilter(id: id ?? this.id, name: name ?? this.name);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
