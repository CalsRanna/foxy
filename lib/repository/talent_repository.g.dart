// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'talent_repository.dart';

final class TalentFilter {
  final String id;
  final String spell;

  const TalentFilter({this.id = '', this.spell = ''});

  factory TalentFilter.fromJson(Map<String, dynamic> json) {
    return TalentFilter(
      id: json['id']?.toString() ?? '',
      spell: json['spell']?.toString() ?? '',
    );
  }

  TalentFilter copyWith({String? id, String? spell}) {
    return TalentFilter(id: id ?? this.id, spell: spell ?? this.spell);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'spell': spell};
  }
}
