import 'package:foxy/entity/item_set_entity.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';

mixin ItemSetValidationMixin on ViewModelValidationMixin {
  void validateItemSetFields(ItemSetEntity value) {
    final id = value.id;
    final nameLangFlags = value.nameLangFlags;
    final itemId0 = value.itemId0;
    final itemId1 = value.itemId1;
    final itemId2 = value.itemId2;
    final itemId3 = value.itemId3;
    final itemId4 = value.itemId4;
    final itemId5 = value.itemId5;
    final itemId6 = value.itemId6;
    final itemId7 = value.itemId7;
    final itemId8 = value.itemId8;
    final itemId9 = value.itemId9;
    final itemId10 = value.itemId10;
    final itemId11 = value.itemId11;
    final itemId12 = value.itemId12;
    final itemId13 = value.itemId13;
    final itemId14 = value.itemId14;
    final itemId15 = value.itemId15;
    final itemId16 = value.itemId16;
    final setSpellId0 = value.setSpellId0;
    final setSpellId1 = value.setSpellId1;
    final setSpellId2 = value.setSpellId2;
    final setSpellId3 = value.setSpellId3;
    final setSpellId4 = value.setSpellId4;
    final setSpellId5 = value.setSpellId5;
    final setSpellId6 = value.setSpellId6;
    final setSpellId7 = value.setSpellId7;
    final setThreshold0 = value.setThreshold0;
    final setThreshold1 = value.setThreshold1;
    final setThreshold2 = value.setThreshold2;
    final setThreshold3 = value.setThreshold3;
    final setThreshold4 = value.setThreshold4;
    final setThreshold5 = value.setThreshold5;
    final setThreshold6 = value.setThreshold6;
    final setThreshold7 = value.setThreshold7;
    final requiredSkill = value.requiredSkill;
    final requiredSkillRank = value.requiredSkillRank;

    if (id <= 0 || id > 0x7FFFFFFF) {
      throw ArgumentError.value(id, 'ID', '必须在 1..2147483647 范围内');
    }
    _requireNonNegativeInt32(nameLangFlags, 'Name_lang_Flags');
    _requireNonNegativeInt32(itemId0, 'ItemID0');
    _requireNonNegativeInt32(itemId1, 'ItemID1');
    _requireNonNegativeInt32(itemId2, 'ItemID2');
    _requireNonNegativeInt32(itemId3, 'ItemID3');
    _requireNonNegativeInt32(itemId4, 'ItemID4');
    _requireNonNegativeInt32(itemId5, 'ItemID5');
    _requireNonNegativeInt32(itemId6, 'ItemID6');
    _requireNonNegativeInt32(itemId7, 'ItemID7');
    _requireNonNegativeInt32(itemId8, 'ItemID8');
    _requireNonNegativeInt32(itemId9, 'ItemID9');
    _requireNonNegativeInt32(itemId10, 'ItemID10');
    _requireNonNegativeInt32(itemId11, 'ItemID11');
    _requireNonNegativeInt32(itemId12, 'ItemID12');
    _requireNonNegativeInt32(itemId13, 'ItemID13');
    _requireNonNegativeInt32(itemId14, 'ItemID14');
    _requireNonNegativeInt32(itemId15, 'ItemID15');
    _requireNonNegativeInt32(itemId16, 'ItemID16');
    _requireNonNegativeInt32(setSpellId0, 'SetSpellID0');
    _requireNonNegativeInt32(setSpellId1, 'SetSpellID1');
    _requireNonNegativeInt32(setSpellId2, 'SetSpellID2');
    _requireNonNegativeInt32(setSpellId3, 'SetSpellID3');
    _requireNonNegativeInt32(setSpellId4, 'SetSpellID4');
    _requireNonNegativeInt32(setSpellId5, 'SetSpellID5');
    _requireNonNegativeInt32(setSpellId6, 'SetSpellID6');
    _requireNonNegativeInt32(setSpellId7, 'SetSpellID7');
    _requireNonNegativeInt32(setThreshold0, 'SetThreshold0');
    _requireNonNegativeInt32(setThreshold1, 'SetThreshold1');
    _requireNonNegativeInt32(setThreshold2, 'SetThreshold2');
    _requireNonNegativeInt32(setThreshold3, 'SetThreshold3');
    _requireNonNegativeInt32(setThreshold4, 'SetThreshold4');
    _requireNonNegativeInt32(setThreshold5, 'SetThreshold5');
    _requireNonNegativeInt32(setThreshold6, 'SetThreshold6');
    _requireNonNegativeInt32(setThreshold7, 'SetThreshold7');
    _requireNonNegativeInt32(requiredSkill, 'RequiredSkill');
    _requireNonNegativeInt32(requiredSkillRank, 'RequiredSkillRank');
    _validateSpellThreshold(setSpellId0, setThreshold0, 0);
    _validateSpellThreshold(setSpellId1, setThreshold1, 1);
    _validateSpellThreshold(setSpellId2, setThreshold2, 2);
    _validateSpellThreshold(setSpellId3, setThreshold3, 3);
    _validateSpellThreshold(setSpellId4, setThreshold4, 4);
    _validateSpellThreshold(setSpellId5, setThreshold5, 5);
    _validateSpellThreshold(setSpellId6, setThreshold6, 6);
    _validateSpellThreshold(setSpellId7, setThreshold7, 7);
    if ((requiredSkill == 0) != (requiredSkillRank == 0)) {
      throw ArgumentError('RequiredSkill 与 RequiredSkillRank 必须同时为 0 或同时为正数');
    }
  }
}

void _requireNonNegativeInt32(int value, String field) {
  if (value < 0 || value > 0x7FFFFFFF) {
    throw ArgumentError.value(value, field, '必须在 0..2147483647 范围内');
  }
}

void _validateSpellThreshold(int spellId, int threshold, int slot) {
  if ((spellId == 0) != (threshold == 0)) {
    throw ArgumentError('SetSpellID$slot 与 SetThreshold$slot 必须同时为空或同时有效');
  }
}
