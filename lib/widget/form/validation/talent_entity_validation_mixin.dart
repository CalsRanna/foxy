import 'package:foxy/constant/talent_constants.dart';
import 'package:foxy/entity/talent_entity.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';

mixin TalentValidationMixin on ViewModelValidationMixin {
  void validateTalentFields(TalentEntity value) {
    final id = value.id;
    final tabId = value.tabId;
    final tierId = value.tierId;
    final columnIndex = value.columnIndex;
    final spellRank0 = value.spellRank0;
    final spellRank1 = value.spellRank1;
    final spellRank2 = value.spellRank2;
    final spellRank3 = value.spellRank3;
    final spellRank4 = value.spellRank4;
    final spellRank5 = value.spellRank5;
    final spellRank6 = value.spellRank6;
    final spellRank7 = value.spellRank7;
    final spellRank8 = value.spellRank8;
    final prereqTalent0 = value.prereqTalent0;
    final prereqTalent1 = value.prereqTalent1;
    final prereqTalent2 = value.prereqTalent2;
    final prereqRank0 = value.prereqRank0;
    final prereqRank1 = value.prereqRank1;
    final prereqRank2 = value.prereqRank2;
    final flags = value.flags;
    final requiredSpellId = value.requiredSpellId;
    final categoryMask0 = value.categoryMask0;
    final categoryMask1 = value.categoryMask1;

    void requireRankContinuity() {
      if (spellRank1 == 0 && spellRank2 != 0 ||
          spellRank2 == 0 && spellRank3 != 0 ||
          spellRank3 == 0 && spellRank4 != 0 ||
          spellRank4 == 0 && spellRank5 != 0 ||
          spellRank5 == 0 && spellRank6 != 0 ||
          spellRank6 == 0 && spellRank7 != 0 ||
          spellRank7 == 0 && spellRank8 != 0) {
        throw ArgumentError('SpellRank0..8 的非零法术必须连续');
      }
    }

    void requireRange(int value, int minimum, int maximum, String name) {
      if (value < minimum || value > maximum) {
        throw ArgumentError('$name 必须在 $minimum..$maximum 范围内');
      }
    }

    void requireSignedInt32(int value, String name) {
      requireRange(value, -0x80000000, 0x7fffffff, name);
    }

    requireRange(id, 1, 0x7fffffff, 'ID');
    requireRange(tabId, 1, 0x7fffffff, 'TabID');
    requireRange(tierId, kTalentTierMinimum, kTalentTierMaximum, 'TierID');
    requireRange(
      columnIndex,
      kTalentColumnMinimum,
      kTalentColumnMaximum,
      'ColumnIndex',
    );
    requireRange(spellRank0, 1, 0x7fffffff, 'SpellRank0');
    requireRange(spellRank1, 0, 0x7fffffff, 'SpellRank1');
    requireRange(spellRank2, 0, 0x7fffffff, 'SpellRank2');
    requireRange(spellRank3, 0, 0x7fffffff, 'SpellRank3');
    requireRange(spellRank4, 0, 0x7fffffff, 'SpellRank4');
    requireRange(spellRank5, 0, 0x7fffffff, 'SpellRank5');
    requireRange(spellRank6, 0, 0x7fffffff, 'SpellRank6');
    requireRange(spellRank7, 0, 0x7fffffff, 'SpellRank7');
    requireRange(spellRank8, 0, 0x7fffffff, 'SpellRank8');
    requireRankContinuity();
    requireRange(prereqTalent0, 0, 0x7fffffff, 'PrereqTalent0');
    requireRange(prereqTalent1, 0, 0x7fffffff, 'PrereqTalent1');
    requireRange(prereqTalent2, 0, 0x7fffffff, 'PrereqTalent2');
    requireRange(prereqRank0, 0, 8, 'PrereqRank0');
    requireRange(prereqRank1, 0, 8, 'PrereqRank1');
    requireRange(prereqRank2, 0, 8, 'PrereqRank2');
    if (!kTalentAddToSpellBookOptions.containsKey(flags)) {
      throw ArgumentError('Flags 必须是有效的 Talent.dbc addToSpellBook 值');
    }
    requireRange(requiredSpellId, 0, 0x7fffffff, 'RequiredSpellID');
    requireSignedInt32(categoryMask0, 'CategoryMask0');
    requireSignedInt32(categoryMask1, 'CategoryMask1');
  }
}
