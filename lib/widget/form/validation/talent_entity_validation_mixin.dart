import 'package:foxy/constant/talent_constants.dart';
import 'package:foxy/entity/talent_entity.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';

mixin TalentValidationMixin on ViewModelValidationMixin {
  void validateTalentFields(TalentEntity value) => value._validateFields();
}

extension on TalentEntity {
  void _validateFields() {
    _requireRange(id, 1, 0x7fffffff, 'ID');
    _requireRange(tabId, 1, 0x7fffffff, 'TabID');
    _requireRange(tierId, kTalentTierMinimum, kTalentTierMaximum, 'TierID');
    _requireRange(
      columnIndex,
      kTalentColumnMinimum,
      kTalentColumnMaximum,
      'ColumnIndex',
    );
    _requireRange(spellRank0, 1, 0x7fffffff, 'SpellRank0');
    _requireRange(spellRank1, 0, 0x7fffffff, 'SpellRank1');
    _requireRange(spellRank2, 0, 0x7fffffff, 'SpellRank2');
    _requireRange(spellRank3, 0, 0x7fffffff, 'SpellRank3');
    _requireRange(spellRank4, 0, 0x7fffffff, 'SpellRank4');
    _requireRange(spellRank5, 0, 0x7fffffff, 'SpellRank5');
    _requireRange(spellRank6, 0, 0x7fffffff, 'SpellRank6');
    _requireRange(spellRank7, 0, 0x7fffffff, 'SpellRank7');
    _requireRange(spellRank8, 0, 0x7fffffff, 'SpellRank8');
    _requireRankContinuity();
    _requireRange(prereqTalent0, 0, 0x7fffffff, 'PrereqTalent0');
    _requireRange(prereqTalent1, 0, 0x7fffffff, 'PrereqTalent1');
    _requireRange(prereqTalent2, 0, 0x7fffffff, 'PrereqTalent2');
    _requireRange(prereqRank0, 0, 8, 'PrereqRank0');
    _requireRange(prereqRank1, 0, 8, 'PrereqRank1');
    _requireRange(prereqRank2, 0, 8, 'PrereqRank2');
    if (!kTalentAddToSpellBookOptions.containsKey(flags)) {
      throw ArgumentError('Flags 必须是有效的 Talent.dbc addToSpellBook 值');
    }
    _requireRange(requiredSpellId, 0, 0x7fffffff, 'RequiredSpellID');
    _requireSignedInt32(categoryMask0, 'CategoryMask0');
    _requireSignedInt32(categoryMask1, 'CategoryMask1');
  }

  void _requireRankContinuity() {
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

  void _requireRange(int value, int minimum, int maximum, String name) {
    if (value < minimum || value > maximum) {
      throw ArgumentError('$name 必须在 $minimum..$maximum 范围内');
    }
  }

  void _requireSignedInt32(int value, String name) {
    _requireRange(value, -0x80000000, 0x7fffffff, name);
  }
}
