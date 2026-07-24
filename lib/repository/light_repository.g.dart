// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'light_repository.dart';

final class LightFilter {
  final String id;
  final String continentId;

  const LightFilter({this.id = '', this.continentId = ''});

  factory LightFilter.fromJson(Map<String, dynamic> json) {
    return LightFilter(
      id: json['id']?.toString() ?? '',
      continentId: json['continentId']?.toString() ?? '',
    );
  }

  LightFilter copyWith({String? id, String? continentId}) {
    return LightFilter(
      id: id ?? this.id,
      continentId: continentId ?? this.continentId,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'continentId': continentId};
  }
}
