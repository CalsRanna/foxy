/// 法术自定义属性列表/Picker 展示模型
class BriefSpellCustomAttrEntity {
  final int spellId;
  final int attributes;

  const BriefSpellCustomAttrEntity({this.spellId = 0, this.attributes = 0});

  factory BriefSpellCustomAttrEntity.fromJson(Map<String, dynamic> json) {
    return BriefSpellCustomAttrEntity(
      spellId: json['spell_id'] ?? 0,
      attributes: json['attributes'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'spell_id': spellId, 'attributes': attributes};
  }
}

/// 法术自定义属性
class SpellCustomAttrEntity {
  final int spellId;
  final int attributes;

  const SpellCustomAttrEntity({this.spellId = 0, this.attributes = 0});

  factory SpellCustomAttrEntity.fromJson(Map<String, dynamic> json) {
    return SpellCustomAttrEntity(
      spellId: json['spell_id'] ?? 0,
      attributes: json['attributes'] ?? 0,
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
}
