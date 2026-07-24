// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
import 'creature_loot_template_entity.dart';

final class CreatureLootTemplateKey {
  final int entry;
  final int item;
  final int reference;
  final int groupId;

  const CreatureLootTemplateKey({
    required this.entry,
    required this.item,
    required this.reference,
    required this.groupId,
  });

  factory CreatureLootTemplateKey.fromEntity(
    CreatureLootTemplateEntity entity,
  ) {
    return CreatureLootTemplateKey(
      entry: entity.entry,
      item: entity.item,
      reference: entity.reference,
      groupId: entity.groupId,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is CreatureLootTemplateKey &&
            entry == other.entry &&
            item == other.item &&
            reference == other.reference &&
            groupId == other.groupId;
  }

  @override
  int get hashCode => Object.hashAll([entry, item, reference, groupId]);

  @override
  String toString() {
    return 'CreatureLootTemplateKey('
        'entry: $entry, '
        'item: $item, '
        'reference: $reference, '
        'groupId: $groupId'
        ')';
  }
}
