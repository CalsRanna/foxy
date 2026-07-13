/// 法术自定义属性
class SpellCustomAttrEntity {
  final int spellId;
  final int attributes;

  const SpellCustomAttrEntity({this.spellId = 0, this.attributes = 0});

  void validate() {
    if ((attributes & 0x00001000) != 0 && (attributes & 0x02000000) != 0) {
      throw ArgumentError('效果1不能同时标记为正面和负面');
    }
    if ((attributes & 0x00002000) != 0 && (attributes & 0x04000000) != 0) {
      throw ArgumentError('效果2不能同时标记为正面和负面');
    }
    if ((attributes & 0x00004000) != 0 && (attributes & 0x08000000) != 0) {
      throw ArgumentError('效果3不能同时标记为正面和负面');
    }
  }

  factory SpellCustomAttrEntity.fromJson(Map<String, dynamic> json) {
    return SpellCustomAttrEntity(
      spellId: json['spell_id'] ?? 0,
      attributes: json['attributes'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'spell_id': spellId, 'attributes': attributes};
  }

  SpellCustomAttrEntity copyWith({int? spellId, int? attributes}) {
    return SpellCustomAttrEntity(
      spellId: spellId ?? this.spellId,
      attributes: attributes ?? this.attributes,
    );
  }
}

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
