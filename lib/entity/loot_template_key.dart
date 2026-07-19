import 'package:flutter/foundation.dart';
import 'package:foxy/entity/loot_table_type.dart';
import 'package:foxy/entity/loot_template_entity.dart';

@immutable
sealed class LootTemplateKey {
  const LootTemplateKey();

  int get entry;
  int get item;

  factory LootTemplateKey.fromEntity(
    LootTableType tableType,
    LootTemplateEntity value,
  ) {
    return LootTemplateKey.fromValues(
      tableType,
      entry: value.entry,
      item: value.item,
      reference: value.reference,
      groupId: value.groupId,
    );
  }

  factory LootTemplateKey.fromValues(
    LootTableType tableType, {
    required int entry,
    required int item,
    required int reference,
    required int groupId,
  }) {
    if (tableType == LootTableType.creature) {
      return CreatureLootTemplateKey(
        entry: entry,
        item: item,
        reference: reference,
        groupId: groupId,
      );
    }
    return StandardLootTemplateKey(entry: entry, item: item);
  }
}

@immutable
final class StandardLootTemplateKey extends LootTemplateKey {
  @override
  final int entry;
  @override
  final int item;

  const StandardLootTemplateKey({required this.entry, required this.item});

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is StandardLootTemplateKey &&
            entry == other.entry &&
            item == other.item;
  }

  @override
  int get hashCode => Object.hash(entry, item);
}

@immutable
final class CreatureLootTemplateKey extends LootTemplateKey {
  @override
  final int entry;
  @override
  final int item;
  final int reference;
  final int groupId;

  const CreatureLootTemplateKey({
    required this.entry,
    required this.item,
    required this.reference,
    required this.groupId,
  });

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
