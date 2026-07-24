// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_model_data_repository.dart';

final class CreatureModelDataFilter {
  final String id;
  final String modelName;

  const CreatureModelDataFilter({this.id = '', this.modelName = ''});

  factory CreatureModelDataFilter.fromJson(Map<String, dynamic> json) {
    return CreatureModelDataFilter(
      id: json['id']?.toString() ?? '',
      modelName: json['modelName']?.toString() ?? '',
    );
  }

  CreatureModelDataFilter copyWith({String? id, String? modelName}) {
    return CreatureModelDataFilter(
      id: id ?? this.id,
      modelName: modelName ?? this.modelName,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'modelName': modelName};
  }
}
