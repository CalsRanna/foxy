// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cinematic_sequence_repository.dart';

final class CinematicSequenceFilter {
  final String id;

  const CinematicSequenceFilter({this.id = ''});

  factory CinematicSequenceFilter.fromJson(Map<String, dynamic> json) {
    return CinematicSequenceFilter(id: json['id']?.toString() ?? '');
  }

  CinematicSequenceFilter copyWith({String? id}) {
    return CinematicSequenceFilter(id: id ?? this.id);
  }

  Map<String, dynamic> toJson() {
    return {'id': id};
  }
}
