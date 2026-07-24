// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_display_info_repository.dart';

final class CreatureDisplayInfoFilter {
  final String id;
  final String modelName;

  const CreatureDisplayInfoFilter({this.id = '', this.modelName = ''});

  factory CreatureDisplayInfoFilter.fromJson(Map<String, dynamic> json) {
    return CreatureDisplayInfoFilter(
      id: json['id']?.toString() ?? '',
      modelName: json['modelName']?.toString() ?? '',
    );
  }

  CreatureDisplayInfoFilter copyWith({String? id, String? modelName}) {
    return CreatureDisplayInfoFilter(
      id: id ?? this.id,
      modelName: modelName ?? this.modelName,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'modelName': modelName};
  }
}
