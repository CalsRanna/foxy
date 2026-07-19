import 'package:flutter/foundation.dart';
import 'package:foxy/entity/loot_table_type.dart';

/// 掉落模板 Picker 中的 Entry 分组标识，不是单个掉落物理行主键。
@immutable
final class LootTemplateEntryKey {
  final LootTableType tableType;
  final int entry;

  const LootTemplateEntryKey({required this.tableType, required this.entry});

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is LootTemplateEntryKey &&
            tableType == other.tableType &&
            entry == other.entry;
  }

  @override
  int get hashCode => Object.hash(tableType, entry);
}
