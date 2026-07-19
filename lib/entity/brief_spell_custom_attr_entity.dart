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

  int get key => spellId;
}
