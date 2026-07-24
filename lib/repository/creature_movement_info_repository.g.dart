// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_movement_info_repository.dart';

final class CreatureMovementInfoFilter {
  final String id;

  const CreatureMovementInfoFilter({this.id = ''});

  factory CreatureMovementInfoFilter.fromJson(Map<String, dynamic> json) {
    return CreatureMovementInfoFilter(id: json['id']?.toString() ?? '');
  }

  CreatureMovementInfoFilter copyWith({String? id}) {
    return CreatureMovementInfoFilter(id: id ?? this.id);
  }

  Map<String, dynamic> toJson() {
    return {'id': id};
  }
}
