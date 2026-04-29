/// 法术自定义属性
class SpellCustomAttr {
  int spellId = 0;
  int attributes = 0;

  SpellCustomAttr();

  factory SpellCustomAttr.fromJson(Map<String, dynamic> json) {
    return SpellCustomAttr()
      ..spellId = json['spell_id'] ?? 0
      ..attributes = json['attributes'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    return {'spell_id': spellId, 'attributes': attributes};
  }
}
