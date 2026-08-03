// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spell_custom_attr_entity.dart';

final class BriefSpellCustomAttrEntity {
  final int spellId;
  final int attributes;

  const BriefSpellCustomAttrEntity({this.spellId = 0, this.attributes = 0});

  factory BriefSpellCustomAttrEntity.fromJson(Map<String, dynamic> json) {
    return BriefSpellCustomAttrEntity(
      spellId: json['spell_id'] == true
          ? 1
          : json['spell_id'] == false
          ? 0
          : (json['spell_id'] as num?)?.toInt() ?? 0,
      attributes: json['attributes'] == true
          ? 1
          : json['attributes'] == false
          ? 0
          : (json['attributes'] as num?)?.toInt() ?? 0,
    );
  }

  @override
  int get hashCode => Object.hashAll([spellId, attributes]);

  int get key => spellId;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is BriefSpellCustomAttrEntity &&
            spellId == other.spellId &&
            attributes == other.attributes;
  }

  @override
  String toString() {
    return 'BriefSpellCustomAttrEntity('
        'spellId: $spellId, '
        'attributes: $attributes'
        ')';
  }
}

mixin _SpellCustomAttrEntityMixin {
  @override
  int get hashCode {
    final self = this as SpellCustomAttrEntity;
    return Object.hashAll([self.runtimeType, self.spellId, self.attributes]);
  }

  @override
  bool operator ==(Object other) {
    final self = this as SpellCustomAttrEntity;
    return identical(self, other) ||
        other is SpellCustomAttrEntity &&
            self.runtimeType == other.runtimeType &&
            self.spellId == other.spellId &&
            self.attributes == other.attributes;
  }

  SpellCustomAttrEntity copyWith({int? spellId, int? attributes}) {
    final self = this as SpellCustomAttrEntity;
    return SpellCustomAttrEntity(
      spellId: spellId ?? self.spellId,
      attributes: attributes ?? self.attributes,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as SpellCustomAttrEntity;
    return {'spell_id': self.spellId, 'attributes': self.attributes};
  }

  @override
  String toString() {
    final self = this as SpellCustomAttrEntity;
    return 'SpellCustomAttrEntity('
        'spellId: ${self.spellId}, '
        'attributes: ${self.attributes}'
        ')';
  }

  static SpellCustomAttrEntity fromJson(Map<String, dynamic> json) {
    return SpellCustomAttrEntity(
      spellId: json['spell_id'] == true
          ? 1
          : json['spell_id'] == false
          ? 0
          : (json['spell_id'] as num?)?.toInt() ?? 0,
      attributes: json['attributes'] == true
          ? 1
          : json['attributes'] == false
          ? 0
          : (json['attributes'] as num?)?.toInt() ?? 0,
    );
  }
}
