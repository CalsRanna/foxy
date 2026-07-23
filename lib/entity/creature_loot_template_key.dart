import 'package:flutter/foundation.dart';
import 'package:foxy/entity/loot_template_entity.dart';

@immutable
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

  factory CreatureLootTemplateKey.fromEntity(LootTemplateEntity value) {
    return CreatureLootTemplateKey(
      entry: value.entry,
      item: value.item,
      reference: value.reference,
      groupId: value.groupId,
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
  int get hashCode => Object.hash(entry, item, reference, groupId);
}
