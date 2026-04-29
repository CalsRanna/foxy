/// 法术自定义属性
class SpellCustomAttr {
  final int spellId;
  final int attributes;

  const SpellCustomAttr({this.spellId = 0, this.attributes = 0});

  factory SpellCustomAttr.fromJson(Map<String, dynamic> json) {
    return SpellCustomAttr(
      spellId: json['spell_id'] ?? 0,
      attributes: json['attributes'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'spell_id': spellId, 'attributes': attributes};
  }
}
