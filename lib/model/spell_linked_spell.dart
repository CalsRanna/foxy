/// 法术链接技能
class SpellLinkedSpell {
  final int spellTrigger;
  final int spellEffect;
  final int type;
  final String comment;

  const SpellLinkedSpell({
    this.spellTrigger = 0,
    this.spellEffect = 0,
    this.type = 0,
    this.comment = '',
  });

  factory SpellLinkedSpell.fromJson(Map<String, dynamic> json) {
    return SpellLinkedSpell(
      spellTrigger: json['spell_trigger'] ?? 0,
      spellEffect: json['spell_effect'] ?? 0,
      type: json['type'] ?? 0,
      comment: json['comment'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'spell_trigger': spellTrigger,
      'spell_effect': spellEffect,
      'type': type,
      'comment': comment,
    };
  }
}
