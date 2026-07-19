import 'package:foxy/entity/spell_custom_attr_entity.dart';

final class SpellCustomAttrKey {
  final int spellId;

  const SpellCustomAttrKey({required this.spellId});

  factory SpellCustomAttrKey.fromEntity(SpellCustomAttrEntity entity) {
    return SpellCustomAttrKey(spellId: entity.spellId);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SpellCustomAttrKey && other.spellId == spellId;

  @override
  int get hashCode => spellId.hashCode;
}
