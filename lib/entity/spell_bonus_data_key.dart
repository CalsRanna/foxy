import 'package:foxy/entity/spell_bonus_data_entity.dart';

final class SpellBonusDataKey {
  final int entry;

  const SpellBonusDataKey({required this.entry});

  factory SpellBonusDataKey.fromEntity(SpellBonusDataEntity entity) {
    return SpellBonusDataKey(entry: entity.entry);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SpellBonusDataKey && other.entry == entry;

  @override
  int get hashCode => entry.hashCode;
}
