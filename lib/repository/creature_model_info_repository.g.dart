// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_model_info_repository.dart';

final class CreatureModelInfoFilter {
  final String id;

  const CreatureModelInfoFilter({this.id = ''});

  factory CreatureModelInfoFilter.fromJson(Map<String, dynamic> json) {
    return CreatureModelInfoFilter(id: json['id']?.toString() ?? '');
  }

  CreatureModelInfoFilter copyWith({String? id}) {
    return CreatureModelInfoFilter(id: id ?? this.id);
  }

  Map<String, dynamic> toJson() {
    return {'id': id};
  }
}
