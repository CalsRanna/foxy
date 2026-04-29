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

  Map<String, dynamic> toJson() {
    return {'spell_id': spellId, 'attributes': attributes};
  }
}
