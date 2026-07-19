import 'package:foxy/entity/creature_template_entity.dart';

class CreatureTemplateKey {
  final int entry;

  const CreatureTemplateKey({required this.entry});

  factory CreatureTemplateKey.fromEntity(CreatureTemplateEntity entity) {
    return CreatureTemplateKey(entry: entity.entry);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CreatureTemplateKey && other.entry == entry;

  @override
  int get hashCode => entry.hashCode;
}
