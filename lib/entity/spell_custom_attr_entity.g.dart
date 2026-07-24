// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spell_custom_attr_entity.dart';

mixin _SpellCustomAttrEntityMixin {
  int get spellId;
  int get attributes;

  static SpellCustomAttrEntity fromJson(Map<String, dynamic> json) {
    return SpellCustomAttrEntity(
      spellId: (json['spell_id'] as num?)?.toInt() ?? 0,
      attributes: (json['attributes'] as num?)?.toInt() ?? 0,
    );
  }

  SpellCustomAttrEntity copyWith({int? spellId, int? attributes}) {
    return SpellCustomAttrEntity(
      spellId: spellId ?? this.spellId,
      attributes: attributes ?? this.attributes,
    );
  }

  Map<String, dynamic> toJson() {
    return {'spell_id': spellId, 'attributes': attributes};
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is SpellCustomAttrEntity &&
            runtimeType == other.runtimeType &&
            spellId == other.spellId &&
            attributes == other.attributes;
  }

  @override
  int get hashCode {
    return Object.hashAll([runtimeType, spellId, attributes]);
  }

  @override
  String toString() {
    return 'SpellCustomAttrEntity('
        'spellId: $spellId, '
        'attributes: $attributes'
        ')';
  }
}
