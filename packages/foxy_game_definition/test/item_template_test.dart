import 'package:foxy_game_definition/foxy_game_definition.dart';
import 'package:test/test.dart';

void main() {
  test('item_template 枚举、运行时保留值和 Flags 覆盖 AzerothCore 取值集', () {
    expect(ItemConstants.itemClasses, hasLength(17));
    expect(ItemConstants.itemInventoryTypes, hasLength(29));
    expect(ItemEnums.itemQualityOptions.keys.toSet(), {0, 1, 2, 3, 4, 5, 6, 7});
    expect(ItemEnums.itemBondingOptions.keys.toSet(), {0, 1, 2, 3, 4, 5});
    expect(ItemEnums.itemMaterialOptions.keys.toSet(), {
      for (var value = -1; value <= 8; value++) value,
    });
    expect(ItemEnums.itemSpellTriggerOptions.keys.toSet(), {0, 1, 2, 4, 5, 6});
    expect(ItemEnums.itemStatTypeOptions.keys.toSet(), {
      for (var value = 0; value < 49; value++) value,
    });
    expect(ItemEnums.itemStatTypeOptions[22], '近战被命中等级');
    expect(ItemEnums.itemStatTypeOptions[28], '近战急速等级');
    expect(ItemEnums.itemStatTypeOptions[40], contains('3.3.5a 未使用'));
    expect(ItemEnums.itemStatTypeOptions[41], contains('已弃用'));
    expect(ItemEnums.itemStatTypeOptions[42], contains('已弃用'));
    expect(ItemEnums.itemReputationRankOptions.keys.toSet(), {
      for (var value = 0; value < 8; value++) value,
    });
    expect(_valuesOf(ItemFlags.itemFlagOptions), _bits(0, 31));
    expect(_valuesOf(ItemFlags.itemFlagsExtraOptions), _bits(0, 31));
    expect(_valuesOf(ItemFlags.itemFlagsCustomOptions), {1, 2, 4});
    expect(_valuesOf(ItemFlags.itemBagFamilyOptions), _bits(0, 14));
    expect(_valuesOf(ItemFlags.itemSocketColorFlagOptions), {1, 2, 4, 8});
  });
}

Set<int> _bits(int start, int end) => {
  for (var bit = start; bit <= end; bit++) 1 << bit,
};

Set<int> _valuesOf(List<FlagItem> flags) => {
  for (final flag in flags) flag.value,
};
