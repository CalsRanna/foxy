import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/game_object_constants.dart';
import 'package:foxy/constant/integer_field_spec.dart';

void main() {

  test('GameobjectTypes 完整覆盖 AzerothCore 0..35', () {
    expect(kGameObjectTypeOptions.keys.toSet(), {
      for (var type = 0; type <= 35; type++) type,
    });
  });

  test('GameObjectFlags 只包含服务端定义的 9 个数据库位', () {
    expect(kGameObjectFlagItems.map((item) => item.value).toSet(), {
      0x00000001,
      0x00000002,
      0x00000004,
      0x00000008,
      0x00000010,
      0x00000020,
      0x00000040,
      0x00000200,
      0x00000400,
    });
  });

  test('Data0..Data23 可编辑槽位与 GameObjectData.h 联合体一致', () {
    final expected = <int, Set<int>>{
      0: _range(0, 6),
      1: _range(0, 8),
      2: _range(0, 9),
      3: _range(0, 16),
      4: {},
      5: _range(0, 5),
      6: _range(0, 14),
      7: _range(0, 3),
      8: _range(0, 6),
      9: _range(0, 3),
      10: _range(0, 20),
      11: _range(0, 4),
      12: _range(0, 7),
      13: _range(0, 3),
      14: {},
      15: _range(0, 8),
      16: {},
      17: {},
      18: _range(0, 7),
      19: {},
      20: {},
      21: _range(0, 1),
      22: _range(0, 4),
      23: _range(0, 2),
      24: _range(0, 7),
      25: _range(0, 4),
      26: _range(0, 4),
      27: {0},
      28: {},
      29: _range(0, 21),
      30: _range(0, 6),
      31: _range(0, 1),
      32: _range(0, 1),
      33: {0, 1, 2, 3, 4, 5, 9, 10, 14, 16, 18, 19, 22},
      34: {},
      35: _range(0, 2),
    };

    for (var type = 0; type <= 35; type++) {
      final actual = <int>{};
      for (var index = 0; index < 24; index++) {
        if (gameObjectDataFieldSpec(type, index).editable) actual.add(index);
      }
      expect(actual, expected[type], reason: 'GameObject type $type');
    }
  });

  test('关键 Data 外键指向精确 Store 或世界表', () {
    GameObjectDataReference referenceOf(int type, int index) =>
        switch (gameObjectDataFieldSpec(type, index)) {
          IntegerReferenceFieldSpec(:final reference) => reference,
          _ => fail('Data$index of type $type 不是引用规格'),
        };

    expect(referenceOf(8, 0), GameObjectDataReference.spellFocusObject);
    expect(referenceOf(13, 1), GameObjectDataReference.cinematicSequence);
    expect(referenceOf(15, 0), GameObjectDataReference.taxiPath);
    expect(referenceOf(33, 18), GameObjectDataReference.destructibleModelData);
    expect(referenceOf(33, 4), GameObjectDataReference.gameObjectDisplayInfo);
    expect(referenceOf(3, 1), GameObjectDataReference.gameObjectLoot);
  });

  test('trap type、boolean、椅子高度为 select 规格，未使用槽位回落只读 number', () {
    expect(gameObjectDataFieldSpec(6, 4), isA<IntegerSelectFieldSpec>());
    expect(gameObjectDataFieldSpec(0, 0), isA<IntegerSelectFieldSpec>());
    expect(gameObjectDataFieldSpec(7, 1), isA<IntegerSelectFieldSpec>());
    expect(gameObjectDataFieldSpec(4, 0), isA<IntegerNumberFieldSpec>());
    expect(gameObjectDataFieldSpec(4, 0).editable, isFalse);
    expect(gameObjectDataFieldSpec(6, 3), isA<IntegerReferenceFieldSpec>());
  });

}

Set<int> _range(int start, int end) => {
  for (var value = start; value <= end; value++) value,
};
