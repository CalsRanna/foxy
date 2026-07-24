// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spell_duration_repository.dart';

final class SpellDurationFilter {
  final String id;

  const SpellDurationFilter({this.id = ''});

  factory SpellDurationFilter.fromJson(Map<String, dynamic> json) {
    return SpellDurationFilter(id: json['id']?.toString() ?? '');
  }

  SpellDurationFilter copyWith({String? id}) {
    return SpellDurationFilter(id: id ?? this.id);
  }

  Map<String, dynamic> toJson() {
    return {'id': id};
  }
}
