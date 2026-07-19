import 'package:foxy/entity/creature_template_addon_entity.dart';

final class CreatureTemplateAddonKey {
  final int entry;

  const CreatureTemplateAddonKey({required this.entry});

  factory CreatureTemplateAddonKey.fromEntity(
    CreatureTemplateAddonEntity entity,
  ) {
    return CreatureTemplateAddonKey(entry: entity.entry);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CreatureTemplateAddonKey && other.entry == entry;

  @override
  int get hashCode => entry.hashCode;
}
