// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spell_custom_attr_entity.dart';

mixin _SpellCustomAttrEntityMixin {
  static SpellCustomAttrEntity fromJson(Map<String, dynamic> json) {
    return SpellCustomAttrEntity(
      spellId: (json['spell_id'] as num?)?.toInt() ?? 0,
      attributes: (json['attributes'] as num?)?.toInt() ?? 0,
    );
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
  bool operator ==(Object other) {
    final self = this as SpellCustomAttrEntity;
    return identical(self, other) ||
        other is SpellCustomAttrEntity &&
            self.runtimeType == other.runtimeType &&
            self.spellId == other.spellId &&
            self.attributes == other.attributes;
  }

  @override
  int get hashCode {
    final self = this as SpellCustomAttrEntity;
    return Object.hashAll([self.runtimeType, self.spellId, self.attributes]);
  }

  @override
  String toString() {
    final self = this as SpellCustomAttrEntity;
    return 'SpellCustomAttrEntity('
        'spellId: ${self.spellId}, '
        'attributes: ${self.attributes}'
        ')';
  }
}
