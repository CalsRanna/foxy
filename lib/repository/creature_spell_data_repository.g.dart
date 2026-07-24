// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_spell_data_repository.dart';

final class CreatureSpellDataFilter {
  final String id;
  final String spell;

  const CreatureSpellDataFilter({this.id = '', this.spell = ''});

  factory CreatureSpellDataFilter.fromJson(Map<String, dynamic> json) {
    return CreatureSpellDataFilter(
      id: json['id']?.toString() ?? '',
      spell: json['spell']?.toString() ?? '',
    );
  }

  CreatureSpellDataFilter copyWith({String? id, String? spell}) {
    return CreatureSpellDataFilter(
      id: id ?? this.id,
      spell: spell ?? this.spell,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'spell': spell};
  }
}
