// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spell_group_entity.dart';

mixin _SpellGroupEntityMixin {
  int get id;
  int get spellId;

  static SpellGroupEntity fromJson(Map<String, dynamic> json) {
    return SpellGroupEntity(
      id: (json['id'] as num?)?.toInt() ?? 0,
      spellId: (json['spell_id'] as num?)?.toInt() ?? 0,
    );
  }

  SpellGroupEntity copyWith({int? id, int? spellId}) {
    return SpellGroupEntity(
      id: id ?? this.id,
      spellId: spellId ?? this.spellId,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'spell_id': spellId};
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is SpellGroupEntity &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            spellId == other.spellId;
  }

  @override
  int get hashCode {
    return Object.hashAll([runtimeType, id, spellId]);
  }

  @override
  String toString() {
    return 'SpellGroupEntity('
        'id: $id, '
        'spellId: $spellId'
        ')';
  }
}
